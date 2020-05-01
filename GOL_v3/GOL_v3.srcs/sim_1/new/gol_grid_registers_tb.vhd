----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/05/2020 11:41:20 AM
-- Design Name: 
-- Module Name: gol_grid_registers_tb - Behavioral
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

entity gol_grid_registers_tb is
--  Port ( );
end gol_grid_registers_tb;

architecture Behavioral of gol_grid_registers_tb is
    
    signal clk, rst, shift : std_logic := '0';
    signal enables : std_logic_vector(2 downto 0) := (others => '0');
    signal row_in : std_logic_vector(63 downto 0) := (others => '1');
    
    signal gd_r0, gd_r1, gd_r2 : std_logic_vector(65 downto 0);
    
    constant clk_period : time := 10ns;
    
begin

    uut: entity work.GOL_grid_registers
    port map(
        clk => clk,
        rst => rst,
        shift => shift,
        enables => enables,
        row_in => row_in,
        gd_r0 => gd_r0,
        gd_r1 => gd_r1,
        gd_r2 => gd_r2
    );
    
    clk <= not clk after clk_period/2;

    process is begin
        
        rst <= '1';
        wait for clk_period;
        rst <= '0';
        
        wait for clk_period;
        
        for j in 0 to 1 loop
            for i in 0 to 2 loop
                enables <= (others => '0');
                wait for 0 ns;
                enables(i) <= '1';
                wait for clk_period;
            end loop;
            enables <= (others => '0');
            shift <= '1';
            wait for clk_period;
            shift <= '0';
            wait for clk_period;
        end loop;
        
        wait for clk_period;
        
        assert false report "End Simulation" severity failure;
        
    end process;

end Behavioral;
