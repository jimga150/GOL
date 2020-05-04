----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/03/2020 08:25:35 PM
-- Design Name: 
-- Module Name: GOL_readout_w_bram_tb - Behavioral
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

entity GOL_readout_w_bram_tb is
--  Port ( );
end GOL_readout_w_bram_tb;

architecture Behavioral of GOL_readout_w_bram_tb is

    signal clk, pixel_clk, rst, frame_parity : std_logic := '0';
    
    signal ar_ready, rd_valid : std_logic;
    
    signal rd_data : std_logic_vector(31 downto 0);
    
    signal ar_valid, rd_ready, rstn : std_logic;
    signal h_sync, v_sync, pixel : std_logic;
    signal ar_addr : std_logic_vector(31 downto 0);
    
    constant clk_period : time := 10ns;
    constant pixel_clk_period : time := 21ns;

begin

    rstn <= not rst;

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
    
    bd_inst: entity work.design_1_wrapper
    port map(
        S_AXI_0_araddr => ar_addr,
        S_AXI_0_arprot => (others => '0'),
        S_AXI_0_arready => ar_ready,
        S_AXI_0_arvalid => ar_valid,
        S_AXI_0_awaddr => (others => '0'),
        S_AXI_0_awprot => (others => '0'),
        S_AXI_0_awready => open,
        S_AXI_0_awvalid => '0',
        S_AXI_0_bready => '1',
        S_AXI_0_bresp => open,
        S_AXI_0_bvalid => open,
        S_AXI_0_rdata => rd_data,
        S_AXI_0_rready => rd_ready,
        S_AXI_0_rresp => open,
        S_AXI_0_rvalid => rd_valid,
        S_AXI_0_wdata => (others => '0'),
        S_AXI_0_wready => open,
        S_AXI_0_wstrb => (others => '0'),
        S_AXI_0_wvalid => '0',
        S_AXI_1_araddr => (others => '0'),
        S_AXI_1_arprot => (others => '0'),
        S_AXI_1_arready => open,
        S_AXI_1_arvalid => '0',
        S_AXI_1_awaddr => (others => '0'),
        S_AXI_1_awprot => (others => '0'),
        S_AXI_1_awready => open,
        S_AXI_1_awvalid => '0',
        S_AXI_1_bready => '0',
        S_AXI_1_bresp => open,
        S_AXI_1_bvalid => open,
        S_AXI_1_rdata => open,
        S_AXI_1_rready => '0',
        S_AXI_1_rresp => open,
        S_AXI_1_rvalid => open,
        S_AXI_1_wdata => (others => '0'),
        S_AXI_1_wready => open,
        S_AXI_1_wstrb => (others => '0'),
        S_AXI_1_wvalid => '0',
        aclk_0 => clk,
        aresetn_0 => rstn
    );
    
    clk <= not clk after clk_period/2;
    pixel_clk <= not pixel_clk after pixel_clk_period/2;
    
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
