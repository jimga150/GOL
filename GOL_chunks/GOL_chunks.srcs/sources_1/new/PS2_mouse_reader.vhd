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
        o_x, o_y : out integer;
        o_mouse_connected : out std_logic;
        o_valid : out std_logic;
        i_ready : in std_logic
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
        SEND_SETRES,
        SEND_RES,
        SEND_SETSAMPRATE,
        SEND_SAMPRATE,
        SEND_SETSTREAM, 
        SEND_ENDATAREPORTING,
        SEND_SETDEFAULTS,
        WAIT_STATUSBYTE, 
        GOT_STATUS, 
        GOT_X, 
        GOT_ALL
    );
    constant c_rst_state : t_state_type := IDLE;
    signal s_state, s_state_resend, s_state_post_ack, s_state_post_send : t_state_type;
    
    signal s_xs, s_ys : std_logic;
    
    signal s_i_ps2_clk, s_o_ps2_clk, s_ps2_clk_oe : std_logic;
    signal s_i_ps2_dat, s_o_ps2_dat, s_ps2_dat_oe : std_logic;

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
            
            case (s_state) is
                when IDLE => 
                    if (s_ps2_rdr_valid_ready = '1' and s_ps2_rdr_data_error = '0' and s_ps2_data_in = c_resp_self_test_passed) then
                        s_state <= WAIT_ID;
                    end if;
                when WAIT_ID => 
                    if (s_ps2_rdr_valid_ready = '1' and s_ps2_data_in = c_resp_mouse_id) then
                        s_state <= SEND_SETRES;
                        o_mouse_connected <= '1';
                    end if;
                when WAIT_ACK =>
                    if (s_ps2_rdr_valid_ready = '1') then
                        if (s_ps2_data_in = c_resp_resend) then
                            s_state <= s_state_resend;
                        elsif (s_ps2_data_in = c_resp_ack) then
                            s_state <= s_state_post_ack;
                        end if;
                    end if;
                    
                when WAIT_SEND => 
                    if (s_ps2_wtr_ready and (not s_ps2_wtr_valid)) then
                        s_state <= s_state_post_send;
                    end if;
                when SEND_SETRES => 
                    if (s_ps2_wtr_ready) then
                        s_ps2_wtr_valid <= '1';
                        s_ps2_data_out <= c_cmd_set_resolution;
                        s_state <= WAIT_SEND;
                        s_state_post_send <= WAIT_ACK;
                        s_state_post_ack <= SEND_RES;
                        s_state_resend <= s_state;
                    end if;
                when SEND_RES =>
                    if (s_ps2_wtr_ready) then
                        s_ps2_wtr_valid <= '1';
                        s_ps2_data_out <= X"03";
                        s_state <= WAIT_SEND;
                        s_state_post_send <= WAIT_ACK;
                        s_state_post_ack <= SEND_SETSAMPRATE;
                        s_state_resend <= s_state;
                    end if;
                when SEND_SETSAMPRATE =>
                    if (s_ps2_wtr_ready) then
                        s_ps2_wtr_valid <= '1';
                        s_ps2_data_out <= c_cmd_set_sample_rate;
                        s_state <= WAIT_SEND;
                        s_state_post_send <= WAIT_ACK;
                        s_state_post_ack <= SEND_SAMPRATE;
                        s_state_resend <= s_state;
                    end if;
                when SEND_SAMPRATE =>
                    if (s_ps2_wtr_ready) then
                        s_ps2_wtr_valid <= '1';
                        s_ps2_data_out <= std_logic_vector(to_unsigned(40, s_ps2_data_out'length));
                        s_state <= WAIT_SEND;
                        s_state_post_send <= WAIT_ACK;
                        s_state_post_ack <= SEND_ENDATAREPORTING;
                        s_state_resend <= s_state;
                    end if;
                when SEND_SETSTREAM => 
                    if (s_ps2_wtr_ready) then
                        s_ps2_wtr_valid <= '1';
                        s_ps2_data_out <= c_cmd_set_stream_mode;
                        s_state <= WAIT_SEND;
                        s_state_post_send <= WAIT_ACK;
                        s_state_post_ack <= SEND_ENDATAREPORTING;
                        s_state_resend <= s_state;
                    end if;
                when SEND_SETDEFAULTS => 
                    if (s_ps2_wtr_ready) then
                        s_ps2_wtr_valid <= '1';
                        s_ps2_data_out <= c_cmd_set_defaults;
                        s_state <= WAIT_SEND;
                        s_state_post_send <= WAIT_ACK;
                        s_state_post_ack <= SEND_ENDATAREPORTING;
                        s_state_resend <= s_state;
                    end if;
                when SEND_ENDATAREPORTING => 
                    if (s_ps2_wtr_ready) then
                        s_ps2_wtr_valid <= '1';
                        s_ps2_data_out <= c_cmd_en_data_reporting;
                        s_state <= WAIT_SEND;
                        s_state_post_send <= WAIT_ACK;
                        s_state_post_ack <= WAIT_STATUSBYTE;
                        s_state_resend <= s_state;
                    end if;
                when WAIT_STATUSBYTE => 
                    if (s_ps2_rdr_valid_ready = '1') then
                        s_state <= GOT_STATUS;
                        o_left_btn <= s_ps2_data_in(0);
                        o_right_btn <= s_ps2_data_in(1);
                        s_xs <= s_ps2_data_in(4);
                        s_ys <= s_ps2_data_in(5);
                    end if;
                when GOT_STATUS => 
                    if (s_ps2_rdr_valid_ready = '1') then
                        s_state <= GOT_X;
                        if (s_xs = '1') then
                            o_x <= -to_integer(unsigned(s_ps2_data_in));
                        else
                            o_x <= to_integer(unsigned(s_ps2_data_in));
                        end if;
                    end if;
                when GOT_X => 
                    if (s_ps2_rdr_valid_ready = '1') then
                        s_state <= GOT_ALL;
                        o_valid <= '1';
                        if (s_ys = '1') then
                            o_y <= -to_integer(unsigned(s_ps2_data_in));
                        else
                            o_y <= to_integer(unsigned(s_ps2_data_in));
                        end if;
                    end if;
                when GOT_ALL => 
                    if (i_ready = '1') then
                        o_valid <= '0';
                        s_state <= WAIT_STATUSBYTE;
                    end if;
            end case;
            
            if (i_sys_rst = '1') then
                s_state <= c_rst_state;
                o_mouse_connected <= '0';
                o_valid <= '0';
            end if;
            
        end if;
    end process;

end Behavioral;
