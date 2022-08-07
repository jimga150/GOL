----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/02/2022 03:52:26 PM
-- Design Name: 
-- Module Name: GOL_cell_logic - Behavioral
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

entity GOL_cell_logic is
    port(
        i_top_left, i_top_center, i_top_right : in std_logic;
        i_middle_left, i_center, i_middle_right : in std_logic;
        i_bottom_left, i_bottom_center, i_bottom_right : in std_logic;
        o_cell : out std_logic
    );
end GOL_cell_logic;

--Uses 6 LUTs on Artix A7 100T
architecture Summation of GOL_cell_logic is
    
    signal s_top_sum, s_middle_sum, s_bottom_sum : unsigned(1 downto 0);
    signal s_bit_sum : unsigned(3 downto 0);

begin

    s_top_sum <= unsigned'('0' & i_top_left) + unsigned'('0' & i_top_center) + unsigned'('0' & i_top_right);
    s_middle_sum <= unsigned'('0' & i_middle_left) + unsigned'('0' & i_center) + unsigned'('0' & i_middle_right);
    s_bottom_sum <= unsigned'('0' & i_bottom_left) + unsigned'('0' & i_bottom_center) + unsigned'('0' & i_bottom_right);
    
    s_bit_sum <= ("00" & s_top_sum) + s_middle_sum + s_bottom_sum;

    o_cell <= '1' when to_integer(s_bit_sum) = 3 or (to_integer(s_bit_sum) = 4 and i_center = '1') else '0';

end Summation;

--Uses 5 LUTs on Artix A7 100T
--Paradoxically, this results in MORE LUT usage in the overall design, probably thanks to less LUT combining in chunks.
--architecture NeighborSummation of GOL_cell_logic is
    
--    signal s_top_sum, s_middle_sum, s_bottom_sum : unsigned(1 downto 0);
--    signal s_num_neighbors : unsigned(3 downto 0);

--begin

--    s_top_sum <= unsigned'('0' & i_top_left) + unsigned'('0' & i_top_center) + unsigned'('0' & i_top_right);
--    s_middle_sum <= unsigned'('0' & i_middle_left) + unsigned'('0' & i_middle_right);
--    s_bottom_sum <= unsigned'('0' & i_bottom_left) + unsigned'('0' & i_bottom_center) + unsigned'('0' & i_bottom_right);
    
--    s_num_neighbors <= ("00" & s_top_sum) + s_middle_sum + s_bottom_sum;

--    o_cell <= '1' when to_integer(s_num_neighbors) = 3 or (to_integer(s_num_neighbors) = 2 and i_center = '1') else '0';

--end NeighborSummation;

--Uses 7 LUTs on Artix A7 100T
--Generated with excel. I did not type this all out.
--architecture LUT of GOL_cell_logic is

--    signal s_bit_vector : std_logic_vector(8 downto 0);

--begin

--    s_bit_vector <= i_center & 
--        i_top_left & i_top_center & i_top_right & 
--        i_middle_left & i_middle_right & 
--        i_bottom_left & i_bottom_center & i_bottom_right;

--    with s_bit_vector select o_cell <=
--        '1' when "000000111",
--        '1' when "000001011",
--        '1' when "000001101",
--        '1' when "000001110",
--        '1' when "000010011",
--        '1' when "000010101",
--        '1' when "000010110",
--        '1' when "000011001",
--        '1' when "000011010",
--        '1' when "000011100",
--        '1' when "000100011",
--        '1' when "000100101",
--        '1' when "000100110",
--        '1' when "000101001",
--        '1' when "000101010",
--        '1' when "000101100",
--        '1' when "000110001",
--        '1' when "000110010",
--        '1' when "000110100",
--        '1' when "000111000",
--        '1' when "001000011",
--        '1' when "001000101",
--        '1' when "001000110",
--        '1' when "001001001",
--        '1' when "001001010",
--        '1' when "001001100",
--        '1' when "001010001",
--        '1' when "001010010",
--        '1' when "001010100",
--        '1' when "001011000",
--        '1' when "001100001",
--        '1' when "001100010",
--        '1' when "001100100",
--        '1' when "001101000",
--        '1' when "001110000",
--        '1' when "010000011",
--        '1' when "010000101",
--        '1' when "010000110",
--        '1' when "010001001",
--        '1' when "010001010",
--        '1' when "010001100",
--        '1' when "010010001",
--        '1' when "010010010",
--        '1' when "010010100",
--        '1' when "010011000",
--        '1' when "010100001",
--        '1' when "010100010",
--        '1' when "010100100",
--        '1' when "010101000",
--        '1' when "010110000",
--        '1' when "011000001",
--        '1' when "011000010",
--        '1' when "011000100",
--        '1' when "011001000",
--        '1' when "011010000",
--        '1' when "011100000",
--        '1' when "100000011",
--        '1' when "100000101",
--        '1' when "100000110",
--        '1' when "100000111",
--        '1' when "100001001",
--        '1' when "100001010",
--        '1' when "100001011",
--        '1' when "100001100",
--        '1' when "100001101",
--        '1' when "100001110",
--        '1' when "100010001",
--        '1' when "100010010",
--        '1' when "100010011",
--        '1' when "100010100",
--        '1' when "100010101",
--        '1' when "100010110",
--        '1' when "100011000",
--        '1' when "100011001",
--        '1' when "100011010",
--        '1' when "100011100",
--        '1' when "100100001",
--        '1' when "100100010",
--        '1' when "100100011",
--        '1' when "100100100",
--        '1' when "100100101",
--        '1' when "100100110",
--        '1' when "100101000",
--        '1' when "100101001",
--        '1' when "100101010",
--        '1' when "100101100",
--        '1' when "100110000",
--        '1' when "100110001",
--        '1' when "100110010",
--        '1' when "100110100",
--        '1' when "100111000",
--        '1' when "101000001",
--        '1' when "101000010",
--        '1' when "101000011",
--        '1' when "101000100",
--        '1' when "101000101",
--        '1' when "101000110",
--        '1' when "101001000",
--        '1' when "101001001",
--        '1' when "101001010",
--        '1' when "101001100",
--        '1' when "101010000",
--        '1' when "101010001",
--        '1' when "101010010",
--        '1' when "101010100",
--        '1' when "101011000",
--        '1' when "101100000",
--        '1' when "101100001",
--        '1' when "101100010",
--        '1' when "101100100",
--        '1' when "101101000",
--        '1' when "101110000",
--        '1' when "110000001",
--        '1' when "110000010",
--        '1' when "110000011",
--        '1' when "110000100",
--        '1' when "110000101",
--        '1' when "110000110",
--        '1' when "110001000",
--        '1' when "110001001",
--        '1' when "110001010",
--        '1' when "110001100",
--        '1' when "110010000",
--        '1' when "110010001",
--        '1' when "110010010",
--        '1' when "110010100",
--        '1' when "110011000",
--        '1' when "110100000",
--        '1' when "110100001",
--        '1' when "110100010",
--        '1' when "110100100",
--        '1' when "110101000",
--        '1' when "110110000",
--        '1' when "111000000",
--        '1' when "111000001",
--        '1' when "111000010",
--        '1' when "111000100",
--        '1' when "111001000",
--        '1' when "111010000",
--        '1' when "111100000",
--        '0' when others;
        

--end LUT;

