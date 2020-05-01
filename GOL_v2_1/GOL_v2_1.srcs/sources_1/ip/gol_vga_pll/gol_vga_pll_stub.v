// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1.3 (win64) Build 2644227 Wed Sep  4 09:45:24 MDT 2019
// Date        : Mon Jan 27 12:35:46 2020
// Host        : DESKTOP-JKR6EMK running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/JimSnedecor/Desktop/Code/C_Cpp/Reconfig/GOL_v2_1/GOL_v2_1.srcs/sources_1/ip/gol_vga_pll/gol_vga_pll_stub.v
// Design      : gol_vga_pll
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module gol_vga_pll(vga_clk, reset, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="vga_clk,reset,clk_in1" */;
  output vga_clk;
  input reset;
  input clk_in1;
endmodule
