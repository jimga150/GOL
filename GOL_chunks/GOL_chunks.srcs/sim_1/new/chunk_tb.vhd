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
        
        assert v_pass report "Test failed" severity failure;
        assert false report "Test passed" severity failure;
        
        wait;
    end process;


end Behavioral;
