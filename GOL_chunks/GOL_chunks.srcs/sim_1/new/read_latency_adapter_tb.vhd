----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/30/2023 15:31:33
-- Design Name: read_latency_adapter_tb
-- Module Name: read_latency_adapter_tb - Behavioral
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

entity read_latency_adapter_tb is
end read_latency_adapter_tb;

architecture Behavioral of read_latency_adapter_tb is
    
    --Generics
    constant g_data_width : integer := 32 ;
    constant g_producer_latency : integer := 2;
    
    
    --Clocks
    signal i_clk : std_logic := '0';
    
    --Resets
    signal i_rst : std_logic := '1';
    
    --General inputs
    signal i_fifo_almost_empty : std_logic := '0';
    signal i_fifo_empty : std_logic := '0';
    signal i_data : std_logic_vector(g_data_width-1 downto 0) := (others => '0');
    signal i_ready : std_logic := '0';
    
    --Outputs
    signal o_read_req : std_logic;
    signal o_valid : std_logic;
    signal o_data : std_logic_vector(g_data_width-1 downto 0);
    
    --Clock Periods
    constant i_clk_period : time := 10 ns;
    
    signal s_read_pipeline : std_logic_vector(g_producer_latency downto 1) := (others => '0');
    signal s_sim_data : integer := 0;
    
    constant c_input_limit : integer := 200;
    signal s_input_cnt : integer := 0;
    signal s_output_cnt : integer := 0;
    
    signal s_error : boolean := false;
    
    signal s_input_done : std_logic := '0';
    
    constant c_ready_pause_cycles : integer := 20;
    signal s_ready_pause_counter : integer := 0;
    
    constant c_ready_go_cycles : integer := 20;
    signal s_ready_go_counter : integer := 0;
    
begin
    
    UUT: entity work.read_latency_adapter
    generic map(
        g_data_width => g_data_width,
        g_producer_latency => g_producer_latency
    )
    port map(
        i_clk => i_clk,
        i_rst => i_rst,
        i_fifo_almost_empty => i_fifo_almost_empty,
        i_fifo_empty => i_fifo_empty,
        o_read_req => o_read_req,
        i_data => i_data,
        o_valid => o_valid,
        i_ready => i_ready,
        o_data => o_data
    );
    
    --Clock Drivers
    i_clk <= not i_clk after i_clk_period/2;
    
    process(i_clk) is
        variable v_seed1, v_seed2 : positive;
        variable v_rnd : real;
        variable v_data_out_exp, v_data_out_act : integer := 0;
    begin
        if rising_edge(i_clk) then
            
            if (o_read_req = '1') then
                s_input_cnt <= s_input_cnt + 1;
            end if;
            
            s_read_pipeline <= s_read_pipeline(s_read_pipeline'high - 1 downto s_read_pipeline'low) 
                & o_read_req;
            
            if (s_read_pipeline(s_read_pipeline'high) = '1') then
                s_sim_data <= s_sim_data + 1;
            end if;
            
            i_fifo_almost_empty <= '0';
            uniform(v_seed1, v_seed2, v_rnd);
            if (v_rnd < 0.2) then
                i_fifo_almost_empty <= '1';
            end if;
            
            if (s_input_cnt >= c_input_limit) then
                i_fifo_almost_empty <= '1';
                s_input_done <= '1';
                
                if (i_fifo_almost_empty = '1') then
                    i_fifo_empty <= '1';
                end if;
                
            end if;
            
            i_ready <= '0';
            uniform(v_seed1, v_seed2, v_rnd);
            if (v_rnd < 0.5) then
                i_ready <= '1';
            end if;
            
            --at some point we should create a lot of continuous backpressure and then see if the data will come out continuously
            if (s_input_cnt = 50 or (s_ready_pause_counter > 0 and s_ready_pause_counter < c_ready_pause_cycles)) then
                s_ready_pause_counter <= s_ready_pause_counter + 1;
                i_ready <= '0';
            end if;
            
            if (s_ready_pause_counter = c_ready_pause_cycles and s_ready_go_counter < c_ready_go_cycles) then
                s_ready_go_counter <= s_ready_go_counter + 1;
                i_ready <= '1';
                i_fifo_almost_empty <= '0';
            end if;
            
            if (i_ready = '1' and o_valid = '1') then
            
                s_output_cnt <= s_output_cnt + 1;
            
                v_data_out_act := to_integer(unsigned(o_data));
                
                if (v_data_out_act /= v_data_out_exp) then
                    report "Data mismatch, expected " & integer'image(v_data_out_exp) & ", got " & integer'image(v_data_out_act)
                    severity error;
                    s_error <= true;
                end if;
                
                v_data_out_exp := v_data_out_exp + 1;
                
            end if;
            
        end if;
    end process;
    
    i_data <= std_logic_vector(to_unsigned(s_sim_data, i_data'length)) when s_read_pipeline(s_read_pipeline'high) = '1' else (others => 'X');
    
    stim_proc: process is begin
        
        wait for i_clk_period;
        
        i_rst <= '0';
        
        wait until s_input_done = '1';
        
        wait for i_clk_period*10;
        
        if (s_error) then
            report "Test Failed: Error detected" severity failure;
        end if;
        if (s_output_cnt /= s_input_cnt) then
            report "Test Failed: Input count was " & integer'image(s_input_cnt) & 
                ", but output count was " & integer'image(s_output_cnt) severity failure;
        end if;
        report "Test Passed" severity failure;
                
        -- Not strictly necessary, but prevents process from looping 
        -- if the above assert statement is removed
        wait;
        
    end process;

end Behavioral;
