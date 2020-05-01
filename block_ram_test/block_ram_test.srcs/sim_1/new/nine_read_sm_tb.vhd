----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/04/2020 03:12:19 PM
-- Design Name: 
-- Module Name: nine_read_sm_tb - Behavioral
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

entity nine_read_sm_tb is
--  Port ( );
end nine_read_sm_tb;

architecture Behavioral of nine_read_sm_tb is

    signal clk, rst, read : std_logic := '0';
    signal addr_base : std_logic_vector(5 downto 0) := "000100";
    signal addr_write :std_logic_vector(5 downto 0) := "101011";
    
    signal bram_read_en, bram_write_en : std_logic;
    signal addr_out : std_logic_vector(5 downto 0);
    signal grid_index_en : std_logic_vector(8 downto 0);
    
    constant clk_period : time := 10ns;

begin

    uut: entity work.nine_read_sm
    port map(
        clk => clk,
        rst => rst,
        read => read,
        addr_base => addr_base,
        addr_write => addr_write,
        bram_read_en => bram_read_en,
        bram_write_en => bram_write_en,
        addr_out => addr_out,
        grid_index_en => grid_index_en
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
        
        wait for clk_period*12;
        
        assert false report "End Simulation" severity failure;
        wait;
    end process;

end Behavioral;
