----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:49:55 02/12/2019 
-- Design Name: 
-- Module Name:    v_sync_tracker - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity v_sync_tracker is
    Port ( clk, rst, v_sync, disp_en : in  STD_LOGIC;
           v_sync_fired : out  STD_LOGIC);
end v_sync_tracker;

architecture Behavioral of v_sync_tracker is

	signal fired : std_logic := '0';

begin

	v_sync_fired <= fired;

	process(clk, rst) is begin
		if rst = '1' then
			fired <= '0';
		elsif rising_edge(clk) then
			if v_sync = '1' then
				fired <= '1';
			elsif disp_en = '1' then
				fired <= '0';
			end if;
		end if;
	end process;

end Behavioral;

