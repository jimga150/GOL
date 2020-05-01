----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/28/2020 07:45:26 AM
-- Design Name: 
-- Module Name: tickenable_sm_tb - Behavioral
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

entity tickenable_sm_tb is
--  Port ( );
end tickenable_sm_tb;

architecture Behavioral of tickenable_sm_tb is

    signal clk, rst, vsync : std_logic := '0';
    signal en : std_logic;

begin

    uut: entity work.tickenable_sm
    port map(
        clk => clk,
        rst => rst,
        vsync => vsync,
        en => en
    );
    
    clk_proc: process is begin
        wait for 5 ns;
        clk <= not clk;
    end process clk_proc;
    
    stim_proc: process is begin
        rst <= '1';
        
        wait for 10ns;
        
        rst <= '0';
        
        wait for 30 ns;
        
        vsync <= '1';
        
        wait for 30 ns;
        
        vsync <= '0';
        
        wait;
    end process stim_proc;
    
end Behavioral;
