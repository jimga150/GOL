----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/02/2022 11:32:13 PM
-- Design Name: 
-- Module Name: GOL_chunk_logic - Structural
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

use work.GOL_pkg.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity GOL_chunk_logic is
    generic(
        g_rules : t_GOL_rules := c_GOL_default
    );
    Port (
        i_chunk : in t_chunk_type;
        i_top_row, i_bottom_row : in std_logic_vector(c_chunk_width-1 downto 0);
        i_left_col, i_right_col : in std_logic_vector(c_chunk_height-1 downto 0);
        i_top_left_bit, i_top_right_bit, i_bottom_left_bit, i_bottom_right_bit : in std_logic;
        o_chunk : out t_chunk_type
    );
end GOL_chunk_logic;

architecture Structural of GOL_chunk_logic is

begin

    gol_cell_rows_gen: for r in o_chunk'range generate
    begin
        gol_cell_cols_gen: for c in o_chunk(o_chunk'low)'range generate
            signal s_top_left, s_top_center, s_top_right : std_logic;
            signal s_middle_left, s_middle_right : std_logic;
            signal s_bottom_left, s_bottom_center, s_bottom_right : std_logic;
        begin
        
            top_left_gen_corner: if (r = 0 and c = 0) generate
                s_top_left <= i_top_left_bit;
            end generate top_left_gen_corner;
            top_left_gen_edge: if (r = 0 and c > 0) generate
                s_top_left <= i_top_row(c-1);
            end generate top_left_gen_edge;
            top_left_gen_edge2: if (r > 0 and c = 0) generate
                s_top_left <= i_left_col(r-1);
            end generate top_left_gen_edge2;
            top_left_gen_else: if (r > 0 and c > 0) generate
                s_top_left <= i_chunk(r-1)(c-1);
            end generate top_left_gen_else;
        
            top_cent_gen_edge: if (r = 0) generate
                s_top_center <= i_top_row(c);
            end generate top_cent_gen_edge;
            top_cent_gen_else: if (r > 0) generate
                s_top_center <= i_chunk(r-1)(c);
            end generate top_cent_gen_else;
            
            top_right_gen_corner: if (r = 0 and c = c_chunk_width - 1) generate
                s_top_right <= i_top_right_bit;
            end generate top_right_gen_corner;
            top_right_gen_edge: if (r = 0 and c < c_chunk_width - 1) generate
                s_top_right <= i_top_row(c+1);
            end generate top_right_gen_edge;
            top_right_gen_edge2: if (r > 0 and c = c_chunk_width - 1) generate
                s_top_right <= i_right_col(r-1);
            end generate top_right_gen_edge2;
            top_right_gen_else: if (r > 0 and c < c_chunk_width - 1) generate
                s_top_right <= i_chunk(r-1)(c+1);
            end generate top_right_gen_else;
            
            middle_left_gen_edge: if (c = 0) generate
                s_middle_left <= i_left_col(r);
            end generate middle_left_gen_edge;
            middle_left_gen_else: if (c > 0) generate
                s_middle_left <= i_chunk(r)(c-1);
            end generate middle_left_gen_else;
            
            middle_right_gen_edge: if (c = c_chunk_width - 1) generate
                s_middle_right <= i_right_col(r);
            end generate middle_right_gen_edge;
            middle_right_gen_else: if (c < c_chunk_width - 1) generate
                s_middle_right <= i_chunk(r)(c+1);
            end generate middle_right_gen_else;
            
            bottom_left_gen_corner: if (r = c_chunk_height - 1 and c = 0) generate
                s_bottom_left <= i_bottom_left_bit;
            end generate bottom_left_gen_corner;
            bottom_left_gen_edge: if (r = c_chunk_height - 1 and c > 0) generate
                s_bottom_left <= i_bottom_row(c-1);
            end generate bottom_left_gen_edge;
            bottom_left_gen_edge2: if (r < c_chunk_height - 1 and c = 0) generate
                s_bottom_left <= i_left_col(r+1);
            end generate bottom_left_gen_edge2;
            bottom_left_gen_else: if (r < c_chunk_height - 1 and c > 0) generate
                s_bottom_left <= i_chunk(r+1)(c-1);
            end generate bottom_left_gen_else;
            
            bottom_cent_gen_edge: if (r = c_chunk_height - 1) generate
                s_bottom_center <= i_bottom_row(c);
            end generate bottom_cent_gen_edge;
            bottom_cent_gen_else: if (r < c_chunk_height - 1) generate
                s_bottom_center <= i_chunk(r+1)(c);
            end generate bottom_cent_gen_else;
            
            bottom_right_gen_corner: if (r = c_chunk_height - 1 and c = c_chunk_width - 1) generate
                s_bottom_right <= i_bottom_right_bit;
            end generate bottom_right_gen_corner;
            bottom_right_gen_edge: if (r = c_chunk_height - 1 and c < c_chunk_width - 1) generate
                s_bottom_right <= i_bottom_row(c+1);
            end generate bottom_right_gen_edge;
            bottom_right_gen_edge2: if (r < c_chunk_height - 1 and c = c_chunk_width - 1) generate
                s_bottom_right <= i_right_col(r+1);
            end generate bottom_right_gen_edge2;
            bottom_right_gen_else: if (r < c_chunk_height - 1 and c < c_chunk_width - 1) generate
                s_bottom_right <= i_chunk(r+1)(c+1);
            end generate bottom_right_gen_else;
            
        
            gol_cell_logic_inst: entity work.GOL_cell_logic
                generic map(
                    g_rules => g_rules
                )
                port map(
                    i_top_left => s_top_left,
                    i_top_center => s_top_center,
                    i_top_right => s_top_right,
                    i_middle_left => s_middle_left,
                    i_center => i_chunk(r)(c),
                    i_middle_right => s_middle_right,
                    i_bottom_left => s_bottom_left,
                    i_bottom_center => s_bottom_center,
                    i_bottom_right => s_bottom_right,
                    o_cell => o_chunk(r)(c)
                );
                
        end generate gol_cell_cols_gen;
    end generate gol_cell_rows_gen;

end Structural;
