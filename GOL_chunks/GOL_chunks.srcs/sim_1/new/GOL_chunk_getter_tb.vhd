----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 08/05/2022 17:26:28
-- Design Name: GOL_chunk_getter_tb
-- Module Name: GOL_chunk_getter_tb - Behavioral
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

entity GOL_chunk_getter_tb is
end GOL_chunk_getter_tb;

architecture Behavioral of GOL_chunk_getter_tb is

    --Clocks
    signal i_clk : std_logic := '0';

    --General inputs
    signal i_chunk_x : unsigned(c_block_num_chunk_col_bits-1 downto 0) := (others => '0');
    signal i_chunk_y : unsigned(c_block_num_chunk_row_bits-1 downto 0) := (others => '0');
    signal i_curr_state_msb : std_logic := '0';
    signal i_bram_rd_data : std_logic_vector(35 downto 0);

    --Outputs
    signal o_chunk : t_chunk_type;
    signal o_bram_clk : std_logic;
    signal o_bram_ena : std_logic;
    signal o_bram_addr : std_logic_vector(9 downto 0);

    --Clock Periods
    constant i_clk_period : time := 10 ns;

begin

    UUT: entity work.GOL_chunk_getter
    port map(
        i_clk => i_clk,
        i_chunk_x => i_chunk_x,
        i_chunk_y => i_chunk_y,
        i_curr_state_msb => i_curr_state_msb,
        o_chunk => o_chunk,
        o_bram_ena => o_bram_ena,
        o_bram_addr => o_bram_addr,
        i_bram_rd_data => i_bram_rd_data
    );
    
    bram_inst: entity work.bram_dp_36k
	port map(
		i_clka => i_clk,
		i_ena => o_bram_ena,
		i_wea => '0',
		i_addra => o_bram_addr,
		i_dina => (others => '0'),
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
        
        wait for i_clk_period*5;

        assert false report "End Simulation" severity failure;

        -- Not strictly necessary, but prevents process from looping
        -- if the above assert statement is removed
        wait;

    end process;

end Behavioral;