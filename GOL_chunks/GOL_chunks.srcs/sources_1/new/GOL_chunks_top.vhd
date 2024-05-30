----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/15/2022 04:32:10 PM
-- Design Name: 
-- Module Name: GOL_chunks_top - Structural
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
use work.GOL_field_init.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity GOL_chunks_top is
    port(
        
        --system clock/reset
        i_clk_100mhz, i_rst_btn : in std_logic;
        
        --user buttons
        i_frame_go_btn, i_frame_step_btn : in std_logic;
        
        --VGA interface
        o_vga_clk : out std_logic;
        o_h_sync, o_v_sync : out std_logic;
        o_pixel_r, o_pixel_g, o_pixel_b : out std_logic_vector(3 downto 0);
        
        --PS2 interface
        io_ps2_clk, io_ps2_dat : inout std_logic;
        
        --LEDS
        led1, led2 : out std_logic
    );
end GOL_chunks_top;

architecture Structural of GOL_chunks_top is

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
        
    attribute mark_debug : string;

--    signal s_rst_sys : std_logic;
--    signal s_rst_sys_pulse : std_logic;

--    signal s_clks_locked : std_logic;
    
    signal s_clk_vga : std_logic;
--    signal s_clk_vga_locked : std_logic;
    
--    signal s_rst_vga_nolock : std_logic;
    signal s_rst_vga, s_rst_vga_n : std_logic;
    
    signal s_frame_go_vga : std_logic;
    
    signal s_col, s_row : integer;
--    attribute mark_debug of s_col: signal is "true";
--    attribute mark_debug of s_row: signal is "true";
    
    signal s0_hsync, s0_vsync : std_logic;
    signal s0_disp_en : std_logic;
    signal s_hsync_pline, s_vsync_pline : std_logic_vector(c_field_pix_read_delay downto 1);
    signal s_disp_en_pline : std_logic_vector(c_field_pix_read_delay downto 1);
    
--    attribute mark_debug of s0_hsync: signal is "true";
--    attribute mark_debug of s0_vsync: signal is "true";
    
    signal s_left_btn, s_right_btn : std_logic;
    signal s_cursor_x, s_cursor_y : integer;
    
    signal s_pixel_we, s_pixel_write_happened_vga : std_logic;
    signal s_pixel_in : std_logic;
        
    signal s_pixel_out : std_logic;
    
    signal s_mouse_overlay_en : std_logic;
    signal s_mouse_pix_r, s_mouse_pix_g, s_mouse_pix_b : std_logic_vector(3 downto 0);
    
    -----------------------
    --stepper logic stuff below here
    -----------------------
    
    signal s_clk_logic : std_logic;
--    signal s_clk_logic_locked : std_logic;

--    signal s_rst_logic_nolock : std_logic;
    signal s_rst_logic, s_rst_logic_n : std_logic;
    
    signal s_vsync_logic : std_logic;
    signal s_do_frame, s_recalc_frame : std_logic;
    
    signal s_frame_go_logic, s_frame_step : std_logic;
    
    signal s_pixel_write_happened_logic : std_logic;

begin

    o_vga_clk <= s_clk_vga;

--    rst_sysclk_conditioner_inst: entity work.button_conditioner
--    generic map(
--        g_metastability_stages => 4,
--        g_stable_cycles => 1000
--    )
--    port map(
--        i_clk => i_clk_100mhz,
--        i_btn => i_rst_btn,
--        o_stablized => s_rst_sys,
--        o_pos_pulse => s_rst_sys_pulse
--    );

    clk_mmcm_1_inst : clk_wiz_1
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
    
    ------------------------------------------------------------------
    --VGA-clocked stuff below here
    ------------------------------------------------------------------
    
--    locked_vga_conditioner_inst: entity work.button_conditioner
--    port map(
--        i_clk => s_clk_vga,
--        i_btn => s_clks_locked,
--        o_stablized => s_clk_vga_locked
--    );
    
    rst_vga_conditioner_inst: entity work.button_conditioner
    port map(
        i_clk => s_clk_vga,
        i_btn => i_rst_btn,
        o_debounced => s_rst_vga --s_rst_vga_nolock
    );
    
--    s_rst_vga <= s_rst_vga_nolock or (not s_clk_vga_locked);
    s_rst_vga_n <= not s_rst_vga;
    
    frame_hold_btn_vga_cond: entity work.button_conditioner
    port map(
        i_clk => s_clk_vga,
        i_rst => s_rst_vga,
        i_btn => i_frame_go_btn,
        o_debounced => s_frame_go_vga
    );
    
    vga_cont_int: entity work.vga_controller
    port map(
        i_clk => s_clk_vga,
		i_rst_n => s_rst_vga_n,
		o_h_sync => s0_hsync,
		o_v_sync => s0_vsync,
		o_disp_ena => s0_disp_en,
		o_column => s_col,
		o_row => s_row
    );
    
    mouse_overlay_inst: entity work.PS2_mouse_overlay
    generic map(
        g_screen_width => c_screen_width,
        g_screen_height => c_screen_height,
        g_pixel_delay => c_field_pix_read_delay,
--        g_sys_clk_f => 100_000_000 --clk_wiz_1
--        g_sys_clk_f => 12_644_675 --clk_wiz_vga_slow_logic
        g_sys_clk_f => 147_136_322 --vga_clk
    )
    port map(
        i_sys_clk => s_clk_vga,
        i_sys_rst => s_rst_vga,
        o_left_btn_down => s_left_btn,
        o_middle_btn_down => open,
        o_right_btn_down => s_right_btn,
        o_left_btn_click => open,
        o_middle_btn_click => open,
        o_right_btn_click => open,
        o_mouse_connected => open,
        o_cursor_x => s_cursor_x,
        o_cursor_y => s_cursor_y,
        io_ps2_clk => io_ps2_clk,
        io_ps2_dat => io_ps2_dat,
        i_col => s_col,
        i_row => s_row,
        o_pixel_r => s_mouse_pix_r,
        o_pixel_g => s_mouse_pix_g,
        o_pixel_b => s_mouse_pix_b,
        o_pixel_enable => s_mouse_overlay_en
    );
    
    process(s_clk_vga) is begin
        if rising_edge(s_clk_vga) then
        
            s_hsync_pline <= s_hsync_pline(s_hsync_pline'high-1 downto s_hsync_pline'low) & s0_hsync;
            s_vsync_pline <= s_vsync_pline(s_vsync_pline'high-1 downto s_vsync_pline'low) & s0_vsync;
            s_disp_en_pline <= s_disp_en_pline(s_disp_en_pline'high-1 downto s_disp_en_pline'low) & s0_disp_en;
            
            o_h_sync <= s_hsync_pline(s_hsync_pline'high);
            o_v_sync <= s_vsync_pline(s_vsync_pline'high);
            
            if (s_mouse_overlay_en = '1') then
                o_pixel_r <= s_mouse_pix_r;
                o_pixel_g <= s_mouse_pix_g;
                o_pixel_b <= s_mouse_pix_b;
            else
                o_pixel_r <= (others => 
                    s_pixel_out and s_disp_en_pline(s_disp_en_pline'high));
                o_pixel_g <= (others => 
                    s_pixel_out and s_disp_en_pline(s_disp_en_pline'high));
                o_pixel_b <= (others => 
                    s_pixel_out and s_disp_en_pline(s_disp_en_pline'high));
            end if;
            
            s_pixel_we <= '0';
            if (s_cursor_x = s_col and s_cursor_y = s_row) then
                -- only allow pixel writes from the mouse if the stepper is paused.
                -- each mouse click will queue another fram generation based on what was just written.
                s_pixel_we <= (s_left_btn or s_right_btn) and (not s_frame_go_vga);
            end if;
            
            -- 1 when frame write is queued from a mouse click
            s_pixel_write_happened_vga <= s_pixel_write_happened_vga or s_pixel_we;
            if (s0_vsync = '1') then
                s_pixel_write_happened_vga <= '0';
            end if;
            
            s_pixel_in <= s_left_btn;
            
            if (s_rst_vga = '1') then
                s_hsync_pline <= (others => '0');
                s_vsync_pline <= (others => '0');
                s_disp_en_pline <= (others => '0');
                s_pixel_we <= '0';
                s_pixel_write_happened_vga <= '0';
            end if;
        
        end if;
    end process;
    
    led1 <= s_pixel_write_happened_vga;
    
    
    ------------------------------------------------------------------
    --Stepper logic-clocked stuff below here
    ------------------------------------------------------------------
    
--    locked_logic_conditioner_inst: entity work.button_conditioner
--    port map(
--        i_clk => s_clk_logic,
--        i_btn => s_clks_locked,
--        o_stablized => s_clk_logic_locked
--    );
    
    rst_logic_conditioner_inst: entity work.button_conditioner
    port map(
        i_clk => s_clk_logic,
        i_btn => i_rst_btn,
        o_debounced => s_rst_logic --s_rst_logic_nolock
    );
    
--    s_rst_logic <= s_rst_logic_nolock or (not s_clk_logic_locked);
    s_rst_logic_n <= not s_rst_logic;
    
    frame_hold_btn_logic_cond: entity work.button_conditioner
    port map(
        i_clk => s_clk_logic,
        i_rst => s_rst_logic,
        i_btn => i_frame_go_btn,
        o_debounced => s_frame_go_logic
    );
    
    frame_step_btn_cond: entity work.button_conditioner
    port map(
        i_clk => s_clk_logic,
        i_rst => s_rst_logic,
        i_btn => i_frame_step_btn,
        o_pos_pulse => s_frame_step
    );
    
    vsync_sync_inst: entity work.button_conditioner
    generic map(
        g_metastability_stages => 3,
        g_stable_cycles => 1
    )
    port map(
        i_clk => s_clk_logic,
        i_rst => s_rst_logic,
        i_btn => s0_vsync,
        o_pos_pulse => s_vsync_logic
    );
    
    pwh_logic_cond: entity work.button_conditioner
    generic map(
        g_metastability_stages => 3,
        g_stable_cycles => 10 -- delay by much more than VGA sync
        --this is because this signal is set to go low as soon as the VGA signal goes high
        --and we want to have them both high for a couple cycles to assert s_do_frame
    )
    port map(
        i_clk => s_clk_logic,
        i_rst => s_rst_logic,
        i_btn => s_pixel_write_happened_vga,
        o_debounced => s_pixel_write_happened_logic
    );
    
    led2 <= s_pixel_write_happened_logic;
        
    s_do_frame <= (s_vsync_logic and s_frame_go_logic) or s_frame_step;
    s_recalc_frame <= s_vsync_logic and s_pixel_write_happened_logic;
    
    field_inst: entity work.GOL_field
    generic map(
        g_init_cells => c_init_puffertrain,
        g_rules => c_GOL_default
    )
    port map(
        i_clk_vga => s_clk_vga,
        i_rst_vga => s_rst_vga,
        i_col => s_col,
        i_row => s_row,
        i_pixel_we => s_pixel_we,
        i_pixel => s_pixel_in,
        o_pixel => s_pixel_out,
        i_clk_stepper => s_clk_logic,
        i_rst_stepper => s_rst_logic,
        i_do_frame => s_do_frame,
        i_recalc_frame => s_recalc_frame,
        o_stepper_busy => open
    );

end Structural;
