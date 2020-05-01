----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:57:32 01/10/2019 
-- Design Name: 
-- Module Name:    image_source - Behavioral 
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

entity image_source is
	generic(
		chunk_addr_bits : integer := 8
	);
    Port ( chunk : in  STD_LOGIC_VECTOR (31 downto 0);
			  chunk_index : in  STD_LOGIC_VECTOR (chunk_addr_bits - 3 downto 0);
           clk, we, rst : in  STD_LOGIC;
           col : in  STD_LOGIC_VECTOR (chunk_addr_bits + 2 downto 0);
           pixel : out  STD_LOGIC);
end image_source;

architecture Behavioral of image_source is

	signal chunks : std_logic_vector(2**(chunk_addr_bits + 3) - 1 downto 0) := (others => '0');

begin

	pixel <= chunks(to_integer(unsigned(col)));

	word_read: process(clk, rst) is begin
		if rst = '1' then
			chunks <= (others => '0');
		elsif rising_edge(clk) then
			if we = '1' then
				chunks( 
					(to_integer(unsigned(chunk_index))+1)*32 - 1 
					downto 
					to_integer(unsigned(chunk_index))*32
				) <= chunk;
			end if;
		end if;
	end process word_read;

end Behavioral;

