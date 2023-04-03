library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package type_pkg is
    
    pure function bool_to_std_logic(i_bool : boolean) return std_logic; 
    
end type_pkg;

package body type_pkg is

    pure function bool_to_std_logic(i_bool : boolean) return std_logic is begin
        if (i_bool) then
            return '1';
        else
            return '0';
        end if;
    end function;

end type_pkg;
