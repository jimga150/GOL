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
use work.bmp_pkg.all;

entity GOL_field_tb is
end GOL_field_tb;

architecture Behavioral of GOL_field_tb is
    
    --Clocks
    signal i_clk : std_logic := '0';
    
    --Resets
    signal i_rst : std_logic := '1';
    
    --General inputs
    signal i_do_frame : std_logic := '0';
    signal i_col : unsigned(c_field_num_cell_col_bits-1 downto 0) := (others => '0');
    signal i_row : unsigned(c_field_num_cell_row_bits-1 downto 0) := (others => '0');
    
    --Outputs
    signal o_pixel : std_logic;
    
    --Clock Periods
    constant i_clk_period : time := 10 ns;
    
begin
    
    UUT: entity work.GOL_field
    port map(
        i_clk => i_clk,
        i_rst => i_rst,
        i_do_frame => i_do_frame,
        i_col => i_col,
        i_row => i_row,
        o_pixel => o_pixel
    );
    
    --Clock Drivers
    i_clk <= not i_clk after i_clk_period/2;
    
    stim_proc: process is begin
        
        wait for i_clk_period;
        
        i_rst <= '0';
        
        wait for i_clk_period;
        
        for i in 0 to 100 loop
            
            i_do_frame <= '1';
            
            wait for i_clk_period;
            
            i_do_frame <= '0';
            
            wait for i_clk_period;
            
            for r in 0 to c_field_num_cell_rows-1 loop
                for c in 0 to c_field_num_cell_cols-1 loop
                    i_col <= to_unsigned(c, i_col'length);
                    i_row <= to_unsigned(r, i_row'length);
                    wait for i_clk_period;
                end loop;
            end loop;
            
            wait for i_clk_period*10;
            
        end loop;
        
        wait for i_clk_period*10;
        
        assert false report "End Simulation" severity failure;
        
        -- Not strictly necessary, but prevents process from looping 
        -- if the above assert statement is removed
        wait;
        
    end process;
    
    bmp_write_proc: process is
        variable v_bmp_ptr : bmp_ptr := new bmp;
        variable v_bmp_is_init : boolean := false;
        constant c_bmp_pix_0 : bmp_pix := (others => (others => '0'));
        constant c_bmp_pix_1 : bmp_pix := (others => (others => '1'));
        variable v_bmp_pix : bmp_pix;
        variable v_step_num : integer := 1;
    begin
    
        if (not v_bmp_is_init) then
            v_bmp_ptr.meta.width := c_field_num_cell_cols;
            v_bmp_ptr.meta.height := c_field_num_cell_rows;
            v_bmp_is_init := true;
        end if;
        
        wait until i_do_frame = '1';
        
        wait for i_clk_period*8;
        
        for r in 0 to c_field_num_cell_rows - 1 loop
            for c in 0 to c_field_num_cell_cols - 1 loop
                v_bmp_pix := c_bmp_pix_0;
                if (o_pixel = '1') then 
                    v_bmp_pix := c_bmp_pix_1;
                end if;
                bmp_set_pix(v_bmp_ptr, c, r, v_bmp_pix);
                wait for i_clk_period;
            end loop;
        end loop;
        
        bmp_save(v_bmp_ptr, "..\..\..\..\GOL_steps\GOL_step_" & integer'image(v_step_num) & ".bmp");
        v_step_num := v_step_num + 1;
        
    end process;

end Behavioral;
