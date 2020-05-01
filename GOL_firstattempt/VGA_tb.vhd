--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:07:39 02/19/2019
-- Design Name:   
-- Module Name:   E:/Code/VHDL/GOL/VGA_tb.vhd
-- Project Name:  GOL
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: vga_controller
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
 
ENTITY VGA_tb IS
END VGA_tb;
 
ARCHITECTURE behavior OF VGA_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT vga_controller
    PORT(
         pixel_clk : IN  std_logic;
         reset_n : IN  std_logic;
         h_sync : OUT  std_logic;
         v_sync : OUT  std_logic;
         disp_ena : OUT  std_logic;
         column : OUT  STD_LOGIC_VECTOR (10 downto 0);
         row : OUT  STD_LOGIC_VECTOR (10 downto 0);
         n_blank : OUT  std_logic;
         n_sync : OUT  std_logic
        );
    END COMPONENT;
	 
	 component image_source
	 Port ( chunk : in  STD_LOGIC_VECTOR (31 downto 0);
			  chunk_index : in  STD_LOGIC_VECTOR (5 downto 0);
           clk, we : in  STD_LOGIC;
           col : in  STD_LOGIC_VECTOR (10 downto 0);
           pixel : out  STD_LOGIC
			 );
	end component;
    

   --Inputs
   signal pixel_clk : std_logic := '0';
   signal reset_n : std_logic := '0';
	
	signal chunk : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
	signal chunk_index : STD_LOGIC_VECTOR (5 downto 0) := (others => '0');
   signal clk, we : STD_LOGIC := '0';
	
	signal pixel_clk_en : std_logic := '0';

 	--Outputs
   signal h_sync, pixel : std_logic;
   signal v_sync : std_logic;
   signal disp_ena : std_logic;
   --signal column_vect : std_logic_vector(10 downto 0);
   signal row, col : STD_LOGIC_VECTOR (10 downto 0);
   signal n_blank : std_logic;
   signal n_sync : std_logic;

   -- Clock period definitions
   constant pixel_clk_period : time := 6.81818 ns;
	constant sys_clk_period : time := 10 ns;
 
BEGIN
 
	--column_vect <= std_logic_vector(to_unsigned(col, 11));
 
	-- Instantiate the Unit Under Test (UUT)
   uut1: vga_controller PORT MAP (
          pixel_clk => pixel_clk,
          reset_n => reset_n,
          h_sync => h_sync,
          v_sync => v_sync,
          disp_ena => disp_ena,
          column => col,
          row => row,
          n_blank => n_blank,
          n_sync => n_sync
        );
	
	uut2: image_source PORT MAP (
		chunk => chunk,
		chunk_index => chunk_index,
      clk => clk, 
		we => we,
      col => col,--umn_vect,
      pixel => pixel
	);

   -- Clock process definitions
   pixel_clk_process :process
   begin
		pixel_clk <= '0';
		wait for pixel_clk_period/2;
		pixel_clk <= pixel_clk_en;
		wait for pixel_clk_period/2;
   end process;
	
	sys_clk_process :process
   begin
		clk <= '0';
		wait for sys_clk_period/2;
		clk <= '1';
		wait for sys_clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
		reset_n <= '1';

      wait for sys_clk_period*10;

      -- insert stimulus here 
		
		chunk <= "10101010101010101010101010101010";
		we <= '1';
		
		for ci in 0 to (2**6)-1 loop
			chunk_index <= std_logic_vector(to_unsigned(ci, 8));
			report integer'image(ci);
			wait for sys_clk_period;
		end loop;
		
		report "End Write";
		
		we <= '0';
		
		pixel_clk_en <= '1';
		
		wait for pixel_clk_period*100;
		
		report "End Simulation" severity failure;
		
      wait;
   end process;

END;
