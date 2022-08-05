----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/03/2022 10:07:20
-- Design Name: GOL_chunk_logic_tb
-- Module Name: GOL_chunk_logic_tb - Behavioral
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
use work.string_pkg.all;
use work.GOL_pkg.all;
use work.rand_pkg.all;

entity GOL_chunk_logic_tb is
end GOL_chunk_logic_tb;

architecture Behavioral of GOL_chunk_logic_tb is
	
	--General inputs
	signal i_chunk : t_chunk_type := (others => (others => '0'));
	signal i_top_row : std_logic_vector(c_chunk_width-1 downto 0) := (others => '0');
	signal i_bottom_row : std_logic_vector(c_chunk_width-1 downto 0) := (others => '0');
	signal i_left_col : std_logic_vector(c_chunk_height-1 downto 0) := (others => '0');
	signal i_right_col : std_logic_vector(c_chunk_height-1 downto 0) := (others => '0');
	signal i_top_left_bit : std_logic := '0';
	signal i_top_right_bit : std_logic := '0';
	signal i_bottom_left_bit : std_logic := '0';
	signal i_bottom_right_bit : std_logic := '0';
	
	--Outputs
	signal o_chunk : t_chunk_type;
	
begin
	
	UUT: entity work.GOL_chunk_logic
	port map(
		i_chunk => i_chunk,
		i_top_row => i_top_row,
		i_bottom_row => i_bottom_row,
		i_left_col => i_left_col,
		i_right_col => i_right_col,
		i_top_left_bit => i_top_left_bit,
		i_top_right_bit => i_top_right_bit,
		i_bottom_left_bit => i_bottom_left_bit,
		i_bottom_right_bit => i_bottom_right_bit,
		o_chunk => o_chunk
	);
	
	
    stim_proc: process is 
        variable v_expected_chunk_out : t_chunk_type;
        variable v_pass : boolean := true;
    begin
    
        --Insert stimuli here
        wait for 10 ns;
        
        for i in 0 to 1000 loop
            for r in 0 to c_chunk_height - 1 loop
                i_chunk(r) <= rand_slv(i_chunk(r)'length);
            end loop;
            i_top_row <= rand_slv(i_top_row'length);
            i_bottom_row <= rand_slv(i_bottom_row'length);
            i_left_col <= rand_slv(i_left_col'length);
            i_right_col <= rand_slv(i_right_col'length);
            i_top_left_bit <= rand_std_logic;
            i_top_right_bit <= rand_std_logic;
            i_bottom_left_bit <= rand_std_logic;
            i_bottom_right_bit <= rand_std_logic;
            
            wait for 10 ns;
            
            --verify answer
            
            v_expected_chunk_out := 
                get_next_chunk(i_chunk, i_top_row, i_bottom_row, i_left_col, i_right_col, 
                    i_top_left_bit, i_top_right_bit, i_bottom_left_bit, i_bottom_right_bit);
            
            if (v_expected_chunk_out /= o_chunk) then
                v_pass := false;
                report "At time " & time'image(now) & ":";
                
                report "Input:";
                report std_logic'image(i_top_left_bit) & slv_to_string(i_top_row) & std_logic'image(i_top_right_bit); 
                for r in i_chunk'low to i_chunk'high loop
                    report std_logic'image(i_left_col(r)) & slv_to_string(i_chunk(r)) & std_logic'image(i_right_col(r));
                end loop;
                report std_logic'image(i_bottom_left_bit) & slv_to_string(i_bottom_row) & std_logic'image(i_bottom_right_bit);
                
                report "Expected output:";
                for r in v_expected_chunk_out'low to v_expected_chunk_out'high loop
                    report slv_to_string(v_expected_chunk_out(r));
                end loop;
                
                report "Actual output:";
                for r in o_chunk'low to o_chunk'high loop
                    report slv_to_string(o_chunk(r));
                end loop;
            end if;
            
        end loop;
        
        assert v_pass report "Test Failed" severity failure;
        assert false report "Test Passed" severity failure;
        
        -- Not strictly necessary, but prevents process from looping 
        -- if the above assert statement is removed
        wait;
    
    end process;

end Behavioral;
