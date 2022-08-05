--Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2019.1.3 (win64) Build 2644227 Wed Sep  4 09:45:24 MDT 2019
--Date        : Wed Sep  2 20:45:37 2020
--Host        : DESKTOP-JKR6EMK running 64-bit major release  (build 9200)
--Command     : generate_target BRAM_AXI_MULT_wrapper.bd
--Design      : BRAM_AXI_MULT_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity BRAM_AXI_MULT_wrapper is
  port (
    S_AXI_0_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_0_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_0_arready : out STD_LOGIC;
    S_AXI_0_arvalid : in STD_LOGIC;
    S_AXI_0_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_0_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_0_awready : out STD_LOGIC;
    S_AXI_0_awvalid : in STD_LOGIC;
    S_AXI_0_bready : in STD_LOGIC;
    S_AXI_0_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_0_bvalid : out STD_LOGIC;
    S_AXI_0_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_0_rready : in STD_LOGIC;
    S_AXI_0_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_0_rvalid : out STD_LOGIC;
    S_AXI_0_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_0_wready : out STD_LOGIC;
    S_AXI_0_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_0_wvalid : in STD_LOGIC;
    S_AXI_1_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_1_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_1_arready : out STD_LOGIC;
    S_AXI_1_arvalid : in STD_LOGIC;
    S_AXI_1_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_1_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_1_awready : out STD_LOGIC;
    S_AXI_1_awvalid : in STD_LOGIC;
    S_AXI_1_bready : in STD_LOGIC;
    S_AXI_1_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_1_bvalid : out STD_LOGIC;
    S_AXI_1_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_1_rready : in STD_LOGIC;
    S_AXI_1_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_1_rvalid : out STD_LOGIC;
    S_AXI_1_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_1_wready : out STD_LOGIC;
    S_AXI_1_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_1_wvalid : in STD_LOGIC;
    S_AXI_2_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_2_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_2_arready : out STD_LOGIC;
    S_AXI_2_arvalid : in STD_LOGIC;
    S_AXI_2_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_2_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_2_awready : out STD_LOGIC;
    S_AXI_2_awvalid : in STD_LOGIC;
    S_AXI_2_bready : in STD_LOGIC;
    S_AXI_2_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_2_bvalid : out STD_LOGIC;
    S_AXI_2_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_2_rready : in STD_LOGIC;
    S_AXI_2_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_2_rvalid : out STD_LOGIC;
    S_AXI_2_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_2_wready : out STD_LOGIC;
    S_AXI_2_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_2_wvalid : in STD_LOGIC;
    clk_100mhz_out : out STD_LOGIC;
    clk_50mhz_out : out STD_LOGIC;
    pixel_clk_out : out STD_LOGIC;
    reset : in STD_LOGIC;
    sd_rst : out STD_LOGIC_VECTOR ( 0 to 0 );
    sys_clock : in STD_LOGIC;
    sys_rst : out STD_LOGIC_VECTOR ( 0 to 0 );
    vga_arstn : out STD_LOGIC_VECTOR ( 0 to 0 );
    vga_rst : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
end BRAM_AXI_MULT_wrapper;

architecture STRUCTURE of BRAM_AXI_MULT_wrapper is
  component BRAM_AXI_MULT is
  port (
    reset : in STD_LOGIC;
    sys_clock : in STD_LOGIC;
    clk_50mhz_out : out STD_LOGIC;
    clk_100mhz_out : out STD_LOGIC;
    pixel_clk_out : out STD_LOGIC;
    vga_arstn : out STD_LOGIC_VECTOR ( 0 to 0 );
    sd_rst : out STD_LOGIC_VECTOR ( 0 to 0 );
    sys_rst : out STD_LOGIC_VECTOR ( 0 to 0 );
    vga_rst : out STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_2_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_2_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_2_awvalid : in STD_LOGIC;
    S_AXI_2_awready : out STD_LOGIC;
    S_AXI_2_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_2_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_2_wvalid : in STD_LOGIC;
    S_AXI_2_wready : out STD_LOGIC;
    S_AXI_2_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_2_bvalid : out STD_LOGIC;
    S_AXI_2_bready : in STD_LOGIC;
    S_AXI_2_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_2_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_2_arvalid : in STD_LOGIC;
    S_AXI_2_arready : out STD_LOGIC;
    S_AXI_2_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_2_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_2_rvalid : out STD_LOGIC;
    S_AXI_2_rready : in STD_LOGIC;
    S_AXI_1_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_1_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_1_awvalid : in STD_LOGIC;
    S_AXI_1_awready : out STD_LOGIC;
    S_AXI_1_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_1_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_1_wvalid : in STD_LOGIC;
    S_AXI_1_wready : out STD_LOGIC;
    S_AXI_1_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_1_bvalid : out STD_LOGIC;
    S_AXI_1_bready : in STD_LOGIC;
    S_AXI_1_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_1_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_1_arvalid : in STD_LOGIC;
    S_AXI_1_arready : out STD_LOGIC;
    S_AXI_1_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_1_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_1_rvalid : out STD_LOGIC;
    S_AXI_1_rready : in STD_LOGIC;
    S_AXI_0_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_0_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_0_awvalid : in STD_LOGIC;
    S_AXI_0_awready : out STD_LOGIC;
    S_AXI_0_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_0_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_0_wvalid : in STD_LOGIC;
    S_AXI_0_wready : out STD_LOGIC;
    S_AXI_0_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_0_bvalid : out STD_LOGIC;
    S_AXI_0_bready : in STD_LOGIC;
    S_AXI_0_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_0_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_0_arvalid : in STD_LOGIC;
    S_AXI_0_arready : out STD_LOGIC;
    S_AXI_0_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_0_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_0_rvalid : out STD_LOGIC;
    S_AXI_0_rready : in STD_LOGIC
  );
  end component BRAM_AXI_MULT;
begin
BRAM_AXI_MULT_i: component BRAM_AXI_MULT
     port map (
      S_AXI_0_araddr(31 downto 0) => S_AXI_0_araddr(31 downto 0),
      S_AXI_0_arprot(2 downto 0) => S_AXI_0_arprot(2 downto 0),
      S_AXI_0_arready => S_AXI_0_arready,
      S_AXI_0_arvalid => S_AXI_0_arvalid,
      S_AXI_0_awaddr(31 downto 0) => S_AXI_0_awaddr(31 downto 0),
      S_AXI_0_awprot(2 downto 0) => S_AXI_0_awprot(2 downto 0),
      S_AXI_0_awready => S_AXI_0_awready,
      S_AXI_0_awvalid => S_AXI_0_awvalid,
      S_AXI_0_bready => S_AXI_0_bready,
      S_AXI_0_bresp(1 downto 0) => S_AXI_0_bresp(1 downto 0),
      S_AXI_0_bvalid => S_AXI_0_bvalid,
      S_AXI_0_rdata(31 downto 0) => S_AXI_0_rdata(31 downto 0),
      S_AXI_0_rready => S_AXI_0_rready,
      S_AXI_0_rresp(1 downto 0) => S_AXI_0_rresp(1 downto 0),
      S_AXI_0_rvalid => S_AXI_0_rvalid,
      S_AXI_0_wdata(31 downto 0) => S_AXI_0_wdata(31 downto 0),
      S_AXI_0_wready => S_AXI_0_wready,
      S_AXI_0_wstrb(3 downto 0) => S_AXI_0_wstrb(3 downto 0),
      S_AXI_0_wvalid => S_AXI_0_wvalid,
      S_AXI_1_araddr(31 downto 0) => S_AXI_1_araddr(31 downto 0),
      S_AXI_1_arprot(2 downto 0) => S_AXI_1_arprot(2 downto 0),
      S_AXI_1_arready => S_AXI_1_arready,
      S_AXI_1_arvalid => S_AXI_1_arvalid,
      S_AXI_1_awaddr(31 downto 0) => S_AXI_1_awaddr(31 downto 0),
      S_AXI_1_awprot(2 downto 0) => S_AXI_1_awprot(2 downto 0),
      S_AXI_1_awready => S_AXI_1_awready,
      S_AXI_1_awvalid => S_AXI_1_awvalid,
      S_AXI_1_bready => S_AXI_1_bready,
      S_AXI_1_bresp(1 downto 0) => S_AXI_1_bresp(1 downto 0),
      S_AXI_1_bvalid => S_AXI_1_bvalid,
      S_AXI_1_rdata(31 downto 0) => S_AXI_1_rdata(31 downto 0),
      S_AXI_1_rready => S_AXI_1_rready,
      S_AXI_1_rresp(1 downto 0) => S_AXI_1_rresp(1 downto 0),
      S_AXI_1_rvalid => S_AXI_1_rvalid,
      S_AXI_1_wdata(31 downto 0) => S_AXI_1_wdata(31 downto 0),
      S_AXI_1_wready => S_AXI_1_wready,
      S_AXI_1_wstrb(3 downto 0) => S_AXI_1_wstrb(3 downto 0),
      S_AXI_1_wvalid => S_AXI_1_wvalid,
      S_AXI_2_araddr(31 downto 0) => S_AXI_2_araddr(31 downto 0),
      S_AXI_2_arprot(2 downto 0) => S_AXI_2_arprot(2 downto 0),
      S_AXI_2_arready => S_AXI_2_arready,
      S_AXI_2_arvalid => S_AXI_2_arvalid,
      S_AXI_2_awaddr(31 downto 0) => S_AXI_2_awaddr(31 downto 0),
      S_AXI_2_awprot(2 downto 0) => S_AXI_2_awprot(2 downto 0),
      S_AXI_2_awready => S_AXI_2_awready,
      S_AXI_2_awvalid => S_AXI_2_awvalid,
      S_AXI_2_bready => S_AXI_2_bready,
      S_AXI_2_bresp(1 downto 0) => S_AXI_2_bresp(1 downto 0),
      S_AXI_2_bvalid => S_AXI_2_bvalid,
      S_AXI_2_rdata(31 downto 0) => S_AXI_2_rdata(31 downto 0),
      S_AXI_2_rready => S_AXI_2_rready,
      S_AXI_2_rresp(1 downto 0) => S_AXI_2_rresp(1 downto 0),
      S_AXI_2_rvalid => S_AXI_2_rvalid,
      S_AXI_2_wdata(31 downto 0) => S_AXI_2_wdata(31 downto 0),
      S_AXI_2_wready => S_AXI_2_wready,
      S_AXI_2_wstrb(3 downto 0) => S_AXI_2_wstrb(3 downto 0),
      S_AXI_2_wvalid => S_AXI_2_wvalid,
      clk_100mhz_out => clk_100mhz_out,
      clk_50mhz_out => clk_50mhz_out,
      pixel_clk_out => pixel_clk_out,
      reset => reset,
      sd_rst(0) => sd_rst(0),
      sys_clock => sys_clock,
      sys_rst(0) => sys_rst(0),
      vga_arstn(0) => vga_arstn(0),
      vga_rst(0) => vga_rst(0)
    );
end STRUCTURE;
