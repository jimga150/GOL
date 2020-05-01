----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:14:57 02/22/2019 
-- Design Name: 
-- Module Name:    VGA_disp_test_top - Structural 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity VGA_disp_test_top is
    Port ( clk, rst_n : in  STD_LOGIC;
           pixel : out  STD_LOGIC_VECTOR (7 downto 0);
           h_sync, v_sync : out  STD_LOGIC);
end VGA_disp_test_top;

architecture Structural of VGA_disp_test_top is

	signal disp_en, pixel_clk : std_logic;
	signal row, col : integer;

begin

	pll : entity work.pix_clk_pll
	port map (
		clk_in => clk,
		pixel_clk => pixel_clk
	);
	
	vga_cont : entity work.vga_controller
	port map (
		pixel_clk => pixel_clk,
		reset_n => rst_n,
		h_sync => h_sync,
		v_sync => v_sync,
		disp_ena => disp_en,
		column => col,
		row => row,
		n_blank => open,
		n_sync => open
	);

	img_src : entity work.hw_image_generator
	port map (
		disp_ena => disp_en,
		row => row,
		column => col,
		blue => pixel,
		red => open,
		green => open
	);

end Structural;

