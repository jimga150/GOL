----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/26/2020 11:42:52 AM
-- Design Name: 
-- Module Name: GOL_top_tb - Behavioral
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

entity GOL_top_tb is
--  Port ( );
end GOL_top_tb;

architecture Behavioral of GOL_top_tb is

    signal clk : std_logic := '0';
    signal rst : std_logic := '1';
    
    signal pixel : std_logic_vector(11 downto 0);
    signal hsync, vsync : std_logic;

begin

    uut: entity work.GOL_top
    port map(
        clk => clk,
        rst => rst,
        pixel => pixel,
        hsync => hsync,
        vsync => vsync
    );
    
    clk_proc: process is begin
        wait for 5ns;
        clk <= not clk;
    end process clk_proc;
    
    stim_proc: process is begin        
        wait for 10ns;
        
        rst <= '0';
        
        wait;
    end process stim_proc;

end Behavioral;
