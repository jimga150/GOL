----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/23/2022 02:48:45 PM
-- Design Name: 
-- Module Name: bram_dp_custom - Structural
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

use work.GOL_pkg.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bram_dp_custom is
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
end bram_dp_custom;

architecture Structural of bram_dp_custom is

    constant c_prim_num_addr_bits : integer := 10;

    constant c_prim_depth : integer := 2**c_prim_num_addr_bits;
    constant c_prim_width : integer := 36;
    
    constant c_req_depth : integer := c_bram_depth;
    constant c_req_width : integer := c_bram_width;
    
    constant c_num_prims_wide : integer := integer(ceil(real(c_req_width)/real(c_prim_width)));
    constant c_num_prims_deep : integer := integer(ceil(real(c_req_depth)/real(c_prim_depth)));
    
    constant c_bram_sel_bits : integer := integer(floor(log2(real(c_num_prims_deep))+1.0));
    
    constant c_num_output_stages : integer := 2;
    
    signal s1_brama_addr : std_logic_vector(c_prim_num_addr_bits-1 downto 0);
    signal s1_brama_sel : std_logic_vector(c_bram_sel_bits-1 downto 0);
    
    signal s1_bramb_addr : std_logic_vector(c_prim_num_addr_bits-1 downto 0);
    signal s1_bramb_sel : std_logic_vector(c_bram_sel_bits-1 downto 0);
    
    type t_prim_addr_pline is array(natural range<>) of std_logic_vector(c_prim_num_addr_bits-1 downto 0);
    type t_bram_sel_pline is array(natural range<>) of std_logic_vector(c_bram_sel_bits-1 downto 0);
    
    signal s_brama_addr_pline : t_prim_addr_pline(3 + c_num_output_stages - 1 downto 2);
    signal s_brama_sel_pline : t_bram_sel_pline(3 + c_num_output_stages - 1 downto 2);
    
    signal s_bramb_addr_pline : t_prim_addr_pline(3 + c_num_output_stages - 1 downto 2);
    signal s_bramb_sel_pline : t_bram_sel_pline(3 + c_num_output_stages - 1 downto 2);
    
    type t_2d_logic_arr is array(natural range<>, natural range<>) of std_logic;
    signal s2_enas, s2_enbs : t_2d_logic_arr(c_num_prims_wide-1 downto 0, c_num_prims_deep-1 downto 0);
    
    signal s1_s2_wea, s1_s2_web : std_logic_vector(2 downto 1);
    
    type t_data_pline is array(natural range<>) of std_logic_vector(c_bram_width-1 downto 0);
    signal s1_s2_dina, s1_s2_dinb : t_data_pline(2 downto 1);
    
    type t_dat_arr is array(c_num_prims_deep-1 downto 0) of std_logic_vector(c_req_width-1 downto 0);
    signal s3_douta_arr, s3_doutb_arr : t_dat_arr;
    
    type t_2d_slv_primdat_arr is array(natural range<>, natural range<>) of std_logic_vector(c_prim_width-1 downto 0);
    signal s2_dinas, s2_dinbs : t_2d_slv_primdat_arr(c_num_prims_wide-1 downto 0, c_num_prims_deep-1 downto 0);
    signal s3_doutas, s3_doutbs : t_2d_slv_primdat_arr(c_num_prims_wide-1 downto 0, c_num_prims_deep-1 downto 0);

begin

    process(i_clka) is begin
        if rising_edge(i_clka) then
        
            s1_brama_addr <= std_logic_vector(resize(unsigned(i_addra) mod to_unsigned(c_prim_depth, i_addra'length), s1_brama_addr'length));
            s1_brama_sel <= std_logic_vector(resize(unsigned(i_addra) / to_unsigned(c_prim_depth, i_addra'length), s1_brama_sel'length));
            
            s_brama_addr_pline <= s_brama_addr_pline(s_brama_addr_pline'high-1 downto s_brama_addr_pline'low) & s1_brama_addr;
            s_brama_sel_pline <= s_brama_sel_pline(s_brama_sel_pline'high-1 downto s_brama_sel_pline'low) & s1_brama_sel;
            
            s1_s2_wea <= s1_s2_wea(s1_s2_wea'high-1 downto s1_s2_wea'low) & i_wea;
            
            s1_s2_dina <= s1_s2_dina(s1_s2_dina'high-1 downto s1_s2_dina'low) & i_dina;
            
        end if;
    end process;
    
    process(i_clkb) is begin
        if rising_edge(i_clkb) then
        
            s1_bramb_addr <= std_logic_vector(resize(unsigned(i_addrb) mod to_unsigned(c_prim_depth, i_addrb'length), s1_bramb_addr'length));
            s1_bramb_sel <= std_logic_vector(resize(unsigned(i_addrb) / to_unsigned(c_prim_depth, i_addrb'length), s1_bramb_sel'length));
            
            s_bramb_addr_pline <= s_bramb_addr_pline(s_bramb_addr_pline'high-1 downto s_bramb_addr_pline'low) & s1_bramb_addr;
            s_bramb_sel_pline <= s_bramb_sel_pline(s_bramb_sel_pline'high-1 downto s_bramb_sel_pline'low) & s1_bramb_sel;
            
            s1_s2_web <= s1_s2_web(s1_s2_web'high-1 downto s1_s2_web'low) & i_web;
            
            s1_s2_dinb <= s1_s2_dinb(s1_s2_dinb'high-1 downto s1_s2_dinb'low) & i_dinb;
            
        end if;
    end process;

    gen_prim_width: for x in 0 to c_num_prims_wide-1 generate
        gen_prim_depth: for y in 0 to c_num_prims_deep-1 generate
            constant c_dat_unused_bits : integer := int_max((x+1)*c_prim_width - 1 - s1_s2_dina(2)'high, 0);
        begin
        
            process(i_clka) is begin
                if rising_edge(i_clka) then
                    s2_enas(x, y) <= '0';
                    if (to_integer(unsigned(s1_brama_sel)) = y) then
                        s2_enas(x, y) <= '1';
                    end if;
                end if;
            end process;
            
            process(i_clkb) is begin
                if rising_edge(i_clkb) then
                    s2_enbs(x, y) <= '0';
                    if (to_integer(unsigned(s1_bramb_sel)) = y) then
                        s2_enbs(x, y) <= '1';
                    end if;
                end if;
            end process;
                        
            gen_dat_overhead: if c_dat_unused_bits > 0 generate
            
                s2_dinas(x, y)(s2_dinas(x, y)'high - c_dat_unused_bits downto 0) <= s1_s2_dina(2)(s1_s2_dina(2)'high downto x*c_prim_width);
                s2_dinas(x, y)(s2_dinas(x, y)'high downto s2_dinas(x, y)'high - c_dat_unused_bits + 1) <= (others => '0');
                s2_dinbs(x, y)(s2_dinbs(x, y)'high - c_dat_unused_bits downto 0) <= s1_s2_dinb(2)(s1_s2_dinb(2)'high downto x*c_prim_width);
                s2_dinbs(x, y)(s2_dinbs(x, y)'high downto s2_dinbs(x, y)'high - c_dat_unused_bits + 1) <= (others => '0');
                
                s3_douta_arr(y)(s3_douta_arr(y)'high downto x*c_prim_width) <= s3_doutas(x, y)(s3_doutas(x, y)'high - c_dat_unused_bits downto 0);
                s3_doutb_arr(y)(s3_doutb_arr(y)'high downto x*c_prim_width) <= s3_doutbs(x, y)(s3_doutbs(x, y)'high - c_dat_unused_bits downto 0);
                
            end generate gen_dat_overhead;
            gen_dat_nooverhead: if c_dat_unused_bits = 0 generate
            
                s2_dinas(x, y) <= s1_s2_dina(2)((x+1)*c_prim_width - 1 downto x*c_prim_width);
                s2_dinbs(x, y) <= s1_s2_dinb(2)((x+1)*c_prim_width - 1 downto x*c_prim_width);
                
                s3_douta_arr(y)((x+1)*c_prim_width - 1 downto x*c_prim_width) <= s3_doutas(x, y);
                s3_doutb_arr(y)((x+1)*c_prim_width - 1 downto x*c_prim_width) <= s3_doutbs(x, y);
                
            end generate gen_dat_nooverhead;
            
            
            bram_prim_inst: entity work.bram_dp_36k
            port map(
                i_clka => i_clka,
                i_ena => s2_enas(x, y),
                i_wea => s1_s2_wea(2),
                i_addra => s_brama_addr_pline(2),
                i_dina => s2_dinas(x, y),
                o_douta => s3_doutas(x, y),
                i_clkb => i_clkb,
                i_enb => s2_enbs(x, y),
                i_web => s1_s2_web(2),
                i_addrb => s_bramb_addr_pline(2),
                i_dinb => s2_dinbs(x, y),
                o_doutb => s3_doutbs(x, y)
            );
            
        end generate gen_prim_depth;
    end generate gen_prim_width;
    
    o_douta <= s3_douta_arr(to_integer(unsigned(s_brama_sel_pline(3))));
    o_doutb <= s3_doutb_arr(to_integer(unsigned(s_bramb_sel_pline(3))));

end Structural;
