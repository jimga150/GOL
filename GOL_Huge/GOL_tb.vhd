--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:58:18 12/19/2018
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
USE ieee.numeric_std.ALL;
 
ENTITY GOL_tb IS
END GOL_tb;
 
ARCHITECTURE behavior OF GOL_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT GOL
    PORT(
         Presets : IN  bus_array;
         clk : IN  std_logic;
         preset_sel : IN  std_logic;
         Cells : OUT  bus_array
        );
    END COMPONENT;
    

   --Inputs
   signal Presets : bus_array;
   signal clk : std_logic := '0';
   signal preset_sel : std_logic := '0';

 	--Outputs
   signal Cells : bus_array;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: GOL PORT MAP (
          Presets => Presets,
          clk => clk,
          preset_sel => preset_sel,
          Cells => Cells
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

      -- insert stimulus here

		--Block
		Presets <= ("000000","011000","011000","000000","000000","000000");
		preset_sel <= '1';
		wait for clk_period;
		
		preset_sel <= '0';
		wait for clk_period*10;
		
		--Beehive
		Presets <= ("000000","001100","010010","001100","000000","000000");
		preset_sel <= '1';
		wait for clk_period;
		
		preset_sel <= '0';
		wait for clk_period*10;
		
		--Blinker
		Presets <= ("000000","001000","001000","001000","000000","000000");
		preset_sel <= '1';
		wait for clk_period;

		preset_sel <= '0';
		wait for clk_period*10;
		
		--Toad
		Presets <= ("000000","000000","001110","011100","000000","000000");
		preset_sel <= '1';
		wait for clk_period;

		preset_sel <= '0';
		wait for clk_period*10;
		
		--Glider
		Presets <= ("000000","001000","000100","011100","000000","000000");
		preset_sel <= '1';
		wait for clk_period;

		preset_sel <= '0';
		wait for clk_period*10;
		
      wait;
   end process;

END;
