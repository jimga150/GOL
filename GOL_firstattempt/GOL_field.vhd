----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:07:32 12/18/2018 
-- Design Name: 
-- Module Name:    GOL - Structural 
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
use IEEE.STD_LOGIC_1164.all;

package bus_array_pkg is
	constant h : integer := 3;
	constant w : integer := 34;
	
	type bus_array is array(h-1 downto 0) of std_logic_vector(w-1 downto 0);
	
	type NC_row is array(w-2 downto 1) of std_logic_vector(7 downto 0);
	--type NC_array is array(h-1 downto 0) of NC_row;
end package bus_array_pkg;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.bus_array_pkg.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity GOL_field is
    Port ( current_state : in bus_array;
           next_state : out std_logic_vector(31 downto 0)
			  );
end GOL_field;

architecture Structural of GOL_field is
	signal neighbor_counts : NC_row;
begin
	
	cells: for c in 1 to 32 generate
		cell: entity work.Cell
			port map(
				current => current_state(1)(c),
				neighbors => neighbor_counts(c),
				output => next_state(c-1)
			);
	end generate cells;


	cell_connections: for c in 1 to 32 generate
		neighbor_counts(c) <= 
			current_state(0)(c-1) & current_state(0)(c) & current_state(0)(c+1) & 
			current_state(1)(c-1)							  & current_state(1)(c+1) &
			current_state(2)(c-1) & current_state(2)(c) & current_state(2)(c+1);
	end generate cell_connections;

end Structural;

