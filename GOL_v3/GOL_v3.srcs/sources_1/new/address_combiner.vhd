----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/01/2020 08:10:32 PM
-- Design Name: 
-- Module Name: address_combiner - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library work;
use work.GOL_package.all;

entity address_combiner is
    port(
        row : in std_logic_vector(GOL_frame_row_addr_length-1 downto 0);
        col : in std_logic_vector(GOL_row_word_addr_length-1 downto 0);
        addr_out : out std_logic_vector(GOL_frame_word_addr_length-1 downto 0)
    );
end address_combiner;

architecture Behavioral of address_combiner is

begin

    addr_out <= row & col;

end Behavioral;
