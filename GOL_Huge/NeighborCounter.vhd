----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:38:59 12/18/2018 
-- Design Name: 
-- Module Name:    NeighborCounter - Behavioral 
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

entity NeighborCounter is
    Port ( neighbors : in  STD_LOGIC_VECTOR (7 downto 0);
           two, three : out  STD_LOGIC);
end NeighborCounter;

architecture Behavioral of NeighborCounter is
	signal sum1, sum2, sum3 : std_logic_vector(1 downto 0);
	signal sum12 : std_logic_vector(2 downto 0);
	signal sum12_carry : std_logic;
	signal sum123_carry : std_logic_vector(1 downto 0);
	signal sum123 : std_logic_vector(3 downto 0);
begin

	FA_1 : entity work.Full_Adder
		port map(
			a => neighbors(0),
			b => neighbors(1),
			cin => neighbors(2),
			sum => sum1(0),
			cout => sum1(1)
		);
	
	FA_2 : entity work.Full_Adder
		port map(
			a => neighbors(3),
			b => neighbors(4),
			cin => neighbors(5),
			sum => sum2(0),
			cout => sum2(1)
		);
	
	FA_3 : entity work.Full_Adder
		port map(
			a => neighbors(6),
			b => neighbors(7),
			cin => '0',
			sum => sum3(0),
			cout => sum3(1)
		);
	
	FA_12_LSBs : entity work.Full_Adder
		port map(
			a => sum1(0),
			b => sum2(0),
			cin => '0',
			sum => sum12(0),
			cout => sum12_carry
		);
	
	FA_12_MSBs : entity work.Full_Adder
		port map(
			a => sum1(1),
			b => sum2(1),
			cin => sum12_carry,
			sum => sum12(1),
			cout => sum12(2)
		);
		
	FA_123_LSBs : entity work.Full_Adder
		port map(
			a => sum12(0),
			b => sum3(0),
			cin => '0',
			sum => sum123(0),
			cout => sum123_carry(0)
		);
	
	FA_123_mids : entity work.Full_Adder
		port map(
			a => sum12(1),
			b => sum3(1),
			cin => sum123_carry(0),
			sum => sum123(1),
			cout => sum123_carry(1)
		);
	
	FA_123_MSBs : entity work.Full_Adder
		port map(
			a => sum12(2),
			b => '0',
			cin => sum123_carry(1),
			sum => sum123(2),
			cout => sum123(3)
		);
		
	two <= '1' when sum123 = "0010" else '0';
	three <= '1' when sum123 = "0011" else '0';
	
end Behavioral;

