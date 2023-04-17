----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/13/2023 08:57:58 AM
-- Design Name: 
-- Module Name: PS2_mouse_overlay_synth_wrapper - Structural
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PS2_mouse_overlay_synth_wrapper is
    port(
        --system clock domain interface
        i_clk_100mhz, i_rst : in std_logic;
        o_left_btn_down : out std_logic;
        o_middle_btn_down : out std_logic;
        o_right_btn_down : out std_logic;
        o_left_btn_click : out std_logic;
        o_middle_btn_click : out std_logic;
        o_right_btn_click : out std_logic;
        o_mouse_connected : out std_logic;
        
        --PS2 interface
        io_ps2_clk, io_ps2_dat : inout std_logic;
        
        --VGA interface
        o_h_sync, o_v_sync : out std_logic;
        o_pixel_r, o_pixel_g, o_pixel_b : out std_logic_vector(3 downto 0)
    );
end PS2_mouse_overlay_synth_wrapper;

architecture Structural of PS2_mouse_overlay_synth_wrapper is

    component clk_wiz_1
        port(
            -- Clock in ports
            clk_in1           : in     std_logic;
            -- Status and control signals
--            reset             : in     std_logic;
--            locked            : out    std_logic;
            -- Clock out ports
            clk_out_logic          : out    std_logic;
            clk_out_vga          : out    std_logic
        );
    end component;
    
    component clk_wiz_vga_slow_logic
        port(
            -- Clock in ports
            clk_in1           : in     std_logic;
            -- Status and control signals
--            reset             : in     std_logic;
--            locked            : out    std_logic;
            -- Clock out ports
            clk_out_logic          : out    std_logic;
            clk_out_vga          : out    std_logic
        );
    end component;
    
    signal s_clk_logic, s_clk_vga : std_logic;
    signal s_rst_vga_n : std_logic;
    
    signal s0_hsync, s0_vsync : std_logic;
    signal s_hsync_pline, s_vsync_pline : std_logic_vector(5 downto 1);
    signal s_col, s_row : integer;

begin

    s_rst_vga_n <= not i_rst;

    clk_mmcm_inst : clk_wiz_vga_slow_logic
    port map (
        -- Clock in ports
        clk_in1 => i_clk_100mhz,
        -- Status and control signals                
--        reset => s_rst_sys_pulse,
--        locked => s_clks_locked,
        -- Clock out ports  
        clk_out_logic => s_clk_logic,
        clk_out_vga => s_clk_vga
    );
    
    vga_cont_int: entity work.vga_controller
    port map(
        i_clk => s_clk_vga,
		i_rst_n => s_rst_vga_n,
		o_h_sync => s0_hsync,
		o_v_sync => s0_vsync,
		o_disp_ena => open,
		o_column => s_col,
		o_row => s_row
    );
    
    process(s_clk_vga) is begin
        if rising_edge(s_clk_vga) then
        
            s_hsync_pline <= s_hsync_pline(s_hsync_pline'high-1 downto s_hsync_pline'low) & s0_hsync;
            s_vsync_pline <= s_vsync_pline(s_vsync_pline'high-1 downto s_vsync_pline'low) & s0_vsync;

            
            o_h_sync <= s_hsync_pline(s_hsync_pline'high);
            o_v_sync <= s_vsync_pline(s_vsync_pline'high);
            
        end if;
    end process;
    
    UUT: entity work.PS2_mouse_overlay
    generic map(
        g_screen_width => 1680,
        g_screen_height => 1050,
        g_pixel_delay => 5,
--        g_sys_clk_f => 100_000_000 --clk_wiz_1
        g_sys_clk_f => 12_644_675 --clk_wiz_vga_slow_logic
    )
    port map(
        i_sys_clk => s_clk_logic,
        i_vga_clk => s_clk_vga,
        i_sys_rst => i_rst,
        i_vga_rst => i_rst,
        o_left_btn_down => o_left_btn_down,
        o_middle_btn_down => o_middle_btn_down,
        o_right_btn_down => o_right_btn_down,
        o_left_btn_click => o_left_btn_click,
        o_middle_btn_click => o_middle_btn_click,
        o_right_btn_click => o_right_btn_click,
        o_mouse_connected => o_mouse_connected,
        io_ps2_clk => io_ps2_clk,
        io_ps2_dat => io_ps2_dat,
        i_col => s_col,
        i_row => s_row,
        o_pixel_r => o_pixel_r,
        o_pixel_g => o_pixel_g,
        o_pixel_b => o_pixel_b,
        o_pixel_enable => open
    );

end Structural;
