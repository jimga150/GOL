----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/12/2023 08:36:47 PM
-- Design Name: 
-- Module Name: PS2_mouse_overlay - Behavioral
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

entity PS2_mouse_overlay is
    generic(
        g_screen_width : integer := 1680;
        g_screen_height : integer := 1050;
        --the number of cycles of delay between the row and column inputs and the pixel outputs
        g_pixel_delay : integer := 5;
        g_sys_clk_f : integer := 12_500_000
    );
    port(
        
        --system clock domain interface
        i_sys_clk, i_sys_rst : in std_logic;
        o_left_btn_down : out std_logic;
        o_middle_btn_down : out std_logic;
        o_right_btn_down : out std_logic;
        o_left_btn_click : out std_logic;
        o_middle_btn_click : out std_logic;
        o_right_btn_click : out std_logic;
        o_mouse_connected : out std_logic;
        o_cursor_x, o_cursor_y : out unsigned(15 downto 0);
        
        --PS2 interface
        io_ps2_clk, io_ps2_dat : inout std_logic;
        
        --VGA interface
        i_vga_clk, i_vga_rst : in std_logic;
        i_col, i_row : in integer;
        o_pixel_r, o_pixel_g, o_pixel_b : out std_logic_vector(3 downto 0);
        o_pixel_enable : out std_logic
    );
end PS2_mouse_overlay;

architecture Behavioral of PS2_mouse_overlay is

    COMPONENT axis_clock_converter_0
    PORT (
        s_axis_aresetn : IN STD_LOGIC;
        m_axis_aresetn : IN STD_LOGIC;
        s_axis_aclk : IN STD_LOGIC;
        s_axis_tvalid : IN STD_LOGIC;
        s_axis_tready : OUT STD_LOGIC;
        s_axis_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        m_axis_aclk : IN STD_LOGIC;
        m_axis_tvalid : OUT STD_LOGIC;
        m_axis_tready : IN STD_LOGIC;
        m_axis_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) 
    );
    END COMPONENT;
    
    attribute mark_debug : string;
    
    signal s_sys_rstn : std_logic;

    signal s_cursor_pos_x, s_cursor_pos_y : signed(15 downto 0);
    attribute mark_debug of s_cursor_pos_x : signal is "true";
    attribute mark_debug of s_cursor_pos_y : signal is "true";
    
    signal s_cursor_pos_x_slv, s_cursor_pos_y_slv : std_logic_vector(s_cursor_pos_x'range);
    signal s_sys_cursor_pos_slv : std_logic_vector(s_cursor_pos_x_slv'length + s_cursor_pos_y_slv'length - 1 downto 0);
    
    signal s_left_button, s_left_button_saved : std_logic;
    signal s_middle_button, s_middle_button_saved : std_logic;
    signal s_right_button, s_right_button_saved : std_logic;
    
    signal s_cursor_delta_x, s_cursor_delta_y : signed(8 downto 0);
    attribute mark_debug of s_cursor_delta_x : signal is "true";
    attribute mark_debug of s_cursor_delta_y : signal is "true";
    
    signal s_mouse_packet_valid : std_logic;
    
    
    signal s_vga_rstn : std_logic;
    
    signal s_vga_cursor_pos_slv : std_logic_vector(s_sys_cursor_pos_slv'range);
    signal s_vga_cursor_x : integer range 0 to g_screen_width-1;
    signal s_vga_cursor_y : integer range 0 to g_screen_height-1;
    
    type t_pix_arr is array(natural range<>) of std_logic_vector(11 downto 0);
    signal s_pixel_pipeline : t_pix_arr(g_pixel_delay downto 1);
    signal s_pix_en_pipeline : std_logic_vector(s_pixel_pipeline'range);

begin

    s_sys_rstn <= not i_sys_rst;
    s_vga_rstn <= not i_vga_rst;

    ps2mr: entity work.PS2_mouse_reader
    generic map(
        g_sys_clk_f => g_sys_clk_f
    )
    port map(
        i_sys_clk => i_sys_clk,
        io_ps2_clk => io_ps2_clk,
        i_sys_rst => i_sys_rst,
        io_ps2_dat => io_ps2_dat,
        o_left_btn => s_left_button,
        o_right_btn => s_right_button,
        o_middle_btn => s_middle_button,
        o_x => s_cursor_delta_x,
        o_y => s_cursor_delta_y,
        o_mouse_connected => o_mouse_connected,
        o_valid => s_mouse_packet_valid,
        i_ready => '1'
    );
    
    o_left_btn_down <= s_left_button_saved;
    o_middle_btn_down <= s_middle_button_saved;
    o_right_btn_down <= s_right_button_saved;
    
    process(i_sys_clk) is
        variable v_cursor_pos_x, v_cursor_pos_y : signed(s_cursor_pos_x'range);
    begin
        if rising_edge(i_sys_clk) then
        
            o_left_btn_click <= (not s_left_button) and s_left_button_saved and s_mouse_packet_valid;
            o_middle_btn_click <= (not s_middle_button) and s_middle_button_saved and s_mouse_packet_valid;
            o_right_btn_click <= (not s_right_button) and s_right_button_saved and s_mouse_packet_valid;
            
            if (s_mouse_packet_valid) then
                
                s_left_button_saved <= s_left_button;
                s_middle_button_saved <= s_middle_button;
                s_right_button_saved <= s_right_button;
                
                --add delta
                v_cursor_pos_x := s_cursor_pos_x + resize(s_cursor_delta_x, v_cursor_pos_x'length);
                --cap at screen width
                v_cursor_pos_x := minimum(v_cursor_pos_x, to_signed(g_screen_width-1, v_cursor_pos_x'length));
                --make sure its at least 0
                v_cursor_pos_x := maximum(v_cursor_pos_x, to_signed(0, v_cursor_pos_x'length));
                s_cursor_pos_x <= v_cursor_pos_x;
                
                --negate Y delta to flip vertically
                v_cursor_pos_y := s_cursor_pos_y - resize(s_cursor_delta_y, v_cursor_pos_y'length);
                --cap at screen width
                v_cursor_pos_y := minimum(v_cursor_pos_y, to_signed(g_screen_height-1, v_cursor_pos_y'length));
                --make sure its at least 0
                v_cursor_pos_y := maximum(v_cursor_pos_y, to_signed(0, v_cursor_pos_y'length));
                s_cursor_pos_y <= v_cursor_pos_y;
                
            end if;
            
            if (i_sys_rst) then
                s_cursor_pos_x <= (others => '0');
                s_cursor_pos_y <= (others => '0');
                o_left_btn_click <= '0';
                o_middle_btn_click <= '0';
                o_right_btn_click <= '0';
                s_left_button_saved <= '0';
                s_middle_button_saved <= '0';
                s_right_button_saved <= '0';
            end if;
            
        end if;
    end process;
    
    o_cursor_x <= unsigned(std_logic_vector(s_cursor_pos_x));
    o_cursor_y <= unsigned(std_logic_vector(s_cursor_pos_y));
    
    s_cursor_pos_x_slv <= std_logic_vector(s_cursor_pos_x);
    s_cursor_pos_y_slv <= std_logic_vector(s_cursor_pos_y);
    s_sys_cursor_pos_slv <= s_cursor_pos_x_slv & s_cursor_pos_y_slv;
    
    axis_clk_cross : axis_clock_converter_0
    PORT MAP (
        s_axis_aclk => i_sys_clk,
        s_axis_aresetn => s_sys_rstn,
        s_axis_tvalid => '1',
        s_axis_tready => open,
        s_axis_tdata => s_sys_cursor_pos_slv,
        
        m_axis_aclk => i_vga_clk,
        m_axis_aresetn => s_vga_rstn,
        m_axis_tvalid => open,
        m_axis_tready => '1',
        m_axis_tdata => s_vga_cursor_pos_slv
    );
    
    s_vga_cursor_x <= to_integer(unsigned(s_vga_cursor_pos_slv(s_vga_cursor_pos_slv'high downto s_vga_cursor_pos_slv'high - s_cursor_pos_x'length + 1)));
    s_vga_cursor_y <= to_integer(unsigned(s_vga_cursor_pos_slv(s_vga_cursor_pos_slv'high - s_cursor_pos_x'length downto s_vga_cursor_pos_slv'low)));
    
    process(i_vga_clk) is begin
        if rising_edge(i_vga_clk) then
        
            s_pix_en_pipeline(1) <= '0';
            s_pixel_pipeline(1) <= (others => '0'); --not strictly necessary but i dont think it adds too much.
            
            --make green pixels surround the current cursor position
            if (i_col = s_vga_cursor_x and (i_row = s_vga_cursor_y + 1 or i_row = s_vga_cursor_y - 1)) then
                s_pixel_pipeline(1) <= "000011110000"; --green
                s_pix_en_pipeline(1) <= '1';
            end if;
            if (i_row = s_vga_cursor_y and (i_col = s_vga_cursor_x + 1 or i_col = s_vga_cursor_x - 1)) then
                s_pixel_pipeline(1) <= "000011110000"; --green
                s_pix_en_pipeline(1) <= '1';
            end if;
            
            s_pixel_pipeline(s_pixel_pipeline'high downto 2) <= s_pixel_pipeline(s_pixel_pipeline'high-1 downto 1);
            s_pix_en_pipeline(s_pix_en_pipeline'high downto 2) <= s_pix_en_pipeline(s_pix_en_pipeline'high-1 downto 1);
            
        end if;
    end process;
    
    o_pixel_r <= s_pixel_pipeline(s_pixel_pipeline'high)(11 downto 8);
    o_pixel_g <= s_pixel_pipeline(s_pixel_pipeline'high)(7 downto 4);
    o_pixel_b <= s_pixel_pipeline(s_pixel_pipeline'high)(3 downto 0);
    o_pixel_enable <= s_pix_en_pipeline(s_pix_en_pipeline'high);

end Behavioral;
