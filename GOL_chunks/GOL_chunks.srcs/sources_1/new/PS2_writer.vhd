----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/05/2023 09:39:11 PM
-- Design Name: 
-- Module Name: PS2_writer - Behavioral
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

entity PS2_writer is
    generic(
        g_sys_clk_f : integer := 100_000_000;
        g_parity_odd : boolean := true
    );
    port(
        i_sys_clk : in std_logic;
        i_sys_rst : in std_logic;
        o_ps2_clk : out std_logic;
        i_ps2_clk : in std_logic;
        o_ps2_clk_oe : out std_logic;
        o_ps2_data : out std_logic;
        i_ps2_data : in std_logic;
        o_ps2_data_oe : out std_logic;
        o_busy : out std_logic;
        i_data : in std_logic_vector(7 downto 0);
        i_valid : in std_logic;
        o_ready : out std_logic
    );
end PS2_writer;

architecture Behavioral of PS2_writer is

    --got procedure from https://web.archive.org/web/20150108222648/http://www.computer-engineering.org/ps2protocol/
    type t_state_type is (
        IDLE,
        PULL_CLK_LOW,
        RTS,
        WAIT_CLK_LOW_START,
        DATA,
        PARITY,
        WAIT_DATA_LOW,
        WAIT_CLK_LOW_STOP,
        WAIT_CLK_DATA_HIGH
    );
    constant c_reset_state : t_state_type := IDLE;
    signal s_state : t_state_type;

    signal s_data : std_logic_vector(i_data'range);
    signal s_parity : std_logic;
    
    constant c_100us_cnt : integer := g_sys_clk_f/10_000;
    constant c_20us_cnt : integer := g_sys_clk_f/50_000;
    
    signal s_timeout_counter : integer range 0 to c_100us_cnt;
    signal s_falling_edge : std_logic;
    signal s_rising_edge : std_logic;
    signal s_sys_ps2_data : std_logic;
    
    signal s_data_count : integer range s_data'low to s_data'high;

begin

    ps2_clk_sync: entity work.button_conditioner
    generic map(
        g_metastability_stages => 4,
        g_stable_cycles => 1
    )
    port map(
        i_clk => i_sys_clk,
        i_rst => i_sys_rst,
        i_btn =>  to_UX01(i_ps2_clk),
        o_pos_pulse => s_rising_edge,
        o_neg_pulse => s_falling_edge
    );
    
    ps2_dat_sync: entity work.button_conditioner
    generic map(
        g_metastability_stages => 4,
        g_stable_cycles => 1
    )
    port map(
        i_clk => i_sys_clk,
        i_rst => i_sys_rst,
        i_btn => to_UX01(i_ps2_data),
        o_debounced => s_sys_ps2_data
    );

    process(i_sys_clk) is begin
        if rising_edge(i_sys_clk) then
        
            if (g_parity_odd) then
                s_parity <= xnor s_data;
            else
                s_parity <= xor s_data;
            end if;
            
            o_ps2_clk_oe <= '0';
            o_ps2_data_oe <= '0';
            
            case(s_state) is
                when IDLE =>
                    if (i_valid = '1') then
                        s_data <= i_data;
                        s_state <= PULL_CLK_LOW;
                        s_timeout_counter <= 0;
                    end if;
                when PULL_CLK_LOW =>
                    o_ps2_clk_oe <= '1';
                    o_ps2_clk <= '0';
                    s_timeout_counter <= s_timeout_counter + 1;
                    if (s_timeout_counter = c_100us_cnt) then
                        s_state <= RTS;
                        s_timeout_counter <= 0;
                    end if;
                when RTS =>
                    o_ps2_clk_oe <= '1';
                    o_ps2_clk <= '0';
                    o_ps2_data_oe <= '1';
                    o_ps2_data <= '0';
                    s_timeout_counter <= s_timeout_counter + 1;
                    if (s_timeout_counter = c_20us_cnt) then
                        s_state <= WAIT_CLK_LOW_START;
                    end if;
                when WAIT_CLK_LOW_START =>
                    o_ps2_data_oe <= '1';
                    o_ps2_data <= '0';
                    if (s_falling_edge) then
                        s_state <= DATA;
                        s_data_count <= 0;
                    end if;
                when DATA =>
                    o_ps2_data_oe <= '1';
                    o_ps2_data <= s_data(s_data_count);
                    if (s_falling_edge = '1') then
                        s_data_count <= s_data_count + 1;
                        if (s_data_count = s_data'high) then
                            s_state <= PARITY;
                        end if;
                    end if;
                when PARITY =>
                    o_ps2_data_oe <= '1';
                    o_ps2_data <= s_parity;
                    if (s_falling_edge = '1') then
                        s_state <= WAIT_DATA_LOW;
                    end if;
                when WAIT_DATA_LOW =>
                    if (s_sys_ps2_data = '0') then
                        s_state <= WAIT_CLK_LOW_STOP;
                    end if;
                when WAIT_CLK_LOW_STOP =>
                    if (s_falling_edge = '1') then
                        s_state <= WAIT_CLK_DATA_HIGH;
                    end if;
                when WAIT_CLK_DATA_HIGH =>
                    if (s_sys_ps2_data = '1') then
                        s_state <= IDLE;
                    end if;
            end case;
            
            if (i_sys_rst = '1') then
                s_state <= c_reset_state;
                o_ps2_clk_oe <= '0';
                o_ps2_data_oe <= '0';
            end if;
            
        end if;
    end process;
    
    o_busy <= '1' when s_state /= IDLE else '0';
    o_ready <= '1' when s_state = IDLE else '0';

end Behavioral;
