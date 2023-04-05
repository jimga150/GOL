----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/03/2023 09:07:51 PM
-- Design Name: 
-- Module Name: PS2_reader - Behavioral
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

entity PS2_reader is
    port(
        i_ps2_clk, i_ps2_dat : in std_logic;
        i_sys_clk, i_sys_rst : in std_logic;
        o_data : out std_logic_vector(7 downto 0);
        o_data_valid : out std_logic;
        o_data_error : out std_logic;
        i_ready : in std_logic
    );
end PS2_reader;

architecture Behavioral of PS2_reader is

    --includes parity bit
    signal s_ps2_word : std_logic_vector(8 downto 0);
    
    signal s_ps2_getting_word : boolean;
    signal s_ps2_bit_count : integer range 0 to 9;
    
    signal s_ps2_got_data : std_logic;
    
    signal s_sys_got_data : std_logic;
    signal s_sys_have_data : std_logic;
    signal s_sys_data_valid : std_logic;
    
    signal s_sys_word : std_logic_vector(s_ps2_word'range);
    
begin

    process(i_ps2_clk, i_sys_rst) is begin
        if (i_sys_rst = '1') then
            s_ps2_getting_word <= false;
            s_ps2_bit_count <= 0;
        elsif falling_edge(i_ps2_clk) then
            
            s_ps2_got_data <= '0';
        
            if ((not s_ps2_getting_word) and i_ps2_dat = '0') then
                s_ps2_getting_word <= true;
            elsif (s_ps2_getting_word) then
                s_ps2_word <= i_ps2_dat & s_ps2_word(s_ps2_word'high downto s_ps2_word'low+1);
                s_ps2_bit_count <= s_ps2_bit_count + 1;
                if (s_ps2_bit_count = 8) then --about to be 9 after this cycle
                    s_ps2_getting_word <= false;
                    s_ps2_bit_count <= 0;
                    s_ps2_got_data <= '1';
                end if;
            end if;
            
        end if;
    end process;
    
    gotdata_clk_cross: entity work.button_conditioner
    generic map(
        g_metastability_stages => 4,
        g_stable_cycles => 1 --don't need to debounce
    )
    port map(
        i_clk => i_sys_clk,
        i_rst => i_sys_rst,
        i_btn => s_ps2_got_data,
        o_pos_pulse => s_sys_got_data
    );
    
    process(i_sys_clk) is begin
        if rising_edge(i_sys_clk) then
            
            if (s_sys_got_data = '1') then
                s_sys_word <= s_ps2_word;
                s_sys_have_data <= '1';
            end if;
            
            if (s_sys_have_data = '1') then
                --odd parity: if the parity is even, there is an error
                o_data_error <= xnor s_sys_word;
                s_sys_data_valid <= '1';
                o_data <= s_sys_word(7 downto 0); --just the data bits, leave out parity bit (LSB)
            end if;
            
            if (s_sys_data_valid = '1' and i_ready = '1') then
                s_sys_have_data <= '0';
                s_sys_data_valid <= '0';
            end if;
            
            if (i_sys_rst = '1') then
                s_sys_have_data <= '0';
                s_sys_data_valid <= '0';
                o_data_error <= '0';
            end if;
            
        end if;
    end process;
    
    o_data_valid <= s_sys_data_valid;

end Behavioral;
