----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/19/2023 08:23:24 PM
-- Design Name: 
-- Module Name: bram_simple_dp - Behavioral
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

entity bram_simple_dp is
    generic(
        g_data_width : integer := 8;
        g_data_depth : integer := 35*1024 --35k
    );
    PORT (
        i_clk : in std_logic;
        
        --port A: write-only
        i_ena : in std_logic;
        i_wea : in std_logic;
        i_addra : in integer range 0 to g_data_depth-1;
        i_dina : in std_logic_vector(g_data_width-1 downto 0);
        
        --port B: read-only
        i_enb : in std_logic;
        i_addrb : in integer range 0 to g_data_depth-1;
        o_doutb : out std_logic_vector(g_data_width-1 downto 0)
      );
end bram_simple_dp;

architecture Inferred of bram_simple_dp is
    
    type t_ram_type is array (g_data_depth-1 downto 0) of std_logic_vector(o_doutb'range);
    signal s_ram : t_ram_type; 

begin

    process(i_clk)
    begin
        if rising_edge(i_clk) then
        
            if (i_ena = '1' and i_wea = '1') then
                s_ram(i_addra) <= i_dina;
            end if;
            
            if (i_enb = '1') then
                o_doutb <= s_ram(i_addrb);
            end if;

        end if;
    end process;
   
end Inferred;
