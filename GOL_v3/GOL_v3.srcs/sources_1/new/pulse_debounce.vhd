----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/31/2020 10:50:43 AM
-- Design Name: 
-- Module Name: pulse_debounce - Behavioral
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

entity pulse_debounce is
    Port ( clk, rst, btn : in STD_LOGIC;
           pulse : out STD_LOGIC);
end pulse_debounce;

architecture Behavioral of pulse_debounce is

    signal dbcd, dbcd_last : std_logic;

begin

    debouncer: entity work.debounce
    port map(
        clk => clk,
        reset => rst,
        button => btn,
        result => dbcd
    );
    
    process(clk) is begin
        if rising_edge(clk) then
            dbcd_last <= dbcd;
        end if;
    end process;
    
    pulse <= '1' when (dbcd and not dbcd_last) = '1' else '0';

end Behavioral;
