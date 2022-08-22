----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/18/2022 04:14:13 PM
-- Design Name: 
-- Module Name: GOL_chunks_top_synth_wrapper - Behavioral
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

entity GOL_chunks_top_synth_wrapper is
    port(
        i_clk_100mhz, i_rst_btn : in std_logic;
        i_frame_go_btn, i_frame_step_btn : in std_logic;
        o_h_sync, o_v_sync : out std_logic;
        o_pixel_slv : out std_logic_vector(11 downto 0)
    );
end GOL_chunks_top_synth_wrapper;

architecture Structural of GOL_chunks_top_synth_wrapper is
begin
    top_inst: entity work.GOL_chunks_top
    port map(
        i_clk_100mhz => i_clk_100mhz,
        i_rst_btn => i_rst_btn,
        o_vga_clk => open,
        i_frame_go_btn => i_frame_go_btn,
        i_frame_step_btn => i_frame_step_btn,
        o_h_sync => o_h_sync,
        o_v_sync => o_v_sync,
        o_pixel_slv => o_pixel_slv
    );
end Structural;