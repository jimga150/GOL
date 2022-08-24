----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/23/2022 12:42:02 PM
-- Design Name: 
-- Module Name: bram_dp_synth_wrapper - Structural
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

use work.GOL_pkg.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bram_dp_synth_wrapper is
    port(
        i_clk_100mhz : in std_logic;
        i_input_bit : in std_logic;
        o_output_bita, o_output_bitb : out std_logic
        
--        i_ena : in std_logic;
--        i_wea : in std_logic;
--        i_addra : in std_logic_vector(c_bram_addr_bits-1 downto 0);
--        i_dina : in std_logic_vector(c_bram_width-1 downto 0);
--        o_douta : out std_logic_vector(c_bram_width-1 downto 0);
        
--        i_enb : in std_logic;
--        i_web : in std_logic;
--        i_addrb : in std_logic_vector(c_bram_addr_bits-1 downto 0);
--        i_dinb : in std_logic_vector(c_bram_width-1 downto 0);
--        o_doutb : out std_logic_vector(c_bram_width-1 downto 0)
    );
end bram_dp_synth_wrapper;

architecture Structural of bram_dp_synth_wrapper is

    component clk_wiz_1
        port(
            -- Clock in ports
            clk_in1           : in     std_logic;
            -- Status and control signals
--            reset             : in     std_logic;
            locked            : out    std_logic;
            -- Clock out ports
            clk_out_logic          : out    std_logic;
            clk_out_vga          : out    std_logic
        );
    end component;
    
    signal s_clk_vga, s_clk_logic : std_logic;
    
    constant c_num_input_bits_per_clk : integer := 2*(1+1+c_bram_addr_bits+c_bram_width);
    signal s_input_pline_vga, s_input_pline_logic : std_logic_vector(c_num_input_bits_per_clk downto 1);
    
    signal s_douta, s_doutb : std_logic_vector(c_bram_width-1 downto 0);

begin

    clk_mmcm_inst : clk_wiz_1
    port map (
        -- Clock in ports
        clk_in1 => i_clk_100mhz,
        -- Status and control signals                
--        reset => s_rst_sys_pulse,
        locked => open,
        -- Clock out ports  
        clk_out_logic => s_clk_logic,
        clk_out_vga => s_clk_vga
    );
    
    process(s_clk_vga) is begin
        if rising_edge(s_clk_vga) then
            s_input_pline_vga <= s_input_pline_vga(s_input_pline_vga'high-1 downto s_input_pline_vga'low) & i_input_bit;
        end if;
    end process;
    
    process(s_clk_logic) is begin
        if rising_edge(s_clk_logic) then
            s_input_pline_logic <= s_input_pline_logic(s_input_pline_logic'high-1 downto s_input_pline_logic'low) & i_input_bit;
        end if;
    end process;


    bram_inst: entity work.bram_dp_custom
    port map(
        i_clka => s_clk_logic,
        i_ena => s_input_pline_logic(1),
        i_wea => s_input_pline_logic(2),
        i_addra => s_input_pline_logic(c_bram_addr_bits + 3 - 1 downto 3),
        i_dina => s_input_pline_logic(c_bram_width + c_bram_addr_bits + 3 - 1 downto c_bram_addr_bits + 3),
        o_douta => s_douta,
        i_clkb => s_clk_vga,
        i_enb => s_input_pline_vga(1),
        i_web => s_input_pline_vga(2),
        i_addrb => s_input_pline_vga(c_bram_addr_bits + 3 - 1 downto 3),
        i_dinb => s_input_pline_vga(c_bram_width + c_bram_addr_bits + 3 - 1 downto c_bram_addr_bits + 3),
        o_doutb => s_doutb
    );
    
    process(s_douta) is
        variable v_out : std_logic;
    begin
        v_out := '0';
        for i in s_douta'range loop
            v_out := v_out xor s_douta(i);
        end loop;
        o_output_bita <= v_out;
    end process;
    
    process(s_doutb) is
        variable v_out : std_logic;
    begin
        v_out := '0';
        for i in s_doutb'range loop
            v_out := v_out xor s_doutb(i);
        end loop;
        o_output_bitb <= v_out;
    end process;

end Structural;
