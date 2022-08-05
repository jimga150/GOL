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
    
    --total number of rows in the frame, in pixels
    constant GOL_num_rows : integer := 480;
    
    --total number of columns in the frame, in pixels (MUST be a multiple of bits per word)
    --TODO: remove that constraint
    constant GOL_frame_width_pixels : integer := 640;
        
    
    constant GOL_bits_per_word : integer := 32;
        
    constant GOL_words_per_row : integer := GOL_frame_width_pixels/GOL_bits_per_word;
    
    constant GOL_num_words_per_frame : integer := GOL_words_per_row*GOL_num_rows;
    
    
    --address lengths
    
    --bits needed to address a row within a frame (usually ceiling(log_2(num_rows))
    constant GOL_frame_row_addr_length : integer := 9;
    
    --bits needed to address a word within a row (usually ceiling(log_2(words_per_row))
    constant GOL_row_word_addr_length : integer := 5;
    
    --bits needed to address a pixel within a word (usually ceiling(log_2(bits per word))
    constant GOL_word_pixel_address_length : integer := 5;
    
    --bits needed to address a pixel within a row
    constant GOL_row_pixel_addr_length : integer := GOL_row_word_addr_length + GOL_word_pixel_address_length;
    
    --bits needed to address a word within a frame
    constant GOL_frame_word_addr_length : integer := GOL_frame_row_addr_length + GOL_row_word_addr_length;
    
    --bits needed to address a pixel within a frame
    constant GOL_frame_pixel_addr_length : integer := GOL_frame_word_addr_length + GOL_word_pixel_address_length;
    
    
    --max addresses
    
    constant GOL_max_row : integer := GOL_num_rows-1;
    
    constant GOL_max_word : integer := GOL_words_per_row-1;
    
    constant GOL_max_pixel : integer := GOL_bits_per_word-1;
    
    
    --type conversions
    
    constant GOL_num_rows_unsigned : unsigned(GOL_frame_row_addr_length-1 downto 0) := 
        to_unsigned(GOL_num_rows, GOL_frame_row_addr_length);
    constant GOL_num_rows_vect : std_logic_vector(GOL_frame_row_addr_length-1 downto 0) := 
        std_logic_vector(GOL_num_rows_unsigned);
        
    constant GOL_max_row_unsigned : unsigned(GOL_frame_row_addr_length-1 downto 0) := 
        to_unsigned(GOL_max_row, GOL_frame_row_addr_length);
    constant GOL_max_row_vect : std_logic_vector(GOL_frame_row_addr_length-1 downto 0) := 
        std_logic_vector(GOL_max_row_unsigned);
        
    constant GOL_words_per_row_unsigned : unsigned(GOL_row_word_addr_length-1 downto 0) := 
        to_unsigned(GOL_words_per_row, GOL_row_word_addr_length);
    constant GOL_words_per_row_vect : std_logic_vector(GOL_row_word_addr_length-1 downto 0) := 
        std_logic_vector(GOL_words_per_row_unsigned);
        
    constant GOL_max_word_unsigned : unsigned(GOL_row_word_addr_length-1 downto 0) := 
        to_unsigned(GOL_max_word, GOL_row_word_addr_length);
    constant GOL_max_word_vect : std_logic_vector(GOL_row_word_addr_length-1 downto 0) := 
        std_logic_vector(GOL_max_word_unsigned);
                
end package GOL_package;


package body GOL_package is

end package body GOL_package;