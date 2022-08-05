----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/02/2022 11:00:23 AM
-- Design Name: 
-- Module Name: bram_model - Behavioral
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

use work.rand_pkg.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bram_model is
    port (
        i_clk : in std_logic;
        i_ena, i_we : in std_logic;
        i_addr : in std_logic_vector(9 downto 0);
        i_din : in std_logic_vector(35 downto 0);
        o_dout : out std_logic_vector(35 downto 0)
    );
end bram_model;

architecture Behavioral of bram_model is

    type t_ram_type is array(2**i_addr'length - 1 downto 0) of std_logic_vector(i_din'range);

    pure function init_ram return t_ram_type is
        variable v_ans : t_ram_type;
    begin
        for i in 0 to 2**i_addr'length - 1 loop
            v_ans(i) := rand_slv(v_ans(i)'length);
        end loop;
        return v_ans;
    end function;

    signal s_ram : t_ram_type := init_ram;
    
    signal s1_ena, s1_we : std_logic := '0';
    signal s1_addr : std_logic_vector(i_addr'range);
    signal s1_din : std_logic_vector(i_din'range);

begin

    process (i_clk) is begin
        if rising_edge(i_clk) then
        
            s1_ena <= i_ena;
            s1_we <= i_we;
            s1_addr <= i_addr;
            s1_din <= i_din;
            
            if (s1_ena = '1') then
                if (s1_we = '1') then
                    s_ram(to_integer(unsigned(s1_addr))) <= s1_din;
                    o_dout <= s1_din;
                else
                    o_dout <= s_ram(to_integer(unsigned(s1_addr)));
                end if;
            end if;
            
        end if;
    end process;

end Behavioral;
