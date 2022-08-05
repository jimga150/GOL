----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/03/2022 09:09:04 AM
-- Design Name: 
-- Module Name: GOL_pkg - Behavioral
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

package GOL_pkg is
    
    constant c_chunk_width : integer := 6;
    constant c_chunk_height : integer := 6;
    
    constant c_num_chunk_rows : integer := 16;
    constant c_num_chunk_cols : integer := 32;
    
    constant c_num_cell_rows : integer := c_num_chunk_rows*c_chunk_height;
    constant c_num_cell_cols : integer := c_num_chunk_cols*c_chunk_width;
    
    constant c_num_chunk_col_bits : integer := integer(floor(log2(real(c_num_chunk_cols))+1.0));
    constant c_num_chunk_row_bits : integer := integer(floor(log2(real(c_num_chunk_rows))+1.0));
    
    type t_chunk_type is array(c_chunk_height-1 downto 0) of std_logic_vector(c_chunk_width-1 downto 0);
    
    pure function get_chunk_addr(
        i_chunk_x : integer;
        i_chunk_y : integer;
        i_msb : std_logic;
        i_addr_len : integer
    ) return std_logic_vector;
    
    pure function chunk_to_vector(i_chunk : t_chunk_type) return std_logic_vector;
    
    pure function vector_to_chunk(i_vector : std_logic_vector(35 downto 0)) return t_chunk_type;
    
    --Used in simulation only
    pure function get_next_cell(
        i_prev_cell : std_logic;
        i_neighbor_cells : std_logic_vector(7 downto 0)
    ) return std_logic;
    
    --Used in simulation only
    pure function get_next_chunk(
        i_chunk : t_chunk_type;
        i_top_edge, i_bottom_edge : std_logic_vector(c_chunk_width-1 downto 0);
        i_left_edge, i_right_edge : std_logic_vector(c_chunk_height-1 downto 0);
        i_top_left_bit, i_top_right_bit, i_bottom_left_bit, i_bottom_right_bit : std_logic
    ) return t_chunk_type;
    
end GOL_pkg;

package body GOL_pkg is

    pure function get_chunk_addr(
        i_chunk_x : integer;
        i_chunk_y : integer;
        i_msb : std_logic;
        i_addr_len : integer
    ) return std_logic_vector is 
        variable v_result_int : integer; 
    begin
        v_result_int := i_chunk_x + c_num_chunk_cols*i_chunk_y;
        if (i_chunk_x < c_num_chunk_cols and i_chunk_y < c_num_chunk_rows) then
            assert v_result_int < 2**(i_addr_len-1) 
                report "Address length " & integer'image(i_addr_len-1) & " cannot hold chunk address result of " & integer'image(v_result_int) & 
                    " (chunk (" & integer'image(i_chunk_x) & ", " & integer'image(i_chunk_y) & "))"
                severity failure;
        end if;
        return i_msb & std_logic_vector(to_unsigned(v_result_int, i_addr_len - 1));
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

end GOL_pkg;
