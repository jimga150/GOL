----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/03/2022 10:10:02 AM
-- Design Name: 
-- Module Name: rand_pkg - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

package rand_pkg is
    impure function rand_std_logic return std_logic;
    impure function rand_slv(len : integer) return std_logic_vector;
end rand_pkg;

package body rand_pkg is

    shared variable v_seed1, v_seed2 : positive := 1;
    shared variable v_r : real;

    impure function rand_std_logic return std_logic is
        variable v_ans : std_logic := '0';
    begin
        uniform(v_seed1, v_seed2, v_r);
        if (v_r > 0.5) then
            v_ans := '1';
        end if;
        return v_ans;
    end function;

    impure function rand_slv(len : integer) return std_logic_vector is
        variable v_ans : std_logic_vector(len - 1 downto 0);
    begin
        for i in v_ans'range loop
            v_ans(i) := rand_std_logic;
        end loop;
        return v_ans;
    end function;
end rand_pkg;
