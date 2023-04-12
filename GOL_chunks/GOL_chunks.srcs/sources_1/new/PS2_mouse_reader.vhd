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
        o_left_btn, o_right_btn : out std_logic;
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
        IDLE, 
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
        0 => SEND_SET_SAMPLE_RATE,
        1 => SEND_SET_SAMPLE_RATE,
        2 => SEND_SET_SAMPLE_RATE,
        3 => SEND_GET_DEV_ID,
        4 => SEND_SET_RESOLUTION,
        5 => SEND_SET_SAMPLE_RATE,
--        2 => SEND_SET_STREAM,
--        0 => SEND_SET_DEFAULTS,
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
                when IDLE => 
                    if (s_ps2_rdr_valid_ready = '1' and s_ps2_rdr_data_error = '0' and s_ps2_data_in = c_resp_self_test_passed) then
                        s_state <= WAIT_ID;
                    end if;
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
                    
                when WAIT_SEND => 
                    if (s_ps2_wtr_ready and (not s_ps2_wtr_valid)) then
                        s_state <= s_state_post_send;
                    end if;
                    
                when COMM_ERROR => 
                    o_error <= '1';
                    
                when SEND_RST =>
                    s_ps2_data_out <= c_cmd_reset;
                    s_sent_reset <= '1';
                    s_state_post_send <= WAIT_ACK;
                    s_state_post_ack <= IDLE;
                    s_state_resend <= s_state;
                    if (s_ps2_wtr_ready) then
                        s_ps2_wtr_valid <= '1';
                        s_state <= WAIT_SEND;
                    end if;
                    
                when SEND_SET_DEFAULTS => --also supposedly sets mouse to stream mode, but not on the Nexys A7!!
                    s_ps2_data_out <= c_cmd_set_defaults;
                    s_state_post_send <= WAIT_ACK;
                    s_state_post_ack <= c_boot_sequence(s_boot_seq_idx + 1);
                    s_state_resend <= s_state;
                    if (s_ps2_wtr_ready) then
                        s_ps2_wtr_valid <= '1';
                        s_state <= WAIT_SEND;
                        s_boot_seq_idx <= s_boot_seq_idx + 1;
                    end if;
                
                when SEND_DIS_DATA_REPORTING =>
                    s_ps2_data_out <= c_cmd_dis_data_reporting;
                    s_state_post_send <= WAIT_ACK;
                    s_state_post_ack <= c_boot_sequence(s_boot_seq_idx + 1);
                    s_state_resend <= s_state;
                    if (s_ps2_wtr_ready) then
                        s_ps2_wtr_valid <= '1';
                        s_state <= WAIT_SEND;
                        s_boot_seq_idx <= s_boot_seq_idx + 1;
                    end if;
                    
                when SEND_EN_DATA_REPORTING =>
                    s_ps2_data_out <= c_cmd_en_data_reporting;
                    s_state_post_send <= WAIT_ACK;
                    s_state_post_ack <= WAIT_STATUSBYTE;
                    s_state_resend <= s_state;
                    if (s_ps2_wtr_ready) then
                        s_ps2_wtr_valid <= '1';
                        s_state <= WAIT_SEND;
                    end if;
                    
                when SEND_SET_SAMPLE_RATE =>
                    s_ps2_data_out <= c_cmd_set_sample_rate;
                    s_state_post_send <= WAIT_ACK;
                    s_state_post_ack <= SEND_SAMPLE_RATE;
                    s_state_resend <= s_state;
                    if (s_ps2_wtr_ready) then
                        s_ps2_wtr_valid <= '1';
                        s_state <= WAIT_SEND;
                    end if;
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
                
                when SEND_GET_DEV_ID =>
                    s_ps2_data_out <= c_cmd_get_dev_id;
                    s_state_post_send <= WAIT_ACK;
                    s_state_post_ack <= WAIT_ID;
                    s_state_resend <= s_state;
                    if (s_ps2_wtr_ready) then
                        s_ps2_wtr_valid <= '1';
                        s_state <= WAIT_SEND;
                    end if;
                
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
                    
                when SEND_READ_DATA =>
                    s_ps2_data_out <= c_cmd_read_data;
                    s_state_post_send <= WAIT_ACK;
                    s_state_post_ack <= WAIT_STATUSBYTE;
                    s_state_resend <= s_state;
                    if (s_ps2_wtr_ready) then
                        s_ps2_wtr_valid <= '1';
                        s_state <= WAIT_SEND;
                    end if;
                    
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
                    
                when SEND_STAT_REQ => 
                    s_ps2_data_out <= c_cmd_set_stream_mode;
                    s_state_post_send <= WAIT_ACK;
                    s_state_post_ack <= WAIT_STATUS_1;
                    s_state_resend <= s_state;
                    if (s_ps2_wtr_ready) then
                        s_ps2_wtr_valid <= '1';
                        s_state <= WAIT_SEND;
                    end if;
                    
                when WAIT_STATUS_1 => 
                    if (s_ps2_rdr_valid_ready = '1') then
                        s_state <= WAIT_STATUS_2;
                        o_right_btn <= s_ps2_data_in(0);
--                        middle button <= s_ps2_data_in(1);
                        o_left_btn <= s_ps2_data_in(2);
--                        scaling <= s_ps2_data_in(4); -- 1 if 2:1, 0 if 1:1
--                        enable <= s_ps2_data_in(5); -- 1 if data reporting enabled, 0 if disabled
--                        mode <= s_ps2_data_in(6); -- 1 if remote mode enabled, 0 if stream mode
                    end if;
                    
                when WAIT_STATUS_2 => 
                    if (s_ps2_rdr_valid_ready = '1') then
                        s_state <= WAIT_STATUS_3;
--                        resolution <= s_ps2_data_in;
                    end if;
                    
                when WAIT_STATUS_3 => 
                    if (s_ps2_rdr_valid_ready = '1') then
                        s_state <= WAIT_STATUS_3; --TODO: what next?
--                        sample rate <= s_ps2_data_in;
                    end if;
                
                when SEND_SET_RESOLUTION => 
                    s_ps2_data_out <= c_cmd_set_resolution;
                    s_state_post_send <= WAIT_ACK;
                    s_state_post_ack <= SEND_RESOLUTION;
                    s_state_resend <= s_state;
                    if (s_ps2_wtr_ready) then
                        s_ps2_wtr_valid <= '1';
                        s_state <= WAIT_SEND;
                    end if;
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
                
                when WAIT_STATUSBYTE => 
                    if (s_ps2_rdr_valid_ready = '1') then
                        s_state <= WAIT_X_BYTE;
                        o_left_btn <= s_ps2_data_in(0);
                        o_right_btn <= s_ps2_data_in(1);
                        s_xs <= s_ps2_data_in(4);
                        s_ys <= s_ps2_data_in(5);
                    end if;
                when WAIT_X_BYTE => 
                    if (s_ps2_rdr_valid_ready = '1') then
                        s_state <= WAIT_Y_BYTE;
                        if (s_xs = '1') then
                            o_x <= -to_integer(unsigned(s_ps2_data_in));
                        else
                            o_x <= to_integer(unsigned(s_ps2_data_in));
                        end if;
                    end if;
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
                when WAIT_Z_BYTE =>
                    if (s_ps2_rdr_valid_ready = '1') then
                        s_state <= GOT_ALL;
                        o_valid <= '1';
                        o_z <= to_integer(signed(s_ps2_data_in));
                    end if;
                when GOT_ALL => --wait on data consumer
                    if (i_ready = '1') then
                        o_valid <= '0';
                        s_state <= WAIT_STATUSBYTE;
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
            end if;
            
        end if;
    end process;

end Behavioral;
