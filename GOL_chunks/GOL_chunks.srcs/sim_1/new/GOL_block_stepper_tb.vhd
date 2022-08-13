----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/02/2022 10:56:28
-- Design Name: GOL_block_stepper_tb
-- Module Name: GOL_block_stepper_tb - Behavioral
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
use work.string_pkg.all;
use work.bmp_pkg.all;

entity GOL_block_stepper_tb is
end GOL_block_stepper_tb;

architecture Behavioral of GOL_block_stepper_tb is

    --Clocks
    signal i_clk : STD_LOGIC := '0';

    --Resets
    signal i_rst : STD_LOGIC := '1';

    --General inputs
    signal i_do_frame : STD_LOGIC := '0';
    signal i_bram_rd_data : std_logic_vector(35 downto 0) := (others => '0');
    
    --Intermediate signals
    signal s_top_to_bottom_edge : STD_LOGIC_VECTOR(c_block_num_cell_cols-1 downto 0) := ( others => '0');
    signal s_bottom_to_top_edge : STD_LOGIC_VECTOR(c_block_num_cell_cols-1 downto 0) := ( others => '0');
    signal s_right_to_left_edge : STD_LOGIC_VECTOR(c_block_num_cell_rows-1 downto 0) := ( others => '0');
    signal s_left_to_right_edge : STD_LOGIC_VECTOR(c_block_num_cell_rows-1 downto 0) := ( others => '0');
    signal s_top_left_to_bottom_right_bit : std_logic := '0';
    signal s_top_right_to_bottom_left_bit : std_logic := '0';
    signal s_bottom_left_to_top_right_bit : std_logic := '0';
    signal s_bottom_right_top_left_bit : std_logic := '0';

    --Outputs
    signal o_stepper_busy : std_logic;
    signal o_bram_ena : std_logic;
    signal o_bram_we : std_logic;
    signal o_bram_addr : std_logic_vector(9 downto 0);
    signal o_bram_wr_data : std_logic_vector(35 downto 0);
    signal o_current_state_msb : std_logic;

    --Clock Periods
    constant i_clk_period : time := 10 ns;
    
    constant c_init_filename : string := c_project_path & "\GOL_mem_init_files\hline_plussome.gmif";
    constant c_field_arr : t_field_chunk_arr := field_chunk_arr_from_gmif(c_init_filename);
    constant c_block_chunk_arr : t_block_chunk_arr := block_chunk_arr_from_field(c_field_arr, 0, 0);

begin

    UUT: entity work.GOL_block_stepper
    generic map(
        g_init_cells => c_block_chunk_arr
    )
    port map(
        i_clk => i_clk,
        i_rst => i_rst,
        i_do_frame => i_do_frame,
        o_stepper_busy => o_stepper_busy,
        o_current_state_msb => o_current_state_msb,
        i_top_edge => s_bottom_to_top_edge,
        i_bottom_edge => s_top_to_bottom_edge,
        i_right_edge => s_left_to_right_edge,
        i_left_edge => s_right_to_left_edge,
        i_top_left_bit => s_bottom_right_top_left_bit,
        i_top_right_bit => s_bottom_left_to_top_right_bit,
        i_bottom_left_bit => s_top_right_to_bottom_left_bit,
        i_bottom_right_bit => s_top_left_to_bottom_right_bit,
        o_bram_ena => o_bram_ena,
        o_bram_we => o_bram_we,
        o_bram_addr => o_bram_addr,
        o_bram_wr_data => o_bram_wr_data,
        i_bram_rd_data => i_bram_rd_data,
        o_top_edge => s_top_to_bottom_edge,
        o_bottom_edge => s_bottom_to_top_edge,
        o_right_edge => s_right_to_left_edge,
        o_left_edge => s_left_to_right_edge,
        o_top_left_bit => s_top_left_to_bottom_right_bit,
        o_top_right_bit => s_top_right_to_bottom_left_bit,
        o_bottom_left_bit => s_bottom_left_to_top_right_bit,
        o_bottom_right_bit => s_bottom_right_top_left_bit
    );
	
	bram_inst: entity work.bram_dp
	generic map(
        g_init_cells => c_block_chunk_arr
    )
	port map(
		i_clka => i_clk,
		i_ena => o_bram_ena,
		i_wea => o_bram_we,
		i_addra => o_bram_addr,
		i_dina => o_bram_wr_data,
		o_douta => i_bram_rd_data,
		i_clkb => '0',
		i_enb => '0',
		i_web => '0',
		i_addrb => (others => '0'),
		i_dinb => (others => '0'),
		o_doutb => open
	);
	
	--Clock Drivers
	i_clk <= not i_clk after i_clk_period/2;
	
	stim_proc: process is
	   variable v_chunk : t_chunk_type;
	begin
		
		wait for i_clk_period;
		
		i_rst <= '0';
		
		wait for i_clk_period*10;
		
		for i in 0 to 100 loop
		
            i_do_frame <= '1';
            
            wait for i_clk_period;
            
            i_do_frame <= '0';
            
            wait until o_bram_ena = '0';
            wait for i_clk_period*10;
		
		end loop;
				
		assert false report "End Simulation" severity failure;
		
		-- Not strictly necessary, but prevents process from looping 
		-- if the above assert statement is removed
		wait;
		
	end process;
	
    image_proc: process(o_bram_ena, o_bram_we, o_bram_addr, o_bram_wr_data) is
        variable v_last_ena_val : std_logic := '0';
        variable v_step_num : integer := 1;
        variable v_bmp_ptr : bmp_ptr := new bmp;
        variable v_bmp_is_init : boolean := false;
        variable v_chunk_x, v_chunk_y : natural;
        variable v_cell_x, v_cell_y : natural;
        variable v_chunk : t_chunk_type;
        constant c_bmp_pix_0 : bmp_pix := (others => (others => '0'));
        constant c_bmp_pix_1 : bmp_pix := (others => (others => '1'));
        variable v_bmp_pix : bmp_pix;
    begin
    
        if (not v_bmp_is_init) then
            v_bmp_ptr.meta.width := c_block_num_cell_cols;
            v_bmp_ptr.meta.height := c_block_num_cell_rows;
            v_bmp_is_init := true;
        end if;
        
        if (o_bram_ena = '1' and o_bram_we = '1') then
            v_chunk_x := get_chunk_x(o_bram_addr);
            v_chunk_y := get_chunk_y(o_bram_addr);
            v_chunk := vector_to_chunk(o_bram_wr_data);
            for y in v_chunk_y*c_chunk_height to (v_chunk_y+1)*c_chunk_height - 1 loop
                v_cell_y := y mod c_chunk_height;
                for x in v_chunk_x*c_chunk_width to (v_chunk_x+1)*c_chunk_width - 1 loop
                    v_cell_x := x mod c_chunk_width;
                    v_bmp_pix := c_bmp_pix_0;
                    if (v_chunk(v_cell_y)(v_cell_x) = '1') then 
                        v_bmp_pix := c_bmp_pix_1;
                    end if;
                    bmp_set_pix(v_bmp_ptr, x, y, v_bmp_pix);
                end loop;
            end loop;
        end if;
        
        if (o_bram_ena = '0' and v_last_ena_val = '1') then
            bmp_save(v_bmp_ptr, c_project_path & "\GOL_steps\GOL_step_" & integer'image(v_step_num) & ".bmp");
            v_step_num := v_step_num + 1;
        end if;
        
        v_last_ena_val := o_bram_ena;
    
    end process;

end Behavioral;
