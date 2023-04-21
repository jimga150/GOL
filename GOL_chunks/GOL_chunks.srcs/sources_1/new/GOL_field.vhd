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
        g_init_cells : t_field_chunk_arr := c_empty_field;
        g_rules : t_GOL_rules := c_GOL_default
    );
    port(
        i_clk_vga : in std_logic;
        i_rst_vga : in std_logic;
        i_col : in integer;
        i_row : in integer;
        i_pixel_we : in std_logic;
        i_pixel : in std_logic;
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
    
    attribute mark_debug : string;
        
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
    signal sA_chunks : t_chunk_2d_array(c_field_num_block_rows-1 downto 0, c_field_num_block_cols-1 downto 0);
    
    type t_2d_std_logic_arr is array(natural range<>, natural range<>) of std_logic;
    signal s_stepper_busys : t_2d_std_logic_arr(sA_chunks'range(1), sA_chunks'range(2));
    
    signal s_col : unsigned(c_field_num_cell_col_bits-1 downto 0);
    signal s_row : unsigned(c_field_num_cell_row_bits-1 downto 0);
    
--    attribute mark_debug of s_col: signal is "true";
--    attribute mark_debug of s_row: signal is "true";
    
    type t_row_pipeline is array(natural range<>) of unsigned(s_row'range);
    type t_col_pipeline is array(natural range<>) of unsigned(s_col'range);
    
    signal s_field_pixel_row_pline : t_row_pipeline(c_field_pix_read_delay downto 1);
    signal s_field_pixel_col_pline : t_col_pipeline(c_field_pix_read_delay downto 1);
    
    signal s_pixel_we_pline : std_logic_vector(c_field_pix_read_delay downto 1);
    signal s_pixel_in_pline : std_logic_vector(c_field_pix_read_delay downto 1);
    
    
    signal s1_field_chunk_x : unsigned(c_field_num_chunk_col_bits-1 downto 0); --TODO: just use row and col for everything, stop mixing in x and y
    signal s1_field_chunk_y : unsigned(c_field_num_chunk_row_bits-1 downto 0);
    
    signal s1_chunk_vector_to_write : std_logic_vector(c_chunk_width*c_chunk_height - 1 downto 0);
    
    signal s1_field_chunk_towrite_row : unsigned(s1_field_chunk_y'range);
    signal s1_field_chunk_towrite_col : unsigned(s1_field_chunk_x'range);
    
    signal s1_fifo_output : std_logic_vector(
        s1_field_chunk_towrite_row'length + 
        s1_field_chunk_towrite_col'length + 
        s1_chunk_vector_to_write'length - 1 downto 0);
        
    signal s1_chunk_towrite_valid : std_logic;
    signal s1_chunk_towrite_addr_match : std_logic;
    
    type t_field_chunk_row_pipeline is array(natural range<>) of unsigned(s1_field_chunk_y'range);
    type t_field_chunk_col_pipeline is array(natural range<>) of unsigned(s1_field_chunk_x'range);
    
    signal s_field_chunk_row_pline : t_field_chunk_row_pipeline(c_field_pix_read_delay downto 2);
    signal s_field_chunk_col_pline : t_field_chunk_col_pipeline(c_field_pix_read_delay downto 2);

    --read addresses
    signal s2_block_chunk_x : unsigned(c_block_num_chunk_col_bits-1 downto 0);
    signal s2_block_chunk_y : unsigned(c_block_num_chunk_row_bits-1 downto 0);

    --write stuff
    signal s2_chunk_we : std_logic;
    
    signal s2_block_chunk_towrite_x : unsigned(c_block_num_chunk_col_bits-1 downto 0);
    signal s2_block_chunk_towrite_y : unsigned(c_block_num_chunk_row_bits-1 downto 0);
    
    signal s2_field_block_towrite_row : unsigned(c_field_num_block_row_bits-1 downto 0);
    signal s2_field_block_towrite_col : unsigned(c_field_num_block_col_bits-1 downto 0);
    
    signal s2_chunk_towrite : t_chunk_type;
    

    constant c_stageA : integer := 2 + c_chunk_getter_read_delay;
    
    signal sA_field_block_row : unsigned(c_field_num_block_row_bits-1 downto 0);
    signal sA_field_block_col : unsigned(c_field_num_block_col_bits-1 downto 0);
    
    constant c_stageB : integer := c_stageA + 1;
    
    signal sB_chunk : t_chunk_type;
    signal sB_chunk_cell_x : unsigned(c_chunk_num_cell_col_bits-1 downto 0);
    signal sB_chunk_cell_y : unsigned(c_chunk_num_cell_row_bits-1 downto 0);
    
    constant c_stageC : integer := c_stageB + 1;

    signal sC_pixel : std_logic;
    signal sC_chunk_to_write : t_chunk_type;
    signal sC_chunk_vector_to_write : std_logic_vector(c_chunk_width*c_chunk_height - 1 downto 0);
    signal sC_fifo_input : std_logic_vector(s1_fifo_output'range);
    
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
            
            signal s2_block_match : std_logic;
            signal s2_block_chunk_we : std_logic;
            
        begin
        
            s2_block_match <= '1' 
                when to_integer(s2_field_block_towrite_row) = r and to_integer(s2_field_block_towrite_col) = c 
                else '0';
                
            s2_block_chunk_we <= s2_chunk_we and s2_block_match;
        
            --5 cycles delay between (x, y) update and o_chunk
            block_inst: entity work.GOL_block
                generic map(
                    g_init_cells => c_block_init_cells,
                    g_rules => g_rules
                )
                port map(
                    i_clk_vga => i_clk_vga,
                    i_chunk_x => s2_block_chunk_x,
                    i_chunk_y => s2_block_chunk_y,
                    i_chunk => s2_chunk_towrite,
                    i_chunk_we => s2_block_chunk_we,
                    o_chunk => sA_chunks(r, c),
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
    
    process(i_clk_vga) is
    
        constant c_chunk_height_us : unsigned(s_row'range) := to_unsigned(c_chunk_height, s_row'length);
        constant c_block_num_chunk_rows_us : unsigned(s1_field_chunk_y'range) := to_unsigned(c_block_num_chunk_rows, s1_field_chunk_y'length);
        
        constant c_chunk_width_us : unsigned(s_col'range) := to_unsigned(c_chunk_width, s_col'length);
        constant c_block_num_chunk_cols_us : unsigned(s1_field_chunk_x'range) := to_unsigned(c_block_num_chunk_cols, s1_field_chunk_x'length);
    
    begin
        if rising_edge(i_clk_vga) then
        
            s_field_pixel_row_pline <= s_field_pixel_row_pline(s_field_pixel_row_pline'high - 1 downto s_field_pixel_row_pline'low) & s_row;
            s_field_pixel_col_pline <= s_field_pixel_col_pline(s_field_pixel_col_pline'high - 1 downto s_field_pixel_col_pline'low) & s_col;
            
            s_pixel_we_pline <= s_pixel_we_pline(s_pixel_we_pline'high - 1 downto s_pixel_we_pline'low) & i_pixel_we;
            s_pixel_in_pline <= s_pixel_in_pline(s_pixel_in_pline'high - 1 downto s_pixel_in_pline'low) & i_pixel;
            
            s1_field_chunk_x <= resize(s_col/c_chunk_width_us, s1_field_chunk_x'length);
            s1_field_chunk_y <= resize(s_row/c_chunk_height_us, s1_field_chunk_y'length);
            
            s_field_chunk_row_pline <= s_field_chunk_row_pline(s_field_chunk_row_pline'high - 1 downto s_field_chunk_row_pline'low) & s1_field_chunk_y;
            s_field_chunk_col_pline <= s_field_chunk_col_pline(s_field_chunk_col_pline'high - 1 downto s_field_chunk_col_pline'low) & s1_field_chunk_x;
            
            s2_block_chunk_x <= resize(s1_field_chunk_x mod c_block_num_chunk_cols_us, s2_block_chunk_x'length);
            s2_block_chunk_y <= resize(s1_field_chunk_y mod c_block_num_chunk_rows_us, s2_block_chunk_y'length);
            
            s2_chunk_towrite <= vector_to_chunk(s1_chunk_vector_to_write);
    
            s2_chunk_we <= s1_chunk_towrite_valid and s1_chunk_towrite_addr_match;
            
            s2_field_block_towrite_row <= resize(s1_field_chunk_towrite_row/c_block_num_chunk_rows_us, s2_field_block_towrite_row'length);
            s2_field_block_towrite_col <= resize(s1_field_chunk_towrite_col/c_block_num_chunk_cols_us, s2_field_block_towrite_col'length);
            
            s2_block_chunk_towrite_x <= resize(s1_field_chunk_towrite_col mod c_block_num_chunk_cols_us, s2_block_chunk_towrite_x'length);
            s2_block_chunk_towrite_y <= resize(s1_field_chunk_towrite_row mod c_block_num_chunk_rows_us, s2_block_chunk_towrite_y'length);
            
            sA_field_block_row <= to_unsigned(to_integer(s_field_pixel_row_pline(c_stageA-1))/c_block_num_cell_rows, sA_field_block_row'length);
            sA_field_block_col <= to_unsigned(to_integer(s_field_pixel_col_pline(c_stageA-1))/c_block_num_cell_cols, sA_field_block_col'length);
            
            sB_chunk <= sA_chunks(to_integer(sA_field_block_row), to_integer(sA_field_block_col));
            sB_chunk_cell_x <= resize(s_field_pixel_col_pline(c_stageA) mod c_chunk_width_us, sB_chunk_cell_x'length);
            sB_chunk_cell_y <= resize(s_field_pixel_row_pline(c_stageA) mod c_chunk_height_us, sB_chunk_cell_y'length);
            
            sC_pixel <= sB_chunk(to_integer(sB_chunk_cell_y))(to_integer(sB_chunk_cell_x));
            
            sC_chunk_to_write <= sB_chunk;
            sC_chunk_to_write(to_integer(sB_chunk_cell_y))(to_integer(sB_chunk_cell_x)) <= s_pixel_in_pline(c_stageB);
            
        end if;
    end process;
    
    sC_chunk_vector_to_write <= chunk_to_vector(sC_chunk_to_write);
    sC_fifo_input <= sC_chunk_vector_to_write & std_logic_vector(s_field_chunk_row_pline(c_stageC)) & std_logic_vector(s_field_chunk_col_pline(c_stageC));
    
    chunk_wr_fifo_inst: entity work.fifo
    generic map(
        g_data_width => sC_fifo_input'length,
        g_data_depth => 1024 --cause more than this would probably be insane
    )
    port map(
        i_clk => i_clk_vga,
        i_rst => i_rst_vga,
        i_valid => s_pixel_we_pline(c_stageC),
        o_ready => open, --drop data. i dont care.
        i_data => sC_fifo_input,
        o_valid => s1_chunk_towrite_valid,
        i_ready => s1_chunk_towrite_addr_match,
        o_data => s1_fifo_output
    );
    
    s1_chunk_vector_to_write <= s1_fifo_output(s1_fifo_output'high downto s1_fifo_output'high - s1_chunk_vector_to_write'length + 1);
    
    s1_field_chunk_towrite_row <= unsigned(
        s1_fifo_output(
            s1_fifo_output'high - s1_chunk_vector_to_write'length downto 
            s1_fifo_output'high - s1_chunk_vector_to_write'length - s1_field_chunk_towrite_row'length + 1
        )
    );
    s1_field_chunk_towrite_col <= unsigned(s1_fifo_output(s1_field_chunk_towrite_col'range));
    
    s1_chunk_towrite_addr_match <= '1' 
        when (s1_field_chunk_towrite_row = s1_field_chunk_y and s1_field_chunk_towrite_col = s1_field_chunk_x) 
        else '0';
    
    
    o_pixel <= sC_pixel;

end Structural;
