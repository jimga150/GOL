----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:33:59 02/19/2019 
-- Design Name: 
-- Module Name:    col_delay - Behavioral 
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

entity col_delay is
    Port ( col_in : in  STD_LOGIC_VECTOR (10 downto 0);
				clk : in std_logic;
           col_out : out  STD_LOGIC_VECTOR (10 downto 0));
end col_delay;

architecture Behavioral of col_delay is

	constant delay_1_start : integer := 3;
	constant delay_2_start : integer := 6;
	
	signal col_delay_1, col_delay_2 : STD_LOGIC_VECTOR (10 downto 0);
	
begin

	delay_connect: for i in 0 to 10 generate
	
		no_delay: if i < delay_1_start generate
			col_out(i) <= col_in(i);
		end generate no_delay;
		
		delay_1: if i < delay_2_start and i >= delay_1_start generate
			col_out(i) <= col_delay_1(i);
		end generate delay_1;
		
		delay_2: if i >= delay_2_start generate
			col_out(i) <= col_delay_2(i);
		end generate delay_2;
		
	end generate delay_connect;

	process (clk) is begin
		if rising_edge(clk) then
		
			delay_1_connect: for i in 0 to 10 loop
				col_delay_1 <= col_in;
			end loop;
			
			delay_2_connect: for i in 0 to 10 loop
				col_delay_2 <= col_delay_1;
			end loop;
			
		end if;
	end process;

end Behavioral;

