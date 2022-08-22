----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/06/2022 15:15:08
-- Design Name: GOL_field_tb
-- Module Name: GOL_field_tb - Behavioral
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
use work.GOL_field_init.all;
use work.bmp_pkg.all;

entity GOL_field_tb is
end GOL_field_tb;

architecture Behavioral of GOL_field_tb is
    
    --Clocks
    signal i_clk_stepper : std_logic := '0';
    signal i_clk_read : std_logic := '0';
    
    --Resets
    signal i_rst_stepper : std_logic := '1';
    
    --General inputs
    signal i_do_frame : std_logic := '0';
    signal i_col_int, i_row_int : integer := 0;
    signal i_col : unsigned(c_field_num_cell_col_bits-1 downto 0);
    signal i_row : unsigned(c_field_num_cell_row_bits-1 downto 0);
    
    --Outputs
    signal o_pixel : std_logic;
    signal o_stepper_busy : std_logic;
        
    --tb signals
    signal s_read_delay_pline : std_logic_vector(c_field_pix_read_delay-1 downto 0) := (others => '0');
    signal s_read_start : std_logic := '0';
    
    --Clock Periods
    constant i_clk_stepper_period : time := 10 ns;
    constant i_clk_read_period : time := 6.796 ns; --VGA timing, 1680x1050 @ 60 Hz
    
    constant c_num_frames : integer := 100;
    
--    constant c_init_filename : string := c_project_path & "\GOL_mem_init_files\hline_plussome.gmif";
    
begin

--    UUT: entity work.GOL_field_synth_wrapper
--    port map(
--        i_clk => i_clk,
--        i_rst => i_rst,
--        i_do_frame => i_do_frame,
--        i_col => std_logic_vector(i_col),
--        i_row => std_logic_vector(i_row),
--        o_pixel => o_pixel
--    );

    i_col <= to_unsigned(i_col_int, i_col'length);
    i_row <= to_unsigned(i_row_int, i_row'length);

    UUT: entity work.GOL_field
    generic map(
        g_init_cells => c_init_vlinelrg
    )
    port map(
        i_clk_stepper => i_clk_stepper,
        i_rst_stepper => i_rst_stepper,
        i_do_frame => i_do_frame,
        o_stepper_busy => o_stepper_busy,
        i_clk_read => i_clk_read,
        i_col => i_col_int,
        i_row => i_row_int,
        o_pixel => o_pixel
    );
    
    --Clock Drivers
    i_clk_stepper <= not i_clk_stepper after i_clk_stepper_period/2;
    i_clk_read <= not i_clk_read after i_clk_read_period/2;
    
    stim_proc: process is begin
        
        wait for i_clk_stepper_period;
        
        i_rst_stepper <= '0';
        
        wait for i_clk_stepper_period;
        
        --re-sync with read clock
        wait until i_clk_read = '1';
        wait until i_clk_read = '0';
        
        for i in 0 to c_num_frames-1 loop
        
            for r in 0 to c_field_num_cell_rows-1 loop
                for c in 0 to c_field_num_cell_cols-1 loop
                    s_read_start <= '0';
                    if (r = 0 and c = 0) then s_read_start <= '1'; end if;
                    i_col_int <= c;
                    i_row_int <= r;
                    wait for i_clk_read_period;
                end loop;
            end loop;
            
            --re-sync with read clock
            wait until i_clk_stepper = '1';
            wait until i_clk_stepper = '0';
            
            if (o_stepper_busy = '1') then
                wait until o_stepper_busy = '0';
                wait for i_clk_stepper_period/2;
            end if;
        
            i_do_frame <= '1';
            
            wait for i_clk_stepper_period;
            
            i_do_frame <= '0';
            
            wait for i_clk_stepper_period;
            
            --re-sync with read clock
            wait until i_clk_read = '1';
            wait until i_clk_read = '0';
            
        end loop;
        
        wait for i_clk_read_period*10;
        
        assert false report "End Simulation" severity failure;
        
        -- Not strictly necessary, but prevents process from looping 
        -- if the above assert statement is removed
        wait;
        
    end process;
    
    process(i_clk_read) is begin
        if rising_edge(i_clk_read) then
            s_read_delay_pline <= s_read_delay_pline(s_read_delay_pline'high-1 downto 0) & s_read_start;
        end if;
    end process;
    
    bmp_write_proc: process is
        variable v_bmp_ptr : bmp_ptr := new bmp;
        variable v_bmp_is_init : boolean := false;
        constant c_bmp_pix_0 : bmp_pix := (others => (others => '0'));
        constant c_bmp_pix_1 : bmp_pix := (others => (others => '1'));
        variable v_bmp_pix : bmp_pix;
    begin
    
        if (not v_bmp_is_init) then
            v_bmp_ptr.meta.width := c_field_num_cell_cols;
            v_bmp_ptr.meta.height := c_field_num_cell_rows;
            v_bmp_is_init := true;
        end if;

        for i in 0 to c_num_frames-1 loop
        
            wait until s_read_delay_pline(s_read_delay_pline'high) = '1';
            wait for i_clk_read_period/2;
        
            for r in 0 to c_field_num_cell_rows - 1 loop
                for c in 0 to c_field_num_cell_cols - 1 loop
                    v_bmp_pix := c_bmp_pix_0;
                    if (o_pixel = '1') then 
                        v_bmp_pix := c_bmp_pix_1;
                    end if;
                    bmp_set_pix(v_bmp_ptr, c, r, v_bmp_pix);
                    wait for i_clk_read_period;
                end loop;
            end loop;
            
            bmp_save(v_bmp_ptr, c_project_path & "\GOL_steps\GOL_step_" & integer'image(i) & ".bmp");
            
        end loop;
        
    end process;

end Behavioral;
