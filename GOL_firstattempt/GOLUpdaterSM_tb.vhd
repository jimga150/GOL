--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:29:38 02/12/2019
-- Design Name:   
-- Module Name:   E:/Code/VHDL/GOL/GOLUpdaterSM_tb.vhd
-- Project Name:  GOL
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: GOLUpdaterSM
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
 
ENTITY GOLUpdaterSM_tb IS
END GOLUpdaterSM_tb;
 
ARCHITECTURE behavior OF GOLUpdaterSM_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT GOLUpdaterSM
    PORT(
         clk : IN  std_logic;
         disp_en : IN  std_logic;
         v_sync_fired : IN  std_logic;
         rd_count : IN  std_logic_vector(6 downto 0);
         readout : IN  std_logic_vector(31 downto 0);
         cmd_en : OUT  std_logic;
         rd_en : OUT  std_logic;
         wr_en : OUT  std_logic;
         plane : OUT  std_logic;
         x_out : OUT  std_logic_vector(7 downto 0);
         y_out : OUT  std_logic_vector(10 downto 0);
         instruction : OUT  std_logic_vector(2 downto 0);
         grid : OUT  bus_array
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal disp_en : std_logic := '0';
   signal v_sync_fired : std_logic := '0';
   signal rd_count : std_logic_vector(6 downto 0) := (others => '0');
   signal readout : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal cmd_en : std_logic;
   signal rd_en : std_logic;
   signal wr_en : std_logic;
   signal plane : std_logic;
   signal x_out : std_logic_vector(7 downto 0);
   signal y_out : std_logic_vector(10 downto 0);
   signal instruction : std_logic_vector(2 downto 0);
   signal grid : bus_array;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: GOLUpdaterSM PORT MAP (
          clk => clk,
          disp_en => disp_en,
          v_sync_fired => v_sync_fired,
          rd_count => rd_count,
          readout => readout,
          cmd_en => cmd_en,
          rd_en => rd_en,
          wr_en => wr_en,
          plane => plane,
          x_out => x_out,
          y_out => y_out,
          instruction => instruction,
          grid => grid
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
		
		disp_en <= '1';
		
		for i in 0 to 39 loop
			wait for clk_period*9;
		
			rd_count <= std_logic_vector(to_unsigned(1, 7));
			readout <= "11111111111111111111111111111111";
			wait for clk_period*2;
		
			rd_count <= (others => '0');
			readout <= (others => '0');
			wait for clk_period*4;
		
			rd_count <= std_logic_vector(to_unsigned(8, 7));
			readout <= "10101100111100001111111100000000";
			wait for clk_period*8;
		
			wait for clk_period*4;
		end loop;
		
		report "End Simulation" severity failure;

      wait;
   end process;

END;
