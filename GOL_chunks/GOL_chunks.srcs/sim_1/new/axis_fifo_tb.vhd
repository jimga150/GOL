----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/21/2023 12:59:34 PM
-- Design Name: 
-- Module Name: axis_fifo_tb - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use ieee.math_real.all;

entity axis_fifo_tb is
end axis_fifo_tb;

architecture Behavioral of axis_fifo_tb is
    
    --Generics
    constant g_data_width : integer := 32;
    constant g_data_depth : integer := 256;
    
    
    --Clocks
    signal i_clk : std_logic := '0';
    
    --Resets
    signal i_rst : std_logic := '1';
    
    --General inputs
    signal i_valid : std_logic := '0';
    signal i_data : std_logic_vector(g_data_width-1 downto 0) := (others => '0');
    signal i_ready : std_logic := '0';
    
    --Outputs
    signal o_ready : std_logic;
    signal o_valid : std_logic;
    signal o_data : std_logic_vector(g_data_width-1 downto 0);
    
    --Clock Periods
    constant i_clk_period : time := 10 ns;
    
    signal s_input_cnt : integer := 0;
    signal s_input_done : std_logic := '0';
    
    constant c_fifo_latency_to_wait : integer := 100;
    signal s_test_done_counter : integer := 0;
    signal s_test_done : std_logic := '0';
    
    signal s_output_cnt : integer := 0;
    
begin
    
    UUT: entity work.axis_fifo
    generic map(
        g_data_width => g_data_width,
        g_data_depth => g_data_depth
    )
    port map(
        i_clk => i_clk,
        i_rst => i_rst,
        i_valid => i_valid,
        o_ready => o_ready,
        i_data => i_data,
        o_valid => o_valid,
        i_ready => i_ready,
        o_data => o_data
    );
    
    --Clock Drivers
    i_clk <= not i_clk after i_clk_period/2;
    
    stim_proc: process is
        variable v_seed1, v_seed2 : positive;
        variable v_rnd : real;
        type t_real_arr is array(natural range<>) of real;
        variable v_valid_probs : t_real_arr(2 downto 0);
        variable v_data : integer := 0;
    begin
        
        wait for i_clk_period;
        
        i_rst <= '0';
        
        wait for i_clk_period;
        
        --i_ready will be 1 half of the time, so try putting data in around the same rate, then much faster, then much slower
        v_valid_probs(0) := 0.5;
        v_valid_probs(1) := 0.8;
        v_valid_probs(2) := 0.2;
        
        for p in v_valid_probs'low to v_valid_probs'high loop
            for i in 0 to g_data_depth*4 loop
        
                uniform(v_seed1, v_seed2, v_rnd);
                
                if (v_rnd < v_valid_probs(p)) then
                    i_valid <= '1';
                    i_data <= std_logic_vector(to_unsigned(v_data, i_data'length));
                    if (o_ready = '1') then
                        v_data := v_data + 1;
                        s_input_cnt <= s_input_cnt + 1;
                    end if;
                else
                    i_valid <= '0';
                    i_data <= (others => 'X');
                end if;
                
                wait for i_clk_period;
            
            end loop;
        end loop;
        
        
        s_input_done <= '1';
        
--        assert false report "End Simulation" severity failure;
        
        -- Not strictly necessary, but prevents process from looping 
        -- if the above assert statement is removed
        wait;
        
    end process;
    
    track_output_proc: process is
        variable v_seed1, v_seed2 : positive := 4;
        variable v_rnd : real;
        variable v_data_out_exp : integer := 0;
        variable v_data_out_act : integer;
        variable v_error : boolean := false;
    begin
        
        if (i_rst = '1') then
            wait until i_rst = '0';
        end if;      
        
        i_ready <= '1';
        
        while (true) loop
        
            wait until rising_edge(i_clk);
            
            if (s_input_done = '1') then
                s_test_done_counter <= s_test_done_counter + 1;
                if (s_test_done_counter >= c_fifo_latency_to_wait) then
                    s_test_done <= '1';
                end if;
            end if;
            
            if (s_test_done = '1') then
                if (v_error) then
                    report "Test Failed: Error detected" severity failure;
                end if;
                if (s_output_cnt /= s_input_cnt) then
                    report "Test Failed: Input count was " & integer'image(s_input_cnt) & 
                        ", but output count was " & integer'image(s_output_cnt) severity failure;
                end if;
                report "Test Passed" severity failure;
            end if;
            
            if (i_ready = '1' and o_valid = '1') then
            
                s_output_cnt <= s_output_cnt + 1;
            
                v_data_out_act := to_integer(unsigned(o_data));
                
                if (v_data_out_act /= v_data_out_exp) then
                    report "Data mismatch, expected " & integer'image(v_data_out_exp) & ", got " & integer'image(v_data_out_act)
                    severity error;
                    v_error := true;
                end if;
                
                v_data_out_exp := v_data_out_exp + 1;
                
            end if;
            
            uniform(v_seed1, v_seed2, v_rnd);
            
            if (v_rnd < 0.5) then
                i_ready <= '1';
            else
                i_ready <= '0';
            end if;
            
        end loop;
        
    end process;

end Behavioral;