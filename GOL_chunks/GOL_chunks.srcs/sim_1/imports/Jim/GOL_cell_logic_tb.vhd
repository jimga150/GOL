----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/02/2022 22:39:10
-- Design Name: GOL_cell_logic_tb
-- Module Name: GOL_cell_logic_tb - Behavioral
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

use work.string_pkg.all;
use work.GOL_pkg.all;

entity GOL_cell_logic_tb is
end GOL_cell_logic_tb;

architecture Behavioral of GOL_cell_logic_tb is
	
	--General inputs
	signal i_top_left : std_logic := '0';
	signal i_top_center : std_logic := '0';
	signal i_top_right : std_logic := '0';
	signal i_middle_left : std_logic := '0';
	signal i_center : std_logic := '0';
	signal i_middle_right : std_logic := '0';
	signal i_bottom_left : std_logic := '0';
	signal i_bottom_center : std_logic := '0';
	signal i_bottom_right : std_logic := '0';
	
	--Outputs
	signal o_cell : std_logic;
	
begin
	
	UUT: entity work.GOL_cell_logic
	port map(
		i_top_left => i_top_left,
		i_top_center => i_top_center,
		i_top_right => i_top_right,
		i_middle_left => i_middle_left,
		i_center => i_center,
		i_middle_right => i_middle_right,
		i_bottom_left => i_bottom_left,
		i_bottom_center => i_bottom_center,
		i_bottom_right => i_bottom_right,
		o_cell => o_cell
	);
	
	
    stim_proc: process is 
        variable v_i_slv : std_logic_vector(8 downto 0);
        variable v_exp_cell : std_logic;
        variable v_pass : boolean := true;
    begin
    
        wait for 10 ns;
        
        --Insert stimuli here
        
        for i in 0 to 2**9 - 1 loop
            v_i_slv := std_logic_vector(to_unsigned(i, v_i_slv'length));
            i_top_left <= v_i_slv(1);
            i_top_center <= v_i_slv(2);
            i_top_right <= v_i_slv(3);
            i_middle_left <= v_i_slv(4);
            i_center <= v_i_slv(0);
            i_middle_right <= v_i_slv(5);
            i_bottom_left <= v_i_slv(6);
            i_bottom_center <= v_i_slv(7);
            i_bottom_right <= v_i_slv(8);
            
            wait for 10 ns;
            
            v_exp_cell := get_next_cell(i_center, v_i_slv(8 downto 1));
              
            if (v_exp_cell /= o_cell) then
                assert false 
                    report "For input " & slv_to_string(v_i_slv) & ": expected output " & 
                        std_logic'image(v_exp_cell) & ", got " & std_logic'image(o_cell) 
                    severity warning;
                v_pass := false;
            end if;
                
        end loop;
        
        assert v_pass report "Test failed!" severity failure;
        assert false report "Test Passed" severity failure;
        
        -- Not strictly necessary, but prevents process from looping 
        -- if the above assert statement is removed
        wait;
    
    end process;

end Behavioral;
