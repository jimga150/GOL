----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/01/2020 04:33:30 PM
-- Design Name: 
-- Module Name: GOL_package - Behavioral
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

package GOL_package is

    constant GOL_num_rows : integer := 10;
    constant GOL_num_col_pixels : integer := 32;
    
    constant GOL_bits_per_word : integer := 32;
    constant GOL_words_per_row : integer := GOL_num_col_pixels/GOL_bits_per_word;
    
    constant GOL_col_addr_length : integer := 16;
    constant GOL_row_addr_length : integer := 16;
    
    constant GOL_num_rows_unsigned : unsigned(GOL_row_addr_length-1 downto 0) := 
        to_unsigned(GOL_num_rows, GOL_row_addr_length);
    constant GOL_num_rows_vect : std_logic_vector(GOL_row_addr_length-1 downto 0) := 
        std_logic_vector(GOL_num_rows_unsigned);
        
    constant GOL_words_per_row_unsigned : unsigned(GOL_col_addr_length-1 downto 0) := 
        to_unsigned(GOL_words_per_row, GOL_col_addr_length);
    constant GOL_words_per_row_vect : std_logic_vector(GOL_col_addr_length-1 downto 0) := 
        std_logic_vector(GOL_words_per_row_unsigned);
        
    constant GOL_max_row : integer := GOL_num_rows-1;
    constant GOL_max_row_unsigned : unsigned(GOL_row_addr_length-1 downto 0) := 
        to_unsigned(GOL_max_row, GOL_row_addr_length);
    constant GOL_max_row_vect : std_logic_vector(GOL_row_addr_length-1 downto 0) := 
        std_logic_vector(GOL_max_row_unsigned);
        
    constant GOL_max_col_index : integer := GOL_words_per_row-1;
    constant GOL_max_col_index_unsigned : unsigned(GOL_col_addr_length-1 downto 0) := 
        to_unsigned(GOL_max_col_index, GOL_col_addr_length);
    constant GOL_max_col_index_vect : std_logic_vector(GOL_col_addr_length-1 downto 0) := 
        std_logic_vector(GOL_max_col_index_unsigned);
        
end package GOL_package;

package body GOL_package is

end package body GOL_package;