----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/01/2020 08:42:06 PM
-- Design Name: 
-- Module Name: GOL_readout_module_tb - Behavioral
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

library work;
use work.GOL_package.all;

entity GOL_readout_module_tb is
--  Port ( );
end GOL_readout_module_tb;

architecture Behavioral of GOL_readout_module_tb is

    signal clk, pixel_clk, rst, frame_parity : std_logic := '0';
    
    signal ar_ready, rd_valid : std_logic := '0';
    
    signal rd_data : std_logic_vector(31 downto 0) := (others => '0');
    
    signal ar_valid, rd_ready : std_logic;
    signal h_sync, v_sync, pixel : std_logic;
    signal ar_addr : std_logic_vector(31 downto 0);
    
    constant clk_period : time := 10ns;
    constant pixel_clk_period : time := 21ns;

begin

    uut: entity work.GOL_readout_module
    port map(
        clk => clk,
        rst => rst,
        pixel_clk => pixel_clk,
        frame_parity => frame_parity,
        ar_valid => ar_valid,
        ar_ready => ar_ready,
        ar_addr => ar_addr,
        rd_valid => rd_valid,
        rd_ready => rd_ready,
        rd_data => rd_data,
        h_sync => h_sync,
        v_sync => v_sync,
        pixel => pixel
    );
    
    clk <= not clk after clk_period/2;
    pixel_clk <= not pixel_clk after pixel_clk_period/2;
    
    arr_proc: process is begin
    
        if ar_valid = '0' then
            wait until ar_valid = '1';
        end if;
        
        wait for clk_period;
        ar_ready <= '1';
        
        wait for clk_period;
        ar_ready <= '0';
        
    end process arr_proc;
    
    rdv_proc: process is
        variable count : integer := 0;
    begin
    
        if rd_ready = '0' then
            wait until rd_ready = '1';
        end if;
        
        wait for clk_period;
        
        rd_valid <= '1';
        
        count := count + 1;
        rd_data <= std_logic_vector(to_unsigned(count, rd_data'length));
        
        wait for clk_period;
        
        rd_valid <= '0';
        rd_data <= (others => '0');
        
    end process rdv_proc;
    
    stim_proc: process is begin
        rst <= '1';
        
        wait for clk_period*3;
        
        rst <= '0';
        
        for i in 0 to 4 loop
            wait until rising_edge(v_sync);
        end loop;
        
        assert false report "End Simulation" severity failure;
        
    end process stim_proc;

end Behavioral;
