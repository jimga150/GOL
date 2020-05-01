----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/28/2020 10:05:42 AM
-- Design Name: 
-- Module Name: debounce_tb - Behavioral
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

entity debounce_tb is
--  Port ( );
end debounce_tb;

architecture Behavioral of debounce_tb is

    signal clk, rst_n, btn_in : std_logic := '0';
    
    signal btn_out : std_logic;
    
begin

    uut: entity work.debounce
    port map(
        clk => clk,
        reset_n => '1',
        button => btn_in,
        result => btn_out
    );
    
    clk_proc: process is begin
        wait for 5 ns;
        clk <= not clk;
    end process clk_proc;
    
    stim_proc: process is begin
        wait for 10ns;
        rst_n <= '1';
        
        wait for 11ms;
        
        btn_in <= '1';
        
        wait for 11ms;
        
        btn_in <= '0';
        
        wait for 11ms;
        wait;
    end process;

end Behavioral;
