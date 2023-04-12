----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/03/2023 08:55:04 PM
-- Design Name: 
-- Module Name: PS2_mouse_reader - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

use work.PS2_mouse_reader_pkg.all;

entity PS2_mouse_reader is
    generic(
        g_sys_clk_f : integer := 12_500_000
    );
    port(
        io_ps2_clk, io_ps2_dat : inout std_logic;
        i_sys_clk, i_sys_rst : in std_logic;
        o_left_btn, o_right_btn, o_middle_btn : out std_logic;
        o_x, o_y, o_z : out integer;
        o_mouse_connected : out std_logic;
        o_valid : out std_logic;
        i_ready : in std_logic;
        o_error : out std_logic
    );
end PS2_mouse_reader;

architecture Behavioral of PS2_mouse_reader is

    attribute mark_debug : string;

    signal s_ps2_data_in : std_logic_vector(7 downto 0);
    attribute mark_debug of s_ps2_data_in : signal is "true";
    signal s_ps2_rdr_valid_ready : std_logic;
    attribute mark_debug of s_ps2_rdr_valid_ready : signal is "true";
    signal s_ps2_rdr_data_error : std_logic;
        
    signal s_ps2_wtr_sending : std_logic;
    signal s_ps2_data_out : std_logic_vector(7 downto 0);
    attribute mark_debug of s_ps2_data_out : signal is "true";
    signal s_ps2_wtr_valid : std_logic;
    attribute mark_debug of s_ps2_wtr_valid : signal is "true";
    signal s_ps2_wtr_ready : std_logic;
    
    type t_state_type is (
        WAIT_BAT, 
        WAIT_ID,
        WAIT_SEND,
        WAIT_ACK,
        COMM_ERROR,
        SEND_RST,
--        SEND_RESEND,
        SEND_SET_DEFAULTS,
        SEND_DIS_DATA_REPORTING,
        SEND_EN_DATA_REPORTING,
        SEND_SET_SAMPLE_RATE,
        SEND_SAMPLE_RATE,
        SEND_GET_DEV_ID,
        SEND_SET_REMOTE_MODE,
        SEND_SET_WRAP_MODE,
        SEND_RST_WRAP_MODE,
        SEND_READ_DATA,
        SEND_SET_STREAM,
        SEND_STAT_REQ,
        WAIT_STATUS_1,
        WAIT_STATUS_2,
        WAIT_STATUS_3,
        SEND_SET_RESOLUTION,
        SEND_RESOLUTION,
        SEND_SET_SCALE_2_1,
        SEND_SET_SCALE_1_1,
        WAIT_STATUSBYTE, 
        WAIT_X_BYTE, 
        WAIT_Y_BYTE,
        WAIT_Z_BYTE,
        GOT_ALL
    );
    constant c_rst_state : t_state_type := SEND_RST;
    signal s_state, s_state_resend, s_state_post_ack, s_state_post_send : t_state_type;
    
    type t_state_seq_type is array(natural range<>) of t_state_type;
    --this is the sequence of commands run after the ID is received from the mouse, 
    --before it starts listening for stream packets
    constant c_boot_sequence : t_state_seq_type(0 to 15) := (
--        0 => SEND_SET_RESOLUTION,
--        0 => SEND_SET_SAMPLE_RATE,
--        1 => SEND_SET_SAMPLE_RATE,
--        2 => SEND_SET_SAMPLE_RATE,
--        3 => SEND_GET_DEV_ID,
--        4 => SEND_SET_RESOLUTION,
--        5 => SEND_SET_SAMPLE_RATE,
--        2 => SEND_SET_STREAM,
        0 => SEND_SET_DEFAULTS,
        others => SEND_EN_DATA_REPORTING --will enter the listening loop upon sending this command
    );
    signal s_boot_seq_idx : integer range c_boot_sequence'range;
    
    type t_data_arr_type is array(natural range<>) of std_logic_vector(7 downto 0);
    -- corresponds to commands in c_boot_sequence that require arguments, like SEND_SET_SAMPLE_RATE
    constant c_boot_seq_args : t_data_arr_type(c_boot_sequence'range) := (
        0 => std_logic_vector(to_unsigned(200, s_ps2_data_out'length)),
        1 => std_logic_vector(to_unsigned(100, s_ps2_data_out'length)),
        2 => std_logic_vector(to_unsigned(80, s_ps2_data_out'length)),
        4 => std_logic_vector(to_unsigned(3, s_ps2_data_out'length)),
        5 => std_logic_vector(to_unsigned(40, s_ps2_data_out'length)),
        others => (others => '0')
    );
    
    signal s_xs, s_ys : std_logic;
    
    signal s_i_ps2_clk, s_o_ps2_clk, s_ps2_clk_oe : std_logic;
    signal s_i_ps2_dat, s_o_ps2_dat, s_ps2_dat_oe : std_logic;
    
    signal s_sent_reset : std_logic;
    
    signal s_mouse_has_wheel : std_logic;
    signal s_waiting_inital_id : std_logic;
    signal s_data_reporting_enabled : std_logic;

begin

    io_ps2_clk <= s_o_ps2_clk when s_ps2_clk_oe = '1' else 'Z';
    s_i_ps2_clk <= io_ps2_clk;
    
    io_ps2_dat <= s_o_ps2_dat when s_ps2_dat_oe = '1' else 'Z';
    s_i_ps2_dat <= io_ps2_dat;

    ps2_rdr_inst: entity work.PS2_reader
    generic map(
        g_sys_clk_f => g_sys_clk_f,
        g_ps2_clk_f => 16891,
        g_parity_odd => true
    )
    port map(
        i_ps2_clk => s_i_ps2_clk,
        i_ps2_ce => not s_ps2_wtr_sending,
        i_ps2_dat => s_i_ps2_dat,
        i_sys_clk => i_sys_clk,
        i_sys_rst => i_sys_rst,
        o_data => s_ps2_data_in,
        o_data_valid => s_ps2_rdr_valid_ready,
        o_data_error => s_ps2_rdr_data_error,
        i_ready => s_ps2_rdr_valid_ready
    );
    
    ps2_writer_inst: entity work.PS2_writer
    generic map(
        g_sys_clk_f => g_sys_clk_f,
        g_parity_odd => true
    )
    port map(
        i_sys_clk => i_sys_clk,
        i_sys_rst => i_sys_rst,
        i_ps2_clk => s_i_ps2_clk,
        o_ps2_clk => s_o_ps2_clk,
        o_ps2_clk_oe => s_ps2_clk_oe,
        i_ps2_data => s_i_ps2_dat,
        o_ps2_data => s_o_ps2_dat,
        o_ps2_data_oe => s_ps2_dat_oe,
        o_busy => s_ps2_wtr_sending,
        i_data => s_ps2_data_out,
        i_valid => s_ps2_wtr_valid,
        o_ready => s_ps2_wtr_ready
    );
    
    process(i_sys_clk) is begin
        if rising_edge(i_sys_clk) then
                
            s_ps2_wtr_valid <= '0';
            o_error <= '0';
            
            case (s_state) is
            
                --wait on mouse self-test, then wait for ID
                when WAIT_BAT => 
                    if (s_ps2_rdr_valid_ready = '1' and s_ps2_rdr_data_error = '0' and s_ps2_data_in = c_resp_self_test_passed) then
                        s_state <= WAIT_ID;
                    end if;
                    
                --wait for ID.
                --if a reset has not already been sent, send that.
                --If the mouse hasnt had a chance to send its ID after a reset, we expect c_resp_mouse_id_norm
                    --at which point, begin the boot sequence
                --otherwise, we have to act differently depending on if the mouse has a wheel (Z) or not.
                    --regardless of the wheel mode, move on to the next step in the boot sequence
                when WAIT_ID => 
                    if (s_ps2_rdr_valid_ready = '1') then
                        if (s_waiting_inital_id = '1' and s_ps2_data_in = c_resp_mouse_id_norm) then
                            if (s_sent_reset) then
                                s_state <= c_boot_sequence(s_boot_seq_idx); --presumably the first one
                                s_waiting_inital_id <= '0';
                            else
                                s_state <= SEND_RST;
                            end if;
                            o_mouse_connected <= '1';
                        elsif (s_ps2_data_in = c_resp_mouse_id_norm) then
                            s_boot_seq_idx <= s_boot_seq_idx + 1;
                            s_state <= c_boot_sequence(s_boot_seq_idx + 1);
                        elsif (s_ps2_data_in = c_resp_mouse_id_wheel) then
                            s_mouse_has_wheel <= '1';
                            s_boot_seq_idx <= s_boot_seq_idx + 1;
                            s_state <= c_boot_sequence(s_boot_seq_idx + 1);
                        end if;
                    end if;
                    
                --generic state meant to handle all ack receipts
                --handles resend request too, but any command that necesitates an ack must save itself 
                --in s_state_resend in order for this state to remember what to resend.
                when WAIT_ACK =>
                    if (s_ps2_rdr_valid_ready = '1') then
                        if (s_ps2_data_in = c_resp_resend) then
                            s_state <= s_state_resend;
                        elsif (s_ps2_data_in = c_resp_ack) then
                            s_state <= s_state_post_ack;
                        else
                            s_state <= COMM_ERROR;
                        end if;
                    end if;
                
                --just wait on outgoing data
                when WAIT_SEND => 
                    if (s_ps2_wtr_ready and (not s_ps2_wtr_valid)) then
                        s_state <= s_state_post_send;
                    end if;
                
                --in case of erro just raise a flag and be done with it
                when COMM_ERROR => 
                    o_error <= '1';
                
                --0xFF (Reset)
                --The mouse responds to this command with "acknowledge" (0xFA) then enters reset mode. 
                --after reset, mouse should always send BAT
                when SEND_RST =>
                    s_ps2_data_out <= c_cmd_reset;
                    s_sent_reset <= '1';
                    s_state_post_send <= WAIT_ACK;
                    s_state_post_ack <= WAIT_BAT;
                    s_state_resend <= s_state;
                    s_data_reporting_enabled <= '0';
                    if (s_ps2_wtr_ready) then
                        s_ps2_wtr_valid <= '1';
                        s_state <= WAIT_SEND;
                    end if;
                
                --0xF6 (Set Defaults)
                --The mouse responds with "acknowledge" (0xFA) then loads the following values: 
                    --Sampling rate = 100, resolution = 4 counts/mm, Scaling = 1:1, 
                    --data reporting = disabled. 
                --The mouse then resets its movement counters and enters stream mode.
                --This command's ack will be followed by the next state in the boot sequence
                when SEND_SET_DEFAULTS =>
                    s_ps2_data_out <= c_cmd_set_defaults;
                    s_state_post_send <= WAIT_ACK;
                    s_state_post_ack <= c_boot_sequence(s_boot_seq_idx + 1);
                    s_state_resend <= s_state;
                    s_data_reporting_enabled <= '0';
                    if (s_ps2_wtr_ready) then
                        s_ps2_wtr_valid <= '1';
                        s_state <= WAIT_SEND;
                        s_boot_seq_idx <= s_boot_seq_idx + 1;
                    end if;
                
                --0xF5 (Disable Data Reporting)
                --The mouse responds with "acknowledge" (0xFA) then disables data reporting and resets its movement counters. 
                --This only affects data reporting in stream mode and does not disable sampling. 
                --Disabled stream mode functions the same as remote mode. 
                --This command's ack will be followed by the next state in the boot sequence
                when SEND_DIS_DATA_REPORTING =>
                    s_ps2_data_out <= c_cmd_dis_data_reporting;
                    s_state_post_send <= WAIT_ACK;
                    s_state_post_ack <= c_boot_sequence(s_boot_seq_idx + 1);
                    s_state_resend <= s_state;
                    s_data_reporting_enabled <= '0';
                    if (s_ps2_wtr_ready) then
                        s_ps2_wtr_valid <= '1';
                        s_state <= WAIT_SEND;
                        s_boot_seq_idx <= s_boot_seq_idx + 1;
                    end if;
                
                --0xF4 (Enable Data Reporting)
                --The mouse responds with "acknowledge" (0xFA) then enables data reporting and resets its movement counters. 
                --This command may be issued while the mouse is in remote mode, but it will only affect data reporting in stream mode. 
                --This command's ack will be followed by the stream packet wait loop.
                when SEND_EN_DATA_REPORTING =>
                    s_ps2_data_out <= c_cmd_en_data_reporting;
                    s_state_post_send <= WAIT_ACK;
                    s_state_post_ack <= WAIT_STATUSBYTE;
                    s_state_resend <= s_state;
                    s_data_reporting_enabled <= '1';
                    if (s_ps2_wtr_ready) then
                        s_ps2_wtr_valid <= '1';
                        s_state <= WAIT_SEND;
                    end if;
                
                --0xF3 (Set Sample Rate)
                --The mouse responds with "acknowledge" (0xFA) then reads one more byte from the host. 
                --The mouse saves this byte as the new sample rate. 
                --After receiving the sample rate, the mouse again responds with "acknowledge" (0xFA) and resets its movement counters. 
                --Valid sample rates are 10, 20, 40, 60, 80, 100, and 200 samples/sec. 
                --This command's ack will be followed by sending the sample rate (specified in c_boot_seq_args)
                when SEND_SET_SAMPLE_RATE =>
                    s_ps2_data_out <= c_cmd_set_sample_rate;
                    s_state_post_send <= WAIT_ACK;
                    s_state_post_ack <= SEND_SAMPLE_RATE;
                    s_state_resend <= s_state;
                    if (s_ps2_wtr_ready) then
                        s_ps2_wtr_valid <= '1';
                        s_state <= WAIT_SEND;
                    end if;
                    
                --This just sends the sample rate, pulling from the arg in c_boot_seq_args at the current s_boot_seq_idx.
                --This command's ack will be followed by the next state in the boot sequence
                when SEND_SAMPLE_RATE =>
                    s_ps2_data_out <= c_boot_seq_args(s_boot_seq_idx);
                    s_state_post_send <= WAIT_ACK;
                    s_state_post_ack <= c_boot_sequence(s_boot_seq_idx + 1);
                    s_state_resend <= s_state;
                    if (s_ps2_wtr_ready) then
                        s_ps2_wtr_valid <= '1';
                        s_state <= WAIT_SEND;
                        s_boot_seq_idx <= s_boot_seq_idx + 1;
                    end if;
                
                --0xF2 (Get Device ID)
                --The mouse responds with "acknowledge" (0xFA) followed by its device ID
                    --0x00 for the standard PS/2 mouse
                    --0x03 for a mouse with wheel (4-byte stream)
                    --0x04 for a mouse with wheel and 4th and 5th buttons (4-byte stream) 
                --The mouse should also reset its movement counters. 
                --This command's ack will be followed by waiting for the ID
                when SEND_GET_DEV_ID =>
                    s_ps2_data_out <= c_cmd_get_dev_id;
                    s_state_post_send <= WAIT_ACK;
                    s_state_post_ack <= WAIT_ID;
                    s_state_resend <= s_state;
                    if (s_ps2_wtr_ready) then
                        s_ps2_wtr_valid <= '1';
                        s_state <= WAIT_SEND;
                    end if;
                
                --0xF0 (Set Remote Mode)
                --The mouse responds with "acknowledge" (0xFA) then resets its movement counters and enters remote mode.
                --In remote mode the mouse reads its inputs and updates its counters/flags at the current sample rate, 
                --but it does not automatically issue data packets when movement has occured. 
                --Instead, the host polls the mouse using the "Read Data" (0xEB) command. 
                --This command's ack will be followed by the next state in the boot sequence 
                when SEND_SET_REMOTE_MODE =>
                    s_ps2_data_out <= c_cmd_set_remote_mode;
                    s_state_post_send <= WAIT_ACK;
                    s_state_post_ack <= c_boot_sequence(s_boot_seq_idx + 1);
                    s_state_resend <= s_state;
                    if (s_ps2_wtr_ready) then
                        s_ps2_wtr_valid <= '1';
                        s_state <= WAIT_SEND;
                        s_boot_seq_idx <= s_boot_seq_idx + 1;
                    end if;
                
                --0xEE (Set Wrap Mode)
                --The mouse responds with "acknowledge" (0xFA) then resets its movement counters and enters wrap mode. 
                --This is an "echoing" mode in which every byte received by the mouse is sent back to the host. 
                --Even if the byte represents a valid command, the mouse will not respond to that command
                --it will only echo that byte back to the host. 
                --There are two exceptions to this: the "Reset" (0xFF) and "Reset Wrap Mode" (0xEC) commands. 
                --The mouse treats these as valid commands and does not echo them back to the host. 
                --This command's ack will be followed by the next state in the boot sequence
                when SEND_SET_WRAP_MODE =>
                    s_ps2_data_out <= c_cmd_set_wrap_mode;
                    s_state_post_send <= WAIT_ACK;
                    s_state_post_ack <= c_boot_sequence(s_boot_seq_idx + 1);
                    s_state_resend <= s_state;
                    if (s_ps2_wtr_ready) then
                        s_ps2_wtr_valid <= '1';
                        s_state <= WAIT_SEND;
                        s_boot_seq_idx <= s_boot_seq_idx + 1;
                    end if;
                
                --xEC (Reset Wrap Mode)
                --The mouse responds with "acknowledge" (0xFA) then resets its movement counters and enters the mode 
                --it was in prior to wrap mode (stream mode or remote mode). 
                --This command's ack will be followed by the next state in the boot sequence
                when SEND_RST_WRAP_MODE =>
                    s_ps2_data_out <= c_cmd_rst_wrap_mode;
                    s_state_post_send <= WAIT_ACK;
                    s_state_post_ack <= c_boot_sequence(s_boot_seq_idx + 1);
                    s_state_resend <= s_state;
                    if (s_ps2_wtr_ready) then
                        s_ps2_wtr_valid <= '1';
                        s_state <= WAIT_SEND;
                        s_boot_seq_idx <= s_boot_seq_idx + 1;
                    end if;
                
                --0xEB (Read Data)
                --The mouse responds with "acknowledge" (0xFA) then sends a movement data packet. 
                --This is the only way to read data in remote mode. 
                --After the data packet has successfully been sent, the mouse resets its movement counters. 
                --This command's ack will be followed by waiting for the data packets to come through
                when SEND_READ_DATA =>
                    s_ps2_data_out <= c_cmd_read_data;
                    s_state_post_send <= WAIT_ACK;
                    s_state_post_ack <= WAIT_STATUSBYTE;
                    s_state_resend <= s_state;
                    if (s_ps2_wtr_ready) then
                        s_ps2_wtr_valid <= '1';
                        s_state <= WAIT_SEND;
                    end if;
                
                --0xEA (Set Stream Mode)
                --The mouse responds with "acknowledge" (0xFA) then resets its movement counters and enters stream mode. 
                --In stream mode the mouse sends movement data when it detects movement or a change in state of one or more mouse buttons.
                --
                --The maximum rate at which this data may be reported is known as the sample rate. 
                --This parameter ranges from 10-200 samples/sec, with a default value of 100 samples/sec. 
                --The host may set this value using the "Set Sample Rate" (0xF3) command.
                --
                --Note that reporting is disabled by default. 
                --The mouse will not actually issue any movement data packets until it receives the "Enable Data Reporting" (0xF4) command.
                --
                --Stream mode is the default operating mode, and is otherwise set using the "Set Stream Mode" (0xEA) command.
                --This command's ack will be followed by the next state in the boot sequence
                when SEND_SET_STREAM => 
                    s_ps2_data_out <= c_cmd_set_stream_mode;
                    s_state_post_send <= WAIT_ACK;
                    s_state_post_ack <= c_boot_sequence(s_boot_seq_idx + 1);
                    s_state_resend <= s_state;
                    if (s_ps2_wtr_ready) then
                        s_ps2_wtr_valid <= '1';
                        s_state <= WAIT_SEND;
                        s_boot_seq_idx <= s_boot_seq_idx + 1;
                    end if;
                
                --0xE9 (Status Request)
                --The mouse responds with "acknowledge" (0xFA) then sends the following 3-byte status packet (then resets its movement counters): 
                --          Bit 7   Bit 6   Bit 5   Bit 4       Bit 3   Bit 2       Bit 1       Bit 0
                --Byte 1    0       Mode    Enable  Scaling     0       Left Btn    Middle Btn  Right Btn
                --Byte 2    ----------------------------Resolution---------------------------------------
                --Byte 3    ----------------------------Sample Rate--------------------------------------
                --This command's ack will be followed by waiting for the data packets to come through
                when SEND_STAT_REQ => 
                    s_ps2_data_out <= c_cmd_set_stream_mode;
                    s_state_post_send <= WAIT_ACK;
                    s_state_post_ack <= WAIT_STATUS_1;
                    s_state_resend <= s_state;
                    if (s_ps2_wtr_ready) then
                        s_ps2_wtr_valid <= '1';
                        s_state <= WAIT_SEND;
                    end if;
                
                --wait on the first byte of the status packet
                when WAIT_STATUS_1 => 
                    if (s_ps2_rdr_valid_ready = '1') then
                        s_state <= WAIT_STATUS_2;
                        o_right_btn <= s_ps2_data_in(0);
                        o_middle_btn <= s_ps2_data_in(1);
                        o_left_btn <= s_ps2_data_in(2);
--                        scaling <= s_ps2_data_in(4); -- 1 if 2:1, 0 if 1:1
                        s_data_reporting_enabled <= s_ps2_data_in(5); -- 1 if data reporting enabled, 0 if disabled
--                        mode <= s_ps2_data_in(6); -- 1 if remote mode enabled, 0 if stream mode
                    end if;
                
                --wait on the second byte of the status packet
                when WAIT_STATUS_2 => 
                    if (s_ps2_rdr_valid_ready = '1') then
                        s_state <= WAIT_STATUS_3;
--                        resolution <= s_ps2_data_in;
                    end if;
                
                --wait on the third byte of the status packet
                when WAIT_STATUS_3 => 
                    if (s_ps2_rdr_valid_ready = '1') then
                        s_state <= WAIT_STATUS_3; --TODO: what next?
--                        sample rate <= s_ps2_data_in;
                    end if;
                
                --0xE8 (Set Resolution)
                --The mouse responds with "acknowledge" (0xFA) then reads one byte from the host 
                --and again responds with "acknowledge" (0xFA) then resets its movement counters. 
                --The byte read from the host determines the resolution as follows: 
                --Byte from host    Resolution
                --00                1 count/mm
                --01                2 counts/mm
                --02                4 counts/mm
                --03                8 counts/mm
                --This command's ack will be followed by sending the resolution (specified in c_boot_seq_args)
                when SEND_SET_RESOLUTION => 
                    s_ps2_data_out <= c_cmd_set_resolution;
                    s_state_post_send <= WAIT_ACK;
                    s_state_post_ack <= SEND_RESOLUTION;
                    s_state_resend <= s_state;
                    if (s_ps2_wtr_ready) then
                        s_ps2_wtr_valid <= '1';
                        s_state <= WAIT_SEND;
                    end if;
                
                --This just sends the resolution, pulling from the arg in c_boot_seq_args at the current s_boot_seq_idx.
                --This command's ack will be followed by the next state in the boot sequence
                when SEND_RESOLUTION =>
                    s_ps2_data_out <= c_boot_seq_args(s_boot_seq_idx);
                    s_state_post_send <= WAIT_ACK;
                    s_state_post_ack <= c_boot_sequence(s_boot_seq_idx + 1);
                    s_state_resend <= s_state;
                    if (s_ps2_wtr_ready) then
                        s_ps2_wtr_valid <= '1';
                        s_state <= WAIT_SEND;
                        s_boot_seq_idx <= s_boot_seq_idx + 1;
                    end if;
                
                --0xE7 (Set Scaling 2:1)
                --The mouse responds with "acknowledge" (0xFA) then enables 2:1 scaling.
                --This command's ack will be followed by the next state in the boot sequence
                when SEND_SET_SCALE_2_1 =>
                    s_ps2_data_out <= c_cmd_set_scaling_2_1;
                    s_state_post_send <= WAIT_ACK;
                    s_state_post_ack <= c_boot_sequence(s_boot_seq_idx + 1);
                    s_state_resend <= s_state;
                    if (s_ps2_wtr_ready) then
                        s_ps2_wtr_valid <= '1';
                        s_state <= WAIT_SEND;
                        s_boot_seq_idx <= s_boot_seq_idx + 1;
                    end if;
                
                --0xE6 (Set Scaling 1:1)
                --The mouse responds with "acknowledge" (0xFA) then enables 1:1 scaling. 
                --This command's ack will be followed by the next state in the boot sequence
                when SEND_SET_SCALE_1_1 =>
                    s_ps2_data_out <= c_cmd_set_scaling_1_1;
                    s_state_post_send <= WAIT_ACK;
                    s_state_post_ack <= c_boot_sequence(s_boot_seq_idx + 1);
                    s_state_resend <= s_state;
                    if (s_ps2_wtr_ready) then
                        s_ps2_wtr_valid <= '1';
                        s_state <= WAIT_SEND;
                        s_boot_seq_idx <= s_boot_seq_idx + 1;
                    end if;
                
                --wait on the status byte of the data stream
                when WAIT_STATUSBYTE => 
                    if (s_ps2_rdr_valid_ready = '1') then
                        s_state <= WAIT_X_BYTE;
                        o_left_btn <= s_ps2_data_in(0);
                        o_right_btn <= s_ps2_data_in(1);
                        o_middle_btn <= s_ps2_data_in(2);
                        s_xs <= s_ps2_data_in(4);
                        s_ys <= s_ps2_data_in(5);
                    end if;
                
                --wait on the X byte of the data stream
                when WAIT_X_BYTE => 
                    if (s_ps2_rdr_valid_ready = '1') then
                        s_state <= WAIT_Y_BYTE;
                        if (s_xs = '1') then
                            o_x <= -to_integer(unsigned(s_ps2_data_in));
                        else
                            o_x <= to_integer(unsigned(s_ps2_data_in));
                        end if;
                    end if;
                
                --wait on the Y byte of the data stream
                --if we expect one, then wait for a Z byte
                when WAIT_Y_BYTE => 
                    if (s_ps2_rdr_valid_ready = '1') then
                        if (s_ys = '1') then
                            o_y <= -to_integer(unsigned(s_ps2_data_in));
                        else
                            o_y <= to_integer(unsigned(s_ps2_data_in));
                        end if;
                        if (s_mouse_has_wheel) then
                            s_state <= WAIT_Z_BYTE;
                        else
                            s_state <= GOT_ALL;
                            o_valid <= '1';
                        end if;
                    end if;
                
                --wait on the Z byte of the data stream
                when WAIT_Z_BYTE =>
                    if (s_ps2_rdr_valid_ready = '1') then
                        s_state <= GOT_ALL;
                        o_valid <= '1';
                        o_z <= to_integer(signed(s_ps2_data_in));
                    end if;
                    
                --wait on data consumer
                when GOT_ALL => 
                    if (i_ready = '1') then
                        o_valid <= '0';
                        if (s_data_reporting_enabled) then
                            s_state <= WAIT_STATUSBYTE; --loop back
                        else
                            --TODO: undetermined what might happen after a READ_DATA is complete
                        end if;
                    end if;
            end case;
            
            if (i_sys_rst = '1') then
                s_state <= c_rst_state;
                o_mouse_connected <= '0';
                o_valid <= '0';
                s_sent_reset <= '0';
                s_mouse_has_wheel <= '0';
                s_waiting_inital_id <= '1';
                s_boot_seq_idx <= c_boot_sequence'low;
                s_data_reporting_enabled <= '0';
            end if;
            
        end if;
    end process;

end Behavioral;
