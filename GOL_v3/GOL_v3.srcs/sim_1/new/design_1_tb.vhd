----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/27/2020 07:43:04 PM
-- Design Name: 
-- Module Name: design_1_tb - Behavioral
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

entity design_1_tb is
--  Port ( );
end design_1_tb;

architecture Behavioral of design_1_tb is

    signal S_AXI_0_araddr : STD_LOGIC_VECTOR ( 31 downto 0 ) := (others => '0');
    signal S_AXI_0_arprot : STD_LOGIC_VECTOR ( 2 downto 0 ) := (others => '0');
    signal S_AXI_0_arready : STD_LOGIC;
    signal S_AXI_0_arvalid : STD_LOGIC := '0';
    signal S_AXI_0_awaddr : STD_LOGIC_VECTOR ( 31 downto 0 ) := (others => '0');
    signal S_AXI_0_awprot : STD_LOGIC_VECTOR ( 2 downto 0 ) := (others => '0');
    signal S_AXI_0_awready : STD_LOGIC;
    signal S_AXI_0_awvalid : STD_LOGIC := '0';
    signal S_AXI_0_bready : STD_LOGIC := '0';
    signal S_AXI_0_bresp : STD_LOGIC_VECTOR ( 1 downto 0 );
    signal S_AXI_0_bvalid : STD_LOGIC;
    signal S_AXI_0_rdata : STD_LOGIC_VECTOR ( 31 downto 0 );
    signal S_AXI_0_rready : STD_LOGIC := '0';
    signal S_AXI_0_rresp : STD_LOGIC_VECTOR ( 1 downto 0 );
    signal S_AXI_0_rvalid : STD_LOGIC;
    signal S_AXI_0_wdata : STD_LOGIC_VECTOR ( 31 downto 0 ) := (others => '0');
    signal S_AXI_0_wready : STD_LOGIC;
    signal S_AXI_0_wstrb : STD_LOGIC_VECTOR ( 3 downto 0 ) := (others => '0');
    signal S_AXI_0_wvalid : STD_LOGIC := '0';
    
    signal S_AXI_1_araddr : STD_LOGIC_VECTOR ( 31 downto 0 ) := (others => '0');
    signal S_AXI_1_arprot : STD_LOGIC_VECTOR ( 2 downto 0 ) := (others => '0');
    signal S_AXI_1_arready : STD_LOGIC;
    signal S_AXI_1_arvalid : STD_LOGIC := '0';
    signal S_AXI_1_awaddr : STD_LOGIC_VECTOR ( 31 downto 0 ) := (others => '0');
    signal S_AXI_1_awprot : STD_LOGIC_VECTOR ( 2 downto 0 ) := (others => '0');
    signal S_AXI_1_awready : STD_LOGIC;
    signal S_AXI_1_awvalid : STD_LOGIC := '0';
    signal S_AXI_1_bready : STD_LOGIC := '0';
    signal S_AXI_1_bresp : STD_LOGIC_VECTOR ( 1 downto 0 );
    signal S_AXI_1_bvalid : STD_LOGIC;
    signal S_AXI_1_rdata : STD_LOGIC_VECTOR ( 31 downto 0 );
    signal S_AXI_1_rready : STD_LOGIC := '0';
    signal S_AXI_1_rresp : STD_LOGIC_VECTOR ( 1 downto 0 );
    signal S_AXI_1_rvalid : STD_LOGIC;
    signal S_AXI_1_wdata : STD_LOGIC_VECTOR ( 31 downto 0 ) := (others => '0');
    signal S_AXI_1_wready : STD_LOGIC;
    signal S_AXI_1_wstrb : STD_LOGIC_VECTOR ( 3 downto 0 ) := (others => '0');
    signal S_AXI_1_wvalid : STD_LOGIC := '0';
    
    signal aclk_0 : STD_LOGIC := '0';
    signal aresetn_0 : STD_LOGIC := '0';
    
    constant clk_period : time := 10ns;

begin

    uut: entity work.design_1_wrapper
    port map(
        S_AXI_0_araddr => S_AXI_0_araddr,
        S_AXI_0_arprot => S_AXI_0_arprot,
        S_AXI_0_arready => S_AXI_0_arready,
        S_AXI_0_arvalid => S_AXI_0_arvalid,
        S_AXI_0_awaddr => S_AXI_0_awaddr,
        S_AXI_0_awprot => S_AXI_0_awprot,
        S_AXI_0_awready => S_AXI_0_awready,
        S_AXI_0_awvalid => S_AXI_0_awvalid,
        S_AXI_0_bready => S_AXI_0_bready,
        S_AXI_0_bresp => S_AXI_0_bresp,
        S_AXI_0_bvalid => S_AXI_0_bvalid,
        S_AXI_0_rdata => S_AXI_0_rdata,
        S_AXI_0_rready => S_AXI_0_rready,
        S_AXI_0_rresp => S_AXI_0_rresp,
        S_AXI_0_rvalid => S_AXI_0_rvalid,
        S_AXI_0_wdata => S_AXI_0_wdata,
        S_AXI_0_wready => S_AXI_0_wready,
        S_AXI_0_wstrb => S_AXI_0_wstrb,
        S_AXI_0_wvalid => S_AXI_0_wvalid,
        S_AXI_1_araddr => S_AXI_1_araddr,
        S_AXI_1_arprot => S_AXI_1_arprot,
        S_AXI_1_arready => S_AXI_1_arready,
        S_AXI_1_arvalid => S_AXI_1_arvalid,
        S_AXI_1_awaddr => S_AXI_1_awaddr,
        S_AXI_1_awprot => S_AXI_1_awprot,
        S_AXI_1_awready => S_AXI_1_awready,
        S_AXI_1_awvalid => S_AXI_1_awvalid,
        S_AXI_1_bready => S_AXI_1_bready,
        S_AXI_1_bresp => S_AXI_1_bresp,
        S_AXI_1_bvalid => S_AXI_1_bvalid,
        S_AXI_1_rdata => S_AXI_1_rdata,
        S_AXI_1_rready => S_AXI_1_rready,
        S_AXI_1_rresp => S_AXI_1_rresp,
        S_AXI_1_rvalid => S_AXI_1_rvalid,
        S_AXI_1_wdata => S_AXI_1_wdata,
        S_AXI_1_wready => S_AXI_1_wready,
        S_AXI_1_wstrb => S_AXI_1_wstrb,
        S_AXI_1_wvalid => S_AXI_1_wvalid,
        aclk_0 => aclk_0,
        aresetn_0 => aresetn_0
    );

    aclk_0 <= not aclk_0 after clk_period/2;
    
    stim_proc: process is begin
        wait for clk_period;
        
        aresetn_0 <= '1';
        
        wait for clk_period;
        
        --send a read address from slave 0
        if S_AXI_0_arvalid = '0' then
            wait until S_AXI_0_arready = '1';
            wait for clk_period/2;
        end if;
        
        S_AXI_0_araddr <= x"C0000000";
        S_AXI_0_arvalid <= '1';
        
        wait for clk_period;
        
        S_AXI_0_arvalid <= '0';
        
        wait for clk_period*120;
        
        assert false report "End Simulation" severity failure;
    end process stim_proc;

end Behavioral;
