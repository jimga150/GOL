----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/13/2023 08:23:49
-- Design Name: PS2_mouse_overlay_tb
-- Module Name: PS2_mouse_overlay_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: Created with VHDL Test Bench Template Generator
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PS2_mouse_overlay_tb is
end PS2_mouse_overlay_tb;

architecture Behavioral of PS2_mouse_overlay_tb is
    
    --Generics
    constant g_screen_width : integer := 1680;
    constant g_screen_height : integer := 1050;
    constant g_pixel_delay : integer := 5;
    constant g_sys_clk_f : integer := 100_000_000;
    
    
    --Clocks
    signal i_sys_clk : std_logic := '0';
    signal i_vga_clk : std_logic := '0';
    
    --Resets
    signal i_sys_rst : std_logic := '1';
    signal i_vga_rst : std_logic := '1';
    
    --General inputs
    signal i_col : integer := 0;
    signal i_row : integer := 0;
    
    --In-Outs
    signal io_ps2_clk : std_logic := '0';
    signal io_ps2_dat : std_logic := '0';
    
    --Outputs
    signal o_left_btn_down : std_logic;
    signal o_middle_btn_down : std_logic;
    signal o_right_btn_down : std_logic;
    signal o_left_btn_click : std_logic;
    signal o_middle_btn_click : std_logic;
    signal o_right_btn_click : std_logic;
    signal o_pixel_r : std_logic_vector(3 downto 0);
    signal o_pixel_g : std_logic_vector(3 downto 0);
    signal o_pixel_b : std_logic_vector(3 downto 0);
    signal o_pixel_enable : std_logic;
    
    --Clock Periods
    constant i_sys_clk_period : time := 10 ns;
    constant i_vga_clk_period : time := 6.798 ns;
    
begin

    io_ps2_clk <= 'H';
    io_ps2_dat <= 'H';
    
    UUT: entity work.PS2_mouse_overlay
    generic map(
        g_screen_width => g_screen_width,
        g_screen_height => g_screen_height,
        g_pixel_delay => g_pixel_delay,
        g_sys_clk_f => g_sys_clk_f
    )
    port map(
        i_sys_clk => i_sys_clk,
        i_vga_clk => i_vga_clk,
        i_sys_rst => i_sys_rst,
        i_vga_rst => i_vga_rst,
        o_left_btn_down => o_left_btn_down,
        o_middle_btn_down => o_middle_btn_down,
        o_right_btn_down => o_right_btn_down,
        o_left_btn_click => o_left_btn_click,
        o_middle_btn_click => o_middle_btn_click,
        o_right_btn_click => o_right_btn_click,
        io_ps2_clk => io_ps2_clk,
        io_ps2_dat => io_ps2_dat,
        i_col => i_col,
        i_row => i_row,
        o_pixel_r => o_pixel_r,
        o_pixel_g => o_pixel_g,
        o_pixel_b => o_pixel_b,
        o_pixel_enable => o_pixel_enable
    );
    
    --Clock Drivers
    i_sys_clk <= not i_sys_clk after i_sys_clk_period/2;
    i_vga_clk <= not i_vga_clk after i_vga_clk_period/2;
    
    stim_proc: process is begin
    
        io_ps2_clk <= 'H';
        io_ps2_dat <= 'H';
        
        wait for i_sys_clk_period;
        
        i_sys_rst <= '0';
        i_vga_rst <= '0';
        
        wait for i_sys_clk_period;
        
        wait until falling_edge(i_vga_clk);
        
        for lv_row in 0 to g_screen_height-1 loop
            for lv_col in 0 to g_screen_width-1 loop
                i_col <= lv_col;
                i_row <= lv_row;
                wait for i_vga_clk_period;
            end loop;
        end loop;
        
        wait for i_vga_clk_period*g_pixel_delay;
        
        assert false report "End Simulation" severity failure;
        
        -- Not strictly necessary, but prevents process from looping 
        -- if the above assert statement is removed
        wait;
        
    end process;

end Behavioral;
