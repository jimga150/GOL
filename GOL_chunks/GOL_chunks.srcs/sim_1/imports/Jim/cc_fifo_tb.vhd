----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/30/2023 22:37:06
-- Design Name: cc_fifo_tb
-- Module Name: cc_fifo_tb - Behavioral
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
use IEEE.MATH_REAL.ALL;

entity cc_fifo_tb is
end cc_fifo_tb;

architecture Behavioral of cc_fifo_tb is
    
    --Generics
    constant g_data_width : integer := 36;
    constant g_data_depth : integer := 1024;
    constant g_sync_stages : integer := 3;
    
    
    --Clocks
    signal i_clk_s : std_logic := '0';
    signal i_clk_m : std_logic := '0';
    
    --Resets
    signal i_rst_s : std_logic := '1';
    signal i_rst_m : std_logic := '1';
    
    --General inputs
    signal i_s_valid : std_logic := '0';
    signal i_s_data : std_logic_vector(g_data_width-1 downto 0) := (others => '0');
    signal i_m_request_data : std_logic := '0';
    
    --Outputs
    signal o_s_fifo_almost_full : std_logic;
    signal o_s_fifo_full : std_logic;
    signal o_m_fifo_almost_empty : std_logic;
    signal o_m_fifo_empty : std_logic;
    signal o_m_data : std_logic_vector(g_data_width-1 downto 0);
    
    --Clock Periods
    constant i_clk_s_period : time := 10 ns;
    constant i_clk_m_period : time := 10.026 ns;
    
    signal s_input_cnt : integer := 0;
    signal s_input_done : std_logic := '0';
    
    constant c_fifo_latency_to_wait : integer := 100;
    signal s_test_done_counter : integer := 0;
    signal s_test_done : std_logic := '0';
    
    signal s_output_cnt : integer := 0;
    
    signal s_m_out_valid_pipeline : std_logic_vector(1 downto 0);
    
begin
    
    UUT: entity work.cc_fifo
    generic map(
        g_data_width => g_data_width,
        g_data_depth => g_data_depth,
        g_sync_stages => g_sync_stages
    )
    port map(
        i_clk_s => i_clk_s,
        i_clk_m => i_clk_m,
        i_rst_s => i_rst_s,
        i_rst_m => i_rst_m,
        i_s_valid => i_s_valid,
        o_s_fifo_almost_full => o_s_fifo_almost_full,
        o_s_fifo_full => o_s_fifo_full,
        i_s_data => i_s_data,
        o_m_fifo_almost_empty => o_m_fifo_almost_empty,
        o_m_fifo_empty => o_m_fifo_empty,
        i_m_request_data => i_m_request_data,
        o_m_data => o_m_data
    );
    
    --Clock Drivers
    i_clk_s <= not i_clk_s after i_clk_s_period/2;
    i_clk_m <= not i_clk_m after i_clk_m_period/2;
    
    process(i_clk_m) is begin
        if rising_edge(i_clk_m) then
        
            s_m_out_valid_pipeline <= s_m_out_valid_pipeline(s_m_out_valid_pipeline'high - 1 downto s_m_out_valid_pipeline'low) & '0';
        
            if (i_m_request_data = '1' and o_m_fifo_empty = '0') then
                s_m_out_valid_pipeline(0) <= '1';
            end if;
            
        end if;
    end process;
    
    stim_proc: process is
        variable v_seed1, v_seed2 : positive;
        variable v_rnd : real;
        type t_real_arr is array(natural range<>) of real;
        variable v_valid_probs : t_real_arr(2 downto 0);
        variable v_data : integer := 0;
    begin
        
        wait for i_clk_s_period*10;
        
        i_rst_s <= '0';
        i_rst_m <= '0';
        
        wait for i_clk_s_period;
        
        --i_ready will be 1 half of the time, so try putting data in around the same rate, then much faster, then much slower
        v_valid_probs(0) := 0.5;
        v_valid_probs(1) := 0.8;
        v_valid_probs(2) := 0.2;
        
        for p in v_valid_probs'low to v_valid_probs'high loop
            for i in 0 to g_data_depth*4 loop
        
                uniform(v_seed1, v_seed2, v_rnd);
                
                if (v_rnd < v_valid_probs(p)) then
                    i_s_valid <= '1';
                    i_s_data <= std_logic_vector(to_unsigned(v_data, i_s_data'length));
                    if (o_s_fifo_full = '0') then
                        v_data := v_data + 1;
                        s_input_cnt <= s_input_cnt + 1;
                    end if;
                else
                    i_s_valid <= '0';
                    i_s_data <= (others => 'X');
                end if;
                
                wait for i_clk_s_period;
            
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
        
        if (i_rst_m = '1') then
            wait until i_rst_m = '0';
        end if;      
        
        i_m_request_data <= '1';
        
        while (true) loop
        
            wait until rising_edge(i_clk_m);
            
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
            
            if (s_m_out_valid_pipeline(s_m_out_valid_pipeline'high) = '1') then
            
                s_output_cnt <= s_output_cnt + 1;
            
                v_data_out_act := to_integer(unsigned(o_m_data));
                
                if (v_data_out_act /= v_data_out_exp) then
                    report "Data mismatch, expected " & integer'image(v_data_out_exp) & ", got " & integer'image(v_data_out_act)
                    severity error;
                    v_error := true;
                end if;
                
                v_data_out_exp := v_data_out_exp + 1;
                
            end if;
            
            uniform(v_seed1, v_seed2, v_rnd);
            
            if (v_rnd < 0.5) then
                i_m_request_data <= '1';
            else
                i_m_request_data <= '0';
            end if;
            
        end loop;
        
    end process;

end Behavioral;
