----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/25/2022 10:39:00 AM
-- Design Name: 
-- Module Name: bram_dp - Behavioral
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

entity bram_dp is
    generic(
        g_data_width : integer := 8;
        g_data_depth : integer := 35*1024 --35k
    );
    PORT (
        i_clka : in std_logic;
        i_ena : in std_logic;
        i_wea : in std_logic;
        i_addra : in integer range 0 to g_data_depth;
        i_dina : in std_logic_vector(g_data_width-1 downto 0);
        o_douta : out std_logic_vector(g_data_width-1 downto 0);
        
        i_clkb : in std_logic;
        i_enb : in std_logic;
        i_web : in std_logic;
        i_addrb : in integer range 0 to g_data_depth;
        i_dinb : in std_logic_vector(g_data_width-1 downto 0);
        o_doutb : out std_logic_vector(g_data_width-1 downto 0)
      );
end bram_dp;

architecture Inferred of bram_dp is
    
    type t_ram_type is array (g_data_depth-1 downto 0) of std_logic_vector(o_douta'range);
        
    shared variable sv_ram : t_ram_type;
    
    attribute ram_decomp : string;
    attribute ram_decomp of sv_ram : variable is "power"; 
    
begin

    process(i_clka) is begin
        if rising_edge(i_clka) then
                
            if i_ena = '1' then
                o_douta <= sv_ram(i_addra);
                if i_wea = '1' then
                    sv_ram(i_addra) := i_dina;
                end if;
            end if;
                        
        end if;
    end process;
    
    process(i_clkb) is begin
        if rising_edge(i_clkb) then
        
            if i_enb = '1' then
                o_doutb <= sv_ram(i_addrb);
                if i_web = '1' then
                    sv_ram(i_addrb) := i_dinb;
                end if;
            end if;
                        
        end if;
    end process;
   
end Inferred;
