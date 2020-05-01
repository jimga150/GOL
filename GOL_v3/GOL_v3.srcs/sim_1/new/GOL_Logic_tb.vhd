----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/24/2020 08:45:31 AM
-- Design Name: 
-- Module Name: GOL_Logic_tb - Behavioral
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

entity GOL_Logic_tb is
--  Port ( );
end GOL_Logic_tb;

architecture Behavioral of GOL_Logic_tb is
    
    signal gd_r0, gd_r1, gd_r2 : std_logic_vector(65 downto 0) := (others=> '0');
    
    signal row_out : std_logic_vector(63 downto 0);
    
begin

    uut: entity work.GOL_logic
    port map(
        gd_r0 => gd_r0,
        gd_r1 => gd_r1,
        gd_r2 => gd_r2,
        row_out => row_out
    );
    
    stim_proc: process is
        constant wait_time : time := 10ns;
    begin
        
        wait for wait_time;
        
        gd_r1(40 downto 38) <= "111";
        
        wait for wait_time;
        
        gd_r0 <= (others => '0');
        gd_r1 <= (others => '0');
        gd_r2 <= (others => '0');
        wait for 0ns;
        
        gd_r0(10) <= '1';
        gd_r1(10) <= '1';
        gd_r2(10) <= '1';
        
        wait for wait_time;
        
        gd_r0 <= (others => '0');
        gd_r1 <= (others => '0');
        gd_r2 <= (others => '0');
        wait for 0ns;
        
        gd_r0(40 downto 39) <= "11";
        gd_r1(40 downto 39) <= "11";
        
        wait for wait_time;
        
        gd_r0 <= (others => '0');
        gd_r1 <= (others => '0');
        gd_r2 <= (others => '0');
        wait for 0ns;
        
        gd_r0(40 downto 39) <= "11";
        gd_r1(41 downto 38) <= "1001";
        gd_r2(40 downto 39) <= "11";
        
        wait for wait_time;
        
        gd_r0 <= (others => '0');
        gd_r1 <= (others => '0');
        gd_r2 <= (others => '0');
        wait for 0ns;
        
        gd_r0(40 downto 38) <= "111";
        gd_r1(41 downto 39) <= "111";
        
        wait for wait_time;
        
        assert false report "End Simulation" severity failure;
        wait;
        
    end process stim_proc;

end Behavioral;
