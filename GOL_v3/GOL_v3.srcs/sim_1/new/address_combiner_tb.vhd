----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/03/2020 02:01:02 PM
-- Design Name: address_combiner_tb
-- Module Name: address_combiner_tb - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity address_combiner_tb is
end address_combiner_tb;

architecture Behavioral of address_combiner_tb is
    
    --General inputs
    signal row : std_logic_vector(GOL_row_addr_length-1 downto 0) := (others => '0');
    signal col : std_logic_vector(GOL_col_addr_length-1 downto 0) := (others => '0');
    
    --Outputs
    signal addr_out : std_logic_vector(GOL_frame_addr_length-1 downto 0);
    
begin
    
    UUT: entity work.address_combiner
    port map(
        row => row,
        col => col,
        addr_out => addr_out
    );
    
    
    stim_proc: process is begin
        
        --Insert stimuli here
        
        assert false report "End Simulation" severity failure;
        
    end process;

end Behavioral;
