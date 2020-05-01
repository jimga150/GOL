----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:35:48 01/10/2019 
-- Design Name: 
-- Module Name:    wraparound_counter - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity wraparound_incrementer is
	generic (n : integer := 6);
    Port ( input, max : in  STD_LOGIC_VECTOR (n-1 downto 0);
           output : out  STD_LOGIC_VECTOR (n-1 downto 0));
end wraparound_incrementer;

architecture Behavioral of wraparound_incrementer is

begin
	
	output <= (others => '0') when input = max else std_logic_vector(unsigned(input) + 1);

end Behavioral;

