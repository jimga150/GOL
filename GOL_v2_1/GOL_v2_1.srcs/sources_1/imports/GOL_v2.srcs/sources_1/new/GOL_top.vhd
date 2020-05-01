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
generic(width_of_cells : integer := 4); --TODO: this is 2^(w-1) width
port(
    clk, rst, step_mode, step_button : in std_logic;
    pixel : out std_logic_vector(11 downto 0);
    hsync, vsync : out std_logic
);
end GOL_top;

architecture Behavioral of GOL_top is

    component gol_vga_pll
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
    
    signal rst_n, rst_dbcd, rst_n_dbcd : std_logic;
    
    signal step_btn_dbcd, step_mode_dbcd : std_logic;
    signal tick_sig : std_logic;
    
    constant max_screen_addr_bits : integer := 14;
    
    signal column_from_vga_cont, row_from_vga_cont : integer;
    signal col_vect, row_vect : std_logic_vector(max_screen_addr_bits-1 downto 0); 
    signal column_to_GOL, row_to_GOL : integer := 0;
    
    signal single_pixel, enabled_pixel, disp_en : std_logic;
    
    signal gol_tick_en : std_logic := '0';
        
begin

    vga_pll : gol_vga_pll
    port map ( 
        -- Clock out ports  
        vga_clk => vga_clk,
        -- Status and control signals                
        reset => rst_dbcd,
        -- Clock in ports
        clk_in1 => clk
    );
    
    vga_contr: entity work.vga_controller
    port map(
		pixel_clk => vga_clk,
		reset_n => rst_n_dbcd,
		h_sync => hsync,
		v_sync => vsync_sig,
		disp_ena => disp_en,
		column => column_from_vga_cont,
		row	=> row_from_vga_cont,
		n_blank	=> open,
		n_sync =>open
	);
	
	GOL: entity work.GOL
	port map(
	   clk => vga_clk,
	   c_e => gol_tick_en,
	   rst => rst_dbcd,
	   row => row_to_GOL,
	   col => column_to_GOL,
	   val => single_pixel
	);
	
	tickenable: entity work.tickenable_sm
	port map(
	   clk => vga_clk,
	   rst => rst_dbcd,
	   tick_signal => tick_sig,
	   en => gol_tick_en
	);
	
	rst_debounce: entity work.debounce
	port map(
	clk => clk,
	reset_n => '1',
	button => rst,
	result => rst_dbcd
	);
	
	step_btn_debounce: entity work.debounce
	port map(
	clk => clk,
	reset_n => rst_n_dbcd,
	button => step_button,
	result => step_btn_dbcd
	);
	
	step_mode_debounce: entity work.debounce
	port map(
	clk => clk,
	reset_n => rst_n_dbcd,
	button => step_mode,
	result => step_mode_dbcd
	);
	
--	cell_addr_shift: if (width_of_cells > 1) generate begin
--	   col_vect(max_screen_addr_bits-1 downto max_screen_addr_bits-width_of_cells+2) <= (others => '0');
--	   col_vect(max_screen_addr_bits-width_of_cells+1 downto 0) <= std_logic_vector(to_unsigned(column_from_vga_cont, max_screen_addr_bits))(max_screen_addr_bits-1 downto width_of_cells-1);
--	else generate
--	   col_vect <= std_logic_vector(to_unsigned(column_from_vga_cont, max_screen_addr_bits));
--	   row_vect <= std_logic_vector(to_unsigned(row_from_vga_cont, max_screen_addr_bits));
--	end generate cell_addr_shift;

    col_vect <= std_logic_vector(to_unsigned(column_from_vga_cont, max_screen_addr_bits)) srl width_of_cells-1;
    row_vect <= std_logic_vector(to_unsigned(row_from_vga_cont, max_screen_addr_bits)) srl width_of_cells-1;
	
	row_to_GOL <= to_integer(unsigned(row_vect));
	column_to_GOL <= to_integer(unsigned(col_vect));
    
    vsync <= vsync_sig;
    
    tick_sig <= vsync_sig when step_mode_dbcd = '0' else step_btn_dbcd;
    
    rst_n <= not rst;
    rst_n_dbcd <= not rst_dbcd;
    
    enabled_pixel <= single_pixel and disp_en;
    
    pixel_driver: for i in 0 to 11 generate
        pixel(i) <= enabled_pixel;
    end generate pixel_driver;

end Behavioral;
