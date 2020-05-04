--Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2019.1.3 (win64) Build 2644227 Wed Sep  4 09:45:24 MDT 2019
--Date        : Mon May  4 09:44:39 2020
--Host        : DESKTOP-JKR6EMK running 64-bit major release  (build 9200)
--Command     : generate_target design_1_wrapper.bd
--Design      : design_1_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_wrapper is
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
    aclk_0 : in STD_LOGIC;
    aresetn_0 : in STD_LOGIC
  );
end design_1_wrapper;

architecture STRUCTURE of design_1_wrapper is
  component design_1 is
  port (
    aclk_0 : in STD_LOGIC;
    aresetn_0 : in STD_LOGIC;
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
    S_AXI_0_rready : in STD_LOGIC;
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
    S_AXI_1_rready : in STD_LOGIC
  );
  end component design_1;
begin
design_1_i: component design_1
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
      aclk_0 => aclk_0,
      aresetn_0 => aresetn_0
    );
end STRUCTURE;
