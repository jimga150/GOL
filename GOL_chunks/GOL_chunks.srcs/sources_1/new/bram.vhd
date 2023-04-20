----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/19/2023 08:14:16 PM
-- Design Name: 
-- Module Name: bram - Behavioral
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
use IEEE.MATH_REAL.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bram is
    generic(
        g_data_width : integer := 8;
        g_data_depth : integer := 35*1024; --35k
        --------------------------------------------------------------------
        --DO NOT OVERRIDE ANYTHING BELOW THIS LINE IN INSTANTIATION
        --------------------------------------------------------------------
        g_addr_width : integer := integer(ceil(log2(real(g_data_depth))))
    );
    PORT (
        i_clk : in std_logic;
        i_en : in std_logic;
        i_we : in std_logic;
        i_addr : in std_logic_vector(g_addr_width-1 downto 0);
        i_din : in std_logic_vector(g_data_width-1 downto 0);
        o_dout : out std_logic_vector(g_data_width-1 downto 0)
      );
end bram;

architecture Inferred of bram is
    
    type t_ram_type is array (g_data_depth-1 downto 0) of std_logic_vector(o_dout'range);
    signal s_ram : t_ram_type; 

begin

    process(i_clk)
    begin
        if rising_edge(i_clk) then
        
            if i_en = '1' then
                o_dout <= s_ram(to_integer(unsigned(i_addr)));
                if i_we = '1' then
                    s_ram(to_integer(unsigned(i_addr))) <= i_din;
                end if;
            end if;

        end if;
    end process;
   
end Inferred;
