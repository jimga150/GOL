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
use IEEE.std_logic_textio.all;
use std.textio.all;

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
        variable v_line : line;
    begin
        write(v_line, i_slv);
        read(v_line, v_ans);
        return v_ans;
    end function;

end string_pkg;
