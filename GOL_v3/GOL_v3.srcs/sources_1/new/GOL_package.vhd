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

    --frame dimensions
    constant GOL_num_rows : integer := 10;
    constant GOL_num_col_pixels : integer := 32;
    
    constant GOL_log_2_bpw : integer := 5;
    constant GOL_bits_per_word : integer := 32;
    constant GOL_words_per_row : integer := GOL_num_col_pixels/GOL_bits_per_word;
    
    --address lengths
    constant GOL_row_addr_length : integer := 13;
    
    constant GOL_col_addr_length : integer := 3;
    constant GOL_pixel_col_addr_length : integer := GOL_col_addr_length + GOL_log_2_bpw;
    
    constant GOL_frame_addr_length : integer := GOL_row_addr_length + GOL_col_addr_length;
    
    
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