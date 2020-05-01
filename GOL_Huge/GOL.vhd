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
	constant h : integer := 6;
	constant w : integer := 6;
	
	type bus_array is array(h-1 downto 0) of std_logic_vector(w-1 downto 0);
	
	type NC_row is array(w-1 downto 0) of std_logic_vector(7 downto 0);
	type NC_array is array(h-1 downto 0) of NC_row;
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

entity GOL is
    Port ( Presets : in bus_array;
           clk, preset_sel : in STD_LOGIC;
           Cells : out bus_array
			  );
end GOL;

architecture Structural of GOL is
	signal cell_states : bus_array;
	signal neighbor_counts : NC_array;
begin

	Cells <= cell_states;
	
	cell_rows: for r in 0 to h-1 generate
		cell_cols: for c in 0 to w-1 generate
			cell: entity work.Cell
					port map(
						preset => Presets(r)(c),
						preset_sel => preset_sel,
						clk => clk,
						neighbors => neighbor_counts(r)(c),
						output => cell_states(r)(c)
					);
		end generate cell_cols;
	end generate cell_rows;


	rows: for r in 0 to h-1 generate
		first_row : if r = 0 generate
			cols: for c in 0 to w-1 generate
				first_col: if c = 0 generate
					 	neighbor_counts(r)(c) <= 
							cell_states(h-1)(w-1) & cell_states(h-1)(c) & cell_states(h-1)(c+1) & 
							cell_states(r)(w-1)								  & cell_states(r)(c+1) &
							cell_states(r+1)(w-1) & cell_states(r+1)(c) & cell_states(r+1)(c+1);
				end generate first_col;
				
				mid_col: if c /= 0 and c /= w-1 generate
					neighbor_counts(r)(c) <= 
							cell_states(h-1)(c-1) & cell_states(h-1)(c) & cell_states(h-1)(c+1) & 
							cell_states(r)(c-1)								  & cell_states(r)(c+1) &
							cell_states(r+1)(c-1) & cell_states(r+1)(c) & cell_states(r+1)(c+1);
				end generate mid_col;
				
				last_col: if c = w-1 generate
					neighbor_counts(r)(c) <= 
							cell_states(h-1)(c-1) & cell_states(h-1)(c) & cell_states(h-1)(0) & 
							cell_states(r)(c-1)								  & cell_states(r)(0) &
							cell_states(r+1)(c-1) & cell_states(r+1)(c) & cell_states(r+1)(0);
				end generate last_col;
			end generate cols;
		end generate first_row;
		
		mid_row : if r /= 0 and r /= h-1 generate
			cols: for c in 0 to w-1 generate
				first_col: if c = 0 generate
					neighbor_counts(r)(c) <= 
							cell_states(r-1)(w-1) & cell_states(r-1)(c) & cell_states(r-1)(c+1) & 
							cell_states(r)(w-1)								  & cell_states(r)(c+1) &
							cell_states(r+1)(w-1) & cell_states(r+1)(c) & cell_states(r+1)(c+1);
				end generate first_col;
				
				mid_col: if c /= 0 and c /= w-1 generate
					neighbor_counts(r)(c) <= 
							cell_states(r-1)(c-1) & cell_states(r-1)(c) & cell_states(r-1)(c+1) & 
							cell_states(r)(c-1)								  & cell_states(r)(c+1) &
							cell_states(r+1)(c-1) & cell_states(r+1)(c) & cell_states(r+1)(c+1);
				end generate mid_col;
				
				last_col: if c = w-1 generate
					neighbor_counts(r)(c) <= 
							cell_states(r-1)(c-1) & cell_states(r-1)(c) & cell_states(r-1)(0) & 
							cell_states(r)(c-1)								  & cell_states(r)(0) &
							cell_states(r+1)(c-1) & cell_states(r+1)(c) & cell_states(r+1)(0);
				end generate last_col;
			end generate cols;
		end generate mid_row;
		
		last_row : if r = h-1 generate
			cols: for c in 0 to w-1 generate
				first_col: if c = 0 generate
					neighbor_counts(r)(c) <= 
							cell_states(r-1)(w-1) & cell_states(r-1)(c) & cell_states(r-1)(c+1) & 
							cell_states(r)(w-1)								  & cell_states(r)(c+1) &
							cell_states(0)(w-1) & cell_states(0)(c) & cell_states(0)(c+1);
				end generate first_col;
				
				mid_col: if c /= 0 and c /= w-1 generate
					neighbor_counts(r)(c) <= 
							cell_states(r-1)(c-1) & cell_states(r-1)(c) & cell_states(r-1)(c+1) & 
							cell_states(r)(c-1)								  & cell_states(r)(c+1) &
							cell_states(0)(c-1) & cell_states(0)(c) & cell_states(0)(c+1);
				end generate mid_col;
				
				last_col: if c = w-1 generate
					neighbor_counts(r)(c) <= 
							cell_states(r-1)(c-1) & cell_states(r-1)(c) & cell_states(r-1)(0) & 
							cell_states(r)(c-1)								  & cell_states(r)(0) &
							cell_states(0)(c-1) & cell_states(0)(c) & cell_states(0)(0);
				end generate last_col;
			end generate cols;
		end generate last_row;
	end generate rows;

end Structural;

