----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/04/2020 11:40:43 AM
-- Design Name: 
-- Module Name: BRAM_tb - Behavioral
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

entity BRAM_tb is
--  Port ( );
end BRAM_tb;

architecture Behavioral of BRAM_tb is

    COMPONENT blk_mem_gen_0
      PORT (
        clka : IN STD_LOGIC;
        ena : IN STD_LOGIC;
        wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        addra : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        dina : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
        douta : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
      );
    END COMPONENT;

    signal clk, ena, rst : std_logic := '0';
    
    signal wea : std_logic_vector(0 downto 0) := "0";
    
    signal addra : std_logic_vector(5 downto 0) := (others => '0');
    
    signal dina : std_logic_vector(63 downto 0) := (others => '0');
    
    signal douta : std_logic_vector(63 downto 0);

    constant clk_period : time := 10ns;

begin

    uut : blk_mem_gen_0
      PORT MAP (
        clka => clk,
        ena => ena,
        wea => wea,
        addra => addra,
        dina => dina,
        douta => douta
      );
      
      clk <= not clk after clk_period/2;
      
      stim_proc: process is begin
        ena <= '1';
        
        for i in 0 to 63 loop
            addra <= std_logic_vector(to_unsigned(i, 6));
            wait for clk_period;
        end loop;
        
        assert false report "End Simulation" severity failure;
        wait;
      end process;

end Behavioral;
