--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:09:51 12/19/2018
-- Design Name:   
-- Module Name:   E:/Code/VHDL/GOL/neighbor_count_tb.vhd
-- Project Name:  GOL
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: NeighborCounter
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
 
ENTITY neighbor_count_tb IS
END neighbor_count_tb;
 
ARCHITECTURE behavior OF neighbor_count_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT NeighborCounter
    PORT(
         neighbors : IN  std_logic_vector(7 downto 0);
         two : OUT  std_logic;
         three : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal neighbors : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal two : std_logic;
   signal three : std_logic;

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: NeighborCounter PORT MAP (
          neighbors => neighbors,
          two => two,
          three => three
        );
 
   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
      -- insert stimulus here 
		
		for i in 0 to (2**8)-1 loop
			neighbors <= std_logic_vector(to_unsigned(i, 8));
			wait for 10 ns;
		end loop;

      wait;
   end process;

END;
