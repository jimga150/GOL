----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/01/2020 01:25:03 PM
-- Design Name: 
-- Module Name: wraparound_addsub - Behavioral
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity wraparound_sub1 is
    port(
        max, num_in : in std_logic_vector(15 downto 0);
        result : out std_logic_vector(15 downto 0)
    );
end wraparound_sub1;

architecture Behavioral of wraparound_sub1 is

begin
    
    result <= max when num_in = x"0000" else std_logic_vector(unsigned(num_in) - 1);

end Behavioral;
