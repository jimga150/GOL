----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/10/2022 10:37:12 PM
-- Design Name: 
-- Module Name: GOL_field_synth_wrapper - Structural
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

use work.GOL_pkg.all;
use work.GOL_field_init.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity GOL_field_synth_wrapper is
    port(
        i_clk_stepper, i_clk_read, i_rst_stepper, i_rst_read, i_do_frame : in std_logic;
        i_pixel, i_pixel_we : in std_logic;
        i_col : in std_logic_vector(c_field_num_cell_col_bits-1 downto 0);
        i_row : in std_logic_vector(c_field_num_cell_row_bits-1 downto 0);
        o_pixel : out std_logic
    );
end GOL_field_synth_wrapper;

architecture Structural of GOL_field_synth_wrapper is

begin

    field_inst: entity work.GOL_field
    generic map(
        g_init_cells => c_init_hline_plussome
    )
    port map(
        i_clk_stepper => i_clk_stepper,
        i_rst_stepper => i_rst_stepper,
        i_rst_read => i_rst_read,
        i_do_frame => i_do_frame,
        i_clk_read => i_clk_read,
        i_pixel => i_pixel,
        i_pixel_we => i_pixel_we,
        i_col => to_integer(unsigned(i_col)),
        i_row => to_integer(unsigned(i_row)),
        o_pixel => o_pixel
    );

end Structural;
