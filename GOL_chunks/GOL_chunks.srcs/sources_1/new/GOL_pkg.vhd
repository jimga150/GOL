----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/03/2022 09:09:04 AM
-- Design Name: 
-- Module Name: GOL_pkg
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
use IEEE.MATH_REAL.ALL;
use std.textio.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

package GOL_pkg is

    constant c_project_path : string := "C:\Users\Jim\Desktop\Code\VHDL\GOL\GOL_chunks";
    
    --Height and width of one chunk, in cells.
    --Product of these two integers must be equal to the length of the data word from memory.
    --Ideally, these numbers should be as close in value as possible, if not the same.
    --This helps reduce the ratio of border bits to internal bits for chunk calculation, which saves on registers.
    constant c_chunk_width : integer := 6;
    constant c_chunk_height : integer := 6;
    
    --number of bits necessary to represent the chunk row and column as an unsigned type.
    constant c_chunk_num_cell_col_bits : integer := integer(floor(log2(real(c_chunk_width))+1.0));
    constant c_chunk_num_cell_row_bits : integer := integer(floor(log2(real(c_chunk_height))+1.0));
    
    --number of rows and columns, in chunks. Doesn't need to be powers of 2.
    constant c_block_num_chunk_rows : integer := 16;
    constant c_block_num_chunk_cols : integer := 32;
    
    --number of rows and columsn, in cells.
    --Product of these two numbers must be less than or equal to the number of bits available in memory.
    constant c_block_num_cell_rows : integer := c_block_num_chunk_rows*c_chunk_height;
    constant c_block_num_cell_cols : integer := c_block_num_chunk_cols*c_chunk_width;
    
    --number of bits necessary to represent the chunk row and column as an unsigned type.
    constant c_block_num_chunk_col_bits : integer := integer(floor(log2(real(c_block_num_chunk_cols))+1.0));
    constant c_block_num_chunk_row_bits : integer := integer(floor(log2(real(c_block_num_chunk_rows))+1.0));
    
    --number of rows and columns, in blocks per field.
    constant c_field_num_block_rows : integer := 4;
    constant c_field_num_block_cols : integer := 4;
    
    --number of bits necessary to represent the chunk row and column as an unsigned type.
    constant c_field_num_block_col_bits : integer := integer(floor(log2(real(c_field_num_block_cols))+1.0));
    constant c_field_num_block_row_bits : integer := integer(floor(log2(real(c_field_num_block_rows))+1.0));
    
    --number of rows and columns, in chunks per field
    constant c_field_num_chunk_rows : integer := c_field_num_block_rows*c_block_num_chunk_rows;
    constant c_field_num_chunk_cols : integer := c_field_num_block_cols*c_block_num_chunk_cols;
    
    --number of bits necessary to represent the chunk row and column as an unsigned type.
    --(wrt the field)
    constant c_field_num_chunk_col_bits : integer := integer(floor(log2(real(c_field_num_chunk_cols))+1.0));
    constant c_field_num_chunk_row_bits : integer := integer(floor(log2(real(c_field_num_chunk_rows))+1.0));
    
    --number of rows and columns, in cells per field
    --try to make this close to a standard screen size
    constant c_field_num_cell_rows : integer := c_field_num_chunk_rows*c_chunk_height;
    constant c_field_num_cell_cols : integer := c_field_num_chunk_cols*c_chunk_width;
    
    --number of bits necessary to represent the cell row and column as an unsigned type.
    --(wrt the field)
    constant c_field_num_cell_col_bits : integer := integer(floor(log2(real(c_field_num_cell_cols))+1.0));
    constant c_field_num_cell_row_bits : integer := integer(floor(log2(real(c_field_num_cell_rows))+1.0));
    
    type t_chunk_type is array(c_chunk_height-1 downto 0) of std_logic_vector(c_chunk_width-1 downto 0);
    type t_2d_chunk_array is array(natural range<>, natural range<>) of t_chunk_type;
    
    pure function int_max(
        i_int1 : integer;
        i_int2 : integer
    ) return integer;
    
    pure function int_min(
        i_int1 : integer;
        i_int2 : integer
    ) return integer;
    
    --Convert chunk X and Y coordinates, as well as the MSB, into an address to be used for read/write on memory.
    pure function get_chunk_addr(
        i_chunk_x : integer;
        i_chunk_y : integer;
        i_msb : std_logic;
        i_addr_len : integer
    ) return std_logic_vector;
    
    --please only use these for simulation.
    --converts address (obtained via get_chunk_addr) back to the chunk X and Y coords.
    --NOT terribly synthesizable.
    pure function get_chunk_x(i_addr : std_logic_vector) return integer;
    pure function get_chunk_y(i_addr : std_logic_vector) return integer;
    
    --converts chunk to std_logic_vector to be written to memory
    pure function chunk_to_vector(i_chunk : t_chunk_type) return std_logic_vector;
    
    --converts std_logic_vector from memory to chunk
    pure function vector_to_chunk(i_vector : std_logic_vector(35 downto 0)) return t_chunk_type;
    
    --Used in simulation only, for verification
    pure function get_next_cell(
        i_prev_cell : std_logic;
        i_neighbor_cells : std_logic_vector(7 downto 0)
    ) return std_logic;
    
    --Used in simulation only, for verification
    pure function get_next_chunk(
        i_chunk : t_chunk_type;
        i_top_edge, i_bottom_edge : std_logic_vector(c_chunk_width-1 downto 0);
        i_left_edge, i_right_edge : std_logic_vector(c_chunk_height-1 downto 0);
        i_top_left_bit, i_top_right_bit, i_bottom_left_bit, i_bottom_right_bit : std_logic
    ) return t_chunk_type;
    
    impure function chunk_2d_arr_from_gmif(i_gmif_filename : in string) return t_2d_chunk_array;
    impure function populate_chunk_2d_arr(
        i_gmif_filename : in string; 
        i_chunk_rows : in integer; 
        i_chunk_cols : in integer
    ) return t_2d_chunk_array;
    
    pure function block_chunk_arr_from_field(i_2d_chunk_arr : t_2d_chunk_array; i_block_x : integer; i_block_y : integer) return t_2d_chunk_array;

    pure function top_row_from_block(i_block : t_2d_chunk_array) return std_logic_vector;
    pure function bottom_row_from_block(i_block : t_2d_chunk_array) return std_logic_vector;
    
    pure function left_col_from_block(i_block : t_2d_chunk_array) return std_logic_vector;
    pure function right_col_from_block(i_block : t_2d_chunk_array) return std_logic_vector;
    
end GOL_pkg;

package body GOL_pkg is

    pure function int_max(
        i_int1 : integer;
        i_int2 : integer
    ) return integer is
    
    begin
        if (i_int1 > i_int2) then
            return i_int1;
        end if;
        return i_int2;
    end function;
    
    pure function int_min(
        i_int1 : integer;
        i_int2 : integer
    ) return integer is
    
    begin
        if (i_int1 < i_int2) then
            return i_int1;
        end if;
        return i_int2;
    end function;

    pure function get_chunk_addr(
        i_chunk_x : integer;
        i_chunk_y : integer;
        i_msb : std_logic;
        i_addr_len : integer
    ) return std_logic_vector is 
        variable v_result_int : integer; 
    begin
        v_result_int := i_chunk_x + c_block_num_chunk_cols*i_chunk_y;
        if (i_chunk_x < c_block_num_chunk_cols and i_chunk_y < c_block_num_chunk_rows) then
            assert v_result_int < 2**(i_addr_len-1) 
                report "Address length " & integer'image(i_addr_len-1) & " cannot hold chunk address result of " & integer'image(v_result_int) & 
                    " (chunk (" & integer'image(i_chunk_x) & ", " & integer'image(i_chunk_y) & "))"
                severity failure;
        end if;
        return i_msb & std_logic_vector(to_unsigned(v_result_int, i_addr_len - 1));
    end function;
    
    pure function get_chunk_x(i_addr : std_logic_vector) return integer is
        variable v_addr_tmp : std_logic_vector(i_addr'range);
        variable v_ans : integer;
    begin
        v_addr_tmp := i_addr;
        v_addr_tmp(v_addr_tmp'high) := '0'; --remove msb, parity bit
        v_ans := to_integer(unsigned(v_addr_tmp));
        v_ans := v_ans mod c_block_num_chunk_cols;
        return v_ans;
    end function;
    
    pure function get_chunk_y(i_addr : std_logic_vector) return integer is
        variable v_addr_tmp : std_logic_vector(i_addr'range);
        variable v_ans : integer;
    begin
        v_addr_tmp := i_addr;
        v_addr_tmp(v_addr_tmp'high) := '0'; --remove msb, parity bit
        v_ans := to_integer(unsigned(v_addr_tmp));
        v_ans := v_ans/c_block_num_chunk_cols;
        return v_ans;
    end function;
    
    pure function chunk_to_vector(i_chunk : t_chunk_type) return std_logic_vector is
        variable v_ans : std_logic_vector(35 downto 0);
    begin
        for r in 0 to c_chunk_height-1 loop
            v_ans((r+1)*c_chunk_width - 1 downto r*c_chunk_width) := i_chunk(r);
        end loop;
        return v_ans;
    end function;
    
    pure function vector_to_chunk(i_vector : std_logic_vector(35 downto 0)) return t_chunk_type is
        variable v_ans : t_chunk_type;
    begin
        for r in 0 to c_chunk_height-1 loop
            v_ans(r) := i_vector((r+1)*c_chunk_width - 1 downto r*c_chunk_width);
        end loop;
        return v_ans;
    end function;
    
    --Used in simulation only
    --This will synthesize, but its a whopping 570 LUTs or so on the Artix 7 100T.
    pure function get_next_cell(
        i_prev_cell : std_logic;
        i_neighbor_cells : std_logic_vector(7 downto 0)
    ) return std_logic is
        variable v_neighbor_count : integer := 0;
        variable v_ans : std_logic := '0';
    begin
    
        for b in i_neighbor_cells'range loop
            if (i_neighbor_cells(b) = '1') then
                v_neighbor_count := v_neighbor_count + 1;
            end if;
        end loop;
        
        if (i_prev_cell = '1') then
            if (v_neighbor_count = 3 or v_neighbor_count = 2) then
                v_ans := '1';
            end if;
        else
            if (v_neighbor_count = 3) then
                v_ans := '1';
            end if;
        end if;
        
        return v_ans;
    end function;
    
    --Used in simulation only
    pure function get_next_chunk(
        i_chunk : t_chunk_type;
        i_top_edge, i_bottom_edge : std_logic_vector(c_chunk_width-1 downto 0);
        i_left_edge, i_right_edge : std_logic_vector(c_chunk_height-1 downto 0);
        i_top_left_bit, i_top_right_bit, i_bottom_left_bit, i_bottom_right_bit : std_logic
    ) return t_chunk_type is
        variable v_ans : t_chunk_type;
        
        type t_arr_type is array(c_chunk_height+1 downto 0) of std_logic_vector(c_chunk_width+1 downto 0);
        variable v_2d_arr : t_arr_type;
        variable v_2d_arr_x, v_2d_arr_y : integer;
        
        variable v_neighbors : std_logic_vector(7 downto 0);
    begin
    
        for r in i_chunk'range loop
            v_2d_arr(r+1)(c_chunk_width downto 1) := i_chunk(r);
        end loop;
        
        v_2d_arr(0)(c_chunk_width downto 1) := i_top_edge;
        v_2d_arr(c_chunk_height+1)(c_chunk_width downto 1) := i_bottom_edge;
        for r in c_chunk_height downto 1 loop
            v_2d_arr(r)(0) := i_left_edge(r-1);
            v_2d_arr(r)(c_chunk_width+1) := i_right_edge(r-1);
        end loop;
        
        v_2d_arr(0)(0) := i_top_left_bit;
        v_2d_arr(0)(c_chunk_width+1) := i_top_right_bit;
        v_2d_arr(c_chunk_height+1)(0) := i_bottom_left_bit;
        v_2d_arr(c_chunk_height+1)(c_chunk_width+1) := i_bottom_right_bit;
    
        for r in v_ans'range loop
            v_2d_arr_y := r + 1;
            for c in v_ans(v_ans'low)'range loop
                v_2d_arr_x := c + 1;
                v_neighbors(0) := v_2d_arr(v_2d_arr_y-1)(v_2d_arr_x-1);
                v_neighbors(1) := v_2d_arr(v_2d_arr_y-1)(v_2d_arr_x);
                v_neighbors(2) := v_2d_arr(v_2d_arr_y-1)(v_2d_arr_x+1);
                v_neighbors(3) := v_2d_arr(v_2d_arr_y)(v_2d_arr_x-1);
                v_neighbors(4) := v_2d_arr(v_2d_arr_y)(v_2d_arr_x+1);
                v_neighbors(5) := v_2d_arr(v_2d_arr_y+1)(v_2d_arr_x-1);
                v_neighbors(6) := v_2d_arr(v_2d_arr_y+1)(v_2d_arr_x);
                v_neighbors(7) := v_2d_arr(v_2d_arr_y+1)(v_2d_arr_x+1);
                v_ans(r)(c) := get_next_cell(i_chunk(r)(c), v_neighbors);
            end loop;
        end loop;
        return v_ans;
    end function;
    
    impure function chunk_2d_arr_from_gmif(i_gmif_filename : in string) return t_2d_chunk_array is
        FILE RamFile : text is in i_gmif_filename;
        variable RamFileLine : line;
        variable v_rows, v_cols : integer;        
    begin
        readline(RamFile, RamFileLine); --skip first line
        readline(RamFile, RamFileLine);
        read(RamFileLine, v_rows);
        readline(RamFile, RamFileLine); --skip third line
        readline(RamFile, RamFileLine);
        read(RamFileLine, v_cols);
        return populate_chunk_2d_arr(i_gmif_filename, v_rows, v_cols);
    end function;
    
    impure function populate_chunk_2d_arr(
        i_gmif_filename : in string; 
        i_chunk_rows : in integer; 
        i_chunk_cols : in integer
    ) return t_2d_chunk_array is
        FILE RamFile : text is in i_gmif_filename;
        variable RamFileLine : line;
        variable v_bv : bit_vector(c_chunk_height*c_chunk_width-1 downto 0);
        variable v_slv : std_logic_vector(v_bv'range);
        variable v_chunk : t_chunk_type;
        variable v_ans : t_2d_chunk_array(i_chunk_rows-1 downto 0, i_chunk_cols-1 downto 0);
    begin
        for i in 1 to 4 loop
            readline(RamFile, RamFileLine); --skip first four lines
        end loop;
        for r in 0 to i_chunk_rows-1 loop
            for c in 0 to i_chunk_cols-1 loop
                readline(RamFile, RamFileLine);
                read(RamFileLine, v_bv);
                v_slv := to_stdlogicvector(v_bv);
                v_chunk := vector_to_chunk(v_slv);
                v_ans(r, c) := v_chunk;
            end loop;
        end loop;
        return v_ans;
    end function;
    
    pure function block_chunk_arr_from_field(
        i_2d_chunk_arr : t_2d_chunk_array; 
        i_block_x : integer; 
        i_block_y : integer
    ) return t_2d_chunk_array is
        constant c_start_x : integer := i_block_x*c_block_num_chunk_cols;
        constant c_start_y : integer := i_block_y*c_block_num_chunk_rows;
        constant c_last_x : integer := int_min((i_block_x+1)*c_block_num_chunk_cols - 1, i_2d_chunk_arr'high(2));
        constant c_last_y : integer := int_min((i_block_y+1)*c_block_num_chunk_rows - 1, i_2d_chunk_arr'high(1));
        variable v_ans : t_2d_chunk_array(c_block_num_chunk_rows-1 downto 0, c_block_num_chunk_cols-1 downto 0) := (others => (others => (others => (others => '0'))));
    begin
        if (c_start_x > c_last_x) then
            return v_ans;
        end if;
        if (c_start_y > c_last_y) then
            return v_ans;
        end if;
        for y in c_start_y to c_last_y loop
            for x in c_start_x to c_last_x loop
                v_ans(y - c_start_y, x - c_start_x) := i_2d_chunk_arr(y, x);
            end loop;
        end loop;
        return v_ans;
    end function;
    
    pure function top_row_from_block(i_block : t_2d_chunk_array) return std_logic_vector is
        variable v_ans : std_logic_vector(c_block_num_cell_cols-1 downto 0);
        variable v_chunk : t_chunk_type;
    begin
        for c in i_block'range(2) loop
            v_chunk := i_block(0, c);
            v_ans((c+1)*c_chunk_width-1 downto c*c_chunk_width) := v_chunk(0);
        end loop;
        return v_ans;
    end function;
    
    pure function bottom_row_from_block(i_block : t_2d_chunk_array) return std_logic_vector is
        variable v_ans : std_logic_vector(c_block_num_cell_cols-1 downto 0);
        variable v_chunk : t_chunk_type;
    begin
        for c in i_block'range(2) loop
            v_chunk := i_block(i_block'high(1), c);
            v_ans((c+1)*c_chunk_width-1 downto c*c_chunk_width) := v_chunk(v_chunk'high);
        end loop;
        return v_ans;
    end function;
    
    pure function left_col_from_block(i_block : t_2d_chunk_array) return std_logic_vector is
        variable v_ans : std_logic_vector(c_block_num_cell_rows-1 downto 0);
        variable v_chunk : t_chunk_type;
    begin
        for r in i_block'range(1) loop
            v_chunk := i_block(r, 0);
            for cr in v_chunk'range loop
                v_ans(r*c_chunk_height + cr) := v_chunk(cr)(0);
            end loop;
        end loop;
        return v_ans;
    end function;
    
    pure function right_col_from_block(i_block : t_2d_chunk_array) return std_logic_vector is
        variable v_ans : std_logic_vector(c_block_num_cell_rows-1 downto 0);
        variable v_chunk : t_chunk_type;
    begin
        for r in i_block'range(1) loop
            v_chunk := i_block(r, i_block'high(2));
            for cr in v_chunk'range loop
                v_ans(r*c_chunk_height + cr) := v_chunk(cr)(v_chunk(cr)'high);
            end loop;
        end loop;
        return v_ans;
    end function;

end GOL_pkg;