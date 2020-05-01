----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:13:48 12/18/2018 
-- Design Name: 
-- Module Name:    Cell - Behavioral 
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

entity Cell is
    Port ( current : in STD_LOGIC;
           neighbors : in STD_LOGIC_VECTOR (7 downto 0);
           output : out STD_LOGIC);
end Cell;

architecture Behavioral of Cell is
	signal two, three : std_logic;
begin
		
	neighbor_counter : entity work.NeighborCounter
	port map(
		neighbors => neighbors,
		two => two,
		three => three
	);
	
	output <= (three or (two and current));
	
end Behavioral;

