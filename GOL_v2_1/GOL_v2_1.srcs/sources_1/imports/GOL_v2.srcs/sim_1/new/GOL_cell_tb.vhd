----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/18/2020 02:13:26 PM
-- Design Name: 
-- Module Name: GOL_cell_tb - Behavioral
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

entity GOL_cell_tb is
--  Port ( );
end GOL_cell_tb;

architecture Behavioral of GOL_cell_tb is

    signal clk, clk_en, preset_en, preset : std_logic := '0';
    signal neighbors : std_logic_vector(7 downto 0) := (others => '0');
    signal cell_val : std_logic;

begin

    uut : entity work.GOL_cell
    port map (
        clk_gc => clk,
        clk_en => clk_en,
        preset_en => preset_en,
        preset => preset,
        neighbors => neighbors,
        cell_val => cell_val
    );
    
    stim_proc: process is begin
        
        clk_en <= '1';
        preset_en <= '1';
        preset <= '1';
        wait for 10ns;
        
        preset_en <= '0';
        wait for 10ns;
        
        for i in 0 to 2**8 - 1 loop
            neighbors <= std_logic_vector(to_unsigned(i, 8));
            wait for 10ns;
        end loop;
        
        clk_en <= '0';
        
        for i in 0 to 2**8 - 1 loop
            neighbors <= std_logic_vector(to_unsigned(i, 8));
            wait for 10ns;
        end loop;
        
        assert false report "Ending Simulation" severity failure;
        wait;
    end process stim_proc;
    
    clk_proc : process is begin
        wait for 5ns;
        clk <= not clk;
    end process clk_proc;

end Behavioral;
