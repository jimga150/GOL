----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/05/2023 22:49:37
-- Design Name: PS2_writer_tb
-- Module Name: PS2_writer_tb - Behavioral
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

entity PS2_writer_tb is
end PS2_writer_tb;

architecture Behavioral of PS2_writer_tb is
    
    --Generics
    constant g_sys_clk_f : integer := 100_000_000;
    constant g_ps2_clk_f : integer := 16891;
    constant g_parity_odd : boolean := true;
    
    
    --Clocks
    signal i_sys_clk : std_logic := '0';
    
    --Resets
    signal i_sys_rst : std_logic := '1';
    
    --General inputs
    signal i_data : std_logic_vector(7 downto 0) := (others => '0');
    signal i_valid : std_logic := '0';
    
    --Outputs
    signal o_ps2_clk : std_logic;
    signal o_ps2_data : std_logic;
    signal o_driving_line : std_logic;
    signal o_ready : std_logic;
    
    --Clock Periods
    constant i_sys_clk_period : time := 10 ns;
    
begin
    
    UUT: entity work.PS2_writer
    generic map(
        g_sys_clk_f => g_sys_clk_f,
        g_ps2_clk_f => g_ps2_clk_f,
        g_parity_odd => g_parity_odd
    )
    port map(
        i_sys_clk => i_sys_clk,
        i_sys_rst => i_sys_rst,
        o_ps2_clk => o_ps2_clk,
        o_ps2_data => o_ps2_data,
        o_driving_line => o_driving_line,
        i_data => i_data,
        i_valid => i_valid,
        o_ready => o_ready
    );
    
    --Clock Drivers
    i_sys_clk <= not i_sys_clk after i_sys_clk_period/2;
    
    stim_proc: process is begin
        
        wait for i_sys_clk_period;
        
        i_sys_rst <= '0';
        
        wait for i_sys_clk_period;
        
        if (o_ready = '0') then
            wait until o_ready = '1';
            wait for i_sys_clk_period/2;
        end if;
        
        i_data <= x"DE";
        i_valid <= '1';
        wait for i_sys_clk_period;
        
        i_valid <= '0';
        wait for i_sys_clk_period;
        
        if (o_ready = '0') then
            wait until o_ready = '1';
            wait for i_sys_clk_period/2;
        end if;
        
        assert false report "End Simulation" severity failure;
        
        -- Not strictly necessary, but prevents process from looping 
        -- if the above assert statement is removed
        wait;
        
    end process;

end Behavioral;
