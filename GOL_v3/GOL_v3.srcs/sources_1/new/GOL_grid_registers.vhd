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
    generic(data_width : integer := 32);
    Port ( clk, rst, shift : in STD_LOGIC;
           enables : in STD_LOGIC_VECTOR (2 downto 0);
           row_in : in STD_LOGIC_VECTOR (data_width-1 downto 0);
           gd_r0 : out STD_LOGIC_VECTOR (data_width+1 downto 0);
           gd_r1 : out STD_LOGIC_VECTOR (data_width+1 downto 0);
           gd_r2 : out STD_LOGIC_VECTOR (data_width+1 downto 0));
end GOL_grid_registers;

--   0   1   2
-- ------------- Row
-- | 0 | 1 | 2 |  |  0
-- -------------  |
-- | 3 | 4 | 5 |  |  1
-- -------------  v
-- | 6 | 7 | 8 |     2
-- ------------- 
-- Col -->

architecture Structural of GOL_grid_registers is

    type grid_reg_type is array(2 downto 0, 2 downto 0) of std_logic_vector(data_width-1 downto 0);
    signal grid_regs : grid_reg_type := (others => (others => (others => '0')));

begin

    gd_r0 <= grid_regs(0, 0)(0) &  grid_regs(0, 1) &  grid_regs(0, 2)(data_width-1);
    gd_r1 <= grid_regs(1, 0)(0) &  grid_regs(1, 1) &  grid_regs(1, 2)(data_width-1);
    gd_r2 <= grid_regs(2, 0)(0) &  grid_regs(2, 1) &  grid_regs(2, 2)(data_width-1);

    process(clk) is begin
        if rising_edge(clk) then
            if rst = '1' then
                grid_regs <= (others => (others => (others => '0')));
            else
                if enables(0) = '1' then
                    grid_regs(0, 0) <= row_in;
                end if;
                
                if enables(1) = '1' then
                    grid_regs(1, 0) <= row_in;
                end if;
                
                if enables(2) = '1' then
                    grid_regs(2, 0) <= row_in;
                end if;
                
                if shift = '1' then
                    for r in 0 to 2 loop
                        grid_regs(r, 0) <= (others => '0');
                        for c in 1 to 2 loop
                            grid_regs(r, c) <= grid_regs(r, c-1);
                        end loop;
                    end loop;
                end if;
                
            end if;
        end if;
    end process;

end Structural;
