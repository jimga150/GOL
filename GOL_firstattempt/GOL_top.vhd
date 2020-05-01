----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:17:41 02/12/2019 
-- Design Name: 
-- Module Name:    GOL_top - Structural 
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
use work.bus_array_pkg.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity GOL_top is
	generic (
		width : integer := 1050;
		height : integer := 1680
	);
	Port (
		clk 					: in  STD_LOGIC;
		rst_n					: in STD_LOGIC;
		mcb3_dram_dq		: inout  std_logic_vector(15 downto 0);
		mcb3_dram_a       : out std_logic_vector(12 downto 0);
		mcb3_dram_ba      : out std_logic_vector(1 downto 0);
		mcb3_dram_cke     : out std_logic;
		mcb3_dram_ras_n   : out std_logic;
		mcb3_dram_cas_n   : out std_logic;
		mcb3_dram_we_n    : out std_logic;
		mcb3_dram_dm      : out std_logic;
		mcb3_dram_udqs    : inout  std_logic;
		mcb3_rzq          : inout  std_logic;
		mcb3_dram_udm     : out std_logic;
		mcb3_dram_dqs     : inout  std_logic;
		mcb3_dram_ck      : out std_logic;
		mcb3_dram_ck_n    : out std_logic;
		
		calib_done			: out std_logic;
		p0_rd_error, p0_wr_error, p2_rd_error : out std_logic;
		pixel_pll_lock : out std_logic;
		
		rst_n_db_out, rst_WFF_out : out std_logic;
		
		h_sync, v_sync : out  STD_LOGIC;
		pixel : out std_logic_vector(7 downto 0)
	);
end GOL_top;

architecture Structural of GOL_top is

	signal pixel_vect : std_logic_vector(7 downto 0);

	signal pixel_clk, buffered_global_clk : std_logic;
	signal pixel_sig, disp_en, vsync_sig, v_sync_fired : std_logic;
	signal calib_done_sig, rst_debounced, rst_n_debounced, rst_WFF, rst_n_WFF : std_logic;
	signal p0_rd_error_sig, p0_wr_error_sig, p2_rd_error_sig : std_logic;
	
	signal GOLU_cmd_en, GOLU_wr_en, GOLU_rd_en : std_logic;
	signal GOLSR_cmd_en, GOLSR_rd_en : std_logic;
		
	signal row_int, col_int : integer;
	signal row : std_logic_vector(10 downto 0);
	signal col : std_logic_vector(10 downto 0);
	
	signal chunk, next_grid, readout : std_logic_vector(31 downto 0);
	signal chunk_index, chunk_index_plus_one : std_logic_vector(5 downto 0);
	
	signal current_plane : std_logic;
	signal current_grid : bus_array;
	
	signal GOLU_address, GOLSR_address : std_logic_vector(29 downto 0);
	signal GOLU_instruction : std_logic_vector(2 downto 0);
	signal GOLU_rdcount, GOLSR_rdcount : std_logic_vector(6 downto 0);
	signal SR_rdempty : std_logic;
	
begin

	rst_debounced <= not rst_n_debounced;
	rst_WFF <= rst_debounced or (not calib_done_sig);
	rst_n_WFF <= not rst_WFF;
	
	rst_n_db_out <= rst_n_debounced;
	rst_WFF_out <= rst_WFF;

	v_sync <= vsync_sig;
	calib_done <= calib_done_sig;
	p0_rd_error <= p0_rd_error_sig;
	p0_wr_error <= p0_wr_error_sig;
	p2_rd_error <= p2_rd_error_sig;
	
	row <= std_logic_vector(to_unsigned(row_int, 11));
	col <= std_logic_vector(to_unsigned(col_int, 11));
	
	GOLU_address(29 downto 20) <= (others => '0');
	GOLU_address(19) <= current_plane;
	GOLU_address(1 downto 0) <= (others => '0');
	GOLSR_address(29 downto 20) <= (others => '0');
	GOLSR_address(1 downto 0) <= (others => '0');
	
	global_clk_buf : BUFG
	port map (
		I => clk,
		O => buffered_global_clk
	);
	
	debouncer: entity work.debounce
	port map(
		clk => buffered_global_clk,
		button => rst_n,
		result => rst_n_debounced
	);

	MI_FIFO : entity work.GOL_MI 
	port map (
		mcb3_dram_dq => mcb3_dram_dq,
		mcb3_dram_a => mcb3_dram_a,
		mcb3_dram_ba => mcb3_dram_ba,
		mcb3_dram_cke => mcb3_dram_cke,
		mcb3_dram_ras_n => mcb3_dram_ras_n,
		mcb3_dram_cas_n => mcb3_dram_cas_n,
		mcb3_dram_we_n => mcb3_dram_we_n,
		mcb3_dram_dm => mcb3_dram_dm,
		mcb3_dram_udqs => mcb3_dram_udqs,
		mcb3_rzq => mcb3_rzq,
		mcb3_dram_udm => mcb3_dram_udm,
		c3_sys_clk => buffered_global_clk,
		c3_sys_rst_n => rst_n_debounced,
		c3_calib_done => calib_done_sig,
		c3_clk0 => open,
		c3_rst0 => open,
		mcb3_dram_dqs => mcb3_dram_dqs,
		mcb3_dram_ck => mcb3_dram_ck,
		mcb3_dram_ck_n => mcb3_dram_ck_n,
		c3_p0_cmd_clk => buffered_global_clk,
		c3_p0_cmd_en => GOLU_cmd_en,
		c3_p0_cmd_instr => GOLU_instruction,
		c3_p0_cmd_bl => "000000",
		c3_p0_cmd_byte_addr => GOLU_address,
		c3_p0_cmd_empty => open,
		c3_p0_cmd_full => open, 
		c3_p0_wr_clk => buffered_global_clk,
		c3_p0_wr_en => GOLU_wr_en,
		c3_p0_wr_mask => "0000",
		c3_p0_wr_data => next_grid,
		c3_p0_wr_full => open,
		c3_p0_wr_empty => open,
		c3_p0_wr_count => open,
		c3_p0_wr_underrun => open,
		c3_p0_wr_error => p0_wr_error_sig,
		c3_p0_rd_clk => buffered_global_clk,
		c3_p0_rd_en => GOLU_rd_en,
		c3_p0_rd_data => readout,
		c3_p0_rd_full => open,
		c3_p0_rd_empty => open,
		c3_p0_rd_count => GOLU_rdcount,
		c3_p0_rd_overflow => open,
		c3_p0_rd_error => p0_rd_error_sig,
		c3_p2_cmd_clk => buffered_global_clk,
		c3_p2_cmd_en => GOLSR_cmd_en,
		c3_p2_cmd_instr => "001",
		c3_p2_cmd_bl => "000000",
		c3_p2_cmd_byte_addr => GOLSR_address,
		c3_p2_cmd_empty => open,
		c3_p2_cmd_full => open,
		c3_p2_rd_clk => buffered_global_clk,
		c3_p2_rd_en => GOLSR_rd_en,
		c3_p2_rd_data => chunk,
		c3_p2_rd_full => open,
		c3_p2_rd_empty => SR_rdempty,
		c3_p2_rd_count => GOLSR_rdcount,
		c3_p2_rd_overflow => open,
		c3_p2_rd_error => p2_rd_error_sig
		);
		
	Updater_SM: entity work.GOLUpdaterSM
	port map (
		clk => buffered_global_clk,
		rst => rst_WFF,
		disp_en => disp_en,
		v_sync_fired => v_sync_fired,
		rd_count => GOLU_rdcount,
		readout => readout,
		cmd_en => GOLU_cmd_en,
		rd_en => GOLU_rd_en,
		wr_en => GOLU_wr_en,
		plane => current_plane,
		x_out => GOLU_address(7 downto 2),
		y_out => GOLU_address(18 downto 8),
		instruction => GOLU_instruction,
		grid => current_grid
	);
	
	v_sync_latch: entity work.v_sync_tracker
	port map (
		clk => buffered_global_clk,
		rst => rst_WFF,
		v_sync => vsync_sig,
		disp_en => disp_en,
		v_sync_fired => v_sync_fired
	);
	
	Dat_boi: entity work.GOL_field
	port map (
		current_state => current_grid,
		next_state => next_grid
	);
	
	Segment_Reader_SM: entity work.SegReadSM
	port map (
		rd_empty => SR_rdempty,
		clk => buffered_global_clk,
		rst => rst_WFF,
		disp_en => disp_en, 
		v_sync => vsync_sig,
		current => current_plane,
		rd_count => GOLSR_rdcount,
		chunk_index_plus_one => chunk_index_plus_one,
		row_in => row ,
		chunk_addr => GOLSR_address(19 downto 2),
		rd_en => GOLSR_rd_en,
		cmd_en => GOLSR_cmd_en
	);
	
	chunk_index_wraparound : entity work.wraparound_incrementer
	port map (
		input => GOLSR_address(7 downto 2),
		max => std_logic_vector(to_unsigned((width/8)-1, 6)),
		output => chunk_index_plus_one
	);
	
	pixel_pll: entity work.pix_clk_pll
	port map(
		clk_in => buffered_global_clk,
		pixel_clk => pixel_clk,
		locked => pixel_pll_lock
	);
	
	DigiKey_cheatcode: entity work.vga_controller
	port map (
		pixel_clk => pixel_clk,
		reset_n => rst_n_debounced,
		h_sync => h_sync,
		v_sync => vsync_sig,
		disp_ena => disp_en,
		column => col_int,
		row => row_int,
		n_blank => open,
		n_sync => open
	);
	
	img_src: entity work.image_source
	port map(
		clk => buffered_global_clk,
		rst => rst_WFF,
		we => GOLSR_rd_en,
		chunk => chunk,
		chunk_index => GOLSR_address(7 downto 2),
		col => col,
		pixel => pixel_sig
	);
	 
	pixels: for i in 0 to 7 generate
		pixel_vect(i) <= pixel_sig;
	end generate;
	pixel <= pixel_vect;
	
end Structural;
