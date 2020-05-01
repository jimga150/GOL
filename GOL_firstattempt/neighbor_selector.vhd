----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:01:54 02/04/2019 
-- Design Name: 
-- Module Name:    neighbor_selector - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity neighbor_selector is
    Port ( origin : in  STD_LOGIC_VECTOR (7 downto 0);
           offset : in  STD_LOGIC_VECTOR (2 downto 0);
           min, max : in  STD_LOGIC_VECTOR (7 downto 0);
			  output : out  STD_LOGIC_VECTOR (7 downto 0));
end neighbor_selector;

architecture Behavioral of neighbor_selector is

	signal origin_plus_offset : std_logic_vector(7 downto 0);

begin

	origin_plus_offset <= unsigned(origin) + unsigned(offset) - 1;
	
	with origin_plus_offset select output <= 
		min when std_logic_vector(unsigned(max) + 1),
		max when std_logic_vector(unsigned(min) - 1),
		origin_plus_offset when others;

end Behavioral;