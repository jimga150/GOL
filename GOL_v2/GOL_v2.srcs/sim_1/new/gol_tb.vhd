----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/18/2020 05:39:11 PM
-- Design Name: 
-- Module Name: gol_tb - Behavioral
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
use ieee.math_real.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity gol_tb is
--  Port ( );
generic (
    w : integer := 6; 
    h : integer := 6
    );
end gol_tb;

architecture Behavioral of gol_tb is

    signal clk, rst : std_logic := '0';
    signal row : integer := 0;
    signal col : integer := 0;
    signal val : std_logic;

begin

    uut: entity work.GOL
--    generic map(
--        w => w,
--        h => h
--    )
    port map(
        clk => clk,
        rst => rst,
        row => row,
        col => col,
        val => val
    );
    
    stim_proc: process is begin
        row <= 1;
        col <= 2;
        rst <= '1';
        wait for 10ns;
        rst <= '0';
        wait for 100ns;
        wait;
    end process stim_proc;
    
    clk_proc: process is begin
        wait for 5ns;
        clk <= not clk;
    end process clk_proc;

end Behavioral;
