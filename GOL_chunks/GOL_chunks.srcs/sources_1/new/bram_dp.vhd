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

use std.textio.all;

use work.GOL_pkg.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bram_dp is
    generic(
        g_init_cells : t_block_chunk_arr := c_empty_block
    );
    PORT (
        i_clka : in std_logic;
        i_ena : in std_logic;
        i_wea : in std_logic;
        i_addra : in std_logic_vector(c_bram_addr_bits-1 downto 0);
        i_dina : in std_logic_vector(c_bram_width-1 downto 0);
        o_douta : out std_logic_vector(c_bram_width-1 downto 0);
        
        i_clkb : in std_logic;
        i_enb : in std_logic;
        i_web : in std_logic;
        i_addrb : in std_logic_vector(c_bram_addr_bits-1 downto 0);
        i_dinb : in std_logic_vector(c_bram_width-1 downto 0);
        o_doutb : out std_logic_vector(c_bram_width-1 downto 0)
      );
end bram_dp;

architecture Inferred of bram_dp is
    
    type t_ram_type is array (c_bram_depth-1 downto 0) of std_logic_vector(o_douta'range);
    
    impure function InitRamFromChunks(i_chunk_arr : in t_block_chunk_arr) return t_ram_type is
        variable v_ram : t_ram_type;
        variable v_ram_idx : integer := 0;
        variable v_slv : std_logic_vector(v_ram(v_ram'low)'range);
    begin
        for r in 0 to c_block_num_chunk_rows-1 loop
            for c in 0 to c_block_num_chunk_cols-1 loop
                v_slv := chunk_to_vector(i_chunk_arr(r, c));
                v_ram(v_ram_idx) := v_slv;
                v_ram(v_ram_idx + c_chunks_per_block) := v_slv; --copy to other half of RAM
                v_ram_idx := v_ram_idx + 1;
            end loop;
        end loop;
        return v_ram;
    end function;
    
    shared variable sv_ram : t_ram_type := InitRamFromChunks(g_init_cells);
    
    signal s1_ena, s1_wea : std_logic;
    signal s1_addra : std_logic_vector(i_addra'range);
    signal s1_dina : std_logic_vector(i_dina'range);
    
    signal s1_enb, s1_web : std_logic;
    signal s1_addrb : std_logic_vector(i_addrb'range);
    signal s1_dinb : std_logic_vector(i_dinb'range);
    
    signal s2_douta : std_logic_vector(o_douta'range);
    signal s2_doutb : std_logic_vector(o_doutb'range);
    
begin

    process(i_clka)
    begin
        if rising_edge(i_clka) then
        
            s1_ena <= i_ena;
            s1_wea <= i_wea;
            s1_addra <= i_addra;
            s1_dina <= i_dina;
        
            if s1_ena = '1' then
                s2_douta <= sv_ram(to_integer(unsigned(s1_addra)));
                if s1_wea = '1' then
                    sv_ram(to_integer(unsigned(s1_addra))) := s1_dina;
                end if;
            end if;
            
            o_douta <= s2_douta;
            
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
                s2_doutb <= sv_ram(to_integer(unsigned(s1_addrb)));
                if s1_web = '1' then
                    sv_ram(to_integer(unsigned(s1_addrb))) := s1_dinb;
                end if;
            end if;
            
            o_doutb <= s2_doutb;
            
        end if;
    end process;
   
end Inferred;
