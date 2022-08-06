----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/05/2022 05:15:01 PM
-- Design Name: 
-- Module Name: GOL_chunk_getter - Behavioral
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

entity GOL_chunk_getter is
    port(
        i_clk : in std_logic;
        i_chunk_x : in unsigned(c_block_num_chunk_col_bits-1 downto 0);
        i_chunk_y : in unsigned(c_block_num_chunk_row_bits-1 downto 0);
        i_curr_state_msb : in std_logic;
        o_chunk : out t_chunk_type;
        
        o_bram_clk : out std_logic;
        o_bram_ena : out std_logic := '1';
        o_bram_addr : out std_logic_vector(9 downto 0);
        i_bram_rd_data : in std_logic_vector(35 downto 0)
        
    );
end GOL_chunk_getter;

architecture Behavioral of GOL_chunk_getter is

begin

    o_bram_clk <= i_clk;

    process(i_clk) is begin
        if (rising_edge(i_clk)) then
            o_bram_addr <= get_chunk_addr(to_integer(i_chunk_x), to_integer(i_chunk_y), i_curr_state_msb, o_bram_addr'length);
            o_chunk <= vector_to_chunk(i_bram_rd_data);
        end if;
    end process;

end Behavioral;
