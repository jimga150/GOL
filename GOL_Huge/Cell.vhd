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
    Port ( preset, preset_sel : in STD_LOGIC;
           clk : in STD_LOGIC;
           neighbors : in STD_LOGIC_VECTOR (7 downto 0);
           output : out STD_LOGIC);
end Cell;

architecture Behavioral of Cell is
	signal cell_state : std_logic := '0';
	signal two, three : std_logic;
begin
	
	output <= cell_state;
	
	neighbor_counter : entity work.NeighborCounter
	port map(
		neighbors => neighbors,
		two => two,
		three => three
	);
	
	process(clk) is begin
		if rising_edge(clk) then
			if preset_sel = '0' then
				cell_state <= (three or (two and cell_state));
			else 
				cell_state <= preset;
			end if;
		end if;
	end process;
	
end Behavioral;

