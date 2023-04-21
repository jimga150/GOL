----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/05/2022 05:15:01 PM
-- Design Name: 
-- Module Name: GOL_chunk_interface - Behavioral
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
-- Delay: 2 + BRAM read delay cycles
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

entity GOL_chunk_interface is
    port(
        i_clk : in std_logic;
        i_chunk_col : in unsigned(c_block_num_chunk_col_bits-1 downto 0);
        i_chunk_row : in unsigned(c_block_num_chunk_row_bits-1 downto 0);
        i_curr_state_msb : in std_logic;
        i_chunk_we : in std_logic;
        i_chunk : in t_chunk_type;
        o_chunk : out t_chunk_type;
        
        o_bram_ena : out std_logic := '1';
        o_bram_addr : out std_logic_vector(c_bram_addr_bits-1 downto 0);
        o_bram_we : out std_logic;
        i_bram_rd_data : in std_logic_vector(c_bram_width-1 downto 0);
        o_bram_wr_data : out std_logic_vector(c_bram_width-1 downto 0)
        
    );
end GOL_chunk_interface;

architecture Behavioral of GOL_chunk_interface is

    signal s1_chunk_row_offset : unsigned(o_bram_addr'range);
    signal s1_bram_half_offset : unsigned(o_bram_addr'range);
    signal s1_chunk_col : unsigned(o_bram_addr'range);
    signal s1_wr_data : std_logic_vector(c_bram_width-1 downto 0);
    signal s1_chunk_we : std_logic;

begin

    process(i_clk) is begin
        if (rising_edge(i_clk)) then
        
            s1_chunk_row_offset <= to_unsigned(c_block_num_chunk_cols*to_integer(i_chunk_row), s1_chunk_row_offset'length);
            
            if (i_curr_state_msb = '1') then
                s1_bram_half_offset <= to_unsigned(c_chunks_per_block, s1_bram_half_offset'length);
            else
                s1_bram_half_offset <= (others => '0');
            end if;
            
            s1_chunk_col <= resize(i_chunk_col, s1_chunk_col'length);
            
            s1_chunk_we <= i_chunk_we;
            s1_wr_data <= chunk_to_vector(i_chunk);
            
            o_bram_addr <= std_logic_vector(s1_chunk_row_offset + s1_chunk_col + s1_bram_half_offset);            
--            o_bram_addr <= get_chunk_addr(to_integer(i_chunk_col), to_integer(i_chunk_row), i_curr_state_msb, o_bram_addr'length);

            o_bram_we <= s1_chunk_we;
            o_bram_wr_data <= s1_wr_data;

            o_chunk <= vector_to_chunk(i_bram_rd_data);
        end if;
    end process;

end Behavioral;
