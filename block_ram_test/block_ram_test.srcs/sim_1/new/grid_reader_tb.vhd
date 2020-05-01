----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/04/2020 09:52:34 PM
-- Design Name: 
-- Module Name: grid_reader_tb - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity grid_reader_tb is
--  Port ( );
end grid_reader_tb;

architecture Behavioral of grid_reader_tb is

    signal clk, rst, read : std_logic := '0';
    signal addr_base : std_logic_vector(5 downto 0) := "000100";
    
    signal grid_index_en : std_logic_vector(8 downto 0);
    signal dout : std_logic_vector(63 downto 0);
    
    constant clk_period : time := 10ns;

begin

    uut: entity work.grid_reader
    port map(
        clk => clk,
        rst => rst,
        read => read,
        addr_in => addr_base,
        grid_index_en => grid_index_en,
        dout => dout
    );

    clk <= not clk after clk_period/2;
    
    stim_proc: process is begin
        rst <= '1';
        wait for clk_period;
        rst <= '0';
        
        wait for clk_period*5;
        
        read <= '1';
        wait for clk_period;
        read <= '0';
        
        wait for clk_period*10;
        
        assert false report "End Simulation" severity failure;
        wait;
    end process;

end Behavioral;
