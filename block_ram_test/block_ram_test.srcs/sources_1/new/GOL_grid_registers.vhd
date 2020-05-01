----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/05/2020 09:44:15 AM
-- Design Name: 
-- Module Name: GOL_grid_registers - Structural
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

entity GOL_grid_registers is
    Port ( clk, rst : in STD_LOGIC;
           enables : in STD_LOGIC_VECTOR (8 downto 0);
           row_in : in STD_LOGIC_VECTOR (63 downto 0);
           gd_r0 : out STD_LOGIC_VECTOR (65 downto 0);
           gd_r1 : out STD_LOGIC_VECTOR (65 downto 0);
           gd_r2 : out STD_LOGIC_VECTOR (65 downto 0));
end GOL_grid_registers;

-- ------------- Row
-- | 0 | 1 | 2 |  |
-- -------------  |
-- | 3 | 4 | 5 |  |
-- -------------  v
-- | 6 | 7 | 8 |
-- ------------- 
-- Col -->

architecture Structural of GOL_grid_registers is

    signal row_0 : std_logic_vector(65 downto 0) := (others => '0');
    signal row_1 : std_logic_vector(65 downto 0) := (others => '0');
    signal row_2 : std_logic_vector(65 downto 0) := (others => '0');

begin

    gd_r0 <= row_0;
    gd_r1 <= row_1;
    gd_r2 <= row_2;

    process(clk) is begin
        if rising_edge(clk) then
            if rst = '1' then
                row_0 <= (others => '0');
                row_1 <= (others => '0');
                row_2 <= (others => '0');
            else
                if enables(0) = '1' then
                    row_0(0) <= row_in(63);
                end if;
                
                if enables(1) = '1' then
                    row_0(64 downto 1) <= row_in;
                end if;
                
                if enables(2) = '1' then
                    row_0(65) <= row_in(0);
                end if;
                
                if enables(3) = '1' then
                    row_1(0) <= row_in(63);
                end if;
                
                if enables(4) = '1' then
                    row_1(64 downto 1) <= row_in;
                end if;
                
                if enables(5) = '1' then
                    row_1(65) <= row_in(0);
                end if;
                
                if enables(6) = '1' then
                    row_2(0) <= row_in(63);
                end if;
                
                if enables(7) = '1' then
                    row_2(64 downto 1) <= row_in;
                end if;
                
                if enables(8) = '1' then
                    row_2(65) <= row_in(0);
                end if;
            end if;
        end if;
    end process;

end Structural;
