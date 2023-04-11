----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/04/2023 10:10:07 PM
-- Design Name: 
-- Module Name: PS2_mouse_reader_synth_wrapper - Behavioral
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

entity PS2_mouse_reader_synth_wrapper is
    port(
        io_ps2_clk, io_ps2_dat : inout std_logic;
        i_sys_clk, i_sys_rst : in std_logic;
        o_left_btn, o_right_btn : out std_logic;
        o_x, o_y : out std_logic_vector(7 downto 0);
        o_mouse_connected : out std_logic;
        o_valid : out std_logic;
        i_ready : in std_logic
    );
end PS2_mouse_reader_synth_wrapper;

architecture Behavioral of PS2_mouse_reader_synth_wrapper is

    component clk_wiz_0
    port(
        clk_out1          : out    std_logic;
        clk_in1           : in     std_logic
    );
    end component;
    
    signal s_sys_clk_slow : std_logic;

    signal s_x_int, s_y_int : integer;

begin

    clk_div : clk_wiz_0
    port map ( 
        -- Clock out ports  
        clk_out1 => s_sys_clk_slow,
        -- Clock in ports
        clk_in1 => i_sys_clk
    );

    ps2mr: entity work.PS2_mouse_reader
    port map(
        i_sys_clk => s_sys_clk_slow,
        io_ps2_clk => io_ps2_clk,
        i_sys_rst => i_sys_rst,
        io_ps2_dat => io_ps2_dat,
        o_left_btn => o_left_btn,
        o_right_btn => o_right_btn,
        o_x => s_x_int,
        o_y => s_y_int,
        o_mouse_connected => o_mouse_connected,
        o_valid => o_valid,
        i_ready => i_ready
    );
    
    o_x <= std_logic_vector(to_unsigned(s_x_int, o_x'length));
    o_y <= std_logic_vector(to_unsigned(s_y_int, o_x'length));

end Behavioral;
