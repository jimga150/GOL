----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/03/2022 02:05:41 PM
-- Design Name: 
-- Module Name: string_pkg - Behavioral
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

package string_pkg is
    function slv_to_string(i_slv : std_logic_vector) return string;
end string_pkg;

package body string_pkg is

    function slv_to_string(i_slv : std_logic_vector) return string is
        variable v_ans : string(1 to i_slv'length);
        variable v_slv_idx : integer := 0;
    begin
        for i in v_ans'range loop
            v_slv_idx := i_slv'length - i;
            v_ans(i to i) := std_logic'image(i_slv(v_slv_idx));
        end loop;
        return v_ans;
    end function;

end string_pkg;
