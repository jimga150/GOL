----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/18/2020 01:20:42 PM
-- Design Name: 
-- Module Name: bitstring_sum_tb - Behavioral
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

entity bitstring_sum_tb is
--  Port ( );
end bitstring_sum_tb;

architecture Behavioral of bitstring_sum_tb is

component bitstring_sum
port (
    bit_string : in std_logic_vector(7 downto 0);
    two, three : out std_logic
);
end component;

signal bit_string : std_logic_vector(7 downto 0) := (others => '0');
signal two, three : std_logic;

begin

    uut : bitstring_sum
    port map (
        bit_string => bit_string,
        two => two,
        three => three
    );

    stim_proc: process is begin
        for i in 0 to (2**8)-1 loop
            bit_string <= std_logic_vector(to_unsigned(i, 8));
            wait for 10ns;
        end loop;
    end process stim_proc;

end Behavioral;
