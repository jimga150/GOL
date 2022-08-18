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

use work.GOL_field_init.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity GOL_chunks_top is
    port(
        i_clk_100mhz, i_rst_btn : in std_logic;
--        i_frame_hold_btn, i_frame_step_btn : in std_logic;
        o_vga_clk : out std_logic;
        o_h_sync, o_v_sync : out std_logic;
        o_pixel_slv : out std_logic_vector(11 downto 0)
    );
end GOL_chunks_top;

architecture Structural of GOL_chunks_top is

    component clk_wiz_0
        port(
            -- Clock in ports
            clk_in1           : in     std_logic;
            -- Status and control signals
            reset             : in     std_logic;
            locked            : out    std_logic;
            -- Clock out ports
            clk_out_logic          : out    std_logic;
            clk_out_vga          : out    std_logic
        );
    end component;

    constant c_field_read_delay : integer := 6;

    signal s_rst_sys : std_logic;
    signal s_rst_sys_pulse : std_logic;

    signal s_clks_locked : std_logic;
    signal s_clk_logic_locked : std_logic;
    signal s_clk_vga_locked : std_logic;

    signal s_clk_vga, s_clk_logic : std_logic;
    
    signal s_rst_vga_nolock, s_rst_vga, s_rst_vga_n : std_logic;
    signal s_rst_logic_nolock, s_rst_logic, s_rst_logic_n : std_logic;
    
    signal s_col, s_row : integer;
    
    signal s0_hsync, s0_vsync : std_logic;
    signal s_hsync_pline, s_vsync_pline : std_logic_vector(c_field_read_delay downto 1);
    
    signal s_vsync_pline_logic : std_logic_vector(3 downto 1);
    signal s_do_frame : std_logic;
    
    signal s_pixel : std_logic;

begin

    o_vga_clk <= s_clk_vga;

    rst_sysclk_conditioner_inst: entity work.button_conditioner
    generic map(
        g_metastability_stages => 4,
        g_stable_cycles => 1000
    )
    port map(
        i_clk => i_clk_100mhz,
        i_btn => i_rst_btn,
        o_stablized => s_rst_sys,
        o_pos_pulse => s_rst_sys_pulse
    );

    clk_mmcm_inst : clk_wiz_0
    port map (
        -- Clock in ports
        clk_in1 => i_clk_100mhz,
        -- Status and control signals                
        reset => s_rst_sys_pulse,
        locked => s_clks_locked,
        -- Clock out ports  
        clk_out_logic => s_clk_logic,
        clk_out_vga => s_clk_vga
    );
    
    locked_logic_conditioner_inst: entity work.button_conditioner
    port map(
        i_clk => s_clk_logic,
        i_btn => s_clks_locked,
        o_stablized => s_clk_logic_locked
    );
    
    locked_vga_conditioner_inst: entity work.button_conditioner
    port map(
        i_clk => s_clk_vga,
        i_btn => s_clks_locked,
        o_stablized => s_clk_vga_locked
    );

    rst_logic_conditioner_inst: entity work.button_conditioner
    port map(
        i_clk => s_clk_logic,
        i_btn => i_rst_btn,
        o_debounced => s_rst_logic_nolock
    );
    
    rst_vga_conditioner_inst: entity work.button_conditioner
    port map(
        i_clk => s_clk_vga,
        i_btn => i_rst_btn,
        o_debounced => s_rst_vga_nolock
    );
    
    s_rst_vga <= s_rst_vga_nolock or (not s_clk_vga_locked);
    s_rst_logic <= s_rst_logic_nolock or (not s_clk_logic_locked);

    s_rst_vga_n <= not s_rst_vga;
    s_rst_logic_n <= not s_rst_logic;

    vga_cont_int: entity work.vga_controller
    port map(
        pixel_clk => s_clk_vga,
		reset_n => s_rst_vga_n,
		h_sync => s0_hsync,
		v_sync => s0_vsync,
		disp_ena => open,
		column => s_col,
		row => s_row,
		n_blank => open,
		n_sync => open
    );
    
    process(s_clk_vga) is begin
        if rising_edge(s_clk_vga) then
        
            s_hsync_pline <= s_hsync_pline(s_hsync_pline'high-1 downto s_hsync_pline'low) & s0_hsync;
            s_vsync_pline <= s_vsync_pline(s_vsync_pline'high-1 downto s_vsync_pline'low) & s0_vsync;
            
            if (s_rst_vga = '1') then
                s_hsync_pline <= (others => '0');
                s_vsync_pline <= (others => '0');
            end if;
            
        end if;
    end process;
    
    process(s_clk_logic) is begin
        if rising_edge(s_clk_logic) then
            s_vsync_pline_logic <= s_vsync_pline_logic(s_vsync_pline_logic'high-1 downto s_vsync_pline_logic'low) & s0_vsync;
            s_do_frame <= s_vsync_pline_logic(s_vsync_pline_logic'high-1) and not s_vsync_pline_logic(s_vsync_pline_logic'high);
        end if;
    end process;
        
    o_h_sync <= s_hsync_pline(s_hsync_pline'high);
    o_v_sync <= s_vsync_pline(s_vsync_pline'high);
    
    field_inst: entity work.GOL_field
    generic map(
        g_init_cells => c_init_vlinelrg
    )
    port map(
        i_clk_read => s_clk_vga,
        i_col => s_col,
        i_row => s_row,
        o_pixel => s_pixel,
        i_clk_stepper => s_clk_logic,
        i_rst_stepper => s_rst_logic,
        i_do_frame => s_do_frame,
        o_stepper_busy => open
    );
    
    gen_pixel: for i in o_pixel_slv'range generate
        o_pixel_slv(i) <= s_pixel;
    end generate gen_pixel;

end Structural;
