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
use IEEE.MATH_REAL.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bram_dp is
    generic(
        g_read_delay : integer := 6+3;
        g_data_width : integer := 8;
        g_word_depth : integer := 35*1024; --35k
        --------------------------------------------------------------------
        --DO NOT OVERRIDE ANYTHING BELOW THIS LINE IN INSTANTIATION
        --------------------------------------------------------------------
        g_addr_width : integer := integer(ceil(log2(real(g_word_depth))))
    );
    PORT (
        i_clka : in std_logic;
        i_ena : in std_logic;
        i_wea : in std_logic;
        i_addra : in std_logic_vector(g_addr_width-1 downto 0);
        i_dina : in std_logic_vector(g_data_width-1 downto 0);
        o_douta : out std_logic_vector(g_data_width-1 downto 0);
        
        i_clkb : in std_logic;
        i_enb : in std_logic;
        i_web : in std_logic;
        i_addrb : in std_logic_vector(g_addr_width-1 downto 0);
        i_dinb : in std_logic_vector(g_data_width-1 downto 0);
        o_doutb : out std_logic_vector(g_data_width-1 downto 0)
      );
end bram_dp;

architecture Inferred of bram_dp is
    
    type t_ram_type is array (g_data_width-1 downto 0) of std_logic_vector(o_douta'range);
    
    constant c_input_stages : integer := 1;
    constant c_output_stages : integer := g_read_delay - c_input_stages;
    
    shared variable sv_ram : t_ram_type;
    
    attribute ram_decomp : string;
    attribute ram_decomp of sv_ram : variable is "power"; 
    
    signal s1_ena, s1_wea : std_logic;
    signal s1_addra : std_logic_vector(i_addra'range);
    signal s1_dina : std_logic_vector(i_dina'range);
    
    signal s1_enb, s1_web : std_logic;
    signal s1_addrb : std_logic_vector(i_addrb'range);
    signal s1_dinb : std_logic_vector(i_dinb'range);
    
    type t_data_pline_type is array(natural range<>) of std_logic_vector(o_douta'range);
    signal s_douta_pline : t_data_pline_type(c_output_stages downto 1);
    signal s_doutb_pline : t_data_pline_type(c_output_stages downto 1);
    
begin

    process(i_clka)
    begin
        if rising_edge(i_clka) then
        
            s1_ena <= i_ena;
            s1_wea <= i_wea;
            s1_addra <= i_addra;
            s1_dina <= i_dina;
        
            if s1_ena = '1' then
                s_douta_pline <= s_douta_pline(s_douta_pline'high-1 downto s_douta_pline'low) & sv_ram(to_integer(unsigned(s1_addra)));
                if s1_wea = '1' then
                    sv_ram(to_integer(unsigned(s1_addra))) := s1_dina;
                end if;
            end if;
            
            o_douta <= s_douta_pline(s_douta_pline'high);
            
        end if;
    end process;
    
    process(i_clkb)
    begin
        if rising_edge(i_clkb) then

            s1_enb <= i_enb;
            s1_web <= i_web;
            s1_addrb <= i_addrb;
            s1_dinb <= i_dinb;
        
            if s1_enb = '1' then
                s_doutb_pline <= s_doutb_pline(s_doutb_pline'high-1 downto s_doutb_pline'low) & sv_ram(to_integer(unsigned(s1_addrb)));
                if s1_web = '1' then
                    sv_ram(to_integer(unsigned(s1_addrb))) := s1_dinb;
                end if;
            end if;
            
            o_doutb <= s_doutb_pline(s_doutb_pline'high);
            
        end if;
    end process;
   
end Inferred;
