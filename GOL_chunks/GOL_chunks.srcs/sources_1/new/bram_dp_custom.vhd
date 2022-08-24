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
    
    constant c_num_input_stages : integer := 2;
    constant c_num_output_stages : integer := 2;
    
    signal s_brama_addr : std_logic_vector(c_prim_num_addr_bits-1 downto 0);
    signal s_brama_sel : std_logic_vector(c_bram_sel_bits-1 downto 0);
    
    signal s_bramb_addr : std_logic_vector(c_prim_num_addr_bits-1 downto 0);
    signal s_bramb_sel : std_logic_vector(c_bram_sel_bits-1 downto 0);
    
    type t_dat_arr is array(c_num_prims_deep-1 downto 0) of std_logic_vector(c_req_width-1 downto 0);
    
    signal s_douta_arr, s_doutb_arr : t_dat_arr;
    
    type t_2d_logic_arr is array(natural range<>, natural range<>) of std_logic;
    signal s_enas, s_enbs : t_2d_logic_arr(c_num_prims_wide-1 downto 0, c_num_prims_deep-1 downto 0);
    
    type t_2d_slv_primdat_arr is array(natural range<>, natural range<>) of std_logic_vector(c_prim_width-1 downto 0);
    signal s_dinas, s_dinbs : t_2d_slv_primdat_arr(c_num_prims_wide-1 downto 0, c_num_prims_deep-1 downto 0);
    signal s_doutas, s_doutbs : t_2d_slv_primdat_arr(c_num_prims_wide-1 downto 0, c_num_prims_deep-1 downto 0);

begin

    s_brama_addr <= std_logic_vector(resize(unsigned(i_addra) mod to_unsigned(c_prim_depth, i_addra'length), s_brama_addr'length));
    s_brama_sel <= std_logic_vector(resize(unsigned(i_addra) / to_unsigned(c_prim_depth, i_addra'length), s_brama_sel'length));
    
    s_bramb_addr <= std_logic_vector(resize(unsigned(i_addrb) mod to_unsigned(c_prim_depth, i_addrb'length), s_bramb_addr'length));
    s_bramb_sel <= std_logic_vector(resize(unsigned(i_addrb) / to_unsigned(c_prim_depth, i_addrb'length), s_brama_sel'length));

    gen_prim_width: for x in 0 to c_num_prims_wide-1 generate
        gen_prim_depth: for y in 0 to c_num_prims_deep-1 generate
            constant c_dat_unused_bits : integer := int_max((x+1)*c_prim_width - 1 - i_dina'high, 0);
        begin
        
            s_enas(x, y) <= '1' when to_integer(unsigned(s_brama_sel)) = y else '0';
            s_enbs(x, y) <= '1' when to_integer(unsigned(s_bramb_sel)) = y else '0';
            
            gen_dat_overhead: if c_dat_unused_bits > 0 generate
            
                s_dinas(x, y)(s_dinas(x, y)'high - c_dat_unused_bits downto 0) <= i_dina(i_dina'high downto x*c_prim_width);
                s_dinas(x, y)(s_dinas(x, y)'high downto s_dinas(x, y)'high - c_dat_unused_bits + 1) <= (others => '0');
                s_dinbs(x, y)(s_dinbs(x, y)'high - c_dat_unused_bits downto 0) <= i_dinb(i_dinb'high downto x*c_prim_width);
                s_dinbs(x, y)(s_dinbs(x, y)'high downto s_dinbs(x, y)'high - c_dat_unused_bits + 1) <= (others => '0');
                
                s_douta_arr(y)(s_douta_arr(y)'high downto x*c_prim_width) <= s_doutas(x, y)(s_doutas(x, y)'high - c_dat_unused_bits downto 0);
                s_doutb_arr(y)(s_doutb_arr(y)'high downto x*c_prim_width) <= s_doutbs(x, y)(s_doutbs(x, y)'high - c_dat_unused_bits downto 0);
                
            end generate gen_dat_overhead;
            gen_dat_nooverhead: if c_dat_unused_bits = 0 generate
            
                s_dinas(x, y) <= i_dina((x+1)*c_prim_width - 1 downto x*c_prim_width);
                s_dinbs(x, y) <= i_dinb((x+1)*c_prim_width - 1 downto x*c_prim_width);
                
                s_douta_arr(y)((x+1)*c_prim_width - 1 downto x*c_prim_width) <= s_doutas(x, y);
                s_doutb_arr(y)((x+1)*c_prim_width - 1 downto x*c_prim_width) <= s_doutbs(x, y);
                
            end generate gen_dat_nooverhead;
            
            
            bram_prim_inst: entity work.bram_dp_36k
            port map(
                i_clka => i_clka,
                i_ena => s_enas(x, y),
                i_wea => i_wea,
                i_addra => s_brama_addr,
                i_dina => s_dinas(x, y),
                o_douta => s_doutas(x, y),
                i_clkb => i_clkb,
                i_enb => s_enbs(x, y),
                i_web => i_web,
                i_addrb => s_bramb_addr,
                i_dinb => s_dinbs(x, y),
                o_doutb => s_doutbs(x, y)
            );
            
        end generate gen_prim_depth;
    end generate gen_prim_width;
    
    o_douta <= s_douta_arr(to_integer(unsigned(s_brama_sel)));
    o_doutb <= s_doutb_arr(to_integer(unsigned(s_bramb_sel)));

end Structural;
