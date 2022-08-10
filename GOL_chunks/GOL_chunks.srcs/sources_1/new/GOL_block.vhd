----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/05/2022 05:48:27 PM
-- Design Name: 
-- Module Name: GOL_block - Structural
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

use work.GOL_pkg.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity GOL_block is
    generic(
        g_init_cells : t_2d_chunk_array(c_block_num_chunk_rows-1 downto 0, c_block_num_chunk_cols-1 downto 0) := (others => (others => (others => (others => '0'))))
    );
    port(
        i_clk, i_rst : in std_logic;
        
        i_chunk_x : in unsigned(c_block_num_chunk_col_bits-1 downto 0);
        i_chunk_y : in unsigned(c_block_num_chunk_row_bits-1 downto 0);
        o_chunk : out t_chunk_type;
        
        i_do_frame: in std_logic;
        
        i_top_edge, i_bottom_edge : in std_logic_vector(c_block_num_cell_cols-1 downto 0) := (others => '0');
        i_right_edge, i_left_edge : in std_logic_vector(c_block_num_cell_rows-1 downto 0) := (others => '0');
        i_top_left_bit, i_top_right_bit, i_bottom_left_bit, i_bottom_right_bit : in std_logic := '0';
        
        o_top_edge, o_bottom_edge : out STD_LOGIC_VECTOR(c_block_num_cell_cols-1 downto 0);
        o_right_edge, o_left_edge : out STD_LOGIC_VECTOR(c_block_num_cell_rows-1 downto 0);
        o_top_left_bit, o_top_right_bit, o_bottom_left_bit, o_bottom_right_bit : out std_logic
    );
end GOL_block;

architecture Structural of GOL_block is

    signal s_current_state_msb : std_logic;
    
    signal s_bram_enaa, s_bram_wea : std_logic;
    signal s_bram_addra : std_logic_vector(9 downto 0);
    signal s_bram_wr_dataa : std_logic_vector(35 downto 0);
    signal s_bram_rd_dataa : std_logic_vector(35 downto 0);
    
    signal s_bram_enab, s_bram_web : std_logic;
    signal s_bram_addrb : std_logic_vector(9 downto 0);
    signal s_bram_wr_datab : std_logic_vector(35 downto 0);
    signal s_bram_rd_datab : std_logic_vector(35 downto 0);

begin

    block_stepper_inst: entity work.GOL_block_stepper
    generic map(
        g_init_cells => g_init_cells
    )
    port map(
        i_clk => i_clk,
        i_rst => i_rst,
        i_do_frame => i_do_frame,
        i_top_edge => i_top_edge,
        i_bottom_edge => i_bottom_edge,
        i_right_edge => i_right_edge,
        i_left_edge => i_left_edge,
        i_top_left_bit => i_top_left_bit,
        i_top_right_bit => i_top_right_bit,
        i_bottom_left_bit => i_bottom_left_bit,
        i_bottom_right_bit => i_bottom_right_bit,
        o_bram_ena => s_bram_enaa,
        o_bram_we => s_bram_wea,
        o_bram_addr => s_bram_addra,
        o_bram_wr_data => s_bram_wr_dataa,
        i_bram_rd_data => s_bram_rd_dataa,
        o_top_edge => o_top_edge,
        o_bottom_edge => o_bottom_edge,
        o_right_edge => o_right_edge,
        o_left_edge => o_left_edge,
        o_top_left_bit => o_top_left_bit,
        o_top_right_bit => o_top_right_bit,
        o_bottom_left_bit => o_bottom_left_bit,
        o_bottom_right_bit => o_bottom_right_bit,
        o_current_state_msb => s_current_state_msb
    );
    
    bram_inst: entity work.bram_dp_36k
    generic map(
        g_init_cells => g_init_cells
    )
    port map(
        i_clka => i_clk,
        i_ena => s_bram_enaa,
        i_wea => s_bram_wea,
        i_addra => s_bram_addra,
        i_dina => s_bram_wr_dataa,
        o_douta => s_bram_rd_dataa,
        i_clkb => i_clk,
        i_enb => s_bram_enab,
        i_web => s_bram_web,
        i_addrb => s_bram_addrb,
        i_dinb => s_bram_wr_datab,
        o_doutb => s_bram_rd_datab
    );
    
    chunk_reader_inst: entity work.GOL_chunk_getter
    port map(
        i_clk => i_clk,
        i_chunk_x => i_chunk_x,
        i_chunk_y => i_chunk_y,
        i_curr_state_msb => s_current_state_msb,
        o_chunk => o_chunk,
        o_bram_ena => s_bram_enab,
        o_bram_addr => s_bram_addrb,
        i_bram_rd_data => s_bram_rd_datab
    );
    
    s_bram_web <= '0';
    s_bram_wr_datab <= (others => '0');

end Structural;