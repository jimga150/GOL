--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:47:22 01/17/2019
-- Design Name:   
-- Module Name:   E:/Code/VHDL/GOL/image_source_tb.vhd
-- Project Name:  GOL
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: image_source
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
 
ENTITY image_source_tb IS
END image_source_tb;
 
ARCHITECTURE behavior OF image_source_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT image_source
    PORT(
         chunk : IN  std_logic_vector(31 downto 0);
         chunk_index : IN  std_logic_vector(2 downto 0);
         clk : IN  std_logic;
         we : IN  std_logic;
         col : IN  std_logic_vector(7 downto 0);
         pixel : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal chunk : std_logic_vector(31 downto 0) := (others => '0');
   signal chunk_index : std_logic_vector(2 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal we : std_logic := '0';
   signal col : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal pixel : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: image_source PORT MAP (
          chunk => chunk,
          chunk_index => chunk_index,
          clk => clk,
          we => we,
          col => col,
          pixel => pixel
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
	
      wait for 100 ns;	
	
		chunk <= "11110000000000001111111101010101";
		we <= '1';
		for wi in 0 to 7 loop
			chunk_index <= std_logic_vector(to_unsigned(wi, 3));
			wait for clk_period;
		end loop;
			
		we <= '0';
		
		cols: for c in 0 to 2**8-1 loop
			col <= std_logic_vector(to_unsigned(c, 8));
			wait for 2 ns;
		end loop cols;
		
		report "End Simulation" severity failure;
			
      wait;
   end process;

END;
