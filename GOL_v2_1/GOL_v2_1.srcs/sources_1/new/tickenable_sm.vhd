----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/27/2020 05:14:06 PM
-- Design Name: 
-- Module Name: tickenable_sm - Behavioral
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

entity tickenable_sm is
    Port ( 
        clk, rst, tick_signal : in STD_LOGIC;
        en : out STD_LOGIC
    );
end tickenable_sm;

architecture Behavioral of tickenable_sm is

    type state_type is (IDLE, ENABLE_CLK, WAIT_FOR_TS_LOW);
    signal state, nextstate : state_type := IDLE;

begin
    
    sync_proc: process(clk, rst) is begin
        if (rst = '1') then
            state <= IDLE;
        elsif rising_edge(clk) then
            state <= nextstate;
        end if;
    end process sync_proc;
    
    nextstate_proc: process(state, tick_signal) is begin
        case state is 
            when IDLE => 
                case tick_signal is
                    when '0' => nextstate <= IDLE;
                    when others => nextstate <= ENABLE_CLK;
                end case;
                
            when ENABLE_CLK => nextstate <= WAIT_FOR_TS_LOW;
            
            when WAIT_FOR_TS_LOW => 
                case tick_signal is 
                    when '0' => nextstate <= IDLE;
                    when others => nextstate <= WAIT_FOR_TS_LOW;
                end case;
                
        end case;
    end process nextstate_proc;

    output_proc: process(state) is begin
        case state is 
            when ENABLE_CLK => en <= '1';
            when others => en <= '0';
        end case;
    end process output_proc;
    
end Behavioral;
