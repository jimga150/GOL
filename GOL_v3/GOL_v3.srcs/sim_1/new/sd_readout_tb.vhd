----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/01/2020 09:35:39 PM
-- Design Name: sd_readout_tb
-- Module Name: sd_readout_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: Created with VHDL Test Bench Template Generator
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

entity sd_readout_tb is
end sd_readout_tb;

architecture Behavioral of sd_readout_tb is
    
    --Clocks
    signal clk : std_logic := '0';
    
    --Resets
    signal rst : std_logic := '1';
    
    --General inputs
    signal sd_error : std_logic := '0';
    signal sd_valid : std_logic := '0';
    signal sd_din : std_logic_vector(7 downto 0) := (others => '0');
    signal wa_ready : std_logic := '0';
    signal wd_ready : std_logic := '0';
    signal wr_resp : std_logic_vector(1 downto 0) := (others => '0');
    signal wr_valid : std_logic := '0';
    
    --Outputs
    signal sd_rd_multiple : std_logic;
    signal sd_ready : std_logic;
    signal sd_block_addr : std_logic_vector(31 downto 0);
    signal wa_addr : std_logic_vector(31 downto 0);
    signal wa_valid : std_logic;
    signal wd_data : std_logic_vector(31 downto 0);
    signal wd_valid : std_logic;
    signal wr_ready : std_logic;
    signal done_flag : std_logic;
    
    --Clock Periods
    constant clk_period : time := 10 ns;
    
begin
    
    UUT: entity work.sd_readout
    port map(
        clk => clk,
        rst => rst,
        sd_rd_multiple => sd_rd_multiple,
        sd_ready => sd_ready,
        sd_error => sd_error,
        sd_valid => sd_valid,
        sd_din => sd_din,
        sd_block_addr => sd_block_addr,
        wa_addr => wa_addr,
        wa_valid => wa_valid,
        wa_ready => wa_ready,
        wd_data => wd_data,
        wd_valid => wd_valid,
        wd_ready => wd_ready,
        wr_resp => wr_resp,
        wr_ready => wr_ready,
        wr_valid => wr_valid,
        done_flag => done_flag
    );
    
    --Clock Drivers
    clk <= not clk after clk_period/2;
    
    stim_proc: process is begin
        
        wait for clk_period;
        
        rst <= '0';
        
        wait for clk_period;
        
        --Insert stimuli here
        --AXI stuff here
        while done_flag = '0' loop
            if wa_valid = '0' then
                wait until wa_valid = '1';
            end if;
            wait for clk_period;
            wa_ready <= '1';
            wait for clk_period;
            wa_ready <= '0';
            
            if wd_valid = '0' then
                wait until wd_valid = '1';
            end if;
            wait for clk_period;
            wd_ready <= '1';
            wait for clk_period;
            wd_ready <= '0';
            
            if wr_ready = '0' then
                wait until wr_ready = '1';
            end if;
            wait for clk_period;
            wr_valid <= '1';
            wait for clk_period;
            wr_valid <= '0';
            
            wait for clk_period*4;
        end loop;
        
        wait for clk_period*4;
        
        assert false report "End Simulation" severity failure;
        
    end process;
    
    sd_controller_proc: process is begin
    
        if sd_rd_multiple = '0' then
            wait until sd_rd_multiple = '1';
        end if;
        
        wait for clk_period*3;
        sd_din <= std_logic_vector(unsigned(sd_din) + 1);
        sd_valid <= '1';
        
        wait until sd_ready = '1';
        wait for clk_period;
        sd_valid <= '0';
        
    end process sd_controller_proc;

end Behavioral;
