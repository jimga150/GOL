----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:42:07 02/05/2019 
-- Design Name: 
-- Module Name:    Nto1Mux - Behavioral 
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

entity Nto1Mux is
	generic (sel_bits : integer := 3);
    Port ( input : in  STD_LOGIC_VECTOR (2**(sel_bits)-1 downto 0);
           sel : in  STD_LOGIC_VECTOR (sel_bits - 1 downto 0);
           output : out  STD_LOGIC);
end Nto1Mux;

architecture Behavioral of Nto1Mux is

begin

	output <= input(to_integer(unsigned(sel)));

end Behavioral;

