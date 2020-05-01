----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/18/2020 01:06:05 PM
-- Design Name: 
-- Module Name: GOL_cell - Behavioral
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

entity GOL_cell is
    Port ( clk_gc, clk_en : in STD_LOGIC;
           preset_en, preset : in STD_LOGIC;
           neighbors : in STD_LOGIC_VECTOR (7 downto 0);
           cell_val : out STD_LOGIC);
end GOL_cell;

architecture Behavioral of GOL_cell is

signal two, three : std_logic;
signal val : std_logic := '0';

begin

    neighbor_counter : entity work.bitstring_sum
    port map (
        bit_string => neighbors,
        two => two,
        three => three
    );
    
    -- synchronous reset (more LUTs but more choice for FFs)
--    process(clk_gc, preset_en, clk_en) is 
--        variable sel : std_logic_vector(1 downto 0);
--    begin
--        sel := preset_en & clk_en;
--        if rising_edge(clk_gc) then
--            case sel is
--                when "00" => val <= val;
--                when "01" => val <= three;
--                when others => val <= preset;
--            end case;
--        end if;
--    end process;

    -- async reset (less LUTS but needs clr/preset FFs)
    process(clk_gc, preset_en) is begin
        if (preset_en = '1') then
            val <= preset;
        elsif clk_en = '1' and rising_edge(clk_gc) then
            val <= three or (two and val);
        end if;
    end process;

    cell_val <= val;
    
end Behavioral;
