----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/21/2023 11:02:30 PM
-- Design Name: 
-- Module Name: binary_grey_convert_tb - Behavioral
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity binary_grey_convert_tb is
end binary_grey_convert_tb;

architecture Behavioral of binary_grey_convert_tb is

    pure function binary_to_grey(
        i_binary : std_logic_vector
    ) return std_logic_vector is
        variable v_ans : std_logic_vector(i_binary'range);
    begin
        v_ans(i_binary'high) := i_binary(i_binary'high);
        for lv_i in i_binary'high-1 downto 0 loop
            v_ans(lv_i) := i_binary(lv_i) xor i_binary(lv_i+1);
        end loop;
        return v_ans;
    end function;
    
    pure function grey_to_binary(
        i_grey : std_logic_vector
    ) return std_logic_vector is
        variable v_ans : std_logic_vector(i_grey'range);
        variable v_xor_result : std_logic := '0';
    begin
        for lv_i in i_grey'range loop
            v_xor_result := v_xor_result xor i_grey(lv_i);
            v_ans(lv_i) := v_xor_result;
        end loop;
        return v_ans;
    end function;
    
    pure function count_ones(
        i_slv : in std_logic_vector
    ) return natural is
        variable v_ans : natural := 0;
    begin
        for lv_i in i_slv'range loop
            if (i_slv(lv_i) = '1') then
                v_ans := v_ans + 1;
            end if;
        end loop;
        return v_ans;
    end function;
    
    signal s_binary, s_grey : std_logic_vector(7 downto 0);
    signal s_binary_last, s_grey_last : std_logic_vector(s_binary'range);
    signal s_binary_reconv : std_logic_vector(s_binary'range);

begin
    
    stim_proc: process is
        variable v_grey_xor : std_logic_vector(s_grey'range);
        variable v_error : boolean := false;
    begin
    
        s_binary <= (others => '1');
        wait for 0 ns;
        s_grey <= binary_to_grey(s_binary);
        wait for 0 ns;
        
        --Insert stimuli here
        for i in 0 to (2**s_binary'length) - 1 loop
        
            s_binary <= std_logic_vector(to_unsigned(i, s_binary'length));
            s_binary_last <= s_binary;
            wait for 0 ns;
            
            s_grey <= binary_to_grey(s_binary);
            s_grey_last <= s_grey;
            wait for 0 ns;
            
            v_grey_xor := s_grey xor s_grey_last;
            if (count_ones(v_grey_xor) /= 1) then
                report "Incorrect grey code transition detected:" severity error;
                report "prev bin: " & to_string(s_binary_last) & 
                        "; prev grey: " & to_string(s_grey_last) severity error;
                report "curr bin: " & to_string(s_binary) & 
                        "; curr grey: " & to_string(s_grey) severity error;
                v_error := true;
            end if;
            wait for 0 ns;
            
            s_binary_reconv <= grey_to_binary(s_grey);
            wait for 0 ns;
            
            if (s_binary_reconv /= s_binary) then
                report "Reconverted binary code doesn't match original binary!" severity error;
                report "Orig: " & to_string(s_binary) & "; Reconverted: " & to_string(s_binary_reconv) severity error;
                v_error := true;
            end if;
            wait for 10 ns;
            
        end loop;
        
        if (v_error) then
            assert false report "Test Failed" severity failure;
        end if;
        assert false report "Test Passed!" severity failure;
        
        -- Not strictly necessary, but prevents process from looping 
        -- if the above assert statement is removed
        wait;
        
    end process;

end Behavioral;
