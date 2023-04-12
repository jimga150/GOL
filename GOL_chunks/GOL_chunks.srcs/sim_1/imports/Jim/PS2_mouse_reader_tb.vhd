----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/04/2023 20:47:13
-- Design Name: PS2_mouse_reader_tb
-- Module Name: PS2_mouse_reader_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: Created with VHDL Test Bench Template Generator
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.math_real.all;

use work.PS2_mouse_reader_pkg.all;

entity PS2_mouse_reader_tb is
end PS2_mouse_reader_tb;

architecture Behavioral of PS2_mouse_reader_tb is
    
    --Clocks
    signal i_sys_clk : std_logic := '0';
    signal io_ps2_clk : std_logic;
    
    --Resets
    signal i_sys_rst : std_logic := '1';
    
    --General inputs
    signal io_ps2_dat : std_logic;
    signal i_ready : std_logic := '1';
    
    --Outputs
    signal o_left_btn : std_logic;
    signal o_right_btn : std_logic;
    signal o_middle_btn : std_logic;
    signal o_x : integer;
    signal o_y : integer;
    signal o_z : integer;
    signal o_mouse_connected : std_logic;
    signal o_valid : std_logic;
    
    signal s_ps2_clk : std_logic := '1';
    signal s_ps2_clk_drive_en : std_logic := '0';
    
    --Clock Periods
    constant i_sys_clk_period : time := 40 ns;
    constant i_ps2_clk_period : time := 2*(40 us);
    
    constant c_num_mouse_events : integer := 20;
    
    type r_mouse_event is record
        e_l : std_logic;
        e_r : std_logic;
        e_xs : std_logic;
        e_ys : std_logic;
        e_xv : std_logic;
        e_yv : std_logic;
        e_x : std_logic_vector(7 downto 0);
        e_y : std_logic_vector(7 downto 0);
        e_z : std_logic_vector(7 downto 0);
    end record;
    
    constant c_default_mouse_event : r_mouse_event := (
        e_l => '0',
        e_r => '0',
        e_xs => '0',
        e_ys => '0',
        e_xv => '0',
        e_yv => '0',
        e_x => (others => '0'),
        e_y => (others => '0'),
        e_z => (others => '0')
    );
    
    type t_mouse_ev_arr is array(natural range<>) of r_mouse_event;
    
    signal s_mouse_ev_arr : t_mouse_ev_arr(c_num_mouse_events-1 downto 0);
    
    procedure p_send_ps2_data(
        variable i_data : in std_logic_vector(7 downto 0);
        signal o_ps2_dat : out std_logic;
        signal o_ps2_clk_drive_en : out std_logic
        )
    is
        variable v_parity : std_logic;
    begin
    
        report "p_send_ps2_data called, sending " & to_hstring(i_data) severity note;
        v_parity := xnor i_data;
        
        wait for i_ps2_clk_period*2;
        wait until rising_edge(s_ps2_clk);
        
        --transmit word
        o_ps2_clk_drive_en <= '1';
        o_ps2_dat <= '0';
        wait for i_ps2_clk_period;
        
        for b in i_data'low to i_data'high loop
            o_ps2_dat <= i_data(b);
            wait for i_ps2_clk_period;
        end loop;
        
        o_ps2_dat <= v_parity;
        wait for i_ps2_clk_period;
        
        o_ps2_dat <= '1';
        wait for i_ps2_clk_period;
        
        o_ps2_clk_drive_en <= '0';
        o_ps2_dat <= 'Z';
        
        wait for 0 ns;
        
    end procedure;
    
    procedure p_get_ps2_data(
        variable o_data : out std_logic_vector(7 downto 0);
        variable o_parity : out std_logic;
        signal io_ps2_dat : inout std_logic;
        signal o_ps2_clk_drive_en : out std_logic;
        variable o_error : out boolean
        )
    is
        variable v_start_time : time;
        variable v_data : std_logic_vector(7 downto 0);
        variable v_parity : std_logic;
    begin
    
        report "p_get_ps2_data called" severity note;
        
        o_ps2_clk_drive_en <= '0';
        
        if (io_ps2_clk = 'H' or io_ps2_clk = '1') then
            wait until io_ps2_clk = '0';
        elsif (io_ps2_clk = '0') then
            report "PS2 clock was already 0 when p_get_ps2_data was called!" severity warning;
        else
            report "PS2 clock was " & std_logic'image(io_ps2_clk) & " when p_get_ps2_data was called!" severity error;
            o_error := true;
            return;
        end if;
        
        v_start_time := now;
        
        wait until io_ps2_dat = '0';
        
        if (now - v_start_time < 100us) then
            report "PS2 clock not held low for long enough before RTS! Needs 100us minimum, was held for " & time'image(now - v_start_time) severity error;
            o_error := true;
            return;
        end if;
        
        if (io_ps2_clk /= '0') then
            report "PS2 clock not held low for RTS!" severity error;
            o_error := true;
            return;
        end if;
        
        wait until io_ps2_clk = 'H';
        
        wait for 20us;
        wait until s_ps2_clk = '1';
        wait for 1 ns;
        
        o_ps2_clk_drive_en <= '1';
        
        --clock in data on rising edge
        for i in 0 to 7 loop
            wait until falling_edge(io_ps2_clk);
            wait until rising_edge(io_ps2_clk);
            v_data(i) := io_ps2_dat;
            o_data(i) := v_data(i);
        end loop;
        
        --clock in parity bit
        wait until falling_edge(io_ps2_clk);
        wait until rising_edge(io_ps2_clk);
        v_parity := io_ps2_dat;
        o_parity := v_parity;
        
        if ((xor (v_data & v_parity)) = '0') then
            report "Parity error on PS2 receive!" severity error;
            o_error := true;
        end if;      
                
        --clock out stop bit on rising edge
        wait until falling_edge(io_ps2_clk);
        wait until rising_edge(io_ps2_clk);
        io_ps2_dat <= '0';
        wait for 40 us;
        
        --give falling edge so device can see it
        wait until falling_edge(io_ps2_clk);
        wait until rising_edge(io_ps2_clk);
        
        io_ps2_dat <= 'Z';
        o_ps2_clk_drive_en <= '0';
                
    end procedure;
    
    procedure p_wait_word(
        constant i_exp_word : in std_logic_vector(7 downto 0);
        constant i_validate : in boolean;
        constant i_do_resend : in boolean;
        signal o_ps2_clk_drive_en : out std_logic;
        signal io_ps2_dat : inout std_logic;
        variable o_word_rxed : out std_logic_vector(7 downto 0);
        variable o_error : out boolean
    )
    is
        variable v_data_slv : std_logic_vector(7 downto 0);
        variable v_parity : std_logic;
    begin
        
        p_get_ps2_data(v_data_slv, v_parity, io_ps2_dat, o_ps2_clk_drive_en, o_error);
        if (o_error) then
            report "Error during p_get_ps2_data" severity error;
        end if;
        
        o_word_rxed := v_data_slv;
        if (i_validate and v_data_slv /= i_exp_word) then
            o_error := true;
            report "Expected " & to_hstring(i_exp_word) & ", got " & to_hstring(v_data_slv) severity error;
        end if;
        
        if (i_do_resend) then
        
            --test resend functionality
            report "Asking for resend" severity note;
            v_data_slv := c_resp_resend;
            p_send_ps2_data(v_data_slv, io_ps2_dat, o_ps2_clk_drive_en);
            
            --expect word again
            report "Reading word again..." severity note;
            p_wait_word(i_exp_word, i_validate, false, o_ps2_clk_drive_en, io_ps2_dat, o_word_rxed, o_error);
            
        else
            --send ack
            report "Sending ack" severity note;
            v_data_slv := c_resp_ack;
            p_send_ps2_data(v_data_slv, io_ps2_dat, o_ps2_clk_drive_en);
        end if;
        
    
    end procedure;
    
begin

    io_ps2_clk <= 'H';
    io_ps2_dat <= 'H';
    
    UUT: entity work.PS2_mouse_reader
    generic map(
        g_sys_clk_f => 25_000_000
    )
    port map(
        i_sys_clk => i_sys_clk,
        io_ps2_clk => io_ps2_clk,
        i_sys_rst => i_sys_rst,
        io_ps2_dat => io_ps2_dat,
        o_left_btn => o_left_btn,
        o_right_btn => o_right_btn,
        o_middle_btn => o_middle_btn,
        o_x => o_x,
        o_y => o_y,
        o_z => o_z,
        o_mouse_connected => o_mouse_connected,
        o_valid => o_valid,
        i_ready => i_ready
    );
    
    --Clock Drivers
    i_sys_clk <= not i_sys_clk after i_sys_clk_period/2;
    s_ps2_clk <= not s_ps2_clk after i_ps2_clk_period/2;
    
    io_ps2_clk <= s_ps2_clk when s_ps2_clk_drive_en = '1' else 'Z';
    
    ps2_stim_proc: process is
        variable v_seed1, v_seed2 : positive;
        variable v_rnd : real;
        variable v_mouse_ev : r_mouse_event;
        variable v_data_slv, v_exp_data_slv : std_logic_vector(7 downto 0);
        variable v_error : boolean := false;
    begin
        
        io_ps2_clk <= 'H';
        io_ps2_dat <= 'H';
        
        wait for i_ps2_clk_period;
        
        i_sys_rst <= '0';
        
                
--        --send self-test pass
--        v_data_slv := c_resp_self_test_passed;
--        p_send_ps2_data(v_data_slv, io_ps2_dat, s_ps2_clk_drive_en);
                
--        --send ID
--        v_data_slv := c_resp_mouse_id_norm;
--        p_send_ps2_data(v_data_slv, io_ps2_dat, s_ps2_clk_drive_en);
        
        --get and validate command
        p_wait_word(c_cmd_reset, true, false, s_ps2_clk_drive_en, io_ps2_dat, v_data_slv, v_error);
        
        --send self-test pass
        v_data_slv := c_resp_self_test_passed;
        p_send_ps2_data(v_data_slv, io_ps2_dat, s_ps2_clk_drive_en);
                
        --send ID
        v_data_slv := c_resp_mouse_id_norm;
        p_send_ps2_data(v_data_slv, io_ps2_dat, s_ps2_clk_drive_en);
        
--        --get command but ask to resend
--        p_wait_word(c_cmd_set_sample_rate, true, true, s_ps2_clk_drive_en, io_ps2_dat, v_data_slv, v_error);
                
--        p_wait_word(X"XX", false, false, s_ps2_clk_drive_en, io_ps2_dat, v_data_slv, v_error);
--        report "Got sample rate of " & to_string(v_data_slv);
        
--        --get command but ask to resend
--        p_wait_word(c_cmd_set_sample_rate, true, true, s_ps2_clk_drive_en, io_ps2_dat, v_data_slv, v_error);
                
--        p_wait_word(X"XX", false, false, s_ps2_clk_drive_en, io_ps2_dat, v_data_slv, v_error);
--        report "Got sample rate of " & to_string(v_data_slv);
        
--        --get and validate command
--        p_wait_word(c_cmd_set_sample_rate, true, false, s_ps2_clk_drive_en, io_ps2_dat, v_data_slv, v_error);
                
--        p_wait_word(X"XX", false, false, s_ps2_clk_drive_en, io_ps2_dat, v_data_slv, v_error);
--        report "Got sample rate of " & to_string(v_data_slv);
        
--        --get and validate command
--        p_wait_word(c_cmd_get_dev_id, true, false, s_ps2_clk_drive_en, io_ps2_dat, v_data_slv, v_error);
        
--        --send wheel ID
--        v_data_slv := c_resp_mouse_id_wheel;
--        p_send_ps2_data(v_data_slv, io_ps2_dat, s_ps2_clk_drive_en);
        
--        --get and validate command
--        p_wait_word(c_cmd_set_resolution, true, false, s_ps2_clk_drive_en, io_ps2_dat, v_data_slv, v_error);
        
--        --get data, no validation
--        p_wait_word(X"XX", false, false, s_ps2_clk_drive_en, io_ps2_dat, v_data_slv, v_error);
--        report "Got resolution of " & to_string(v_data_slv);
        
--        --get and validate command
--        p_wait_word(c_cmd_set_sample_rate, true, false, s_ps2_clk_drive_en, io_ps2_dat, v_data_slv, v_error);
                
--        p_wait_word(X"XX", false, false, s_ps2_clk_drive_en, io_ps2_dat, v_data_slv, v_error);
--        report "Got sample rate of " & to_string(v_data_slv);

        --get and validate command
        p_wait_word(c_cmd_set_defaults, true, false, s_ps2_clk_drive_en, io_ps2_dat, v_data_slv, v_error);
        
        p_wait_word(c_cmd_en_data_reporting, true, false, s_ps2_clk_drive_en, io_ps2_dat, v_data_slv, v_error);
        
        for i in s_mouse_ev_arr'range loop
            
            v_mouse_ev := c_default_mouse_event;
            
            uniform(v_seed1, v_seed2, v_rnd);
            if (v_rnd > 0.5) then
                v_mouse_ev.e_l := '1';
            end if;
            
            uniform(v_seed1, v_seed2, v_rnd);
            if (v_rnd > 0.5) then
                v_mouse_ev.e_r := '1';
            end if;
            
            uniform(v_seed1, v_seed2, v_rnd);
            if (v_rnd > 0.5) then
                v_mouse_ev.e_xs := '1';
            end if;
            
            uniform(v_seed1, v_seed2, v_rnd);
            if (v_rnd > 0.5) then
                v_mouse_ev.e_ys := '1';
            end if;
            
            uniform(v_seed1, v_seed2, v_rnd);
            if (v_rnd > 0.5) then
                v_mouse_ev.e_xv := '1';
            end if;
            
            uniform(v_seed1, v_seed2, v_rnd);
            if (v_rnd > 0.5) then
                v_mouse_ev.e_yv := '1';
            end if;
            
            uniform(v_seed1, v_seed2, v_rnd);
            v_mouse_ev.e_x := std_logic_vector(to_unsigned(integer(v_rnd*(2**v_mouse_ev.e_x'length)), v_mouse_ev.e_x'length));
            
            uniform(v_seed1, v_seed2, v_rnd);
            v_mouse_ev.e_y := std_logic_vector(to_unsigned(integer(v_rnd*(2**v_mouse_ev.e_y'length)), v_mouse_ev.e_y'length));
            
            uniform(v_seed1, v_seed2, v_rnd);
            v_mouse_ev.e_z := std_logic_vector(to_unsigned(integer(v_rnd*(2**v_mouse_ev.e_z'length)), v_mouse_ev.e_z'length));
            
            s_mouse_ev_arr(i) <= v_mouse_ev;
            
            for j in 0 to 3 loop
            
                case(j) is
                    when 0 => v_data_slv := v_mouse_ev.e_yv & v_mouse_ev.e_xv & v_mouse_ev.e_ys & v_mouse_ev.e_xs & "10" & v_mouse_ev.e_r & v_mouse_ev.e_l; 
                    when 1 => v_data_slv := v_mouse_ev.e_x;
                    when 2 => v_data_slv := v_mouse_ev.e_y;
                    when 3 => v_data_slv := v_mouse_ev.e_z;
                    when others => report "check J loop" severity failure;
                end case;
                
                p_send_ps2_data(v_data_slv, io_ps2_dat, s_ps2_clk_drive_en);
                
            end loop;
            
        end loop;
        
        if (v_error) then
            report "Test Failed!" severity failure;
        else
            report "Test Passed!" severity failure;
        end if;
        
        -- Not strictly necessary, but prevents process from looping 
        -- if the above assert statement is removed
        wait;
        
    end process;

end Behavioral;
