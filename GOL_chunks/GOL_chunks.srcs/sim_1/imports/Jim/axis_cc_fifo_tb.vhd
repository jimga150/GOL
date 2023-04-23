----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/22/2023 11:21:29
-- Design Name: axis_cc_fifo_tb
-- Module Name: axis_cc_fifo_tb - Behavioral
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

entity axis_cc_fifo_tb is
end axis_cc_fifo_tb;

architecture Behavioral of axis_cc_fifo_tb is
    
    --Generics
    constant g_data_width : integer := 36;
    constant g_data_depth : integer := 1024;
    constant g_sync_stages : integer := 3;
    
    
    --Clocks
    signal i_m_clk : std_logic := '0';
    signal i_s_clk : std_logic := '0';
    
    --Resets
    signal i_m_rst : std_logic := '1';
    signal i_s_rst : std_logic := '1';
    
    --General inputs
    signal i_m_valid : std_logic := '0';
    signal i_m_data : std_logic_vector(g_data_width-1 downto 0) := (others => '0');
    signal i_s_ready : std_logic := '0';
    
    --Outputs
    signal o_m_ready : std_logic;
    signal o_s_valid : std_logic;
    signal o_s_data : std_logic_vector(g_data_width-1 downto 0);
    
    --Clock Periods
    constant i_m_clk_period : time := 10 ns;
    constant i_s_clk_period : time := 10.026 ns;
    
    signal s_test_done : std_logic := '0';
    
begin
    
    UUT: entity work.axis_cc_fifo
    generic map(
        g_data_width => g_data_width,
        g_data_depth => g_data_depth,
        g_sync_stages => g_sync_stages
    )
    port map(
        i_m_clk => i_m_clk,
        i_s_clk => i_s_clk,
        i_m_rst => i_m_rst,
        i_s_rst => i_s_rst,
        i_m_valid => i_m_valid,
        o_m_ready => o_m_ready,
        i_m_data => i_m_data,
        o_s_valid => o_s_valid,
        i_s_ready => i_s_ready,
        o_s_data => o_s_data
    );
    
    --Clock Drivers
    i_m_clk <= not i_m_clk after i_m_clk_period/2;
    i_s_clk <= not i_s_clk after i_s_clk_period/2;
    
    stim_proc: process is
        variable v_seed1, v_seed2 : positive;
        variable v_rnd : real;
        type t_real_arr is array(natural range<>) of real;
        variable v_valid_probs : t_real_arr(2 downto 0);
        variable v_data : integer := 0;
    begin
        
        wait for i_m_clk_period*10;
        
        i_m_rst <= '0';
        i_s_rst <= '0';
        
        wait for i_m_clk_period;
        
        --i_s_ready will be 1 half of the time, so try putting data in around 
        --the same rate, then much faster, then much slower
        v_valid_probs(0) := 0.5;
        v_valid_probs(1) := 0.8;
        v_valid_probs(2) := 0.2;
        
        for p in v_valid_probs'low to v_valid_probs'high loop
            for i in 0 to g_data_depth*4 loop
        
                uniform(v_seed1, v_seed2, v_rnd);
                
                if (v_rnd < v_valid_probs(p)) then
                    i_m_valid <= '1';
                    i_m_data <= std_logic_vector(to_unsigned(v_data, i_m_data'length));
                    if (o_m_ready = '1') then
                        v_data := v_data + 1;
                    end if;
                else
                    i_m_valid <= '0';
                    i_m_data <= (others => 'X');
                end if;
                
                wait for i_m_clk_period;
            
            end loop;
        end loop;
        
        i_m_valid <= '0';
        wait for i_m_clk_period*20;
        
        s_test_done <= '1';
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
        
        if (i_s_rst = '1') then
            wait until i_s_rst = '0';
        end if;
                
        i_s_ready <= '0';
        
        while (true) loop
        
            wait until rising_edge(i_s_clk);
            
            if (s_test_done = '1') then
                assert (not v_error) report "Test Failed" severity failure;
                report "Test Passed" severity failure;
            end if;
            
            if (i_s_ready = '1' and o_s_valid = '1') then
            
                v_data_out_act := to_integer(unsigned(o_s_data));
                
                if (v_data_out_act /= v_data_out_exp) then
                    report "Data mismatch, expected " & integer'image(v_data_out_exp) & ", got " & integer'image(v_data_out_act)
                    severity error;
                    v_error := true;
                end if;
                
                v_data_out_exp := v_data_out_exp + 1;
                
            end if;
            
            uniform(v_seed1, v_seed2, v_rnd);
            
            if (v_rnd < 0.5) then
                i_s_ready <= '1';
            else
                i_s_ready <= '0';
            end if;
            
        end loop;
        
    end process;

end Behavioral;
