----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/23/2020 10:18:07 PM
-- Design Name: 
-- Module Name: GOL_top - Behavioral
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
use IEEE.math_real.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity GOL_top is
generic(width_of_cells : integer := 1);
port(
    clk, rst : in std_logic;
    pixel : out std_logic_vector(11 downto 0);
    hsync, vsync : out std_logic
);
end GOL_top;

architecture Behavioral of GOL_top is

    component vga_pll
    port
    (   -- Clock in ports
        -- Clock out ports
        vga_clk          : out    std_logic;
        -- Status and control signals
        reset             : in     std_logic;
        clk_in1           : in     std_logic
    );
    end component;
    
    signal vga_clk : std_logic;
    signal vsync_sig : std_logic;
    
    signal rst_n : std_logic;
    
    signal column_from_vga_cont : integer;
    signal row_from_vga_cont : integer;
    
    signal column_to_GOL : integer;
    signal row_to_GOL : integer;
    
    signal single_pixel : std_logic;
        
begin

    gol_vga_pll : vga_pll
    port map ( 
        -- Clock out ports  
        vga_clk => vga_clk,
        -- Status and control signals                
        reset => rst,
        -- Clock in ports
        clk_in1 => clk
    );
    
    vga_contr: entity work.vga_controller
    port map(
		pixel_clk => vga_clk,
		reset_n => rst_n,
		h_sync => hsync,
		v_sync => vsync_sig,
		disp_ena => open,
		column => column_from_vga_cont,
		row	=> row_from_vga_cont,
		n_blank	=> open,
		n_sync =>open
	);
	
	GOL: entity work.GOL
	port map(
	   clk => vsync_sig,
	   rst => rst,
	   row => row_to_GOL,
	   col => column_to_GOL,
	   val => single_pixel
	);
	
	row_to_GOL <= to_integer(to_unsigned(row_from_vga_cont, 32) srl width_of_cells-1);
	column_to_GOL <= to_integer(to_unsigned(column_from_vga_cont, 32) srl width_of_cells-1);
    
    vsync <= vsync_sig;
    
    rst_n <= not rst;
    
    pixel_driver: for i in 0 to 11 generate
        pixel(i) <= single_pixel;
    end generate pixel_driver;

end Behavioral;
