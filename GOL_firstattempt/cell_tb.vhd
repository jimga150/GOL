--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:17:37 12/19/2018
-- Design Name:   
-- Module Name:   E:/Code/VHDL/GOL/cell_tb.vhd
-- Project Name:  GOL
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Cell
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY cell_tb IS
END cell_tb;
 
ARCHITECTURE behavior OF cell_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Cell
    PORT(
         preset : IN  std_logic;
         preset_sel : IN  std_logic;
         clk : IN  std_logic;
         neighbors : IN  std_logic_vector(7 downto 0);
         output : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal preset : std_logic := '0';
   signal preset_sel : std_logic := '0';
   signal clk : std_logic := '0';
   signal neighbors : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal output : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Cell PORT MAP (
          preset => preset,
          preset_sel => preset_sel,
          clk => clk,
          neighbors => neighbors,
          output => output
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;
		
		preset <= '1';
		preset_sel <= '1';
		
		wait for clk_period*10;
		
		preset <= '0';
		
		wait for clk_period*10;
		
		preset_sel <= '0';
		
		for i in 0 to (2**8)-1 loop
			neighbors <= std_logic_vector(to_unsigned(i, 8));
			wait for clk_period;
		end loop;

      wait;
   end process;

END;
