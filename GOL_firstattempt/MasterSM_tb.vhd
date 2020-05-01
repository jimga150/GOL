--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:33:34 01/18/2019
-- Design Name:   
-- Module Name:   E:/Code/VHDL/GOL/MasterSM_tb.vhd
-- Project Name:  GOL
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MasterSM
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
 
ENTITY MasterSM_tb IS
END MasterSM_tb;
 
ARCHITECTURE behavior OF MasterSM_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MasterSM
    PORT(
         clk : IN  std_logic;
         disp_en : IN  std_logic;
         v_sync : IN  std_logic;
         done_reading : IN  std_logic;
         done_updating : IN  std_logic;
			row_count_plus_one : IN std_logic_vector(2 downto 0);
			row_count : OUT std_logic_vector(2 downto 0);
         read_seg : OUT  std_logic;
         segment_num : OUT  std_logic_vector(7 downto 0);
         pixel_clk_en : OUT  std_logic;
         update : OUT  std_logic;
         current : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal disp_en : std_logic := '0';
   signal v_sync : std_logic := '0';
   signal done_reading : std_logic := '0';
   signal done_updating : std_logic := '0';
	signal row_count_plus_one : std_logic_vector(2 downto 0) := "001";

 	--Outputs
	signal row_count : std_logic_vector(2 downto 0);
   signal read_seg : std_logic;
   signal segment_num : std_logic_vector(7 downto 0);
   signal pixel_clk_en : std_logic;
   signal update : std_logic;
   signal current : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN

	row_count_plus_one <= "000" when row_count = "011" else 
						std_logic_vector(unsigned(row_count) + 1);
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MasterSM PORT MAP (
          clk => clk,
          disp_en => disp_en,
          v_sync => v_sync,
          done_reading => done_reading,
          done_updating => done_updating,
			 row_count_plus_one => row_count_plus_one,
			 row_count => row_count,
          read_seg => read_seg,
          segment_num => segment_num,
          pixel_clk_en => pixel_clk_en,
          update => update,
          current => current
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
		done_reading <= '1';
		wait for clk_period;
		done_reading <= '0';
		
		wait for clk_period;
		
		frame: for f in 0 to 3 loop
		
			segment_nums: for r in 0 to 19 loop
		
				disp_en <= '1';
				wait for clk_period*10;
				disp_en <= '0';
				
				wait for clk_period*4;
				done_reading <= '1';
				wait for clk_period;
				done_reading <= '0';
				wait for clk_period*4;
			
			end loop segment_nums;
		
			wait for clk_period*10;
			v_sync <= '1';
			wait for clk_period;
			v_sync <= '0';
		
			wait for clk_period*4;
			done_updating <= '1';
			wait for clk_period;
			done_updating <= '0';
		
			wait for clk_period*4;
			done_reading <= '1';
			wait for clk_period;
			done_reading <= '0';
			wait for clk_period;
		
		end loop frame;
		
		report "End of Simulation" severity failure;
		
      wait;
   end process;

END;
