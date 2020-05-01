----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/18/2020 01:10:52 PM
-- Design Name: 
-- Module Name: bitstring_sum - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bitstring_sum is
port(
    bit_string : in std_logic_vector(7 downto 0);
    two, three : out std_logic
);
end bitstring_sum;

architecture Behavioral of bitstring_sum is

begin

process(bit_string) is 
variable sum_interm : unsigned(4 downto 0);
begin
    sum_interm := (others => '0');
    for i in 0 to 7 loop
            sum_interm := sum_interm + unsigned(bit_string(i downto i));
    end loop;
    two <= sum_interm(1) and not sum_interm(0);
    three <= sum_interm(1) and sum_interm(0);
end process;

end Behavioral;
