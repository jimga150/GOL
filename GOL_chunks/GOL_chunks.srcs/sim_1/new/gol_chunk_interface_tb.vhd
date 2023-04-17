----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 08/05/2022 17:26:28
-- Design Name: GOL_chunk_interface_tb
-- Module Name: GOL_chunk_interface_tb - Behavioral
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
use work.bram_dp_custom_pkg.all;

entity GOL_chunk_interface_tb is
end GOL_chunk_interface_tb;

architecture Behavioral of GOL_chunk_interface_tb is

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

    --Clocks
    signal i_clk : std_logic := '0';

    --General inputs
    signal i_chunk_x : unsigned(c_block_num_chunk_col_bits-1 downto 0) := (others => '0');
    signal i_chunk_y : unsigned(c_block_num_chunk_row_bits-1 downto 0) := (others => '0');
    signal i_chunk : t_chunk_type := c_empty_chunk;
    signal i_chunk_we : std_logic := '0';
    signal i_curr_state_msb : std_logic := '0';
    signal i_bram_rd_data : std_logic_vector(c_bram_width-1 downto 0);

    --Outputs
    signal o_chunk : t_chunk_type;
    signal o_bram_clk : std_logic;
    signal o_bram_ena : std_logic;
    signal o_bram_we : std_logic;
    signal o_bram_addr : std_logic_vector(c_bram_addr_bits-1 downto 0);
    signal o_bram_wr_data : std_logic_vector(c_bram_width-1 downto 0);

    --Clock Periods
    constant i_clk_period : time := 10 ns;

begin

    UUT: entity work.GOL_chunk_interface
    port map(
        i_clk => i_clk,
        i_chunk_x => i_chunk_x,
        i_chunk_y => i_chunk_y,
        i_chunk => i_chunk,
        i_chunk_we => i_chunk_we,
        i_curr_state_msb => i_curr_state_msb,
        o_chunk => o_chunk,
        o_bram_ena => o_bram_ena,
        o_bram_addr => o_bram_addr,
        o_bram_we => o_bram_we,
        i_bram_rd_data => i_bram_rd_data,
        o_bram_wr_data => o_bram_wr_data
    );
    
--    bram_inst: entity work.bram_dp_36k
--	port map(
--		i_clka => i_clk,
--		i_ena => o_bram_ena,
--		i_wea => '0',
--		i_addra => o_bram_addr,
--		i_dina => (others => '0'),
--		o_douta => i_bram_rd_data,
--		i_clkb => '0',
--		i_enb => '0',
--		i_web => '0',
--		i_addrb => (others => '0'),
--		i_dinb => (others => '0'),
--		o_doutb => open
--	);
	
	bram_inst: entity work.bram_dp_custom
    generic map(
        g_init_vals => InitRamFromChunks(block_chunk_arr_from_field(c_init_vline1680x1050_diamond, 0, 0)),
        g_read_delay => c_bram_read_delay,
        g_data_width => c_bram_width,
        g_word_depth => c_bram_depth
    )
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

        for r in 0 to 10 loop
            for c in 0 to 10 loop
                i_chunk_x <= to_unsigned(c, i_chunk_x'length);
                i_chunk_y <= to_unsigned(r, i_chunk_y'length);
                wait for i_clk_period;
            end loop;
        end loop;
        
        i_chunk_x <= to_unsigned(5, i_chunk_x'length);
        i_chunk_y <= to_unsigned(5, i_chunk_y'length);
        i_chunk <= vector_to_chunk((others => '1'));
        i_chunk_we <= '1';
        wait for i_clk_period;
        
        i_chunk_we <= '0';
        
        for r in 0 to 10 loop
            for c in 0 to 10 loop
                i_chunk_x <= to_unsigned(c, i_chunk_x'length);
                i_chunk_y <= to_unsigned(r, i_chunk_y'length);
                wait for i_clk_period;
            end loop;
        end loop;
        
        wait for i_clk_period*5;

        assert false report "End Simulation" severity failure;

        -- Not strictly necessary, but prevents process from looping
        -- if the above assert statement is removed
        wait;

    end process;

end Behavioral;