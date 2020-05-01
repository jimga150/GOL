----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/06/2020 05:51:14 PM
-- Design Name: 
-- Module Name: GOL_logic - Structural
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

entity GOL_logic is
    generic(data_width : integer := 32);
    Port ( gd_r0, gd_r1, gd_r2 : in STD_LOGIC_VECTOR (data_width+1 downto 0);
           row_out : out STD_LOGIC_VECTOR (data_width-1 downto 0));
end GOL_logic;

architecture Structural of GOL_logic is

    type neighbor_count_array_type is 
        array(data_width-1 downto 0) of
        std_logic_vector(7 downto 0);
        
    signal neighbor_count_array : neighbor_count_array_type;
    
    signal twos, threes: std_logic_vector(data_width-1 downto 0);

begin

    cell_logic_array: for i in 0 to data_width-1 generate
        
        neighbor_count_array(i) <= 
            gd_r0(i) & gd_r0(i+1) & gd_r0(i+2) &
            gd_r1(i)              & gd_r1(i+2) &
            gd_r2(i) & gd_r2(i+1) & gd_r2(i+2);
        
        bitstring_summer: entity work.bitstring_sum
        port map(
            bit_string => neighbor_count_array(i), 
            two => twos(i),
            three => threes(i)
        );
        
        row_out(i) <= threes(i) or (twos(i) and gd_r1(i+1));
        
    end generate cell_logic_array;

end Structural;
