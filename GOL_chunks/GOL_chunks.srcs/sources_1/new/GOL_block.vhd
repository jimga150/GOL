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
use work.bram_dp_custom_pkg.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity GOL_block is
    generic(
        g_init_cells : t_block_chunk_arr := c_empty_block;
        g_rules : t_GOL_rules := c_GOL_default
    );
    port(
        i_clk_vga : in std_logic;
        
        i_chunk_col : in unsigned(c_block_num_chunk_col_bits-1 downto 0);
        i_chunk_row : in unsigned(c_block_num_chunk_row_bits-1 downto 0);
        i_chunk : in t_chunk_type;
        i_chunk_we : in std_logic;
        o_chunk : out t_chunk_type;
        
        i_clk_stepper : in std_logic;
        i_rst_stepper : in std_logic;
        
        i_do_frame: in std_logic;
        o_stepper_busy : out std_logic;
        
        i_top_edge, i_bottom_edge : in std_logic_vector(c_block_num_cell_cols-1 downto 0) := (others => '0');
        i_right_edge, i_left_edge : in std_logic_vector(c_block_num_cell_rows-1 downto 0) := (others => '0');
        i_top_left_bit, i_top_right_bit, i_bottom_left_bit, i_bottom_right_bit : in std_logic := '0';
        
        o_top_edge, o_bottom_edge : out STD_LOGIC_VECTOR(c_block_num_cell_cols-1 downto 0);
        o_right_edge, o_left_edge : out STD_LOGIC_VECTOR(c_block_num_cell_rows-1 downto 0);
        o_top_left_bit, o_top_right_bit, o_bottom_left_bit, o_bottom_right_bit : out std_logic
    );
end GOL_block;

architecture Structural of GOL_block is

    attribute ASYNC_REG : boolean;
    
    pure function InitRamFromChunks(i_chunk_arr : in t_block_chunk_arr) return t_custom_ram is
        variable v_ans : t_custom_ram(c_bram_depth-1 downto 0)(c_bram_width-1 downto 0);
        variable v_addr : integer;
        variable v_slv : std_logic_vector(v_ans(v_ans'low)'range);
    begin
        for r in 0 to c_block_num_chunk_rows-1 loop
            for c in 0 to c_block_num_chunk_cols-1 loop
                v_addr := get_chunk_addr_int(c, r, '0');
                v_slv := chunk_to_vector(i_chunk_arr(r, c));
                v_ans(v_addr) := v_slv;
            end loop;
        end loop;
        return v_ans;
    end function;

    constant c_ram_init : t_custom_ram := InitRamFromChunks(g_init_cells);

    --sync stages for current state MSB 
    --(this means that chunks cannot be accurately read 
    --immediately after i_do_frame is asserted, since this bit 
    --will not have reached the reader until after this many cycles on the read clock)
    signal s0_current_state_msb : std_logic;
    signal s_current_state_msb_pline : std_logic_vector(2 downto 1);
    attribute ASYNC_REG of s_current_state_msb_pline : signal is TRUE;
    
    signal s_bram_enaa, s_bram_wea : std_logic;
    signal s_bram_addra : std_logic_vector(c_bram_addr_bits-1 downto 0);
    signal s_bram_wr_dataa : std_logic_vector(c_bram_width-1 downto 0);
    signal s_bram_rd_dataa : std_logic_vector(c_bram_width-1 downto 0);
    
    signal s_bram_enab, s_bram_web : std_logic;
    signal s_bram_addrb : std_logic_vector(c_bram_addr_bits-1 downto 0);
    signal s_bram_wr_datab : std_logic_vector(c_bram_width-1 downto 0);
    signal s_bram_rd_datab : std_logic_vector(c_bram_width-1 downto 0);

begin

    block_stepper_inst: entity work.GOL_block_stepper
    generic map(
        g_init_cells => g_init_cells,
        g_rules => g_rules
    )
    port map(
        i_clk => i_clk_stepper,
        i_rst => i_rst_stepper,
        i_do_frame => i_do_frame,
        o_stepper_busy => o_stepper_busy,
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
        o_current_state_msb => s0_current_state_msb
    );
    
    bram_inst: entity work.bram_dp_custom
    generic map(
        g_init_vals => c_ram_init,
        g_read_delay => c_bram_read_delay,
        g_data_width => c_bram_width,
        g_word_depth => c_bram_depth
    )
    port map(
        i_clka => i_clk_stepper,
        i_ena => s_bram_enaa,
        i_wea => s_bram_wea,
        i_addra => s_bram_addra,
        i_dina => s_bram_wr_dataa,
        o_douta => s_bram_rd_dataa,
        i_clkb => i_clk_vga,
        i_enb => s_bram_enab,
        i_web => s_bram_web,
        i_addrb => s_bram_addrb,
        i_dinb => s_bram_wr_datab,
        o_doutb => s_bram_rd_datab
    );
    
    chunk_rw_inst: entity work.GOL_chunk_interface
    port map(
        i_clk => i_clk_vga,
        i_chunk_col => i_chunk_col,
        i_chunk_row => i_chunk_row,
        i_chunk => i_chunk,
        i_chunk_we => i_chunk_we,
        i_curr_state_msb => s_current_state_msb_pline(s_current_state_msb_pline'high),
        o_chunk => o_chunk,
        o_bram_ena => s_bram_enab,
        o_bram_addr => s_bram_addrb,
        o_bram_we => s_bram_web,
        i_bram_rd_data => s_bram_rd_datab,
        o_bram_wr_data => s_bram_wr_datab
    );
    
    process(i_clk_vga) is begin
        if rising_edge(i_clk_vga) then
            s_current_state_msb_pline <= 
                s_current_state_msb_pline(s_current_state_msb_pline'high - 1 downto s_current_state_msb_pline'low) & 
                s0_current_state_msb;
        end if;
    end process;

end Structural;
