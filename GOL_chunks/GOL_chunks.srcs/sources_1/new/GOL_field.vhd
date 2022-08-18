----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/05/2022 06:53:37 PM
-- Design Name: 
-- Module Name: GOL_field - Structural
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

use work.GOL_pkg.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity GOL_field is
    generic(
        g_init_cells : t_field_chunk_arr := c_empty_field
    );
    port(
        i_clk_read : in std_logic;
        i_col : in integer;
        i_row : in integer;
        o_pixel : out std_logic;
        
        i_clk_stepper : in std_logic;
        i_rst_stepper : in std_logic;
        i_do_frame : in std_logic;
        o_stepper_busy : out std_logic
    );
end GOL_field;

architecture Structural of GOL_field is

    function barrel_add(i_in : integer; i_max : integer) return integer is
        variable v_ans : integer;
    begin
        if (i_in = i_max) then
            v_ans := 0;
        else
            v_ans := i_in + 1;
        end if;
        return v_ans;
    end function;
    
    function barrel_sub(i_in : integer; i_max : integer) return integer is
        variable v_ans : integer;
    begin
        if (i_in = 0) then
            v_ans := i_max;
        else
            v_ans := i_in - 1;
        end if;
        return v_ans;
    end function;

    type t_2d_array_type is array(natural range<>, natural range<>) of std_logic;
    type t_h_edge_2d_array_type is array(natural range<>, natural range<>) of std_logic_vector(c_block_num_cell_cols-1 downto 0);
    type t_v_edge_2d_array_type is array(natural range<>, natural range<>) of std_logic_vector(c_block_num_cell_rows-1 downto 0);
        
    signal s_top_to_bottom_edges : t_h_edge_2d_array_type(
        c_field_num_block_rows-1 downto 0,
        c_field_num_block_cols-1 downto 0
    );
    
    signal s_bottom_to_top_edges : t_h_edge_2d_array_type(
        c_field_num_block_rows-1 downto 0,
        c_field_num_block_cols-1 downto 0
    );
    
    signal s_left_to_right_edges : t_v_edge_2d_array_type(
        c_field_num_block_rows-1 downto 0,
        c_field_num_block_cols-1 downto 0
    );
    
    signal s_right_to_left_edges : t_v_edge_2d_array_type(
        c_field_num_block_rows-1 downto 0,
        c_field_num_block_cols-1 downto 0
    );
    
    signal s_top_left_to_bottom_right_corners : t_2d_array_type(
        c_field_num_block_rows-1 downto 0, 
        c_field_num_block_cols-1 downto 0
    );
    
    signal s_top_right_to_bottom_left_corners : t_2d_array_type(
        c_field_num_block_rows-1 downto 0, 
        c_field_num_block_cols-1 downto 0
    );
    
    signal s_bottom_left_to_top_right_corners : t_2d_array_type(
        c_field_num_block_rows-1 downto 0, 
        c_field_num_block_cols-1 downto 0
    );
    
    signal s_bottom_right_to_top_left_corners : t_2d_array_type(
        c_field_num_block_rows-1 downto 0, 
        c_field_num_block_cols-1 downto 0
    );
    
    type t_chunk_2d_array is array(natural range<>, natural range<>) of t_chunk_type;
    signal s_chunks : t_chunk_2d_array(c_field_num_block_rows-1 downto 0, c_field_num_block_cols-1 downto 0);
    
    type t_2d_std_logic_arr is array(natural range<>, natural range<>) of std_logic;
    signal s_stepper_busys : t_2d_std_logic_arr(s_chunks'range(1), s_chunks'range(2));
    
    signal s_col : unsigned(c_field_num_cell_col_bits-1 downto 0);
    signal s_row : unsigned(c_field_num_cell_row_bits-1 downto 0);
    
    type t_row_pipeline is array(natural range<>) of unsigned(s_row'range);
    type t_col_pipeline is array(natural range<>) of unsigned(s_col'range);
    
    signal s1_s8_field_pixel_row : t_row_pipeline(8 downto 1);
    signal s1_s8_field_pixel_col : t_col_pipeline(8 downto 1);
    
    signal s1_chunk_x : unsigned(c_block_num_chunk_col_bits-1 downto 0);
    signal s1_chunk_y : unsigned(c_block_num_chunk_row_bits-1 downto 0);
    
    signal s4_block_row : unsigned(c_field_num_block_row_bits-1 downto 0);
    signal s4_block_col : unsigned(c_field_num_block_col_bits-1 downto 0);
    
    signal s5_chunk : t_chunk_type;
    signal s5_chunk_cell_x : unsigned(c_chunk_num_cell_col_bits-1 downto 0);
    signal s5_chunk_cell_y : unsigned(c_chunk_num_cell_row_bits-1 downto 0);
    
    signal s6_pixel : std_logic;

begin

    o_stepper_busy <= s_stepper_busys(0, 0);
    
    s_col <= to_unsigned(i_col, s_col'length);
    s_row <= to_unsigned(i_row, s_row'length);

    block_row_gen: for r in 0 to c_field_num_block_rows-1 generate
        block_col_gen: for c in 0 to c_field_num_block_cols-1 generate
            constant c_next_row : integer := barrel_add(r, c_field_num_block_rows-1);
            constant c_next_col : integer := barrel_add(c, c_field_num_block_cols-1);
            constant c_prev_row : integer := barrel_sub(r, c_field_num_block_rows-1);
            constant c_prev_col : integer := barrel_sub(c, c_field_num_block_cols-1);
            constant c_block_init_cells : t_block_chunk_arr := block_chunk_arr_from_field(g_init_cells, c, r);
        begin
            --5 cycles delay between (x, y) update and o_chunk
            block_inst: entity work.GOL_block
                generic map(
                    g_init_cells => c_block_init_cells
                )
                port map(
                    i_clk_read => i_clk_read,
                    i_chunk_x => s1_chunk_x,
                    i_chunk_y => s1_chunk_y,
                    o_chunk => s_chunks(r, c),
                    i_clk_stepper => i_clk_stepper,
                    i_rst_stepper => i_rst_stepper,
                    i_do_frame => i_do_frame,
                    o_stepper_busy => s_stepper_busys(r, c),
                    i_top_edge => s_bottom_to_top_edges(c_prev_row, c),
                    i_bottom_edge => s_top_to_bottom_edges(c_next_row, c),
                    i_left_edge => s_right_to_left_edges(r, c_prev_col),
                    i_right_edge => s_left_to_right_edges(r, c_next_col),
                    i_top_left_bit => s_bottom_right_to_top_left_corners(c_prev_row, c_prev_col),
                    i_top_right_bit => s_bottom_left_to_top_right_corners(c_prev_row, c_next_col),
                    i_bottom_left_bit => s_top_right_to_bottom_left_corners(c_next_row, c_prev_col),
                    i_bottom_right_bit => s_top_left_to_bottom_right_corners(c_next_row, c_next_col),
                    o_top_edge => s_top_to_bottom_edges(r, c),
                    o_bottom_edge => s_bottom_to_top_edges(r, c),
                    o_right_edge => s_right_to_left_edges(r, c),
                    o_left_edge => s_left_to_right_edges(r, c),
                    o_top_left_bit => s_top_left_to_bottom_right_corners(r, c),
                    o_top_right_bit => s_top_right_to_bottom_left_corners(r, c),
                    o_bottom_left_bit => s_bottom_left_to_top_right_corners(r, c),
                    o_bottom_right_bit => s_bottom_right_to_top_left_corners(r, c)
                );
        end generate block_col_gen;
    end generate block_row_gen;
    
    process(i_clk_read) is begin
        if rising_edge(i_clk_read) then
        
            s1_s8_field_pixel_row <= s1_s8_field_pixel_row(s1_s8_field_pixel_row'high - 1 downto s1_s8_field_pixel_row'low) & s_row;
            s1_s8_field_pixel_col <= s1_s8_field_pixel_col(s1_s8_field_pixel_col'high - 1 downto s1_s8_field_pixel_col'low) & s_col;
            
            s1_chunk_x <= to_unsigned((to_integer(s_col)/c_chunk_width) mod c_block_num_chunk_cols, s1_chunk_x'length);
            s1_chunk_y <= to_unsigned((to_integer(s_row)/c_chunk_height) mod c_block_num_chunk_rows, s1_chunk_y'length);
            
            s4_block_row <= to_unsigned(to_integer(s1_s8_field_pixel_row(3))/c_block_num_cell_rows, s4_block_row'length);
            s4_block_col <= to_unsigned(to_integer(s1_s8_field_pixel_col(3))/c_block_num_cell_cols, s4_block_col'length);
            
            s5_chunk <= s_chunks(to_integer(s4_block_row), to_integer(s4_block_col));
            s5_chunk_cell_x <= to_unsigned(to_integer(s1_s8_field_pixel_col(4)) mod c_chunk_width, s5_chunk_cell_x'length);
            s5_chunk_cell_y <= to_unsigned(to_integer(s1_s8_field_pixel_row(4)) mod c_chunk_height, s5_chunk_cell_y'length);
            
            s6_pixel <= s5_chunk(to_integer(s5_chunk_cell_y))(to_integer(s5_chunk_cell_x));
            
        end if;
    end process;
    
    o_pixel <= s6_pixel;

end Structural;
