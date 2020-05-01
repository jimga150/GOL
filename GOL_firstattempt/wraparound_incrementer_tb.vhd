--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:25:24 01/17/2019
-- Design Name:   
-- Module Name:   E:/Code/VHDL/GOL/wraparound_incrementer_tb.vhd
-- Project Name:  GOL
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: wraparound_incrementer
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
--USE ieee.numeric_std.ALL;
 
ENTITY wraparound_incrementer_tb IS
END wraparound_incrementer_tb;
 
ARCHITECTURE behavior OF wraparound_incrementer_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT wraparound_incrementer
    PORT(
         input : IN  std_logic_vector(7 downto 0);
         max : IN  std_logic_vector(7 downto 0);
         output : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal input : std_logic_vector(7 downto 0) := (others => '0');
   signal max : std_logic_vector(7 downto 0) := "01010101";

 	--Outputs
   signal output : std_logic_vector(7 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: wraparound_incrementer PORT MAP (
          input => input,
          max => max,
          output => output
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

		for i in 0 to (2**8)*3 loop
			input <= output;
			wait for 10 ns;
		end loop;

      wait;
   end process;

END;
