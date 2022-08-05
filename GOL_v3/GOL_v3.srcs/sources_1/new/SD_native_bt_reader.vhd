----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/28/2020 12:03:47 PM
-- Design Name: 
-- Module Name: SD_native_bt_reader - Behavioral
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

entity SD_native_bt_reader is
    port(
        clk_100mhz, rst, start_btn, cont_btn : in std_logic;
        blk_addr : in std_logic_vector(15 downto 0);
        dout : out std_logic_vector(7 downto 0);
        error_code : out std_logic_vector(7 downto 0);
        error, busy, dout_valid : out std_logic;
        
        cs, mosi, sclk : out std_logic;
        miso : in std_logic
    );
end SD_native_bt_reader;

architecture Behavioral of SD_native_bt_reader is

    signal clk_50mhz : std_logic;
    
    signal start_dbcd, cont_dbcd, start_last, cont_last, start_pulse, cont_pulse : std_logic;
    
    signal blk_addr_full : std_logic_vector(31 downto 0);

begin

    blk_addr_full(31 downto 16) <= (others => '0');
    blk_addr_full(15 downto 0) <= blk_addr;

    controller: entity work.sd_controller_sy2002
    port map(
        cs => cs,
        mosi => mosi,
        miso => miso,
        sclk => sclk,
        clk => clk_50mhz,
        reset => rst, 
        rd_multiple => start_dbcd,
        dout => dout,
        dout_avail => dout_valid,
        dout_taken => cont_pulse,
        addr => blk_addr_full,
        sd_error => error,
        sd_busy => busy,
        sd_error_code => error_code
    );
    
    start_debouncer: entity work.debounce
    port map(
        clk => clk_50mhz,
        reset => rst,
        button => start_btn,
        result => start_dbcd
    );
    
    cont_debouncer: entity work.debounce
    port map(
        clk => clk_50mhz,
        reset => rst,
        button => cont_btn,
        result => cont_dbcd
    );
    
    clk_divider: process(clk_100mhz) is begin
        if rising_edge(clk_100mhz) then
            clk_50mhz <= not clk_50mhz;
        end if;
    end process clk_divider;
    
    pulse_proc: process(clk_50mhz) is begin
        if rising_edge(clk_50mhz) then
            start_last <= start_dbcd;
            cont_last <= cont_dbcd;
        end if;
    end process pulse_proc;
    
    start_pulse <= '1' when (start_dbcd and not start_last) = '1' else '0';
    cont_pulse <= '1' when (cont_dbcd and not cont_last) = '1' else '0';

end Behavioral;
