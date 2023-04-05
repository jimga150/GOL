----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/03/2023 08:55:04 PM
-- Design Name: 
-- Module Name: PS2_mouse_reader - Behavioral
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

entity PS2_mouse_reader is
    port(
        i_ps2_clk, i_ps2_dat : in std_logic;
        i_sys_clk, i_sys_rst : in std_logic;
        o_left_btn, o_right_btn : out std_logic;
        o_x, o_y : out integer;
        o_mouse_connected : out std_logic
    );
end PS2_mouse_reader;

architecture Behavioral of PS2_mouse_reader is

--    signal s_got_

begin

    process(i_ps2_clk, i_sys_rst) is begin
        if (i_sys_rst = '1') then
            
        elsif falling_edge(i_ps2_clk) then
            
        end if;
    end process;

end Behavioral;
