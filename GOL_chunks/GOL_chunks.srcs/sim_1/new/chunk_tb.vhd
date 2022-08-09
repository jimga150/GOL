----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/03/2022 03:48:05 PM
-- Design Name: 
-- Module Name: chunk_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

use work.GOL_pkg.all;
use work.rand_pkg.all;
use work.string_pkg.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity chunk_tb is
--  Port ( );
end chunk_tb;

architecture Behavioral of chunk_tb is

begin

    process is
    
        constant c_init_filename : string := c_project_path & "\GOL_mem_init_files\vline_plussome.gmif";
        constant c_field_arr : t_2d_chunk_array := chunk_2d_arr_from_gmif(c_init_filename); 
        constant c_block_chunk_arr : t_2d_chunk_array(c_block_num_chunk_rows-1 downto 0, c_block_num_chunk_cols-1 downto 0) := block_chunk_arr_from_field(c_field_arr, 0, 0);
        constant c_block01_chunk_arr : t_2d_chunk_array(c_block_num_chunk_rows-1 downto 0, c_block_num_chunk_cols-1 downto 0) := block_chunk_arr_from_field(c_field_arr, 0, 1);
        constant c_block10_chunk_arr : t_2d_chunk_array(c_block_num_chunk_rows-1 downto 0, c_block_num_chunk_cols-1 downto 0) := block_chunk_arr_from_field(c_field_arr, 1, 0);
        constant c_block11_chunk_arr : t_2d_chunk_array(c_block_num_chunk_rows-1 downto 0, c_block_num_chunk_cols-1 downto 0) := block_chunk_arr_from_field(c_field_arr, 1, 1);
    
        variable v_slv1, v_slv2 : std_logic_vector(35 downto 0);
        variable v_chunk : t_chunk_type;
        variable v_pass : boolean := true;
        
    begin
    
        wait for 10 ns;
    
        for i in 1 to 100 loop
        
            v_slv1 := rand_slv(v_slv1'length);
            v_chunk := vector_to_chunk(v_slv1);
            v_slv2 := chunk_to_vector(v_chunk);
            
            if (v_slv1 /= v_slv2) then
                v_pass := false;
                report "Time: " & time'image(now);
                report "Input: " & slv_to_string(v_slv1) & ", output: " & slv_to_string(v_slv2);
            end if;
            
            wait for 10 ns;
        end loop;
        
--        v_chunk := (
--		  0 => "000010",
--		  1 => "000100",
--		  2 => "000111",
--		  others => (others => '0')
--		);
----		report "0th row in chunk: " & slv_to_string(v_chunk(0));
--		report slv_to_string(chunk_to_vector(v_chunk));
		
--		v_chunk := (
--		  0 => "000100",
--		  1 => "001000",
--		  2 => "001110",
--		  others => (others => '0')
--		);
--		report slv_to_string(chunk_to_vector(v_chunk));
		
		v_chunk := (
		  "000011",
		  "000011",
		  others => (others => '0')
		);
		report "(0, 0): " & slv_to_string(chunk_to_vector(v_chunk));
		
		v_chunk := (
		  "010000",
		  "010000",
		  "100000",
		  others => (others => '0')
		);
		report "(0, 1): " & slv_to_string(chunk_to_vector(v_chunk));
		
		v_chunk := (
		  "110100",
		  "010000",
		  "001000",
		  "000011",
		  others => (others => '0')
		);
		report "(0, 2): " & slv_to_string(chunk_to_vector(v_chunk));
		
		v_chunk := (
		  "010000",
		  "001100",
		  "001100",
		  "001100",
		  "010000",
		  others => (others => '0')
		);
		report "(0, 3): " & slv_to_string(chunk_to_vector(v_chunk));
		
		v_chunk := (
		  "000001",
		  "000000",
		  "000000",
		  "000000",
		  "000001",
		  "000001"
		);
		report "(0, 4): " & slv_to_string(chunk_to_vector(v_chunk));
		
		v_chunk := (
		  "000000",
		  "000000",
		  "110000",
		  "110000",
		  others => (others => '0')
		);
		report "(0, 5): " & slv_to_string(chunk_to_vector(v_chunk));
		
		v_chunk := (
		  others => (others => '0')
		);
		report "(1, 0): " & slv_to_string(chunk_to_vector(v_chunk));
		
		v_chunk := (
		  "000000",
		  "000000",
		  "000000",
		  "000000",
		  "100000",
		  "010000"
		);
		report "(1, 1): " & slv_to_string(chunk_to_vector(v_chunk));
		
		v_chunk := (
		  "000000",
		  "000000",
		  "000000",
		  "000011",
		  "001000",
		  "010000"
		);
		report "(1, 2): " & slv_to_string(chunk_to_vector(v_chunk));
		
		v_chunk := (
		  others => (others => '0')
		);
		report "(1, 3): " & slv_to_string(chunk_to_vector(v_chunk));
		
		v_chunk := (
		  "000000",
		  "000000",
		  "000000",
		  "000000",
		  "000000",
		  "000001"
		);
		report "(1, 4): " & slv_to_string(chunk_to_vector(v_chunk));
        
        assert v_pass report "Test failed" severity failure;
        assert false report "Test passed" severity failure;
        
        wait;
    end process;


end Behavioral;
