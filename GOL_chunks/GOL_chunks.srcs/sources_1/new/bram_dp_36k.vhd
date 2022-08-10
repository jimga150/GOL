----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/25/2022 10:39:00 AM
-- Design Name: 
-- Module Name: bram_dp_36k - Behavioral
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

entity bram_dp_36k is
    generic(
        g_init_cells : t_block_chunk_arr := c_empty_block
    );
    PORT (
        i_clka : IN STD_LOGIC;
        i_ena : IN STD_LOGIC;
        i_wea : IN STD_LOGIC;
        i_addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        i_dina : IN STD_LOGIC_VECTOR(35 DOWNTO 0);
        o_douta : OUT STD_LOGIC_VECTOR(35 DOWNTO 0);
        
        i_clkb : IN STD_LOGIC;
        i_enb : IN STD_LOGIC;
        i_web : IN STD_LOGIC;
        i_addrb : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        i_dinb : IN STD_LOGIC_VECTOR(35 DOWNTO 0);
        o_doutb : OUT STD_LOGIC_VECTOR(35 DOWNTO 0)
      );
end bram_dp_36k;

architecture Inferred of bram_dp_36k is

    constant c_ram_depth : integer := 2**i_addra'length;
    
    type t_ram_type is array (c_ram_depth-1 downto 0) of std_logic_vector(o_douta'range);
    
    impure function InitRamFromChunks(i_chunk_arr : in t_block_chunk_arr) return t_ram_type is
        variable v_ram : t_ram_type;
        variable v_ram_idx : integer := 0;
    begin
        for r in 0 to c_block_num_chunk_rows-1 loop
            for c in 0 to c_block_num_chunk_cols-1 loop
                v_ram(v_ram_idx) := chunk_to_vector(i_chunk_arr(r, c));
                v_ram_idx := v_ram_idx + 1;
            end loop;
        end loop;
        return v_ram;
    end function;
    
    shared variable sv_ram : t_ram_type := InitRamFromChunks(g_init_cells);
    
begin

    process(i_clka)
    begin
        if rising_edge(i_clka) then
            if i_ena = '1' then
                o_douta <= sv_ram(to_integer(unsigned(i_addra)));
                if i_wea = '1' then
                    sv_ram(to_integer(unsigned(i_addra))) := i_dina;
                end if;
            end if;
        end if;
    end process;
    
    process(i_clkb)
    begin
        if rising_edge(i_clkb) then
            if i_enb = '1' then
                o_doutb <= sv_ram(to_integer(unsigned(i_addrb)));
                if i_web = '1' then
                    sv_ram(to_integer(unsigned(i_addrb))) := i_dinb;
                end if;
            end if;
        end if;
    end process;
   
end Inferred;

--architecture XilinxIP of bram_dp_36k is

--    COMPONENT blk_mem_gen_0
--      PORT (
--        clka : IN STD_LOGIC;
--        ena : IN STD_LOGIC;
--        wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
--        addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
--        dina : IN STD_LOGIC_VECTOR(35 DOWNTO 0);
--        douta : OUT STD_LOGIC_VECTOR(35 DOWNTO 0);
--        clkb : IN STD_LOGIC;
--        enb : IN STD_LOGIC;
--        web : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
--        addrb : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
--        dinb : IN STD_LOGIC_VECTOR(35 DOWNTO 0);
--        doutb : OUT STD_LOGIC_VECTOR(35 DOWNTO 0)
--      );
--    END COMPONENT;

--begin

--    bram_inst : blk_mem_gen_0
--      PORT MAP (
--        clka => i_clka,
--        ena => i_ena,
--        wea(0) => i_wea,
--        addra => i_addra,
--        dina => i_dina,
--        douta => o_douta,
--        clkb => i_clkb,
--        enb => i_enb,
--        web(0) => i_web,
--        addrb => i_addrb,
--        dinb => i_dinb,
--        doutb => o_doutb
--      );

--end XilinxIP;
