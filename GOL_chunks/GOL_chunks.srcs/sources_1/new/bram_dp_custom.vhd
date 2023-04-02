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
        --g_init_cells is tightly coupled with the codebase this file was made in, 
        --because the alternative is a whole package and frankly i dont feel like it.
        --you'll have to modify the initialization for your own code.
        g_init_cells : t_block_chunk_arr := c_empty_block;
        g_read_delay : integer := 6+3;
        g_data_width : integer := 36;
        g_word_depth : integer := 35*1024; --32k
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
end bram_dp_custom;

architecture Structural of bram_dp_custom is

    constant c_primitive_data_width : integer := 36;
    constant c_primitive_addr_width : integer := 10;
    constant c_primitive_word_depth : integer := 2**c_primitive_addr_width;
    constant c_primitive_delay : integer := 1;
    
    --how many primitives to instantiate
    --currently assumes one primitive will handle one word address
    constant c_num_prims_deep : integer := integer(ceil(real(g_word_depth)/real(c_primitive_word_depth)));
    
    --TODO: this currently assumes the requested data width = primitive word width. fix that.
    
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
                
                v_prim_idx := v_ram_idx/c_primitive_word_depth;
                v_prim_addr := v_ram_idx mod c_primitive_word_depth;
                v_ans(v_prim_idx)(v_prim_addr) := v_slv;
                
                v_prim_idx := (v_ram_idx + c_chunks_per_block)/c_primitive_word_depth;
                v_prim_addr := (v_ram_idx + c_chunks_per_block) mod c_primitive_word_depth;
                v_ans(v_prim_idx)(v_prim_addr) := v_slv; --copy to other half of RAM
                
                v_ram_idx := v_ram_idx + 1;
                
            end loop;
        end loop;
        return v_ans;
    end function;
    
    constant c_ram_init : t_prim_init_arr_type := InitRamFromChunks(g_init_cells);
    
    --the cycles of delay between data in and the BRAM primitives
    constant c_input_delay : integer := 2;
    
    --delay between input and primitive output
    constant c_primitive_dout_stage_idx : integer := c_input_delay + c_primitive_delay;
    
    --the number of registered stages to make the pipelined multiplexers for the data outputs.
    constant c_mux_stages : integer := g_read_delay - c_primitive_dout_stage_idx; --subtract 1 for the primitive read delay
    
    --the number of inputs every individual mux will have
    --on Vivado 2022.1, this line wont elaborate without this patch:
    --https://support.xilinx.com/s/article/2022-1-Vivado-Synthesis-Change-in-Parser-Behavior?language=en_US
    --also, calling ceil() on results of floating point math that aould otherwise evaluate to an exact integer
    --sometimes results in evaluating to the next integer up, not the integer you want.
    --subtract a tiny amount to adjust for this
    constant c_mux_depth : integer := integer(ceil( c_num_prims_deep**(1.0/real(c_mux_stages)) - 0.0001 ));
    
    --round c_num_prims_deep up to the nearest multiple of c_mux_depth to ensure the signals exist for the first stage of mux inputs
    constant c_num_stage0_mux_ins : integer := integer(ceil(real(c_num_prims_deep)/real(c_mux_depth)))*c_mux_depth;
    
    --for a given stage index, returns the number of muxes that stage should have
    --0 = first stage of muxes, prims/mux depth
    pure function getNumMuxesForStage(i_stage_idx : in integer) return integer is
        variable v_ans : integer;
    begin
        v_ans := integer(ceil( real(c_num_prims_deep)/real(c_mux_depth**(i_stage_idx+1)) - 0.0001 ));
        return v_ans;
    end function;
    
    --round the stage 0 mux count up to the nearest multiple of c_mux_depth to ensure the signals exist for the second stage of mux inputs
    constant c_num_stage1_mux_ins : integer := integer(ceil(real(getNumMuxesForStage(0))/real(c_mux_depth)))*c_mux_depth;
    
    --write enable pipelines
    signal s_wea_pline, s_web_pline : std_logic_vector(c_input_delay downto 1);
    
    --data 1D and 2D array types
    type t_data_arr is array(natural range<>) of std_logic_vector(g_data_width-1 downto 0);
    type t_data_2d_arr is array(natural range<>, natural range<>) of std_logic_vector(g_data_width-1 downto 0);
    
    --data in pipelines
    signal s_dina_pline, s_dinb_pline : t_data_arr(c_input_delay downto 1);
    
    --major address pipelines
    type t_int_arr is array(natural range<>) of integer;
    signal s_major_addra_pline, s_major_addrb_pline : t_int_arr(g_read_delay downto 2);
    
    --major address: address to select between primitives
    signal s1_major_addra, s1_major_addrb : integer;
    
    --minor address: address to feed primitives to select for word within
    signal s1_minor_addra, s1_minor_addrb : integer;
    
    signal s1_ena, s1_enb : std_logic;
    
    
    signal s2_minor_addra, s2_minor_addrb : std_logic_vector(c_primitive_addr_width-1 downto 0);
    
    --data outputs right from primitives
    signal s3_doutas, s3_doutbs : t_data_arr(c_num_stage0_mux_ins-1 downto 0);
    
    
    --the outputs of all muxes in all stages
    signal s_mux_outs_a, s_mux_outs_b : t_data_2d_arr(c_mux_stages-1 downto 0, c_num_stage1_mux_ins-1 downto 0);
        
begin

    --TODO
    assert c_primitive_data_width = g_data_width report "Data width must match primitive data width!" severity failure;
    
    assert g_read_delay > c_primitive_dout_stage_idx report "Read delay must be greater than " & integer'image(c_primitive_dout_stage_idx) severity failure;
    
    assert 2**c_mux_stages <= c_num_prims_deep 
        report "Output multiplexer has more pipeline stages than it can use to interleave logic. The maximum number of stages it can use is " 
        & integer'image(integer(ceil( log2(real(c_num_prims_deep)) + 0.0001 )))
        & " (read delay of " & integer'image(c_primitive_dout_stage_idx + integer(ceil( log2(real(c_num_prims_deep)) + 0.0001 ))) & ")"
        severity warning;

    gen_dout_mux_stages: for gv_stage_idx in 0 to c_mux_stages-1 generate
        --gv_stage_idx is the stage index, where 0 is the first stage of muxes 
        --and the last one is the final mux that drives the data output.
        
        --number of muxes this stage wil have
        constant c_num_muxes : integer := getNumMuxesForStage(gv_stage_idx);
        
        --delay index within pipeline--the stage of delay this mux stage will be taking input from.
        --this stage will output to delay stage c_pline_idx+1.
        constant c_pline_idx : integer := gv_stage_idx + c_primitive_dout_stage_idx;
        
        --the amount to divide down the primitive address to isolate 
        --the part of the address pertaining to this stage of muxes
        constant c_mux_mag : integer := c_mux_depth**gv_stage_idx;
        
        --select input to all muxes for this stage
        signal s_sela, s_selb : integer range 0 to c_mux_depth-1;
            
    begin
    
        process(i_clka) is begin
            if rising_edge(i_clka) then
                s_sela <= (s_major_addra_pline(c_pline_idx-1)/c_mux_mag) mod c_mux_depth;
            end if;
        end process;
        
        process(i_clkb) is begin
            if rising_edge(i_clkb) then
                s_selb <= (s_major_addrb_pline(c_pline_idx-1)/c_mux_mag) mod c_mux_depth;
            end if;
        end process;
            
        gen_dout_muxes: for gv_mux_idx in 0 to c_num_muxes-1 generate
            --gv_mux_idx is this multiplexer's index within the stage. 
            --it selects between c_mux_depth data values from the last stage.
        
            --array to multiplex between on this mux
            signal s_mux_inputs_a, s_mux_inputs_b : t_data_arr(c_mux_depth-1 downto 0);
        
        begin
            
            process(i_clka) is begin
                if rising_edge(i_clka) then
                    s_mux_outs_a(gv_stage_idx, gv_mux_idx) <= s_mux_inputs_a(s_sela);
                end if;
            end process;
            
            process(i_clkb) is begin
                if rising_edge(i_clkb) then
                    s_mux_outs_b(gv_stage_idx, gv_mux_idx) <= s_mux_inputs_b(s_selb);
                end if;
            end process;
            
            gen_mux_inputs: if (gv_stage_idx = 0) generate
                s_mux_inputs_a <= s3_doutas(c_mux_depth*(gv_mux_idx+1) - 1 downto c_mux_depth*gv_mux_idx);
                s_mux_inputs_b <= s3_doutbs(c_mux_depth*(gv_mux_idx+1) - 1 downto c_mux_depth*gv_mux_idx);
            else generate
                gen_nth_stage_inputs: for gv_mux_in_idx in 0 to c_mux_depth - 1 generate
                    --assign mux inputs with a for generate since slices arent supported in 2D arrays in Vivado's VHDL 2008.
                    --gv_mux_in_idx is the index of the multiplexer's input, representing one data bus.
                    s_mux_inputs_a(gv_mux_in_idx) <= s_mux_outs_a(gv_stage_idx-1, gv_mux_in_idx + c_mux_depth*gv_mux_idx);
                    s_mux_inputs_b(gv_mux_in_idx) <= s_mux_outs_b(gv_stage_idx-1, gv_mux_in_idx + c_mux_depth*gv_mux_idx);
                end generate;
            end generate;
            
        end generate;
        
    end generate;
    
    o_douta <= s_mux_outs_a(c_mux_stages-1, 0);
    o_doutb <= s_mux_outs_b(c_mux_stages-1, 0);

    process(i_clka) is begin
        if rising_edge(i_clka) then
            
            s_wea_pline <= s_wea_pline(s_wea_pline'high-1 downto s_wea_pline'low) & i_wea;
            s_dina_pline <= s_dina_pline(s_dina_pline'high-1 downto s_dina_pline'low) & i_dina;
            s_major_addra_pline <= s_major_addra_pline(s_major_addra_pline'high-1 downto s_major_addra_pline'low) & s1_major_addra;
            
            s1_major_addra <= to_integer(unsigned(i_addra)) / c_primitive_word_depth; --TODO: this is a power of 2 so simplify it
            s1_minor_addra <= to_integer(unsigned(i_addra)) mod c_primitive_word_depth;
            s1_ena <= i_ena;
            
            s2_minor_addra <= std_logic_vector(to_unsigned(s1_minor_addra, s2_minor_addra'length));

        end if;
    end process;
    
    process(i_clkb) is begin
        if rising_edge(i_clkb) then
        
            s_web_pline <= s_web_pline(s_web_pline'high-1 downto s_web_pline'low) & i_web;
            s_dinb_pline <= s_dinb_pline(s_dinb_pline'high-1 downto s_dinb_pline'low) & i_dinb;
            s_major_addrb_pline <= s_major_addrb_pline(s_major_addrb_pline'high-1 downto s_major_addrb_pline'low) & s1_major_addrb;
            
            s1_major_addrb <= to_integer(unsigned(i_addrb)) / c_primitive_word_depth;
            s1_minor_addrb <= to_integer(unsigned(i_addrb)) mod c_primitive_word_depth;
            s1_enb <= i_enb;
            
            s2_minor_addrb <= std_logic_vector(to_unsigned(s1_minor_addrb, s2_minor_addrb'length));
            
        end if;
    end process;

    gen_prims: for i in 0 to c_num_prims_deep-1 generate
        
        signal s2_ena, s2_enb : std_logic;
        
    begin
    
        process(i_clka) is begin
            if rising_edge(i_clka) then
                
                s2_ena <= '0';
                if (s1_major_addra = i) then
                    s2_ena <= s1_ena;
                end if;
                
            end if;
        end process;
        
        process(i_clkb) is begin
            if rising_edge(i_clkb) then
                
                s2_enb <= '0';
                if (s1_major_addrb = i) then
                    s2_enb <= s1_enb;
                end if;
                
            end if;
        end process;
    
        bram_prim_inst: entity work.bram_dp_36k
        generic map(
            g_init_data => c_ram_init(i)
        )
        port map(
            i_clka => i_clka,
            i_ena => s2_ena,
            i_wea => s_wea_pline(2),
            i_addra => s2_minor_addra,
            i_dina => s_dina_pline(2),
            o_douta => s3_doutas(i),
            i_clkb => i_clkb,
            i_enb => s2_enb,
            i_web => s_web_pline(2),
            i_addrb => s2_minor_addrb,
            i_dinb => s_dinb_pline(2),
            o_doutb => s3_doutbs(i)
        );
    end generate;
    
    s3_doutas(s3_doutas'high downto c_num_prims_deep) <= (others => (others => '0'));
    s3_doutbs(s3_doutas'high downto c_num_prims_deep) <= (others => (others => '0'));

end Structural;
