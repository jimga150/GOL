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
    
    constant c_num_output_stages : integer := c_bram_output_mux_stages;
    --number of busses selected for per mux stage
    constant c_output_mux_s_bits_per_stage : integer := integer(ceil(log2(real(c_num_prims_deep))/real(c_num_output_stages)));
    constant c_output_mux_div : integer := 2**c_output_mux_s_bits_per_stage;
    
    type t_prim_init_arr_type is array(c_num_prims_deep-1 downto 0) of t_bram_36k_arr;
        
    pure function InitRamFromChunks(i_chunk_arr : in t_block_chunk_arr) return t_prim_init_arr_type is
        variable v_ans : t_prim_init_arr_type;
        variable v_ram_idx : integer := 0;
        variable v_prim_idx : integer;
        variable v_prim_addr : integer;
        variable v_slv : std_logic_vector(c_bram_width-1 downto 0);
    begin
        for r in 0 to c_block_num_chunk_rows-1 loop
            for c in 0 to c_block_num_chunk_cols-1 loop
                
                v_slv := chunk_to_vector(i_chunk_arr(r, c));
                
                v_prim_idx := v_ram_idx/c_prim_depth;
                v_prim_addr := v_ram_idx mod c_prim_depth;
                v_ans(v_prim_idx)(v_prim_addr) := v_slv;
                
                v_prim_idx := (v_ram_idx + c_chunks_per_block)/c_prim_depth;
                v_prim_addr := (v_ram_idx + c_chunks_per_block) mod c_prim_depth;
                v_ans(v_prim_idx)(v_prim_addr) := v_slv; --copy to other half of RAM
                
                v_ram_idx := v_ram_idx + 1;
                
            end loop;
        end loop;
        return v_ans;
    end function;
    
    constant c_ram_init : t_prim_init_arr_type := InitRamFromChunks(g_init_cells);
    
    signal s1_brama_addr : std_logic_vector(c_prim_num_addr_bits-1 downto 0);
    signal s1_brama_sel : std_logic_vector(c_bram_sel_bits-1 downto 0);
    
    signal s1_bramb_addr : std_logic_vector(c_prim_num_addr_bits-1 downto 0);
    signal s1_bramb_sel : std_logic_vector(c_bram_sel_bits-1 downto 0);
    
    type t_prim_addr_pline is array(natural range<>) of std_logic_vector(c_prim_num_addr_bits-1 downto 0);
    type t_bram_sel_pline is array(natural range<>) of std_logic_vector(c_bram_sel_bits-1 downto 0);
    
    signal s_brama_addr_pline : t_prim_addr_pline(3 + c_num_output_stages - 1 downto 2);
    signal s_brama_sel_pline : t_bram_sel_pline(3 + c_num_output_stages downto 2);
    
    signal s_bramb_addr_pline : t_prim_addr_pline(3 + c_num_output_stages - 1 downto 2);
    signal s_bramb_sel_pline : t_bram_sel_pline(3 + c_num_output_stages downto 2);
    
    type t_2d_logic_arr is array(natural range<>, natural range<>) of std_logic;
    signal s2_enas, s2_enbs : t_2d_logic_arr(c_num_prims_wide-1 downto 0, c_num_prims_deep-1 downto 0);
    
    signal s1_s2_wea, s1_s2_web : std_logic_vector(2 downto 1);
    
    type t_data_pline is array(natural range<>) of std_logic_vector(c_bram_width-1 downto 0);
    signal s1_s2_dina, s1_s2_dinb : t_data_pline(2 downto 1);
    
    type t_dat_arr is array(natural range<>) of std_logic_vector(c_req_width-1 downto 0);
    type t_dat_arr_pline is array(c_num_output_stages + 3 downto 3) of t_dat_arr(c_num_prims_deep-1 downto 0);
    signal s_douta_arr_pline, s_doutb_arr_pline : t_dat_arr_pline;
    signal s_douta_arr_pline_reg, s_doutb_arr_pline_reg : t_dat_arr_pline;
    
    type t_dout_sel_pline is array(natural range<>) of unsigned(c_output_mux_s_bits_per_stage-1 downto 0);
    signal s_douta_sel_pline, s_doutb_sel_pline : t_dout_sel_pline(s_brama_sel_pline'range);
    
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
            
            s_douta_arr_pline_reg(s_douta_arr_pline_reg'high downto s_douta_arr_pline_reg'low+1) <= s_douta_arr_pline(s_douta_arr_pline'high-1 downto s_douta_arr_pline'low);
            
            o_douta <= s_douta_arr_pline(s_douta_arr_pline_reg'high)(0);

        end if;
    end process;
    
    gen_outmuxa: for s in s_douta_arr_pline'high downto s_douta_arr_pline'low+1 generate
    
        --0 = first layer
        constant c_layer_idx : integer := s-s_douta_arr_pline'low-1;
        constant c_layer_idx_us : unsigned(c_bram_sel_bits-1 downto 0) := to_unsigned(c_layer_idx, c_bram_sel_bits);
        
        constant c_start_s_bit_idx : integer := c_layer_idx*c_output_mux_s_bits_per_stage;
        constant c_end_s_bit_idx : integer := int_min((c_layer_idx+1)*c_output_mux_s_bits_per_stage - 1, c_bram_sel_bits-1);
        
        --number of muxes on this layer, should be 1 on last layer
        constant c_num_outputs : integer := integer(ceil(real(c_num_prims_deep)/real(c_output_mux_div**(c_layer_idx+1))));
        
    begin
    
        --select signal for all the muxes on this layer
        s_douta_sel_pline(s) <= resize(unsigned(s_brama_sel_pline(s)(c_end_s_bit_idx downto c_start_s_bit_idx)), s_douta_sel_pline(s)'length);
        s_doutb_sel_pline(s) <= resize(unsigned(s_bramb_sel_pline(s)(c_end_s_bit_idx downto c_start_s_bit_idx)), s_doutb_sel_pline(s)'length);
    
        gen_mux: for i in 0 to c_num_outputs - 1 generate
        
            constant c_start_idx : integer := i*c_output_mux_div;
            constant c_end_idx : integer := int_min((i+1)*c_output_mux_div - 1, c_num_prims_deep-1);
            constant c_mux_length : integer := c_end_idx - c_start_idx + 1;
            
            signal s_muxa_inp_arr, s_muxb_inp_arr : t_dat_arr(c_mux_length-1 downto 0);
            
        begin
        
            s_muxa_inp_arr <= s_douta_arr_pline_reg(s)(c_end_idx downto c_start_idx);
            s_muxb_inp_arr <= s_doutb_arr_pline_reg(s)(c_end_idx downto c_start_idx);
            
            s_douta_arr_pline(s)(i) <= s_muxa_inp_arr(to_integer(s_douta_sel_pline(s)));
            s_doutb_arr_pline(s)(i) <= s_muxb_inp_arr(to_integer(s_doutb_sel_pline(s)));
            
        end generate gen_mux;
        
    end generate gen_outmuxa;
    
    process(i_clkb) is begin
        if rising_edge(i_clkb) then
        
            s1_bramb_addr <= std_logic_vector(resize(unsigned(i_addrb) mod to_unsigned(c_prim_depth, i_addrb'length), s1_bramb_addr'length));
            s1_bramb_sel <= std_logic_vector(resize(unsigned(i_addrb) / to_unsigned(c_prim_depth, i_addrb'length), s1_bramb_sel'length));
            
            s_bramb_addr_pline <= s_bramb_addr_pline(s_bramb_addr_pline'high-1 downto s_bramb_addr_pline'low) & s1_bramb_addr;
            s_bramb_sel_pline <= s_bramb_sel_pline(s_bramb_sel_pline'high-1 downto s_bramb_sel_pline'low) & s1_bramb_sel;
            
            s1_s2_web <= s1_s2_web(s1_s2_web'high-1 downto s1_s2_web'low) & i_web;
            
            s1_s2_dinb <= s1_s2_dinb(s1_s2_dinb'high-1 downto s1_s2_dinb'low) & i_dinb;
            
            s_doutb_arr_pline_reg(s_doutb_arr_pline_reg'high downto s_doutb_arr_pline_reg'low+1) <= s_doutb_arr_pline(s_doutb_arr_pline'high-1 downto s_doutb_arr_pline'low);
            
            o_doutb <= s_doutb_arr_pline(s_doutb_arr_pline_reg'high)(0);
            
        end if;
    end process;
    
--    o_douta <= s3_douta_arr(to_integer(unsigned(s_brama_sel_pline(3))));
--    o_doutb <= s3_doutb_arr(to_integer(unsigned(s_bramb_sel_pline(3))));

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
                
                s_douta_arr_pline(3)(y)(s_douta_arr_pline(3)(y)'high downto x*c_prim_width) <= s3_doutas(x, y)(s3_doutas(x, y)'high - c_dat_unused_bits downto 0);
                s_doutb_arr_pline(3)(y)(s_doutb_arr_pline(3)(y)'high downto x*c_prim_width) <= s3_doutbs(x, y)(s3_doutbs(x, y)'high - c_dat_unused_bits downto 0);
                
            end generate gen_dat_overhead;
            gen_dat_nooverhead: if c_dat_unused_bits = 0 generate
            
                s2_dinas(x, y) <= s1_s2_dina(2)((x+1)*c_prim_width - 1 downto x*c_prim_width);
                s2_dinbs(x, y) <= s1_s2_dinb(2)((x+1)*c_prim_width - 1 downto x*c_prim_width);
                
                s_douta_arr_pline(3)(y)((x+1)*c_prim_width - 1 downto x*c_prim_width) <= s3_doutas(x, y);
                s_doutb_arr_pline(3)(y)((x+1)*c_prim_width - 1 downto x*c_prim_width) <= s3_doutbs(x, y);
                
            end generate gen_dat_nooverhead;
            
            
            bram_prim_inst: entity work.bram_dp_36k
            generic map(
                g_init_data => c_ram_init(y)
            )
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

end Structural;
