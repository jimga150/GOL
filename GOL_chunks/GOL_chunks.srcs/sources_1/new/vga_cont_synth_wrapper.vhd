----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/22/2022 11:20:19 AM
-- Design Name: 
-- Module Name: vga_cont_synth_wrapper - Structural
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

entity vga_cont_synth_wrapper is
    port(
        i_clk_100mhz, i_rst_btn : in std_logic;
        i_frame_go_btn, i_frame_step_btn : in std_logic;
        o_disp_en, o_h_sync, o_v_sync : out std_logic;
        o_pixel : out std_logic
    );
end vga_cont_synth_wrapper;

architecture Structural of vga_cont_synth_wrapper is

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
    
    signal s_clk_vga : std_logic;
    
    signal s_col, s_row : integer;

begin

    clk_mmcm_inst : clk_wiz_1
    port map (
        -- Clock in ports
        clk_in1 => i_clk_100mhz,
        -- Status and control signals                
--        reset => s_rst_sys_pulse,
        locked => open,
        -- Clock out ports  
        clk_out_logic => open,
        clk_out_vga => s_clk_vga
    );

    vga_cont_int: entity work.vga_controller
    port map(
        i_clk => s_clk_vga,
		i_rst_n => i_rst_btn,
		o_h_sync => o_h_sync,
		o_v_sync => o_v_sync,
		o_disp_ena => o_disp_en,
		o_column => s_col,
		o_row => s_row
    );
    
    process(s_col, s_row) is
        variable v_pixel : std_logic;
        variable v_col_slv : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(s_col, 32));
        variable v_row_slv : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(s_row, 32));
    begin
    
        v_pixel := '0';
    
        for i in v_col_slv'range loop
            v_pixel := v_pixel xor v_col_slv(i);
        end loop;
        
        for i in v_row_slv'range loop
            v_pixel := v_pixel xor v_row_slv(i);
        end loop;
        
        o_pixel <= v_pixel;
    
    end process;

end Structural;
