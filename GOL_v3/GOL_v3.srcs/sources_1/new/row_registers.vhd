----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/01/2020 07:21:16 PM
-- Design Name: 
-- Module Name: row_registers - Behavioral
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library work;
use work.GOL_package.all;

entity row_registers is
    port(
        clk, rst, write_en : in std_logic;
        write_addr : in std_logic_vector(GOL_col_addr_length-1 downto 0);
        read_addr : in std_logic_vector(GOL_pixel_col_addr_length-1 downto 0);
        write_data : in std_logic_vector(GOL_bits_per_word-1 downto 0);
        pixel : out std_logic
    );
end row_registers;

architecture Behavioral of row_registers is

    signal row_regs : std_logic_vector(GOL_num_col_pixels-1 downto 0) := (others => '0');

    signal wa_int : integer;

begin

    pixel <= row_regs(to_integer(unsigned(read_addr)));
    
    wa_int <= to_integer(unsigned(write_addr));
    
    process(clk) is begin
        if rising_edge(clk) then
            if rst = '1'  then
                row_regs <= (others => '0');
            elsif write_en = '1' then
                row_regs(GOL_bits_per_word*(wa_int+1) - 1 downto GOL_bits_per_word*wa_int) <= write_data;
            end if;
        end if;
    end process;

end Behavioral;
