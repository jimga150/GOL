--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:35:19 02/11/2019
-- Design Name:   
-- Module Name:   E:/Code/VHDL/GOL/GOL_tb.vhd
-- Project Name:  GOL
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: GOL
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
use work.bus_array_pkg.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY GOL_tb IS
END GOL_tb;
 
ARCHITECTURE behavior OF GOL_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT GOL
    PORT(
         current_state : IN  bus_array;
         next_state : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal current_state : bus_array := (others => (others => '0'));

 	--Outputs
   signal next_state : std_logic_vector(31 downto 0);
  
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: GOL PORT MAP (
          current_state => current_state,
          next_state => next_state
        );

   -- Stimulus process
   stim_proc: process
   begin		
	
      wait for 10 ns;	

      -- insert stimulus here 
		
		current_state <= (
			"0100000100100000001100011000000000", 
			"0010010100100111001100100100000000", 
			"1110001100100000000000011000000000"
		);
		
		wait for 10 ns;
		
		report "End Simulation" severity failure;

      wait;
   end process;

END;
