----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/26/2020 12:03:09 PM
-- Design Name: 
-- Module Name: vga_controller_tb - Behavioral
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

entity vga_controller_tb is
--  Port ( );
end vga_controller_tb;

architecture Behavioral of vga_controller_tb is
    signal clk : std_logic := '0';
    signal rst_n : std_logic := '0';
    
    signal h_sync, v_sync, disp_en, n_blank, n_sync : std_logic;
    signal col, row : integer;
    
begin

    uut: entity work.vga_controller
    port map(
        pixel_clk => clk,
        reset_n => rst_n,
        h_sync => h_sync,
        v_sync => v_sync,
        disp_ena => disp_en,
        n_blank => n_blank,
        n_sync => n_sync,
        row => row,
        column => col
    );
    
    clk_proc: process is begin
        wait for 5ns;
        clk <= not clk;
    end process clk_proc;

    stim_proc: process is begin
        wait for 10ns;
        rst_n <= '1';
        wait;
    end process stim_proc;

end Behavioral;
