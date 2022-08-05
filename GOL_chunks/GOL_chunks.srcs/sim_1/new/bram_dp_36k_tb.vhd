----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/27/2022 21:30:25
-- Design Name: bram_dp_36k_tb
-- Module Name: bram_dp_36k_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: Created with VHDL Test Bench Template Generator
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bram_dp_36k_tb is
end bram_dp_36k_tb;

architecture Behavioral of bram_dp_36k_tb is
	
	--Clocks
	signal clk : STD_LOGIC := '0';
	
	--General inputs
	signal ena : STD_LOGIC := '0';
	signal wea : STD_LOGIC := '0';
	signal addra : STD_LOGIC_VECTOR(9 DOWNTO 0) := (others => '0');
	signal dina : STD_LOGIC_VECTOR(35 DOWNTO 0) := (others => '0');
	signal enb : STD_LOGIC := '0';
	signal web : STD_LOGIC := '0';
	signal addrb : STD_LOGIC_VECTOR(9 DOWNTO 0) := (others => '0');
	signal dinb : STD_LOGIC_VECTOR(35 DOWNTO 0) := (others => '0');
	
	--Outputs
	signal douta : STD_LOGIC_VECTOR(35 DOWNTO 0);
	signal doutb : STD_LOGIC_VECTOR(35 DOWNTO 0);
	
	--Clock Periods
	constant clk_period : time := 10 ns;
	
begin
	
	UUT: entity work.bram_dp_36k
	port map(
		i_clka => clk,
		i_ena => ena,
		i_wea => wea,
		i_addra => addra,
		i_dina => dina,
		o_douta => douta,
		i_clkb => clk,
		i_enb => enb,
		i_web => web,
		i_addrb => addrb,
		i_dinb => dinb,
		o_doutb => doutb
	);
	
	--Clock Drivers
	clk <= not clk after clk_period/2;
	
	stim_proc: process is begin
		
		wait for clk_period;
				
		for i in 0 to 15 loop
		  ena <= '1';
		  wea <= '1';
		  addra <= std_logic_vector(to_unsigned(i, addra'length));
		  dina <= std_logic_vector(to_unsigned(i, dina'length));
		  wait for clk_period;
		end loop;
		
		ena <= '0';
		wea <= '0';
		wait for clk_period;
		
		for i in 0 to 15 loop
		  ena <= '1';
		  addra <= std_logic_vector(to_unsigned(i, addra'length));
		  wait for clk_period;
		end loop;
		
		ena <= '0';
		wait for clk_period;
		
		for i in 0 to 15 loop
		  enb <= '1';
		  addrb <= std_logic_vector(to_unsigned(i, addrb'length));
		  wait for clk_period;
		end loop;
		
		enb <= '0';
		wait for clk_period;
		
		for i in 0 to 15 loop
		  enb <= '1';
		  web <= '1';
		  addrb <= std_logic_vector(to_unsigned(i, addrb'length));
		  dinb <= std_logic_vector(to_unsigned(i, dinb'length));
		  wait for clk_period;
		end loop;
		
		enb <= '0';
		web <= '0';
		wait for clk_period;
		
		for i in 0 to 15 loop
		  enb <= '1';
		  addrb <= std_logic_vector(to_unsigned(i, addrb'length));
		  wait for clk_period;
		end loop;
		
		wait for clk_period*2;
		
		assert false report "End Simulation" severity failure;
		
		-- Not strictly necessary, but prevents process from looping 
		-- if the above assert statement is removed
		wait;
		
	end process;

end Behavioral;
