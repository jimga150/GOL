----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/02/2022 10:56:28
-- Design Name: GOL_chunk_stepper_tb
-- Module Name: GOL_chunk_stepper_tb - Behavioral
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

entity GOL_chunk_stepper_tb is
end GOL_chunk_stepper_tb;

architecture Behavioral of GOL_chunk_stepper_tb is

    --Clocks
    signal i_clk : STD_LOGIC := '0';

    --Resets
    signal i_rst : STD_LOGIC := '1';

    --General inputs
    signal i_step_ena : STD_LOGIC := '0';
    signal i_top_edge : STD_LOGIC_VECTOR(c_num_cell_cols-1 downto 0) := ( others => '0');
    signal i_bottom_edge : STD_LOGIC_VECTOR(c_num_cell_cols-1 downto 0) := ( others => '0');
    signal i_right_edge : STD_LOGIC_VECTOR(c_num_cell_rows-1 downto 0) := ( others => '0');
    signal i_left_edge : STD_LOGIC_VECTOR(c_num_cell_rows-1 downto 0) := ( others => '0');
    signal i_top_left_bit : std_logic := '0';
    signal i_top_right_bit : std_logic := '0';
    signal i_bottom_left_bit : std_logic := '0';
    signal i_bottom_right_bit : std_logic := '0';
    signal i_curr_state_msb : STD_LOGIC := '0';
    signal i_bram_rd_data : std_logic_vector(35 downto 0) := (others => '0');

    --Outputs
    signal o_bram_clk : std_logic;
    signal o_bram_ena : std_logic;
    signal o_bram_we : std_logic;
    signal o_bram_addr : std_logic_vector(9 downto 0);
    signal o_bram_wr_data : std_logic_vector(35 downto 0);
    signal o_top_edge : STD_LOGIC_VECTOR(c_num_cell_cols-1 downto 0);
    signal o_bottom_edge : STD_LOGIC_VECTOR(c_num_cell_cols-1 downto 0);
    signal o_right_edge : STD_LOGIC_VECTOR(c_num_cell_rows-1 downto 0);
    signal o_left_edge : STD_LOGIC_VECTOR(c_num_cell_rows-1 downto 0);
    signal o_top_left_bit : std_logic;
    signal o_top_right_bit : std_logic;
    signal o_bottom_left_bit : std_logic;
    signal o_bottom_right_bit : std_logic;

    --Clock Periods
    constant i_clk_period : time := 10 ns;

begin

    UUT: entity work.GOL_chunk_stepper
    port map(
        i_clk => i_clk,
        i_rst => i_rst,
        i_step_ena => i_step_ena,
        i_top_edge => i_top_edge,
        i_bottom_edge => i_bottom_edge,
        i_right_edge => i_right_edge,
        i_left_edge => i_left_edge,
        i_top_left_bit => i_top_left_bit,
        i_top_right_bit => i_top_right_bit,
        i_bottom_left_bit => i_bottom_left_bit,
        i_bottom_right_bit => i_bottom_right_bit,
        i_curr_state_msb => i_curr_state_msb,
        o_bram_clk => o_bram_clk,
        o_bram_ena => o_bram_ena,
        o_bram_we => o_bram_we,
        o_bram_addr => o_bram_addr,
        o_bram_wr_data => o_bram_wr_data,
        i_bram_rd_data => i_bram_rd_data,
        o_top_edge => o_top_edge,
        o_bottom_edge => o_bottom_edge,
        o_right_edge => o_right_edge,
        o_left_edge => o_left_edge,
        o_top_left_bit => o_top_left_bit,
        o_top_right_bit => o_top_right_bit,
        o_bottom_left_bit => o_bottom_left_bit,
        o_bottom_right_bit => o_bottom_right_bit
    );
	
	bram_inst: entity work.bram_dp_36k
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
	
	stim_proc: process is begin
		
		wait for i_clk_period;
		
		i_rst <= '0';
		
		wait for i_clk_period*10;
		
		i_step_ena <= '1';
		
		wait for i_clk_period;
		
		i_step_ena <= '0';
		
		wait until o_bram_ena = '0';
		wait for i_clk_period*10;
				
		assert false report "End Simulation" severity failure;
		
		-- Not strictly necessary, but prevents process from looping 
		-- if the above assert statement is removed
		wait;
		
	end process;

end Behavioral;
