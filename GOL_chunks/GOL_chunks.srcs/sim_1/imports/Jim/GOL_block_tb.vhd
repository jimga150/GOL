----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/05/2022 18:24:14
-- Design Name: GOL_block_tb
-- Module Name: GOL_block_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: Created with VHDL Test Bench Template Generator
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.GOL_pkg.all;
use work.bmp_pkg.all;

entity GOL_block_tb is
end GOL_block_tb;

architecture Behavioral of GOL_block_tb is
    
    --Clocks
    signal i_clk : std_logic := '0';
    
    --Resets
    signal i_rst : std_logic := '1';
    
    --General inputs
    signal i_chunk_x : unsigned(c_block_num_chunk_col_bits-1 downto 0) := (others => '0');
    signal i_chunk_y : unsigned(c_block_num_chunk_row_bits-1 downto 0) := (others => '0');
    signal i_do_frame : std_logic := '0';
    
    --Loopbacks
    signal s_top_to_bottom_edge : std_logic_vector(c_block_num_cell_cols-1 downto 0);
    signal s_bottom_to_top_edge : std_logic_vector(c_block_num_cell_cols-1 downto 0);
    signal s_right_to_left_edge : std_logic_vector(c_block_num_cell_rows-1 downto 0);
    signal s_left_to_right_edge : std_logic_vector(c_block_num_cell_rows-1 downto 0);
    signal s_top_left_to_bottom_right_bit : std_logic;
    signal s_top_right_to_bottom_left_bit : std_logic;
    signal s_bottom_left_to_top_right_bit : std_logic;
    signal s_bottom_right_to_top_left_bit : std_logic;
    
    --Outputs
    signal o_chunk : t_chunk_type;
    
    --Clock Periods
    constant i_clk_period : time := 10 ns;
    
    constant c_num_frames : integer := 100;
    
    constant c_init_filename : string := c_project_path & "\GOL_mem_init_files\hline_plussome.gmif";
    constant c_field_arr : t_field_chunk_arr := field_chunk_arr_from_gmif(c_init_filename);
    constant c_block_chunk_arr : t_block_chunk_arr := block_chunk_arr_from_field(c_field_arr, 0, 0);
    
begin
    
    UUT: entity work.GOL_block
    generic map(
        g_init_cells => c_block_chunk_arr
    )
    port map(
        i_clk => i_clk,
        i_rst => i_rst,
        i_chunk_x => i_chunk_x,
        i_chunk_y => i_chunk_y,
        o_chunk => o_chunk,
        i_do_frame => i_do_frame,
        i_top_edge => s_bottom_to_top_edge,
        i_bottom_edge => s_top_to_bottom_edge,
        i_right_edge => s_left_to_right_edge,
        i_left_edge => s_right_to_left_edge,
        i_top_left_bit => s_bottom_right_to_top_left_bit,
        i_top_right_bit => s_bottom_left_to_top_right_bit,
        i_bottom_left_bit => s_top_right_to_bottom_left_bit,
        i_bottom_right_bit => s_top_left_to_bottom_right_bit,
        o_top_edge => s_top_to_bottom_edge,
        o_bottom_edge => s_bottom_to_top_edge,
        o_right_edge => s_right_to_left_edge,
        o_left_edge => s_left_to_right_edge,
        o_top_left_bit => s_top_left_to_bottom_right_bit,
        o_top_right_bit => s_top_right_to_bottom_left_bit,
        o_bottom_left_bit => s_bottom_left_to_top_right_bit,
        o_bottom_right_bit => s_bottom_right_to_top_left_bit
    );
    
    --Clock Drivers
    i_clk <= not i_clk after i_clk_period/2;
    
    stim_proc: process is begin
        
        wait for i_clk_period;
        
        i_rst <= '0';
        
        wait for i_clk_period;
        
        for i in 0 to c_num_frames-1 loop
        
            for r in 0 to c_block_num_chunk_rows - 1 loop
                for c in 0 to c_block_num_chunk_cols - 1 loop
                    i_chunk_x <= to_unsigned(c, i_chunk_x'length);
                    i_chunk_y <= to_unsigned(r, i_chunk_y'length);
                    wait for i_clk_period;
                end loop;
            end loop;
        
            i_do_frame <= '1';
            
            wait for i_clk_period;
            
            i_do_frame <= '0';
            
            wait for i_clk_period*7000;
        
        end loop;
        
        assert false report "End Simulation" severity failure;
        
        -- Not strictly necessary, but prevents process from looping 
        -- if the above assert statement is removed
        wait;
        
    end process;
    
    bmp_write_proc: process is
        variable v_chunk : t_chunk_type;
        variable v_cell_x, v_cell_y : natural;
        variable v_bmp_ptr : bmp_ptr := new bmp;
        variable v_bmp_is_init : boolean := false;
        constant c_bmp_pix_0 : bmp_pix := (others => (others => '0'));
        constant c_bmp_pix_1 : bmp_pix := (others => (others => '1'));
        variable v_bmp_pix : bmp_pix;
    begin
    
        if (not v_bmp_is_init) then
            v_bmp_ptr.meta.width := c_block_num_cell_cols;
            v_bmp_ptr.meta.height := c_block_num_cell_rows;
            v_bmp_is_init := true;
        end if;
        
        wait for i_clk_period*2; --reset delay
        
        wait for i_clk_period*3; --pipeline delay
        
        for i in 0 to c_num_frames-1 loop
            
            for r in 0 to c_block_num_chunk_rows - 1 loop
                for c in 0 to c_block_num_chunk_cols - 1 loop
                
                    v_chunk := o_chunk;
                    
                    for y in r*c_chunk_height to (r+1)*c_chunk_height - 1 loop
                        v_cell_y := y mod c_chunk_height;
                        for x in c*c_chunk_width to (c+1)*c_chunk_width - 1 loop
                            v_cell_x := x mod c_chunk_width;
                            v_bmp_pix := c_bmp_pix_0;
                            if (v_chunk(v_cell_y)(v_cell_x) = '1') then 
                                v_bmp_pix := c_bmp_pix_1;
                            end if;
                            bmp_set_pix(v_bmp_ptr, x, y, v_bmp_pix);
                        end loop;
                    end loop;
                    
                    wait for i_clk_period;
                    
                end loop;
            end loop;
            
            bmp_save(v_bmp_ptr, c_project_path & "\GOL_steps\GOL_step_" & integer'image(i) & ".bmp");
             
            wait for i_clk_period;
            wait for i_clk_period*7000;
        
        end loop;
        
    end process;

end Behavioral;
