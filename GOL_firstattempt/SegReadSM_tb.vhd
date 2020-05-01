--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:58:11 02/05/2019
-- Design Name:   
-- Module Name:   E:/Code/VHDL/GOL/SegReadSM_tb.vhd
-- Project Name:  GOL
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: SegReadSM
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
 
ENTITY SegReadSM_tb IS
END SegReadSM_tb;
 
ARCHITECTURE behavior OF SegReadSM_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SegReadSM
    PORT(
         rd_empty : IN  std_logic;
         clk : IN  std_logic;
         disp_en : IN  std_logic;
         v_sync : IN  std_logic;
         rd_count : IN  std_logic_vector(6 downto 0);
         chunk_index_plus_one : IN  std_logic_vector(4 downto 0);
         row_in : IN  std_logic_vector(8 downto 0);
         chunk_addr : OUT  std_logic_vector(13 downto 0);
         rd_en : OUT  std_logic;
         cmd_en : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal rd_empty : std_logic := '0';
   signal clk : std_logic := '0';
   signal disp_en : std_logic := '0';
   signal v_sync : std_logic := '0';
   signal rd_count : std_logic_vector(6 downto 0) := (others => '0');
   signal chunk_index_plus_one : std_logic_vector(4 downto 0) := (others => '0');
   signal row_in : std_logic_vector(8 downto 0) := (others => '0');

 	--Outputs
   signal chunk_addr : std_logic_vector(13 downto 0);
   signal rd_en : std_logic;
   signal cmd_en : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN

	chunk_index_plus_one <= std_logic_vector(unsigned(chunk_addr(4 downto 0)) + 1);
	
	-- Instantiate the Unit Under Test (UUT)
   uut: SegReadSM PORT MAP (
          rd_empty => rd_empty,
          clk => clk,
          disp_en => disp_en,
          v_sync => v_sync,
          rd_count => rd_count,
          chunk_index_plus_one => chunk_index_plus_one,
          row_in => row_in,
          chunk_addr => chunk_addr,
          rd_en => rd_en,
          cmd_en => cmd_en
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
	
	rc_count_proc: process(clk) is begin
		if rising_edge(clk) and rd_en = '1' and unsigned(rd_count) /= 0 then
			rd_count <= std_logic_vector(unsigned(rd_count) - 1);
		end if;
	end process rc_count_proc;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here
		for f in 0 to 3 loop
			for r in 0 to 3 loop
				disp_en <= '1';
				wait for clk_period*((2**5)+6);
				rd_empty <= '0';
				rd_count <= "1111111";
				wait for clk_period*4;
				disp_en <= '0';
				
				wait until rd_count = "0000000";
				
				wait for clk_period*4;
				
				rd_empty <= '1';
			end loop;
			wait for clk_period*10;
			v_sync <= '1';
			wait for clk_period*10;
			v_sync <= '0';
			wait for clk_period*100;
		end loop;
		
		
		

      wait;
   end process;

END;
