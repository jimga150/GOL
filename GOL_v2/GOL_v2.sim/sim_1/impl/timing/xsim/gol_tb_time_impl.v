// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1.3 (win64) Build 2644227 Wed Sep  4 09:45:24 MDT 2019
// Date        : Sun Jan 19 10:36:16 2020
// Host        : DESKTOP-JKR6EMK running 64-bit major release  (build 9200)
// Command     : write_verilog -mode timesim -nolib -sdf_anno true -force -file {C:/Users/Jim
//               Snedecor/Desktop/Code/C_Cpp/Reconfig/GOL_v2/GOL_v2.sim/sim_1/impl/timing/xsim/gol_tb_time_impl.v}
// Design      : GOL
// Purpose     : This verilog netlist is a timing simulation representation of the design and should not be modified or
//               synthesized. Please ensure that this netlist is used with the corresponding SDF file.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps
`define XIL_TIMING

(* ECO_CHECKSUM = "84ebf627" *) (* h = "6" *) (* w = "6" *) 
(* NotValidForBitStream *)
module GOL
   (clk,
    rst,
    row,
    col,
    val);
  input clk;
  input rst;
  input [2:0]row;
  input [2:0]col;
  output val;

  wire \GOL_outputs[0]_0 ;
  wire \GOL_outputs[0]_1 ;
  wire \GOL_outputs[0]_2 ;
  wire \GOL_outputs[0]_3 ;
  wire \GOL_outputs[0]_4 ;
  wire \GOL_outputs[0]_5 ;
  wire [5:0]\GOL_outputs[2] ;
  wire [5:0]\GOL_outputs[3] ;
  wire [5:1]\GOL_outputs[5] ;
  wire clk;
  wire clk_IBUF;
  wire clk_IBUF_BUFG;
  wire [2:0]col;
  wire [2:0]col_IBUF;
  wire p_0_in;
  wire p_0_out;
  wire p_10_in;
  wire p_11_in;
  wire p_1_in;
  wire p_1_out;
  wire p_2_in;
  wire p_2_out;
  wire p_3_in;
  wire p_3_out;
  wire p_4_in;
  wire p_4_out;
  wire p_5_in;
  wire p_5_out;
  wire p_6_in;
  wire p_7_in;
  wire p_8_in;
  wire p_9_in;
  wire [2:0]row;
  wire [2:0]row_IBUF;
  wire \rows[0].cols[0].gol_cell_inst_n_1 ;
  wire \rows[0].cols[0].gol_cell_inst_n_2 ;
  wire \rows[0].cols[1].gol_cell_inst_n_1 ;
  wire \rows[0].cols[1].gol_cell_inst_n_2 ;
  wire \rows[0].cols[2].gol_cell_inst_n_1 ;
  wire \rows[0].cols[2].gol_cell_inst_n_2 ;
  wire \rows[0].cols[3].gol_cell_inst_n_1 ;
  wire \rows[0].cols[3].gol_cell_inst_n_2 ;
  wire \rows[0].cols[4].gol_cell_inst_n_1 ;
  wire \rows[0].cols[4].gol_cell_inst_n_2 ;
  wire \rows[0].cols[5].gol_cell_inst_n_1 ;
  wire \rows[0].cols[5].gol_cell_inst_n_2 ;
  wire \rows[1].cols[0].gol_cell_inst_n_1 ;
  wire \rows[1].cols[0].gol_cell_inst_n_2 ;
  wire \rows[1].cols[1].gol_cell_inst_n_1 ;
  wire \rows[1].cols[1].gol_cell_inst_n_2 ;
  wire \rows[1].cols[2].gol_cell_inst_n_1 ;
  wire \rows[1].cols[2].gol_cell_inst_n_2 ;
  wire \rows[1].cols[3].gol_cell_inst_n_1 ;
  wire \rows[1].cols[3].gol_cell_inst_n_2 ;
  wire \rows[1].cols[4].gol_cell_inst_n_1 ;
  wire \rows[1].cols[4].gol_cell_inst_n_2 ;
  wire \rows[1].cols[5].gol_cell_inst_n_1 ;
  wire \rows[1].cols[5].gol_cell_inst_n_2 ;
  wire \rows[2].cols[0].gol_cell_inst_n_1 ;
  wire \rows[2].cols[0].gol_cell_inst_n_2 ;
  wire \rows[2].cols[1].gol_cell_inst_n_1 ;
  wire \rows[2].cols[1].gol_cell_inst_n_2 ;
  wire \rows[2].cols[2].gol_cell_inst_n_1 ;
  wire \rows[2].cols[2].gol_cell_inst_n_2 ;
  wire \rows[2].cols[3].gol_cell_inst_n_1 ;
  wire \rows[2].cols[3].gol_cell_inst_n_2 ;
  wire \rows[2].cols[4].gol_cell_inst_n_1 ;
  wire \rows[2].cols[4].gol_cell_inst_n_2 ;
  wire \rows[2].cols[5].gol_cell_inst_n_1 ;
  wire \rows[2].cols[5].gol_cell_inst_n_2 ;
  wire \rows[3].cols[0].gol_cell_inst_n_1 ;
  wire \rows[3].cols[0].gol_cell_inst_n_2 ;
  wire \rows[3].cols[0].gol_cell_inst_n_3 ;
  wire \rows[3].cols[1].gol_cell_inst_n_1 ;
  wire \rows[3].cols[1].gol_cell_inst_n_2 ;
  wire \rows[3].cols[2].gol_cell_inst_n_1 ;
  wire \rows[3].cols[2].gol_cell_inst_n_2 ;
  wire \rows[3].cols[2].gol_cell_inst_n_3 ;
  wire \rows[3].cols[3].gol_cell_inst_n_1 ;
  wire \rows[3].cols[3].gol_cell_inst_n_2 ;
  wire \rows[3].cols[4].gol_cell_inst_n_1 ;
  wire \rows[3].cols[4].gol_cell_inst_n_3 ;
  wire \rows[3].cols[5].gol_cell_inst_n_1 ;
  wire \rows[3].cols[5].gol_cell_inst_n_2 ;
  wire \rows[4].cols[0].gol_cell_inst_n_1 ;
  wire \rows[4].cols[0].gol_cell_inst_n_2 ;
  wire \rows[4].cols[1].gol_cell_inst_n_1 ;
  wire \rows[4].cols[1].gol_cell_inst_n_2 ;
  wire \rows[4].cols[2].gol_cell_inst_n_1 ;
  wire \rows[4].cols[2].gol_cell_inst_n_2 ;
  wire \rows[4].cols[3].gol_cell_inst_n_1 ;
  wire \rows[4].cols[3].gol_cell_inst_n_2 ;
  wire \rows[4].cols[4].gol_cell_inst_n_1 ;
  wire \rows[4].cols[4].gol_cell_inst_n_2 ;
  wire \rows[4].cols[5].gol_cell_inst_n_1 ;
  wire \rows[4].cols[5].gol_cell_inst_n_2 ;
  wire \rows[5].cols[0].gol_cell_inst_n_1 ;
  wire \rows[5].cols[0].gol_cell_inst_n_2 ;
  wire \rows[5].cols[0].gol_cell_inst_n_3 ;
  wire \rows[5].cols[1].gol_cell_inst_n_1 ;
  wire \rows[5].cols[1].gol_cell_inst_n_2 ;
  wire \rows[5].cols[1].gol_cell_inst_n_3 ;
  wire \rows[5].cols[2].gol_cell_inst_n_1 ;
  wire \rows[5].cols[2].gol_cell_inst_n_2 ;
  wire \rows[5].cols[2].gol_cell_inst_n_3 ;
  wire \rows[5].cols[3].gol_cell_inst_n_1 ;
  wire \rows[5].cols[3].gol_cell_inst_n_2 ;
  wire \rows[5].cols[3].gol_cell_inst_n_3 ;
  wire \rows[5].cols[4].gol_cell_inst_n_1 ;
  wire \rows[5].cols[4].gol_cell_inst_n_2 ;
  wire \rows[5].cols[4].gol_cell_inst_n_3 ;
  wire \rows[5].cols[5].gol_cell_inst_n_1 ;
  wire \rows[5].cols[5].gol_cell_inst_n_2 ;
  wire \rows[5].cols[5].gol_cell_inst_n_3 ;
  wire rst;
  wire rst_IBUF;
  wire val;
  wire val_OBUF;

initial begin
 $sdf_annotate("gol_tb_time_impl.sdf",,,,"tool_control");
end
  BUFG clk_IBUF_BUFG_inst
       (.I(clk_IBUF),
        .O(clk_IBUF_BUFG));
  IBUF clk_IBUF_inst
       (.I(clk),
        .O(clk_IBUF));
  IBUF \col_IBUF[0]_inst 
       (.I(col[0]),
        .O(col_IBUF[0]));
  IBUF \col_IBUF[1]_inst 
       (.I(col[1]),
        .O(col_IBUF[1]));
  IBUF \col_IBUF[2]_inst 
       (.I(col[2]),
        .O(col_IBUF[2]));
  IBUF \row_IBUF[0]_inst 
       (.I(row[0]),
        .O(row_IBUF[0]));
  IBUF \row_IBUF[1]_inst 
       (.I(row[1]),
        .O(row_IBUF[1]));
  IBUF \row_IBUF[2]_inst 
       (.I(row[2]),
        .O(row_IBUF[2]));
  GOL_cell \rows[0].cols[0].gol_cell_inst 
       (.\GOL_outputs[0]_0 (\GOL_outputs[0]_0 ),
        .\GOL_outputs[0]_1 (\GOL_outputs[0]_1 ),
        .\GOL_outputs[0]_4 (\GOL_outputs[0]_4 ),
        .\GOL_outputs[0]_5 (\GOL_outputs[0]_5 ),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .p_10_in(p_10_in),
        .p_11_in(p_11_in),
        .p_3_in(p_3_in),
        .p_4_in(p_4_in),
        .p_5_in(p_5_in),
        .p_9_in(p_9_in),
        .rst_IBUF(rst_IBUF),
        .val_reg_0(\rows[0].cols[0].gol_cell_inst_n_1 ),
        .val_reg_1(\rows[0].cols[0].gol_cell_inst_n_2 ),
        .val_reg_2(\rows[0].cols[1].gol_cell_inst_n_1 ),
        .val_reg_3(\rows[5].cols[5].gol_cell_inst_n_2 ));
  GOL_cell_0 \rows[0].cols[1].gol_cell_inst 
       (.\GOL_outputs[0]_0 (\GOL_outputs[0]_0 ),
        .\GOL_outputs[0]_1 (\GOL_outputs[0]_1 ),
        .\GOL_outputs[0]_2 (\GOL_outputs[0]_2 ),
        .\GOL_outputs[0]_5 (\GOL_outputs[0]_5 ),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .p_0_in(p_0_in),
        .p_10_in(p_10_in),
        .p_11_in(p_11_in),
        .p_4_in(p_4_in),
        .p_5_in(p_5_in),
        .p_6_in(p_6_in),
        .rst_IBUF(rst_IBUF),
        .val_reg_0(\rows[0].cols[1].gol_cell_inst_n_1 ),
        .val_reg_1(\rows[0].cols[1].gol_cell_inst_n_2 ),
        .val_reg_2(\rows[0].cols[2].gol_cell_inst_n_1 ),
        .val_reg_3(\rows[5].cols[0].gol_cell_inst_n_2 ));
  GOL_cell_1 \rows[0].cols[2].gol_cell_inst 
       (.\GOL_outputs[0]_0 (\GOL_outputs[0]_0 ),
        .\GOL_outputs[0]_1 (\GOL_outputs[0]_1 ),
        .\GOL_outputs[0]_2 (\GOL_outputs[0]_2 ),
        .\GOL_outputs[0]_3 (\GOL_outputs[0]_3 ),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .p_0_in(p_0_in),
        .p_11_in(p_11_in),
        .p_1_in(p_1_in),
        .p_5_in(p_5_in),
        .p_6_in(p_6_in),
        .p_7_in(p_7_in),
        .rst_IBUF(rst_IBUF),
        .val_reg_0(\rows[0].cols[2].gol_cell_inst_n_1 ),
        .val_reg_1(\rows[0].cols[2].gol_cell_inst_n_2 ),
        .val_reg_2(\rows[0].cols[3].gol_cell_inst_n_1 ),
        .val_reg_3(\rows[5].cols[1].gol_cell_inst_n_2 ));
  GOL_cell_2 \rows[0].cols[3].gol_cell_inst 
       (.\GOL_outputs[0]_1 (\GOL_outputs[0]_1 ),
        .\GOL_outputs[0]_2 (\GOL_outputs[0]_2 ),
        .\GOL_outputs[0]_3 (\GOL_outputs[0]_3 ),
        .\GOL_outputs[0]_4 (\GOL_outputs[0]_4 ),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .p_0_in(p_0_in),
        .p_1_in(p_1_in),
        .p_2_in(p_2_in),
        .p_6_in(p_6_in),
        .p_7_in(p_7_in),
        .p_8_in(p_8_in),
        .rst_IBUF(rst_IBUF),
        .val_reg_0(\rows[0].cols[3].gol_cell_inst_n_1 ),
        .val_reg_1(\rows[0].cols[3].gol_cell_inst_n_2 ),
        .val_reg_2(\rows[0].cols[4].gol_cell_inst_n_1 ),
        .val_reg_3(\rows[5].cols[2].gol_cell_inst_n_2 ));
  GOL_cell_3 \rows[0].cols[4].gol_cell_inst 
       (.\GOL_outputs[0]_2 (\GOL_outputs[0]_2 ),
        .\GOL_outputs[0]_3 (\GOL_outputs[0]_3 ),
        .\GOL_outputs[0]_4 (\GOL_outputs[0]_4 ),
        .\GOL_outputs[0]_5 (\GOL_outputs[0]_5 ),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .p_1_in(p_1_in),
        .p_2_in(p_2_in),
        .p_3_in(p_3_in),
        .p_7_in(p_7_in),
        .p_8_in(p_8_in),
        .p_9_in(p_9_in),
        .rst_IBUF(rst_IBUF),
        .val_reg_0(\rows[0].cols[4].gol_cell_inst_n_1 ),
        .val_reg_1(\rows[0].cols[4].gol_cell_inst_n_2 ),
        .val_reg_2(\rows[0].cols[5].gol_cell_inst_n_1 ),
        .val_reg_3(\rows[5].cols[3].gol_cell_inst_n_2 ));
  GOL_cell_4 \rows[0].cols[5].gol_cell_inst 
       (.\GOL_outputs[0]_0 (\GOL_outputs[0]_0 ),
        .\GOL_outputs[0]_3 (\GOL_outputs[0]_3 ),
        .\GOL_outputs[0]_4 (\GOL_outputs[0]_4 ),
        .\GOL_outputs[0]_5 (\GOL_outputs[0]_5 ),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .p_10_in(p_10_in),
        .p_2_in(p_2_in),
        .p_3_in(p_3_in),
        .p_4_in(p_4_in),
        .p_8_in(p_8_in),
        .p_9_in(p_9_in),
        .rst_IBUF(rst_IBUF),
        .val_reg_0(\rows[0].cols[5].gol_cell_inst_n_1 ),
        .val_reg_1(\rows[0].cols[5].gol_cell_inst_n_2 ),
        .val_reg_2(\rows[0].cols[0].gol_cell_inst_n_1 ),
        .val_reg_3(\rows[5].cols[4].gol_cell_inst_n_2 ));
  GOL_cell_5 \rows[1].cols[0].gol_cell_inst 
       (.\GOL_outputs[0]_0 (\GOL_outputs[0]_0 ),
        .\GOL_outputs[0]_4 (\GOL_outputs[0]_4 ),
        .\GOL_outputs[0]_5 (\GOL_outputs[0]_5 ),
        .\GOL_outputs[2] ({\GOL_outputs[2] [5:4],\GOL_outputs[2] [0]}),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .p_0_in(p_0_in),
        .p_3_in(p_3_in),
        .p_4_in(p_4_in),
        .p_5_in(p_5_in),
        .rst_IBUF(rst_IBUF),
        .val_reg_0(\rows[1].cols[0].gol_cell_inst_n_1 ),
        .val_reg_1(\rows[1].cols[0].gol_cell_inst_n_2 ),
        .val_reg_2(\rows[1].cols[1].gol_cell_inst_n_1 ),
        .val_reg_3(\rows[0].cols[5].gol_cell_inst_n_2 ));
  GOL_cell_6 \rows[1].cols[1].gol_cell_inst 
       (.\GOL_outputs[0]_0 (\GOL_outputs[0]_0 ),
        .\GOL_outputs[0]_1 (\GOL_outputs[0]_1 ),
        .\GOL_outputs[0]_5 (\GOL_outputs[0]_5 ),
        .\GOL_outputs[2] ({\GOL_outputs[2] [5],\GOL_outputs[2] [1:0]}),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .p_0_in(p_0_in),
        .p_1_in(p_1_in),
        .p_4_in(p_4_in),
        .p_5_in(p_5_in),
        .rst_IBUF(rst_IBUF),
        .val_reg_0(\rows[1].cols[1].gol_cell_inst_n_1 ),
        .val_reg_1(\rows[1].cols[1].gol_cell_inst_n_2 ),
        .val_reg_2(\rows[1].cols[2].gol_cell_inst_n_1 ),
        .val_reg_3(\rows[0].cols[0].gol_cell_inst_n_2 ));
  GOL_cell_7 \rows[1].cols[2].gol_cell_inst 
       (.\GOL_outputs[0]_0 (\GOL_outputs[0]_0 ),
        .\GOL_outputs[0]_1 (\GOL_outputs[0]_1 ),
        .\GOL_outputs[0]_2 (\GOL_outputs[0]_2 ),
        .\GOL_outputs[2] (\GOL_outputs[2] [2:0]),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .p_0_in(p_0_in),
        .p_1_in(p_1_in),
        .p_2_in(p_2_in),
        .p_5_in(p_5_in),
        .rst_IBUF(rst_IBUF),
        .val_reg_0(\rows[1].cols[2].gol_cell_inst_n_1 ),
        .val_reg_1(\rows[1].cols[2].gol_cell_inst_n_2 ),
        .val_reg_2(\rows[1].cols[3].gol_cell_inst_n_1 ),
        .val_reg_3(\rows[0].cols[1].gol_cell_inst_n_2 ));
  GOL_cell_8 \rows[1].cols[3].gol_cell_inst 
       (.\GOL_outputs[0]_1 (\GOL_outputs[0]_1 ),
        .\GOL_outputs[0]_2 (\GOL_outputs[0]_2 ),
        .\GOL_outputs[0]_3 (\GOL_outputs[0]_3 ),
        .\GOL_outputs[2] (\GOL_outputs[2] [3:1]),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .p_0_in(p_0_in),
        .p_1_in(p_1_in),
        .p_2_in(p_2_in),
        .p_3_in(p_3_in),
        .rst_IBUF(rst_IBUF),
        .val_reg_0(\rows[1].cols[3].gol_cell_inst_n_1 ),
        .val_reg_1(\rows[1].cols[3].gol_cell_inst_n_2 ),
        .val_reg_2(\rows[1].cols[4].gol_cell_inst_n_1 ),
        .val_reg_3(\rows[0].cols[2].gol_cell_inst_n_2 ));
  GOL_cell_9 \rows[1].cols[4].gol_cell_inst 
       (.\GOL_outputs[0]_2 (\GOL_outputs[0]_2 ),
        .\GOL_outputs[0]_3 (\GOL_outputs[0]_3 ),
        .\GOL_outputs[0]_4 (\GOL_outputs[0]_4 ),
        .\GOL_outputs[2] (\GOL_outputs[2] [4:2]),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .p_1_in(p_1_in),
        .p_2_in(p_2_in),
        .p_3_in(p_3_in),
        .p_4_in(p_4_in),
        .rst_IBUF(rst_IBUF),
        .val_reg_0(\rows[1].cols[4].gol_cell_inst_n_1 ),
        .val_reg_1(\rows[1].cols[4].gol_cell_inst_n_2 ),
        .val_reg_2(\rows[1].cols[5].gol_cell_inst_n_1 ),
        .val_reg_3(\rows[0].cols[3].gol_cell_inst_n_2 ));
  GOL_cell_10 \rows[1].cols[5].gol_cell_inst 
       (.\GOL_outputs[0]_3 (\GOL_outputs[0]_3 ),
        .\GOL_outputs[0]_4 (\GOL_outputs[0]_4 ),
        .\GOL_outputs[0]_5 (\GOL_outputs[0]_5 ),
        .\GOL_outputs[2] (\GOL_outputs[2] [5:3]),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .p_2_in(p_2_in),
        .p_3_in(p_3_in),
        .p_4_in(p_4_in),
        .p_5_in(p_5_in),
        .rst_IBUF(rst_IBUF),
        .val_reg_0(\rows[1].cols[5].gol_cell_inst_n_1 ),
        .val_reg_1(\rows[1].cols[5].gol_cell_inst_n_2 ),
        .val_reg_2(\rows[1].cols[0].gol_cell_inst_n_1 ),
        .val_reg_3(\rows[0].cols[4].gol_cell_inst_n_2 ));
  GOL_cell_11 \rows[2].cols[0].gol_cell_inst 
       (.\GOL_outputs[2] (\GOL_outputs[2] [0]),
        .\GOL_outputs[3] ({\GOL_outputs[3] [5:4],\GOL_outputs[3] [0]}),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .p_3_in(p_3_in),
        .p_4_in(p_4_in),
        .p_5_in(p_5_in),
        .rst_IBUF(rst_IBUF),
        .val_reg_0(\rows[2].cols[0].gol_cell_inst_n_1 ),
        .val_reg_1(\rows[2].cols[0].gol_cell_inst_n_2 ),
        .val_reg_2(\rows[2].cols[1].gol_cell_inst_n_1 ),
        .val_reg_3({\GOL_outputs[2] [5:4],\GOL_outputs[2] [1]}),
        .val_reg_4(\rows[1].cols[5].gol_cell_inst_n_2 ));
  GOL_cell_12 \rows[2].cols[1].gol_cell_inst 
       (.\GOL_outputs[2] ({\GOL_outputs[2] [5],\GOL_outputs[2] [2],\GOL_outputs[2] [0]}),
        .\GOL_outputs[3] ({\GOL_outputs[3] [5],\GOL_outputs[3] [1:0]}),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .p_0_in(p_0_in),
        .p_4_in(p_4_in),
        .p_5_in(p_5_in),
        .rst_IBUF(rst_IBUF),
        .val_reg_0(\GOL_outputs[2] [1]),
        .val_reg_1(\rows[2].cols[1].gol_cell_inst_n_1 ),
        .val_reg_2(\rows[2].cols[1].gol_cell_inst_n_2 ),
        .val_reg_3(\rows[2].cols[2].gol_cell_inst_n_1 ),
        .val_reg_4(\rows[1].cols[0].gol_cell_inst_n_2 ));
  GOL_cell_13 \rows[2].cols[2].gol_cell_inst 
       (.\GOL_outputs[2] (\GOL_outputs[2] [2]),
        .\GOL_outputs[3] (\GOL_outputs[3] [2:0]),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .p_0_in(p_0_in),
        .p_1_in(p_1_in),
        .p_5_in(p_5_in),
        .rst_IBUF(rst_IBUF),
        .val_reg_0(\rows[2].cols[2].gol_cell_inst_n_1 ),
        .val_reg_1(\rows[2].cols[2].gol_cell_inst_n_2 ),
        .val_reg_2(\rows[2].cols[3].gol_cell_inst_n_1 ),
        .val_reg_3({\GOL_outputs[2] [3],\GOL_outputs[2] [1:0]}),
        .val_reg_4(\rows[1].cols[1].gol_cell_inst_n_2 ));
  GOL_cell_14 \rows[2].cols[3].gol_cell_inst 
       (.\GOL_outputs[2] ({\GOL_outputs[2] [4],\GOL_outputs[2] [2:1]}),
        .\GOL_outputs[3] (\GOL_outputs[3] [3:1]),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .p_0_in(p_0_in),
        .p_1_in(p_1_in),
        .p_2_in(p_2_in),
        .rst_IBUF(rst_IBUF),
        .val_reg_0(\GOL_outputs[2] [3]),
        .val_reg_1(\rows[2].cols[3].gol_cell_inst_n_1 ),
        .val_reg_2(\rows[2].cols[3].gol_cell_inst_n_2 ),
        .val_reg_3(\rows[2].cols[4].gol_cell_inst_n_1 ),
        .val_reg_4(\rows[1].cols[2].gol_cell_inst_n_2 ));
  GOL_cell_15 \rows[2].cols[4].gol_cell_inst 
       (.\GOL_outputs[2] (\GOL_outputs[2] [4]),
        .\GOL_outputs[3] (\GOL_outputs[3] [4:2]),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .p_1_in(p_1_in),
        .p_2_in(p_2_in),
        .p_3_in(p_3_in),
        .rst_IBUF(rst_IBUF),
        .val_reg_0(\rows[2].cols[4].gol_cell_inst_n_1 ),
        .val_reg_1(\rows[2].cols[4].gol_cell_inst_n_2 ),
        .val_reg_2(\rows[2].cols[5].gol_cell_inst_n_1 ),
        .val_reg_3({\GOL_outputs[2] [5],\GOL_outputs[2] [3:2]}),
        .val_reg_4(\rows[1].cols[3].gol_cell_inst_n_2 ));
  GOL_cell_16 \rows[2].cols[5].gol_cell_inst 
       (.\GOL_outputs[2] ({\GOL_outputs[2] [4:3],\GOL_outputs[2] [0]}),
        .\GOL_outputs[3] (\GOL_outputs[3] [5:3]),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .p_2_in(p_2_in),
        .p_3_in(p_3_in),
        .p_4_in(p_4_in),
        .rst_IBUF(rst_IBUF),
        .val_reg_0(\GOL_outputs[2] [5]),
        .val_reg_1(\rows[2].cols[5].gol_cell_inst_n_1 ),
        .val_reg_2(\rows[2].cols[5].gol_cell_inst_n_2 ),
        .val_reg_3(\rows[2].cols[0].gol_cell_inst_n_1 ),
        .val_reg_4(\rows[1].cols[4].gol_cell_inst_n_2 ));
  GOL_cell_17 \rows[3].cols[0].gol_cell_inst 
       (.\GOL_outputs[0]_0 (\GOL_outputs[0]_0 ),
        .\GOL_outputs[2] ({\GOL_outputs[2] [5:4],\GOL_outputs[2] [0]}),
        .\GOL_outputs[3] (\GOL_outputs[3] [0]),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .\col[0] (\rows[3].cols[0].gol_cell_inst_n_2 ),
        .col_IBUF(col_IBUF[0]),
        .p_0_out(p_0_out),
        .p_1_out(p_1_out),
        .p_5_in(p_5_in),
        .p_5_out(p_5_out),
        .row_IBUF(row_IBUF),
        .rst_IBUF(rst_IBUF),
        .val_OBUF_inst_i_1(\GOL_outputs[5] [1]),
        .val_OBUF_inst_i_4_0(\rows[5].cols[0].gol_cell_inst_n_3 ),
        .val_reg_0(\rows[3].cols[0].gol_cell_inst_n_1 ),
        .val_reg_1(\rows[3].cols[0].gol_cell_inst_n_3 ),
        .val_reg_2(\rows[3].cols[1].gol_cell_inst_n_1 ),
        .val_reg_3({\GOL_outputs[3] [5:4],\GOL_outputs[3] [1]}),
        .val_reg_4(\rows[2].cols[5].gol_cell_inst_n_2 ));
  GOL_cell_18 \rows[3].cols[1].gol_cell_inst 
       (.\GOL_outputs[0]_1 (\GOL_outputs[0]_1 ),
        .\GOL_outputs[2] ({\GOL_outputs[2] [5],\GOL_outputs[2] [1:0]}),
        .\GOL_outputs[3] ({\GOL_outputs[3] [5],\GOL_outputs[3] [2],\GOL_outputs[3] [0]}),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .p_0_in(p_0_in),
        .p_0_out(p_0_out),
        .p_4_out(p_4_out),
        .p_5_out(p_5_out),
        .\row[2] (\GOL_outputs[5] [1]),
        .row_IBUF(row_IBUF),
        .rst_IBUF(rst_IBUF),
        .val_OBUF_inst_i_4(\rows[5].cols[1].gol_cell_inst_n_3 ),
        .val_reg_0(\GOL_outputs[3] [1]),
        .val_reg_1(\rows[3].cols[1].gol_cell_inst_n_1 ),
        .val_reg_2(\rows[3].cols[1].gol_cell_inst_n_2 ),
        .val_reg_3(\rows[3].cols[2].gol_cell_inst_n_1 ),
        .val_reg_4(\rows[2].cols[0].gol_cell_inst_n_2 ));
  GOL_cell_19 \rows[3].cols[2].gol_cell_inst 
       (.\GOL_outputs[0]_2 (\GOL_outputs[0]_2 ),
        .\GOL_outputs[2] (\GOL_outputs[2] [2:0]),
        .\GOL_outputs[3] (\GOL_outputs[3] [2]),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .\col[0] (\rows[3].cols[2].gol_cell_inst_n_2 ),
        .col_IBUF(col_IBUF[0]),
        .p_1_in(p_1_in),
        .p_3_out(p_3_out),
        .p_4_out(p_4_out),
        .p_5_out(p_5_out),
        .row_IBUF(row_IBUF),
        .rst_IBUF(rst_IBUF),
        .val_OBUF_inst_i_1(\GOL_outputs[5] [3]),
        .val_OBUF_inst_i_3_0(\rows[5].cols[2].gol_cell_inst_n_3 ),
        .val_reg_0(\rows[3].cols[2].gol_cell_inst_n_1 ),
        .val_reg_1(\rows[3].cols[2].gol_cell_inst_n_3 ),
        .val_reg_2(\rows[3].cols[3].gol_cell_inst_n_1 ),
        .val_reg_3({\GOL_outputs[3] [3],\GOL_outputs[3] [1:0]}),
        .val_reg_4(\rows[2].cols[1].gol_cell_inst_n_2 ));
  GOL_cell_20 \rows[3].cols[3].gol_cell_inst 
       (.\GOL_outputs[0]_3 (\GOL_outputs[0]_3 ),
        .\GOL_outputs[2] (\GOL_outputs[2] [3:1]),
        .\GOL_outputs[3] ({\GOL_outputs[3] [4],\GOL_outputs[3] [2:1]}),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .p_2_in(p_2_in),
        .p_2_out(p_2_out),
        .p_3_out(p_3_out),
        .p_4_out(p_4_out),
        .\row[2] (\GOL_outputs[5] [3]),
        .row_IBUF(row_IBUF),
        .rst_IBUF(rst_IBUF),
        .val_OBUF_inst_i_3(\rows[5].cols[3].gol_cell_inst_n_3 ),
        .val_reg_0(\GOL_outputs[3] [3]),
        .val_reg_1(\rows[3].cols[3].gol_cell_inst_n_1 ),
        .val_reg_2(\rows[3].cols[3].gol_cell_inst_n_2 ),
        .val_reg_3(\rows[3].cols[4].gol_cell_inst_n_1 ),
        .val_reg_4(\rows[2].cols[2].gol_cell_inst_n_2 ));
  GOL_cell_21 \rows[3].cols[4].gol_cell_inst 
       (.\GOL_outputs[0]_4 (\GOL_outputs[0]_4 ),
        .\GOL_outputs[2] (\GOL_outputs[2] [4:2]),
        .\GOL_outputs[3] (\GOL_outputs[3] [4]),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .col_IBUF(col_IBUF),
        .p_1_out(p_1_out),
        .p_2_out(p_2_out),
        .p_3_in(p_3_in),
        .p_3_out(p_3_out),
        .row_IBUF(row_IBUF),
        .rst_IBUF(rst_IBUF),
        .val(\rows[3].cols[2].gol_cell_inst_n_2 ),
        .val_0(\rows[3].cols[0].gol_cell_inst_n_2 ),
        .val_OBUF(val_OBUF),
        .val_OBUF_inst_i_1_0(\GOL_outputs[5] [5]),
        .val_OBUF_inst_i_2_0(\rows[5].cols[4].gol_cell_inst_n_3 ),
        .val_reg_0(\rows[3].cols[4].gol_cell_inst_n_1 ),
        .val_reg_1(\rows[3].cols[4].gol_cell_inst_n_3 ),
        .val_reg_2(\rows[3].cols[5].gol_cell_inst_n_1 ),
        .val_reg_3({\GOL_outputs[3] [5],\GOL_outputs[3] [3:2]}),
        .val_reg_4(\rows[2].cols[3].gol_cell_inst_n_2 ));
  GOL_cell_22 \rows[3].cols[5].gol_cell_inst 
       (.\GOL_outputs[0]_5 (\GOL_outputs[0]_5 ),
        .\GOL_outputs[2] (\GOL_outputs[2] [5:3]),
        .\GOL_outputs[3] ({\GOL_outputs[3] [4:3],\GOL_outputs[3] [0]}),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .p_0_out(p_0_out),
        .p_1_out(p_1_out),
        .p_2_out(p_2_out),
        .p_4_in(p_4_in),
        .\row[2] (\GOL_outputs[5] [5]),
        .row_IBUF(row_IBUF),
        .rst_IBUF(rst_IBUF),
        .val_OBUF_inst_i_2(\rows[5].cols[5].gol_cell_inst_n_3 ),
        .val_reg_0(\GOL_outputs[3] [5]),
        .val_reg_1(\rows[3].cols[5].gol_cell_inst_n_1 ),
        .val_reg_2(\rows[3].cols[5].gol_cell_inst_n_2 ),
        .val_reg_3(\rows[3].cols[0].gol_cell_inst_n_1 ),
        .val_reg_4(\rows[2].cols[4].gol_cell_inst_n_2 ));
  GOL_cell_23 \rows[4].cols[0].gol_cell_inst 
       (.\GOL_outputs[3] ({\GOL_outputs[3] [5:4],\GOL_outputs[3] [0]}),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .p_0_out(p_0_out),
        .p_10_in(p_10_in),
        .p_11_in(p_11_in),
        .p_1_out(p_1_out),
        .p_4_out(p_4_out),
        .p_5_out(p_5_out),
        .p_9_in(p_9_in),
        .rst_IBUF(rst_IBUF),
        .val_reg_0(\rows[4].cols[0].gol_cell_inst_n_1 ),
        .val_reg_1(\rows[4].cols[0].gol_cell_inst_n_2 ),
        .val_reg_2(\rows[4].cols[1].gol_cell_inst_n_1 ),
        .val_reg_3(\rows[3].cols[5].gol_cell_inst_n_2 ));
  GOL_cell_24 \rows[4].cols[1].gol_cell_inst 
       (.\GOL_outputs[3] ({\GOL_outputs[3] [5],\GOL_outputs[3] [1:0]}),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .p_0_out(p_0_out),
        .p_10_in(p_10_in),
        .p_11_in(p_11_in),
        .p_3_out(p_3_out),
        .p_4_out(p_4_out),
        .p_5_out(p_5_out),
        .p_6_in(p_6_in),
        .rst_IBUF(rst_IBUF),
        .val_reg_0(\rows[4].cols[1].gol_cell_inst_n_1 ),
        .val_reg_1(\rows[4].cols[1].gol_cell_inst_n_2 ),
        .val_reg_2(\rows[4].cols[2].gol_cell_inst_n_1 ),
        .val_reg_3(\rows[3].cols[0].gol_cell_inst_n_3 ));
  GOL_cell_25 \rows[4].cols[2].gol_cell_inst 
       (.\GOL_outputs[3] (\GOL_outputs[3] [2:0]),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .p_11_in(p_11_in),
        .p_2_out(p_2_out),
        .p_3_out(p_3_out),
        .p_4_out(p_4_out),
        .p_5_out(p_5_out),
        .p_6_in(p_6_in),
        .p_7_in(p_7_in),
        .rst_IBUF(rst_IBUF),
        .val_reg_0(\rows[4].cols[2].gol_cell_inst_n_1 ),
        .val_reg_1(\rows[4].cols[2].gol_cell_inst_n_2 ),
        .val_reg_2(\rows[4].cols[3].gol_cell_inst_n_1 ),
        .val_reg_3(\rows[3].cols[1].gol_cell_inst_n_2 ));
  GOL_cell_26 \rows[4].cols[3].gol_cell_inst 
       (.\GOL_outputs[3] (\GOL_outputs[3] [3:1]),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .p_1_out(p_1_out),
        .p_2_out(p_2_out),
        .p_3_out(p_3_out),
        .p_4_out(p_4_out),
        .p_6_in(p_6_in),
        .p_7_in(p_7_in),
        .p_8_in(p_8_in),
        .rst_IBUF(rst_IBUF),
        .val_reg_0(\rows[4].cols[3].gol_cell_inst_n_1 ),
        .val_reg_1(\rows[4].cols[3].gol_cell_inst_n_2 ),
        .val_reg_2(\rows[4].cols[4].gol_cell_inst_n_1 ),
        .val_reg_3(\rows[3].cols[2].gol_cell_inst_n_3 ));
  GOL_cell_27 \rows[4].cols[4].gol_cell_inst 
       (.\GOL_outputs[3] (\GOL_outputs[3] [4:2]),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .p_0_out(p_0_out),
        .p_1_out(p_1_out),
        .p_2_out(p_2_out),
        .p_3_out(p_3_out),
        .p_7_in(p_7_in),
        .p_8_in(p_8_in),
        .p_9_in(p_9_in),
        .rst_IBUF(rst_IBUF),
        .val_reg_0(\rows[4].cols[4].gol_cell_inst_n_1 ),
        .val_reg_1(\rows[4].cols[4].gol_cell_inst_n_2 ),
        .val_reg_2(\rows[4].cols[5].gol_cell_inst_n_1 ),
        .val_reg_3(\rows[3].cols[3].gol_cell_inst_n_2 ));
  GOL_cell_28 \rows[4].cols[5].gol_cell_inst 
       (.\GOL_outputs[3] (\GOL_outputs[3] [5:3]),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .p_0_out(p_0_out),
        .p_10_in(p_10_in),
        .p_1_out(p_1_out),
        .p_2_out(p_2_out),
        .p_5_out(p_5_out),
        .p_8_in(p_8_in),
        .p_9_in(p_9_in),
        .rst_IBUF(rst_IBUF),
        .val_reg_0(\rows[4].cols[5].gol_cell_inst_n_1 ),
        .val_reg_1(\rows[4].cols[5].gol_cell_inst_n_2 ),
        .val_reg_2(\rows[4].cols[0].gol_cell_inst_n_1 ),
        .val_reg_3(\rows[3].cols[4].gol_cell_inst_n_3 ));
  GOL_cell_29 \rows[5].cols[0].gol_cell_inst 
       (.\GOL_outputs[0]_0 (\GOL_outputs[0]_0 ),
        .\GOL_outputs[0]_4 (\GOL_outputs[0]_4 ),
        .\GOL_outputs[0]_5 (\GOL_outputs[0]_5 ),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .p_0_out(p_0_out),
        .p_10_in(p_10_in),
        .p_11_in(p_11_in),
        .p_1_out(p_1_out),
        .p_5_out(p_5_out),
        .p_6_in(p_6_in),
        .p_9_in(p_9_in),
        .row_IBUF(row_IBUF[0]),
        .rst_IBUF(rst_IBUF),
        .val_reg_0(\rows[5].cols[0].gol_cell_inst_n_1 ),
        .val_reg_1(\rows[5].cols[0].gol_cell_inst_n_2 ),
        .val_reg_2(\rows[5].cols[0].gol_cell_inst_n_3 ),
        .val_reg_3(\rows[5].cols[1].gol_cell_inst_n_1 ),
        .val_reg_4(\rows[4].cols[5].gol_cell_inst_n_2 ));
  GOL_cell_30 \rows[5].cols[1].gol_cell_inst 
       (.\GOL_outputs[0]_0 (\GOL_outputs[0]_0 ),
        .\GOL_outputs[0]_1 (\GOL_outputs[0]_1 ),
        .\GOL_outputs[0]_5 (\GOL_outputs[0]_5 ),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .p_0_out(p_0_out),
        .p_10_in(p_10_in),
        .p_11_in(p_11_in),
        .p_4_out(p_4_out),
        .p_5_out(p_5_out),
        .p_6_in(p_6_in),
        .p_7_in(p_7_in),
        .row_IBUF(row_IBUF[0]),
        .rst_IBUF(rst_IBUF),
        .val_reg_0(\rows[5].cols[1].gol_cell_inst_n_1 ),
        .val_reg_1(\rows[5].cols[1].gol_cell_inst_n_2 ),
        .val_reg_2(\rows[5].cols[1].gol_cell_inst_n_3 ),
        .val_reg_3(\rows[5].cols[2].gol_cell_inst_n_1 ),
        .val_reg_4(\rows[4].cols[0].gol_cell_inst_n_2 ));
  GOL_cell_31 \rows[5].cols[2].gol_cell_inst 
       (.\GOL_outputs[0]_0 (\GOL_outputs[0]_0 ),
        .\GOL_outputs[0]_1 (\GOL_outputs[0]_1 ),
        .\GOL_outputs[0]_2 (\GOL_outputs[0]_2 ),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .p_11_in(p_11_in),
        .p_3_out(p_3_out),
        .p_4_out(p_4_out),
        .p_5_out(p_5_out),
        .p_6_in(p_6_in),
        .p_7_in(p_7_in),
        .p_8_in(p_8_in),
        .row_IBUF(row_IBUF[0]),
        .rst_IBUF(rst_IBUF),
        .val_reg_0(\rows[5].cols[2].gol_cell_inst_n_1 ),
        .val_reg_1(\rows[5].cols[2].gol_cell_inst_n_2 ),
        .val_reg_2(\rows[5].cols[2].gol_cell_inst_n_3 ),
        .val_reg_3(\rows[5].cols[3].gol_cell_inst_n_1 ),
        .val_reg_4(\rows[4].cols[1].gol_cell_inst_n_2 ));
  GOL_cell_32 \rows[5].cols[3].gol_cell_inst 
       (.\GOL_outputs[0]_1 (\GOL_outputs[0]_1 ),
        .\GOL_outputs[0]_2 (\GOL_outputs[0]_2 ),
        .\GOL_outputs[0]_3 (\GOL_outputs[0]_3 ),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .p_2_out(p_2_out),
        .p_3_out(p_3_out),
        .p_4_out(p_4_out),
        .p_6_in(p_6_in),
        .p_7_in(p_7_in),
        .p_8_in(p_8_in),
        .p_9_in(p_9_in),
        .row_IBUF(row_IBUF[0]),
        .rst_IBUF(rst_IBUF),
        .val_reg_0(\rows[5].cols[3].gol_cell_inst_n_1 ),
        .val_reg_1(\rows[5].cols[3].gol_cell_inst_n_2 ),
        .val_reg_2(\rows[5].cols[3].gol_cell_inst_n_3 ),
        .val_reg_3(\rows[5].cols[4].gol_cell_inst_n_1 ),
        .val_reg_4(\rows[4].cols[2].gol_cell_inst_n_2 ));
  GOL_cell_33 \rows[5].cols[4].gol_cell_inst 
       (.\GOL_outputs[0]_2 (\GOL_outputs[0]_2 ),
        .\GOL_outputs[0]_3 (\GOL_outputs[0]_3 ),
        .\GOL_outputs[0]_4 (\GOL_outputs[0]_4 ),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .p_10_in(p_10_in),
        .p_1_out(p_1_out),
        .p_2_out(p_2_out),
        .p_3_out(p_3_out),
        .p_7_in(p_7_in),
        .p_8_in(p_8_in),
        .p_9_in(p_9_in),
        .row_IBUF(row_IBUF[0]),
        .rst_IBUF(rst_IBUF),
        .val_reg_0(\rows[5].cols[4].gol_cell_inst_n_1 ),
        .val_reg_1(\rows[5].cols[4].gol_cell_inst_n_2 ),
        .val_reg_2(\rows[5].cols[4].gol_cell_inst_n_3 ),
        .val_reg_3(\rows[5].cols[5].gol_cell_inst_n_1 ),
        .val_reg_4(\rows[4].cols[3].gol_cell_inst_n_2 ));
  GOL_cell_34 \rows[5].cols[5].gol_cell_inst 
       (.\GOL_outputs[0]_3 (\GOL_outputs[0]_3 ),
        .\GOL_outputs[0]_4 (\GOL_outputs[0]_4 ),
        .\GOL_outputs[0]_5 (\GOL_outputs[0]_5 ),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .p_0_out(p_0_out),
        .p_10_in(p_10_in),
        .p_11_in(p_11_in),
        .p_1_out(p_1_out),
        .p_2_out(p_2_out),
        .p_8_in(p_8_in),
        .p_9_in(p_9_in),
        .row_IBUF(row_IBUF[0]),
        .rst_IBUF(rst_IBUF),
        .val_reg_0(\rows[5].cols[5].gol_cell_inst_n_1 ),
        .val_reg_1(\rows[5].cols[5].gol_cell_inst_n_2 ),
        .val_reg_2(\rows[5].cols[5].gol_cell_inst_n_3 ),
        .val_reg_3(\rows[5].cols[0].gol_cell_inst_n_1 ),
        .val_reg_4(\rows[4].cols[4].gol_cell_inst_n_2 ));
  IBUF rst_IBUF_inst
       (.I(rst),
        .O(rst_IBUF));
  OBUF val_OBUF_inst
       (.I(val_OBUF),
        .O(val));
endmodule

module GOL_cell
   (\GOL_outputs[0]_0 ,
    val_reg_0,
    val_reg_1,
    rst_IBUF,
    val_reg_2,
    clk_IBUF_BUFG,
    \GOL_outputs[0]_5 ,
    val_reg_3,
    p_9_in,
    p_5_in,
    p_3_in,
    p_4_in,
    p_10_in,
    p_11_in,
    \GOL_outputs[0]_4 ,
    \GOL_outputs[0]_1 );
  output \GOL_outputs[0]_0 ;
  output val_reg_0;
  output val_reg_1;
  input rst_IBUF;
  input val_reg_2;
  input clk_IBUF_BUFG;
  input \GOL_outputs[0]_5 ;
  input val_reg_3;
  input p_9_in;
  input p_5_in;
  input p_3_in;
  input p_4_in;
  input p_10_in;
  input p_11_in;
  input \GOL_outputs[0]_4 ;
  input \GOL_outputs[0]_1 ;

  wire \GOL_outputs[0]_0 ;
  wire \GOL_outputs[0]_1 ;
  wire \GOL_outputs[0]_4 ;
  wire \GOL_outputs[0]_5 ;
  wire clk_IBUF_BUFG;
  wire p_10_in;
  wire p_11_in;
  wire p_3_in;
  wire p_4_in;
  wire p_5_in;
  wire p_9_in;
  wire rst_IBUF;
  wire val_i_2__6_n_0;
  wire val_i_3__4_n_0;
  wire val_reg_0;
  wire val_reg_1;
  wire val_reg_2;
  wire val_reg_3;

  LUT6 #(
    .INIT(64'h8332322C322C2CC8)) 
    val_i_1__4
       (.I0(\GOL_outputs[0]_5 ),
        .I1(val_i_2__6_n_0),
        .I2(val_i_3__4_n_0),
        .I3(val_reg_3),
        .I4(p_9_in),
        .I5(p_5_in),
        .O(val_reg_0));
  LUT6 #(
    .INIT(64'h171717E817E8E8E8)) 
    val_i_2__6
       (.I0(\GOL_outputs[0]_0 ),
        .I1(p_3_in),
        .I2(p_4_in),
        .I3(p_10_in),
        .I4(p_11_in),
        .I5(\GOL_outputs[0]_4 ),
        .O(val_i_2__6_n_0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_3__4
       (.I0(\GOL_outputs[0]_0 ),
        .I1(p_4_in),
        .I2(p_3_in),
        .O(val_i_3__4_n_0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_4__5
       (.I0(\GOL_outputs[0]_0 ),
        .I1(p_4_in),
        .I2(\GOL_outputs[0]_1 ),
        .O(val_reg_1));
  FDRE #(
    .INIT(1'b0)) 
    val_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(val_reg_2),
        .Q(\GOL_outputs[0]_0 ),
        .R(rst_IBUF));
endmodule

(* ORIG_REF_NAME = "GOL_cell" *) 
module GOL_cell_0
   (\GOL_outputs[0]_1 ,
    val_reg_0,
    val_reg_1,
    rst_IBUF,
    val_reg_2,
    clk_IBUF_BUFG,
    \GOL_outputs[0]_0 ,
    val_reg_3,
    p_10_in,
    p_0_in,
    p_4_in,
    p_5_in,
    p_11_in,
    p_6_in,
    \GOL_outputs[0]_5 ,
    \GOL_outputs[0]_2 );
  output \GOL_outputs[0]_1 ;
  output val_reg_0;
  output val_reg_1;
  input rst_IBUF;
  input val_reg_2;
  input clk_IBUF_BUFG;
  input \GOL_outputs[0]_0 ;
  input val_reg_3;
  input p_10_in;
  input p_0_in;
  input p_4_in;
  input p_5_in;
  input p_11_in;
  input p_6_in;
  input \GOL_outputs[0]_5 ;
  input \GOL_outputs[0]_2 ;

  wire \GOL_outputs[0]_0 ;
  wire \GOL_outputs[0]_1 ;
  wire \GOL_outputs[0]_2 ;
  wire \GOL_outputs[0]_5 ;
  wire clk_IBUF_BUFG;
  wire p_0_in;
  wire p_10_in;
  wire p_11_in;
  wire p_4_in;
  wire p_5_in;
  wire p_6_in;
  wire rst_IBUF;
  wire val_i_2__0_n_0;
  wire val_i_3_n_0;
  wire val_reg_0;
  wire val_reg_1;
  wire val_reg_2;
  wire val_reg_3;

  LUT6 #(
    .INIT(64'h8332322C322C2CC8)) 
    val_i_1
       (.I0(\GOL_outputs[0]_0 ),
        .I1(val_i_2__0_n_0),
        .I2(val_i_3_n_0),
        .I3(val_reg_3),
        .I4(p_10_in),
        .I5(p_0_in),
        .O(val_reg_0));
  LUT6 #(
    .INIT(64'h171717E817E8E8E8)) 
    val_i_2__0
       (.I0(\GOL_outputs[0]_1 ),
        .I1(p_4_in),
        .I2(p_5_in),
        .I3(p_11_in),
        .I4(p_6_in),
        .I5(\GOL_outputs[0]_5 ),
        .O(val_i_2__0_n_0));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_3
       (.I0(\GOL_outputs[0]_1 ),
        .I1(p_5_in),
        .I2(p_4_in),
        .O(val_i_3_n_0));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_4__6
       (.I0(\GOL_outputs[0]_1 ),
        .I1(p_5_in),
        .I2(\GOL_outputs[0]_2 ),
        .O(val_reg_1));
  FDRE #(
    .INIT(1'b0)) 
    val_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(val_reg_2),
        .Q(\GOL_outputs[0]_1 ),
        .R(rst_IBUF));
endmodule

(* ORIG_REF_NAME = "GOL_cell" *) 
module GOL_cell_1
   (\GOL_outputs[0]_2 ,
    val_reg_0,
    val_reg_1,
    rst_IBUF,
    val_reg_2,
    clk_IBUF_BUFG,
    \GOL_outputs[0]_1 ,
    val_reg_3,
    p_11_in,
    p_1_in,
    p_5_in,
    p_0_in,
    p_6_in,
    p_7_in,
    \GOL_outputs[0]_0 ,
    \GOL_outputs[0]_3 );
  output \GOL_outputs[0]_2 ;
  output val_reg_0;
  output val_reg_1;
  input rst_IBUF;
  input val_reg_2;
  input clk_IBUF_BUFG;
  input \GOL_outputs[0]_1 ;
  input val_reg_3;
  input p_11_in;
  input p_1_in;
  input p_5_in;
  input p_0_in;
  input p_6_in;
  input p_7_in;
  input \GOL_outputs[0]_0 ;
  input \GOL_outputs[0]_3 ;

  wire \GOL_outputs[0]_0 ;
  wire \GOL_outputs[0]_1 ;
  wire \GOL_outputs[0]_2 ;
  wire \GOL_outputs[0]_3 ;
  wire clk_IBUF_BUFG;
  wire p_0_in;
  wire p_11_in;
  wire p_1_in;
  wire p_5_in;
  wire p_6_in;
  wire p_7_in;
  wire rst_IBUF;
  wire val_i_2__12_n_0;
  wire val_i_3__0_n_0;
  wire val_reg_0;
  wire val_reg_1;
  wire val_reg_2;
  wire val_reg_3;

  LUT6 #(
    .INIT(64'h8332322C322C2CC8)) 
    val_i_1__0
       (.I0(\GOL_outputs[0]_1 ),
        .I1(val_i_2__12_n_0),
        .I2(val_i_3__0_n_0),
        .I3(val_reg_3),
        .I4(p_11_in),
        .I5(p_1_in),
        .O(val_reg_0));
  LUT6 #(
    .INIT(64'h171717E817E8E8E8)) 
    val_i_2__12
       (.I0(\GOL_outputs[0]_2 ),
        .I1(p_5_in),
        .I2(p_0_in),
        .I3(p_6_in),
        .I4(p_7_in),
        .I5(\GOL_outputs[0]_0 ),
        .O(val_i_2__12_n_0));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_3__0
       (.I0(\GOL_outputs[0]_2 ),
        .I1(p_0_in),
        .I2(p_5_in),
        .O(val_i_3__0_n_0));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_4__7
       (.I0(\GOL_outputs[0]_2 ),
        .I1(p_0_in),
        .I2(\GOL_outputs[0]_3 ),
        .O(val_reg_1));
  FDSE #(
    .INIT(1'b0)) 
    val_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(val_reg_2),
        .Q(\GOL_outputs[0]_2 ),
        .S(rst_IBUF));
endmodule

(* ORIG_REF_NAME = "GOL_cell" *) 
module GOL_cell_10
   (p_4_in,
    val_reg_0,
    val_reg_1,
    rst_IBUF,
    val_reg_2,
    clk_IBUF_BUFG,
    p_3_in,
    val_reg_3,
    \GOL_outputs[0]_3 ,
    \GOL_outputs[2] ,
    \GOL_outputs[0]_4 ,
    \GOL_outputs[0]_5 ,
    p_2_in,
    p_5_in);
  output p_4_in;
  output val_reg_0;
  output val_reg_1;
  input rst_IBUF;
  input val_reg_2;
  input clk_IBUF_BUFG;
  input p_3_in;
  input val_reg_3;
  input \GOL_outputs[0]_3 ;
  input [2:0]\GOL_outputs[2] ;
  input \GOL_outputs[0]_4 ;
  input \GOL_outputs[0]_5 ;
  input p_2_in;
  input p_5_in;

  wire \GOL_outputs[0]_3 ;
  wire \GOL_outputs[0]_4 ;
  wire \GOL_outputs[0]_5 ;
  wire [2:0]\GOL_outputs[2] ;
  wire clk_IBUF_BUFG;
  wire p_2_in;
  wire p_3_in;
  wire p_4_in;
  wire p_5_in;
  wire rst_IBUF;
  wire val_i_2__30_n_0;
  wire val_i_3__9_n_0;
  wire val_reg_0;
  wire val_reg_1;
  wire val_reg_2;
  wire val_reg_3;

  LUT6 #(
    .INIT(64'h8332322C322C2CC8)) 
    val_i_1__9
       (.I0(p_3_in),
        .I1(val_i_2__30_n_0),
        .I2(val_i_3__9_n_0),
        .I3(val_reg_3),
        .I4(\GOL_outputs[0]_3 ),
        .I5(\GOL_outputs[2] [2]),
        .O(val_reg_0));
  LUT6 #(
    .INIT(64'h171717E817E8E8E8)) 
    val_i_2__30
       (.I0(p_4_in),
        .I1(\GOL_outputs[2] [0]),
        .I2(\GOL_outputs[2] [1]),
        .I3(\GOL_outputs[0]_4 ),
        .I4(\GOL_outputs[0]_5 ),
        .I5(p_2_in),
        .O(val_i_2__30_n_0));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_3__9
       (.I0(p_4_in),
        .I1(\GOL_outputs[2] [1]),
        .I2(\GOL_outputs[2] [0]),
        .O(val_i_3__9_n_0));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_4__16
       (.I0(p_4_in),
        .I1(\GOL_outputs[2] [1]),
        .I2(p_5_in),
        .O(val_reg_1));
  FDRE #(
    .INIT(1'b0)) 
    val_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(val_reg_2),
        .Q(p_4_in),
        .R(rst_IBUF));
endmodule

(* ORIG_REF_NAME = "GOL_cell" *) 
module GOL_cell_11
   (\GOL_outputs[2] ,
    val_reg_0,
    val_reg_1,
    rst_IBUF,
    val_reg_2,
    clk_IBUF_BUFG,
    val_reg_3,
    val_reg_4,
    p_3_in,
    \GOL_outputs[3] ,
    p_4_in,
    p_5_in);
  output [0:0]\GOL_outputs[2] ;
  output val_reg_0;
  output val_reg_1;
  input rst_IBUF;
  input val_reg_2;
  input clk_IBUF_BUFG;
  input [2:0]val_reg_3;
  input val_reg_4;
  input p_3_in;
  input [2:0]\GOL_outputs[3] ;
  input p_4_in;
  input p_5_in;

  wire [0:0]\GOL_outputs[2] ;
  wire [2:0]\GOL_outputs[3] ;
  wire clk_IBUF_BUFG;
  wire p_3_in;
  wire p_4_in;
  wire p_5_in;
  wire rst_IBUF;
  wire val_i_2__3_n_0;
  wire val_i_3__16_n_0;
  wire val_reg_0;
  wire val_reg_1;
  wire val_reg_2;
  wire [2:0]val_reg_3;
  wire val_reg_4;

  LUT6 #(
    .INIT(64'h8332322C322C2CC8)) 
    val_i_1__16
       (.I0(val_reg_3[2]),
        .I1(val_i_2__3_n_0),
        .I2(val_i_3__16_n_0),
        .I3(val_reg_4),
        .I4(p_3_in),
        .I5(\GOL_outputs[3] [0]),
        .O(val_reg_0));
  LUT6 #(
    .INIT(64'h171717E817E8E8E8)) 
    val_i_2__3
       (.I0(\GOL_outputs[2] ),
        .I1(\GOL_outputs[3] [1]),
        .I2(\GOL_outputs[3] [2]),
        .I3(p_4_in),
        .I4(p_5_in),
        .I5(val_reg_3[1]),
        .O(val_i_2__3_n_0));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_3__16
       (.I0(\GOL_outputs[2] ),
        .I1(\GOL_outputs[3] [2]),
        .I2(\GOL_outputs[3] [1]),
        .O(val_i_3__16_n_0));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_4__17
       (.I0(\GOL_outputs[2] ),
        .I1(\GOL_outputs[3] [2]),
        .I2(val_reg_3[0]),
        .O(val_reg_1));
  FDRE #(
    .INIT(1'b0)) 
    val_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(val_reg_2),
        .Q(\GOL_outputs[2] ),
        .R(rst_IBUF));
endmodule

(* ORIG_REF_NAME = "GOL_cell" *) 
module GOL_cell_12
   (val_reg_0,
    val_reg_1,
    val_reg_2,
    rst_IBUF,
    val_reg_3,
    clk_IBUF_BUFG,
    \GOL_outputs[2] ,
    val_reg_4,
    p_4_in,
    \GOL_outputs[3] ,
    p_5_in,
    p_0_in);
  output [0:0]val_reg_0;
  output val_reg_1;
  output val_reg_2;
  input rst_IBUF;
  input val_reg_3;
  input clk_IBUF_BUFG;
  input [2:0]\GOL_outputs[2] ;
  input val_reg_4;
  input p_4_in;
  input [2:0]\GOL_outputs[3] ;
  input p_5_in;
  input p_0_in;

  wire [2:0]\GOL_outputs[2] ;
  wire [2:0]\GOL_outputs[3] ;
  wire clk_IBUF_BUFG;
  wire p_0_in;
  wire p_4_in;
  wire p_5_in;
  wire rst_IBUF;
  wire val_i_2__10_n_0;
  wire val_i_3__11_n_0;
  wire [0:0]val_reg_0;
  wire val_reg_1;
  wire val_reg_2;
  wire val_reg_3;
  wire val_reg_4;

  LUT6 #(
    .INIT(64'h8332322C322C2CC8)) 
    val_i_1__11
       (.I0(\GOL_outputs[2] [0]),
        .I1(val_i_2__10_n_0),
        .I2(val_i_3__11_n_0),
        .I3(val_reg_4),
        .I4(p_4_in),
        .I5(\GOL_outputs[3] [1]),
        .O(val_reg_1));
  LUT6 #(
    .INIT(64'h171717E817E8E8E8)) 
    val_i_2__10
       (.I0(val_reg_0),
        .I1(\GOL_outputs[3] [2]),
        .I2(\GOL_outputs[3] [0]),
        .I3(p_5_in),
        .I4(p_0_in),
        .I5(\GOL_outputs[2] [2]),
        .O(val_i_2__10_n_0));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_3__11
       (.I0(val_reg_0),
        .I1(\GOL_outputs[3] [0]),
        .I2(\GOL_outputs[3] [2]),
        .O(val_i_3__11_n_0));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_4__18
       (.I0(val_reg_0),
        .I1(\GOL_outputs[3] [0]),
        .I2(\GOL_outputs[2] [1]),
        .O(val_reg_2));
  FDRE #(
    .INIT(1'b0)) 
    val_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(val_reg_3),
        .Q(val_reg_0),
        .R(rst_IBUF));
endmodule

(* ORIG_REF_NAME = "GOL_cell" *) 
module GOL_cell_13
   (\GOL_outputs[2] ,
    val_reg_0,
    val_reg_1,
    rst_IBUF,
    val_reg_2,
    clk_IBUF_BUFG,
    val_reg_3,
    val_reg_4,
    p_5_in,
    \GOL_outputs[3] ,
    p_0_in,
    p_1_in);
  output [0:0]\GOL_outputs[2] ;
  output val_reg_0;
  output val_reg_1;
  input rst_IBUF;
  input val_reg_2;
  input clk_IBUF_BUFG;
  input [2:0]val_reg_3;
  input val_reg_4;
  input p_5_in;
  input [2:0]\GOL_outputs[3] ;
  input p_0_in;
  input p_1_in;

  wire [0:0]\GOL_outputs[2] ;
  wire [2:0]\GOL_outputs[3] ;
  wire clk_IBUF_BUFG;
  wire p_0_in;
  wire p_1_in;
  wire p_5_in;
  wire rst_IBUF;
  wire val_i_2__9_n_0;
  wire val_i_3__12_n_0;
  wire val_reg_0;
  wire val_reg_1;
  wire val_reg_2;
  wire [2:0]val_reg_3;
  wire val_reg_4;

  LUT6 #(
    .INIT(64'h8332322C322C2CC8)) 
    val_i_1__12
       (.I0(val_reg_3[1]),
        .I1(val_i_2__9_n_0),
        .I2(val_i_3__12_n_0),
        .I3(val_reg_4),
        .I4(p_5_in),
        .I5(\GOL_outputs[3] [2]),
        .O(val_reg_0));
  LUT6 #(
    .INIT(64'h171717E817E8E8E8)) 
    val_i_2__9
       (.I0(\GOL_outputs[2] ),
        .I1(\GOL_outputs[3] [0]),
        .I2(\GOL_outputs[3] [1]),
        .I3(p_0_in),
        .I4(p_1_in),
        .I5(val_reg_3[0]),
        .O(val_i_2__9_n_0));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_3__12
       (.I0(\GOL_outputs[2] ),
        .I1(\GOL_outputs[3] [1]),
        .I2(\GOL_outputs[3] [0]),
        .O(val_i_3__12_n_0));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_4__19
       (.I0(\GOL_outputs[2] ),
        .I1(\GOL_outputs[3] [1]),
        .I2(val_reg_3[2]),
        .O(val_reg_1));
  FDSE #(
    .INIT(1'b0)) 
    val_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(val_reg_2),
        .Q(\GOL_outputs[2] ),
        .S(rst_IBUF));
endmodule

(* ORIG_REF_NAME = "GOL_cell" *) 
module GOL_cell_14
   (val_reg_0,
    val_reg_1,
    val_reg_2,
    rst_IBUF,
    val_reg_3,
    clk_IBUF_BUFG,
    \GOL_outputs[2] ,
    val_reg_4,
    p_0_in,
    \GOL_outputs[3] ,
    p_1_in,
    p_2_in);
  output [0:0]val_reg_0;
  output val_reg_1;
  output val_reg_2;
  input rst_IBUF;
  input val_reg_3;
  input clk_IBUF_BUFG;
  input [2:0]\GOL_outputs[2] ;
  input val_reg_4;
  input p_0_in;
  input [2:0]\GOL_outputs[3] ;
  input p_1_in;
  input p_2_in;

  wire [2:0]\GOL_outputs[2] ;
  wire [2:0]\GOL_outputs[3] ;
  wire clk_IBUF_BUFG;
  wire p_0_in;
  wire p_1_in;
  wire p_2_in;
  wire rst_IBUF;
  wire val_i_2__20_n_0;
  wire val_i_3__13_n_0;
  wire [0:0]val_reg_0;
  wire val_reg_1;
  wire val_reg_2;
  wire val_reg_3;
  wire val_reg_4;

  LUT6 #(
    .INIT(64'h8332322C322C2CC8)) 
    val_i_1__13
       (.I0(\GOL_outputs[2] [1]),
        .I1(val_i_2__20_n_0),
        .I2(val_i_3__13_n_0),
        .I3(val_reg_4),
        .I4(p_0_in),
        .I5(\GOL_outputs[3] [2]),
        .O(val_reg_1));
  LUT6 #(
    .INIT(64'h171717E817E8E8E8)) 
    val_i_2__20
       (.I0(val_reg_0),
        .I1(\GOL_outputs[3] [0]),
        .I2(\GOL_outputs[3] [1]),
        .I3(p_1_in),
        .I4(p_2_in),
        .I5(\GOL_outputs[2] [0]),
        .O(val_i_2__20_n_0));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_3__13
       (.I0(val_reg_0),
        .I1(\GOL_outputs[3] [1]),
        .I2(\GOL_outputs[3] [0]),
        .O(val_i_3__13_n_0));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_4__20
       (.I0(val_reg_0),
        .I1(\GOL_outputs[3] [1]),
        .I2(\GOL_outputs[2] [2]),
        .O(val_reg_2));
  FDSE #(
    .INIT(1'b0)) 
    val_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(val_reg_3),
        .Q(val_reg_0),
        .S(rst_IBUF));
endmodule

(* ORIG_REF_NAME = "GOL_cell" *) 
module GOL_cell_15
   (\GOL_outputs[2] ,
    val_reg_0,
    val_reg_1,
    rst_IBUF,
    val_reg_2,
    clk_IBUF_BUFG,
    val_reg_3,
    val_reg_4,
    p_1_in,
    \GOL_outputs[3] ,
    p_2_in,
    p_3_in);
  output [0:0]\GOL_outputs[2] ;
  output val_reg_0;
  output val_reg_1;
  input rst_IBUF;
  input val_reg_2;
  input clk_IBUF_BUFG;
  input [2:0]val_reg_3;
  input val_reg_4;
  input p_1_in;
  input [2:0]\GOL_outputs[3] ;
  input p_2_in;
  input p_3_in;

  wire [0:0]\GOL_outputs[2] ;
  wire [2:0]\GOL_outputs[3] ;
  wire clk_IBUF_BUFG;
  wire p_1_in;
  wire p_2_in;
  wire p_3_in;
  wire rst_IBUF;
  wire val_i_2__26_n_0;
  wire val_i_3__14_n_0;
  wire val_reg_0;
  wire val_reg_1;
  wire val_reg_2;
  wire [2:0]val_reg_3;
  wire val_reg_4;

  LUT6 #(
    .INIT(64'h8332322C322C2CC8)) 
    val_i_1__14
       (.I0(val_reg_3[1]),
        .I1(val_i_2__26_n_0),
        .I2(val_i_3__14_n_0),
        .I3(val_reg_4),
        .I4(p_1_in),
        .I5(\GOL_outputs[3] [2]),
        .O(val_reg_0));
  LUT6 #(
    .INIT(64'h171717E817E8E8E8)) 
    val_i_2__26
       (.I0(\GOL_outputs[2] ),
        .I1(\GOL_outputs[3] [0]),
        .I2(\GOL_outputs[3] [1]),
        .I3(p_2_in),
        .I4(p_3_in),
        .I5(val_reg_3[0]),
        .O(val_i_2__26_n_0));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_3__14
       (.I0(\GOL_outputs[2] ),
        .I1(\GOL_outputs[3] [1]),
        .I2(\GOL_outputs[3] [0]),
        .O(val_i_3__14_n_0));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_4__21
       (.I0(\GOL_outputs[2] ),
        .I1(\GOL_outputs[3] [1]),
        .I2(val_reg_3[2]),
        .O(val_reg_1));
  FDRE #(
    .INIT(1'b0)) 
    val_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(val_reg_2),
        .Q(\GOL_outputs[2] ),
        .R(rst_IBUF));
endmodule

(* ORIG_REF_NAME = "GOL_cell" *) 
module GOL_cell_16
   (val_reg_0,
    val_reg_1,
    val_reg_2,
    rst_IBUF,
    val_reg_3,
    clk_IBUF_BUFG,
    \GOL_outputs[2] ,
    val_reg_4,
    p_2_in,
    \GOL_outputs[3] ,
    p_3_in,
    p_4_in);
  output [0:0]val_reg_0;
  output val_reg_1;
  output val_reg_2;
  input rst_IBUF;
  input val_reg_3;
  input clk_IBUF_BUFG;
  input [2:0]\GOL_outputs[2] ;
  input val_reg_4;
  input p_2_in;
  input [2:0]\GOL_outputs[3] ;
  input p_3_in;
  input p_4_in;

  wire [2:0]\GOL_outputs[2] ;
  wire [2:0]\GOL_outputs[3] ;
  wire clk_IBUF_BUFG;
  wire p_2_in;
  wire p_3_in;
  wire p_4_in;
  wire rst_IBUF;
  wire val_i_2__32_n_0;
  wire val_i_3__15_n_0;
  wire [0:0]val_reg_0;
  wire val_reg_1;
  wire val_reg_2;
  wire val_reg_3;
  wire val_reg_4;

  LUT6 #(
    .INIT(64'h8332322C322C2CC8)) 
    val_i_1__15
       (.I0(\GOL_outputs[2] [2]),
        .I1(val_i_2__32_n_0),
        .I2(val_i_3__15_n_0),
        .I3(val_reg_4),
        .I4(p_2_in),
        .I5(\GOL_outputs[3] [2]),
        .O(val_reg_1));
  LUT6 #(
    .INIT(64'h171717E817E8E8E8)) 
    val_i_2__32
       (.I0(val_reg_0),
        .I1(\GOL_outputs[3] [0]),
        .I2(\GOL_outputs[3] [1]),
        .I3(p_3_in),
        .I4(p_4_in),
        .I5(\GOL_outputs[2] [1]),
        .O(val_i_2__32_n_0));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_3__15
       (.I0(val_reg_0),
        .I1(\GOL_outputs[3] [1]),
        .I2(\GOL_outputs[3] [0]),
        .O(val_i_3__15_n_0));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_4__22
       (.I0(val_reg_0),
        .I1(\GOL_outputs[3] [1]),
        .I2(\GOL_outputs[2] [0]),
        .O(val_reg_2));
  FDRE #(
    .INIT(1'b0)) 
    val_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(val_reg_3),
        .Q(val_reg_0),
        .R(rst_IBUF));
endmodule

(* ORIG_REF_NAME = "GOL_cell" *) 
module GOL_cell_17
   (\GOL_outputs[3] ,
    val_reg_0,
    \col[0] ,
    val_reg_1,
    rst_IBUF,
    val_reg_2,
    clk_IBUF_BUFG,
    val_reg_3,
    val_reg_4,
    \GOL_outputs[2] ,
    p_5_out,
    p_1_out,
    p_0_out,
    col_IBUF,
    val_OBUF_inst_i_1,
    row_IBUF,
    val_OBUF_inst_i_4_0,
    p_5_in,
    \GOL_outputs[0]_0 );
  output [0:0]\GOL_outputs[3] ;
  output val_reg_0;
  output \col[0] ;
  output val_reg_1;
  input rst_IBUF;
  input val_reg_2;
  input clk_IBUF_BUFG;
  input [2:0]val_reg_3;
  input val_reg_4;
  input [2:0]\GOL_outputs[2] ;
  input p_5_out;
  input p_1_out;
  input p_0_out;
  input [0:0]col_IBUF;
  input [0:0]val_OBUF_inst_i_1;
  input [2:0]row_IBUF;
  input val_OBUF_inst_i_4_0;
  input p_5_in;
  input \GOL_outputs[0]_0 ;

  wire \GOL_outputs[0]_0 ;
  wire [2:0]\GOL_outputs[2] ;
  wire [0:0]\GOL_outputs[3] ;
  wire [0:0]\GOL_outputs[5] ;
  wire clk_IBUF_BUFG;
  wire \col[0] ;
  wire [0:0]col_IBUF;
  wire p_0_out;
  wire p_1_out;
  wire p_5_in;
  wire p_5_out;
  wire [2:0]row_IBUF;
  wire rst_IBUF;
  wire [0:0]val_OBUF_inst_i_1;
  wire val_OBUF_inst_i_19_n_0;
  wire val_OBUF_inst_i_4_0;
  wire val_i_2__8_n_0;
  wire val_i_3__22_n_0;
  wire val_reg_0;
  wire val_reg_1;
  wire val_reg_2;
  wire [2:0]val_reg_3;
  wire val_reg_4;

  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    val_OBUF_inst_i_19
       (.I0(\GOL_outputs[3] ),
        .I1(\GOL_outputs[2] [0]),
        .I2(row_IBUF[1]),
        .I3(p_5_in),
        .I4(row_IBUF[0]),
        .I5(\GOL_outputs[0]_0 ),
        .O(val_OBUF_inst_i_19_n_0));
  MUXF8 val_OBUF_inst_i_4
       (.I0(\GOL_outputs[5] ),
        .I1(val_OBUF_inst_i_1),
        .O(\col[0] ),
        .S(col_IBUF));
  MUXF7 val_OBUF_inst_i_9
       (.I0(val_OBUF_inst_i_19_n_0),
        .I1(val_OBUF_inst_i_4_0),
        .O(\GOL_outputs[5] ),
        .S(row_IBUF[2]));
  LUT6 #(
    .INIT(64'h8332322C322C2CC8)) 
    val_i_1__22
       (.I0(val_reg_3[2]),
        .I1(val_i_2__8_n_0),
        .I2(val_i_3__22_n_0),
        .I3(val_reg_4),
        .I4(\GOL_outputs[2] [1]),
        .I5(p_5_out),
        .O(val_reg_0));
  LUT6 #(
    .INIT(64'h171717E817E8E8E8)) 
    val_i_2__8
       (.I0(\GOL_outputs[3] ),
        .I1(p_1_out),
        .I2(p_0_out),
        .I3(\GOL_outputs[2] [2]),
        .I4(\GOL_outputs[2] [0]),
        .I5(val_reg_3[1]),
        .O(val_i_2__8_n_0));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_3__22
       (.I0(\GOL_outputs[3] ),
        .I1(p_0_out),
        .I2(p_1_out),
        .O(val_i_3__22_n_0));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_4__23
       (.I0(\GOL_outputs[3] ),
        .I1(p_0_out),
        .I2(val_reg_3[0]),
        .O(val_reg_1));
  FDRE #(
    .INIT(1'b0)) 
    val_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(val_reg_2),
        .Q(\GOL_outputs[3] ),
        .R(rst_IBUF));
endmodule

(* ORIG_REF_NAME = "GOL_cell" *) 
module GOL_cell_18
   (val_reg_0,
    val_reg_1,
    val_reg_2,
    \row[2] ,
    rst_IBUF,
    val_reg_3,
    clk_IBUF_BUFG,
    \GOL_outputs[3] ,
    val_reg_4,
    \GOL_outputs[2] ,
    p_4_out,
    p_0_out,
    p_5_out,
    row_IBUF,
    val_OBUF_inst_i_4,
    p_0_in,
    \GOL_outputs[0]_1 );
  output [0:0]val_reg_0;
  output val_reg_1;
  output val_reg_2;
  output [0:0]\row[2] ;
  input rst_IBUF;
  input val_reg_3;
  input clk_IBUF_BUFG;
  input [2:0]\GOL_outputs[3] ;
  input val_reg_4;
  input [2:0]\GOL_outputs[2] ;
  input p_4_out;
  input p_0_out;
  input p_5_out;
  input [2:0]row_IBUF;
  input val_OBUF_inst_i_4;
  input p_0_in;
  input \GOL_outputs[0]_1 ;

  wire \GOL_outputs[0]_1 ;
  wire [2:0]\GOL_outputs[2] ;
  wire [2:0]\GOL_outputs[3] ;
  wire clk_IBUF_BUFG;
  wire p_0_in;
  wire p_0_out;
  wire p_4_out;
  wire p_5_out;
  wire [0:0]\row[2] ;
  wire [2:0]row_IBUF;
  wire rst_IBUF;
  wire val_OBUF_inst_i_21_n_0;
  wire val_OBUF_inst_i_4;
  wire val_i_2__15_n_0;
  wire val_i_3__17_n_0;
  wire [0:0]val_reg_0;
  wire val_reg_1;
  wire val_reg_2;
  wire val_reg_3;
  wire val_reg_4;

  MUXF7 val_OBUF_inst_i_10
       (.I0(val_OBUF_inst_i_21_n_0),
        .I1(val_OBUF_inst_i_4),
        .O(\row[2] ),
        .S(row_IBUF[2]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    val_OBUF_inst_i_21
       (.I0(val_reg_0),
        .I1(\GOL_outputs[2] [1]),
        .I2(row_IBUF[1]),
        .I3(p_0_in),
        .I4(row_IBUF[0]),
        .I5(\GOL_outputs[0]_1 ),
        .O(val_OBUF_inst_i_21_n_0));
  LUT6 #(
    .INIT(64'h8332322C322C2CC8)) 
    val_i_1__17
       (.I0(\GOL_outputs[3] [0]),
        .I1(val_i_2__15_n_0),
        .I2(val_i_3__17_n_0),
        .I3(val_reg_4),
        .I4(\GOL_outputs[2] [2]),
        .I5(p_4_out),
        .O(val_reg_1));
  LUT6 #(
    .INIT(64'h171717E817E8E8E8)) 
    val_i_2__15
       (.I0(val_reg_0),
        .I1(p_0_out),
        .I2(p_5_out),
        .I3(\GOL_outputs[2] [0]),
        .I4(\GOL_outputs[2] [1]),
        .I5(\GOL_outputs[3] [2]),
        .O(val_i_2__15_n_0));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_3__17
       (.I0(val_reg_0),
        .I1(p_5_out),
        .I2(p_0_out),
        .O(val_i_3__17_n_0));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_4__24
       (.I0(val_reg_0),
        .I1(p_5_out),
        .I2(\GOL_outputs[3] [1]),
        .O(val_reg_2));
  FDRE #(
    .INIT(1'b0)) 
    val_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(val_reg_3),
        .Q(val_reg_0),
        .R(rst_IBUF));
endmodule

(* ORIG_REF_NAME = "GOL_cell" *) 
module GOL_cell_19
   (\GOL_outputs[3] ,
    val_reg_0,
    \col[0] ,
    val_reg_1,
    rst_IBUF,
    val_reg_2,
    clk_IBUF_BUFG,
    val_reg_3,
    val_reg_4,
    \GOL_outputs[2] ,
    p_3_out,
    p_5_out,
    p_4_out,
    col_IBUF,
    val_OBUF_inst_i_1,
    row_IBUF,
    val_OBUF_inst_i_3_0,
    p_1_in,
    \GOL_outputs[0]_2 );
  output [0:0]\GOL_outputs[3] ;
  output val_reg_0;
  output \col[0] ;
  output val_reg_1;
  input rst_IBUF;
  input val_reg_2;
  input clk_IBUF_BUFG;
  input [2:0]val_reg_3;
  input val_reg_4;
  input [2:0]\GOL_outputs[2] ;
  input p_3_out;
  input p_5_out;
  input p_4_out;
  input [0:0]col_IBUF;
  input [0:0]val_OBUF_inst_i_1;
  input [2:0]row_IBUF;
  input val_OBUF_inst_i_3_0;
  input p_1_in;
  input \GOL_outputs[0]_2 ;

  wire \GOL_outputs[0]_2 ;
  wire [2:0]\GOL_outputs[2] ;
  wire [0:0]\GOL_outputs[3] ;
  wire [2:2]\GOL_outputs[5] ;
  wire clk_IBUF_BUFG;
  wire \col[0] ;
  wire [0:0]col_IBUF;
  wire p_1_in;
  wire p_3_out;
  wire p_4_out;
  wire p_5_out;
  wire [2:0]row_IBUF;
  wire rst_IBUF;
  wire [0:0]val_OBUF_inst_i_1;
  wire val_OBUF_inst_i_15_n_0;
  wire val_OBUF_inst_i_3_0;
  wire val_i_2__14_n_0;
  wire val_i_3__18_n_0;
  wire val_reg_0;
  wire val_reg_1;
  wire val_reg_2;
  wire [2:0]val_reg_3;
  wire val_reg_4;

  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    val_OBUF_inst_i_15
       (.I0(\GOL_outputs[3] ),
        .I1(\GOL_outputs[2] [2]),
        .I2(row_IBUF[1]),
        .I3(p_1_in),
        .I4(row_IBUF[0]),
        .I5(\GOL_outputs[0]_2 ),
        .O(val_OBUF_inst_i_15_n_0));
  MUXF8 val_OBUF_inst_i_3
       (.I0(\GOL_outputs[5] ),
        .I1(val_OBUF_inst_i_1),
        .O(\col[0] ),
        .S(col_IBUF));
  MUXF7 val_OBUF_inst_i_7
       (.I0(val_OBUF_inst_i_15_n_0),
        .I1(val_OBUF_inst_i_3_0),
        .O(\GOL_outputs[5] ),
        .S(row_IBUF[2]));
  LUT6 #(
    .INIT(64'h8332322C322C2CC8)) 
    val_i_1__18
       (.I0(val_reg_3[1]),
        .I1(val_i_2__14_n_0),
        .I2(val_i_3__18_n_0),
        .I3(val_reg_4),
        .I4(\GOL_outputs[2] [0]),
        .I5(p_3_out),
        .O(val_reg_0));
  LUT6 #(
    .INIT(64'h171717E817E8E8E8)) 
    val_i_2__14
       (.I0(\GOL_outputs[3] ),
        .I1(p_5_out),
        .I2(p_4_out),
        .I3(\GOL_outputs[2] [1]),
        .I4(\GOL_outputs[2] [2]),
        .I5(val_reg_3[0]),
        .O(val_i_2__14_n_0));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_3__18
       (.I0(\GOL_outputs[3] ),
        .I1(p_4_out),
        .I2(p_5_out),
        .O(val_i_3__18_n_0));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_4__25
       (.I0(\GOL_outputs[3] ),
        .I1(p_4_out),
        .I2(val_reg_3[2]),
        .O(val_reg_1));
  FDRE #(
    .INIT(1'b0)) 
    val_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(val_reg_2),
        .Q(\GOL_outputs[3] ),
        .R(rst_IBUF));
endmodule

(* ORIG_REF_NAME = "GOL_cell" *) 
module GOL_cell_2
   (\GOL_outputs[0]_3 ,
    val_reg_0,
    val_reg_1,
    rst_IBUF,
    val_reg_2,
    clk_IBUF_BUFG,
    \GOL_outputs[0]_2 ,
    val_reg_3,
    p_6_in,
    p_2_in,
    p_0_in,
    p_1_in,
    p_7_in,
    p_8_in,
    \GOL_outputs[0]_1 ,
    \GOL_outputs[0]_4 );
  output \GOL_outputs[0]_3 ;
  output val_reg_0;
  output val_reg_1;
  input rst_IBUF;
  input val_reg_2;
  input clk_IBUF_BUFG;
  input \GOL_outputs[0]_2 ;
  input val_reg_3;
  input p_6_in;
  input p_2_in;
  input p_0_in;
  input p_1_in;
  input p_7_in;
  input p_8_in;
  input \GOL_outputs[0]_1 ;
  input \GOL_outputs[0]_4 ;

  wire \GOL_outputs[0]_1 ;
  wire \GOL_outputs[0]_2 ;
  wire \GOL_outputs[0]_3 ;
  wire \GOL_outputs[0]_4 ;
  wire clk_IBUF_BUFG;
  wire p_0_in;
  wire p_1_in;
  wire p_2_in;
  wire p_6_in;
  wire p_7_in;
  wire p_8_in;
  wire rst_IBUF;
  wire val_i_2__21_n_0;
  wire val_i_3__1_n_0;
  wire val_reg_0;
  wire val_reg_1;
  wire val_reg_2;
  wire val_reg_3;

  LUT6 #(
    .INIT(64'h8332322C322C2CC8)) 
    val_i_1__1
       (.I0(\GOL_outputs[0]_2 ),
        .I1(val_i_2__21_n_0),
        .I2(val_i_3__1_n_0),
        .I3(val_reg_3),
        .I4(p_6_in),
        .I5(p_2_in),
        .O(val_reg_0));
  LUT6 #(
    .INIT(64'h171717E817E8E8E8)) 
    val_i_2__21
       (.I0(\GOL_outputs[0]_3 ),
        .I1(p_0_in),
        .I2(p_1_in),
        .I3(p_7_in),
        .I4(p_8_in),
        .I5(\GOL_outputs[0]_1 ),
        .O(val_i_2__21_n_0));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_3__1
       (.I0(\GOL_outputs[0]_3 ),
        .I1(p_1_in),
        .I2(p_0_in),
        .O(val_i_3__1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_4__8
       (.I0(\GOL_outputs[0]_3 ),
        .I1(p_1_in),
        .I2(\GOL_outputs[0]_4 ),
        .O(val_reg_1));
  FDSE #(
    .INIT(1'b0)) 
    val_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(val_reg_2),
        .Q(\GOL_outputs[0]_3 ),
        .S(rst_IBUF));
endmodule

(* ORIG_REF_NAME = "GOL_cell" *) 
module GOL_cell_20
   (val_reg_0,
    val_reg_1,
    val_reg_2,
    \row[2] ,
    rst_IBUF,
    val_reg_3,
    clk_IBUF_BUFG,
    \GOL_outputs[3] ,
    val_reg_4,
    \GOL_outputs[2] ,
    p_2_out,
    p_4_out,
    p_3_out,
    row_IBUF,
    val_OBUF_inst_i_3,
    p_2_in,
    \GOL_outputs[0]_3 );
  output [0:0]val_reg_0;
  output val_reg_1;
  output val_reg_2;
  output [0:0]\row[2] ;
  input rst_IBUF;
  input val_reg_3;
  input clk_IBUF_BUFG;
  input [2:0]\GOL_outputs[3] ;
  input val_reg_4;
  input [2:0]\GOL_outputs[2] ;
  input p_2_out;
  input p_4_out;
  input p_3_out;
  input [2:0]row_IBUF;
  input val_OBUF_inst_i_3;
  input p_2_in;
  input \GOL_outputs[0]_3 ;

  wire \GOL_outputs[0]_3 ;
  wire [2:0]\GOL_outputs[2] ;
  wire [2:0]\GOL_outputs[3] ;
  wire clk_IBUF_BUFG;
  wire p_2_in;
  wire p_2_out;
  wire p_3_out;
  wire p_4_out;
  wire [0:0]\row[2] ;
  wire [2:0]row_IBUF;
  wire rst_IBUF;
  wire val_OBUF_inst_i_17_n_0;
  wire val_OBUF_inst_i_3;
  wire val_i_2__22_n_0;
  wire val_i_3__19_n_0;
  wire [0:0]val_reg_0;
  wire val_reg_1;
  wire val_reg_2;
  wire val_reg_3;
  wire val_reg_4;

  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    val_OBUF_inst_i_17
       (.I0(val_reg_0),
        .I1(\GOL_outputs[2] [2]),
        .I2(row_IBUF[1]),
        .I3(p_2_in),
        .I4(row_IBUF[0]),
        .I5(\GOL_outputs[0]_3 ),
        .O(val_OBUF_inst_i_17_n_0));
  MUXF7 val_OBUF_inst_i_8
       (.I0(val_OBUF_inst_i_17_n_0),
        .I1(val_OBUF_inst_i_3),
        .O(\row[2] ),
        .S(row_IBUF[2]));
  LUT6 #(
    .INIT(64'h8332322C322C2CC8)) 
    val_i_1__19
       (.I0(\GOL_outputs[3] [1]),
        .I1(val_i_2__22_n_0),
        .I2(val_i_3__19_n_0),
        .I3(val_reg_4),
        .I4(\GOL_outputs[2] [0]),
        .I5(p_2_out),
        .O(val_reg_1));
  LUT6 #(
    .INIT(64'h171717E817E8E8E8)) 
    val_i_2__22
       (.I0(val_reg_0),
        .I1(p_4_out),
        .I2(p_3_out),
        .I3(\GOL_outputs[2] [1]),
        .I4(\GOL_outputs[2] [2]),
        .I5(\GOL_outputs[3] [0]),
        .O(val_i_2__22_n_0));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_3__19
       (.I0(val_reg_0),
        .I1(p_3_out),
        .I2(p_4_out),
        .O(val_i_3__19_n_0));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_4__26
       (.I0(val_reg_0),
        .I1(p_3_out),
        .I2(\GOL_outputs[3] [2]),
        .O(val_reg_2));
  FDRE #(
    .INIT(1'b0)) 
    val_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(val_reg_3),
        .Q(val_reg_0),
        .R(rst_IBUF));
endmodule

(* ORIG_REF_NAME = "GOL_cell" *) 
module GOL_cell_21
   (\GOL_outputs[3] ,
    val_reg_0,
    val_OBUF,
    val_reg_1,
    rst_IBUF,
    val_reg_2,
    clk_IBUF_BUFG,
    val_reg_3,
    val_reg_4,
    \GOL_outputs[2] ,
    p_1_out,
    p_3_out,
    p_2_out,
    col_IBUF,
    val,
    val_0,
    val_OBUF_inst_i_1_0,
    row_IBUF,
    val_OBUF_inst_i_2_0,
    p_3_in,
    \GOL_outputs[0]_4 );
  output [0:0]\GOL_outputs[3] ;
  output val_reg_0;
  output val_OBUF;
  output val_reg_1;
  input rst_IBUF;
  input val_reg_2;
  input clk_IBUF_BUFG;
  input [2:0]val_reg_3;
  input val_reg_4;
  input [2:0]\GOL_outputs[2] ;
  input p_1_out;
  input p_3_out;
  input p_2_out;
  input [2:0]col_IBUF;
  input val;
  input val_0;
  input [0:0]val_OBUF_inst_i_1_0;
  input [2:0]row_IBUF;
  input val_OBUF_inst_i_2_0;
  input p_3_in;
  input \GOL_outputs[0]_4 ;

  wire \GOL_outputs[0]_4 ;
  wire [2:0]\GOL_outputs[2] ;
  wire [0:0]\GOL_outputs[3] ;
  wire [4:4]\GOL_outputs[5] ;
  wire clk_IBUF_BUFG;
  wire [2:0]col_IBUF;
  wire p_1_out;
  wire p_2_out;
  wire p_3_in;
  wire p_3_out;
  wire [2:0]row_IBUF;
  wire rst_IBUF;
  wire val;
  wire val_0;
  wire val_OBUF;
  wire val_OBUF_inst_i_11_n_0;
  wire [0:0]val_OBUF_inst_i_1_0;
  wire val_OBUF_inst_i_2_0;
  wire val_OBUF_inst_i_2_n_0;
  wire val_i_2__28_n_0;
  wire val_i_3__20_n_0;
  wire val_reg_0;
  wire val_reg_1;
  wire val_reg_2;
  wire [2:0]val_reg_3;
  wire val_reg_4;

  LUT5 #(
    .INIT(32'hB8BBB888)) 
    val_OBUF_inst_i_1
       (.I0(val_OBUF_inst_i_2_n_0),
        .I1(col_IBUF[2]),
        .I2(val),
        .I3(col_IBUF[1]),
        .I4(val_0),
        .O(val_OBUF));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    val_OBUF_inst_i_11
       (.I0(\GOL_outputs[3] ),
        .I1(\GOL_outputs[2] [2]),
        .I2(row_IBUF[1]),
        .I3(p_3_in),
        .I4(row_IBUF[0]),
        .I5(\GOL_outputs[0]_4 ),
        .O(val_OBUF_inst_i_11_n_0));
  MUXF8 val_OBUF_inst_i_2
       (.I0(\GOL_outputs[5] ),
        .I1(val_OBUF_inst_i_1_0),
        .O(val_OBUF_inst_i_2_n_0),
        .S(col_IBUF[0]));
  MUXF7 val_OBUF_inst_i_5
       (.I0(val_OBUF_inst_i_11_n_0),
        .I1(val_OBUF_inst_i_2_0),
        .O(\GOL_outputs[5] ),
        .S(row_IBUF[2]));
  LUT6 #(
    .INIT(64'h8332322C322C2CC8)) 
    val_i_1__20
       (.I0(val_reg_3[1]),
        .I1(val_i_2__28_n_0),
        .I2(val_i_3__20_n_0),
        .I3(val_reg_4),
        .I4(\GOL_outputs[2] [0]),
        .I5(p_1_out),
        .O(val_reg_0));
  LUT6 #(
    .INIT(64'h171717E817E8E8E8)) 
    val_i_2__28
       (.I0(\GOL_outputs[3] ),
        .I1(p_3_out),
        .I2(p_2_out),
        .I3(\GOL_outputs[2] [1]),
        .I4(\GOL_outputs[2] [2]),
        .I5(val_reg_3[0]),
        .O(val_i_2__28_n_0));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_3__20
       (.I0(\GOL_outputs[3] ),
        .I1(p_2_out),
        .I2(p_3_out),
        .O(val_i_3__20_n_0));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_4__27
       (.I0(\GOL_outputs[3] ),
        .I1(p_2_out),
        .I2(val_reg_3[2]),
        .O(val_reg_1));
  FDRE #(
    .INIT(1'b0)) 
    val_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(val_reg_2),
        .Q(\GOL_outputs[3] ),
        .R(rst_IBUF));
endmodule

(* ORIG_REF_NAME = "GOL_cell" *) 
module GOL_cell_22
   (val_reg_0,
    val_reg_1,
    val_reg_2,
    \row[2] ,
    rst_IBUF,
    val_reg_3,
    clk_IBUF_BUFG,
    \GOL_outputs[3] ,
    val_reg_4,
    \GOL_outputs[2] ,
    p_0_out,
    p_2_out,
    p_1_out,
    row_IBUF,
    val_OBUF_inst_i_2,
    p_4_in,
    \GOL_outputs[0]_5 );
  output [0:0]val_reg_0;
  output val_reg_1;
  output val_reg_2;
  output [0:0]\row[2] ;
  input rst_IBUF;
  input val_reg_3;
  input clk_IBUF_BUFG;
  input [2:0]\GOL_outputs[3] ;
  input val_reg_4;
  input [2:0]\GOL_outputs[2] ;
  input p_0_out;
  input p_2_out;
  input p_1_out;
  input [2:0]row_IBUF;
  input val_OBUF_inst_i_2;
  input p_4_in;
  input \GOL_outputs[0]_5 ;

  wire \GOL_outputs[0]_5 ;
  wire [2:0]\GOL_outputs[2] ;
  wire [2:0]\GOL_outputs[3] ;
  wire clk_IBUF_BUFG;
  wire p_0_out;
  wire p_1_out;
  wire p_2_out;
  wire p_4_in;
  wire [0:0]\row[2] ;
  wire [2:0]row_IBUF;
  wire rst_IBUF;
  wire val_OBUF_inst_i_13_n_0;
  wire val_OBUF_inst_i_2;
  wire val_i_2__34_n_0;
  wire val_i_3__21_n_0;
  wire [0:0]val_reg_0;
  wire val_reg_1;
  wire val_reg_2;
  wire val_reg_3;
  wire val_reg_4;

  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    val_OBUF_inst_i_13
       (.I0(val_reg_0),
        .I1(\GOL_outputs[2] [2]),
        .I2(row_IBUF[1]),
        .I3(p_4_in),
        .I4(row_IBUF[0]),
        .I5(\GOL_outputs[0]_5 ),
        .O(val_OBUF_inst_i_13_n_0));
  MUXF7 val_OBUF_inst_i_6
       (.I0(val_OBUF_inst_i_13_n_0),
        .I1(val_OBUF_inst_i_2),
        .O(\row[2] ),
        .S(row_IBUF[2]));
  LUT6 #(
    .INIT(64'h8332322C322C2CC8)) 
    val_i_1__21
       (.I0(\GOL_outputs[3] [2]),
        .I1(val_i_2__34_n_0),
        .I2(val_i_3__21_n_0),
        .I3(val_reg_4),
        .I4(\GOL_outputs[2] [0]),
        .I5(p_0_out),
        .O(val_reg_1));
  LUT6 #(
    .INIT(64'h171717E817E8E8E8)) 
    val_i_2__34
       (.I0(val_reg_0),
        .I1(p_2_out),
        .I2(p_1_out),
        .I3(\GOL_outputs[2] [1]),
        .I4(\GOL_outputs[2] [2]),
        .I5(\GOL_outputs[3] [1]),
        .O(val_i_2__34_n_0));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_3__21
       (.I0(val_reg_0),
        .I1(p_1_out),
        .I2(p_2_out),
        .O(val_i_3__21_n_0));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_4__28
       (.I0(val_reg_0),
        .I1(p_1_out),
        .I2(\GOL_outputs[3] [0]),
        .O(val_reg_2));
  FDRE #(
    .INIT(1'b0)) 
    val_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(val_reg_3),
        .Q(val_reg_0),
        .R(rst_IBUF));
endmodule

(* ORIG_REF_NAME = "GOL_cell" *) 
module GOL_cell_23
   (p_5_out,
    val_reg_0,
    val_reg_1,
    rst_IBUF,
    val_reg_2,
    clk_IBUF_BUFG,
    p_0_out,
    val_reg_3,
    \GOL_outputs[3] ,
    p_11_in,
    p_9_in,
    p_10_in,
    p_1_out,
    p_4_out);
  output p_5_out;
  output val_reg_0;
  output val_reg_1;
  input rst_IBUF;
  input val_reg_2;
  input clk_IBUF_BUFG;
  input p_0_out;
  input val_reg_3;
  input [2:0]\GOL_outputs[3] ;
  input p_11_in;
  input p_9_in;
  input p_10_in;
  input p_1_out;
  input p_4_out;

  wire [2:0]\GOL_outputs[3] ;
  wire clk_IBUF_BUFG;
  wire p_0_out;
  wire p_10_in;
  wire p_11_in;
  wire p_1_out;
  wire p_4_out;
  wire p_5_out;
  wire p_9_in;
  wire rst_IBUF;
  wire val_i_2__13_n_0;
  wire val_i_3__28_n_0;
  wire val_reg_0;
  wire val_reg_1;
  wire val_reg_2;
  wire val_reg_3;

  LUT6 #(
    .INIT(64'h8332322C322C2CC8)) 
    val_i_1__28
       (.I0(p_0_out),
        .I1(val_i_2__13_n_0),
        .I2(val_i_3__28_n_0),
        .I3(val_reg_3),
        .I4(\GOL_outputs[3] [1]),
        .I5(p_11_in),
        .O(val_reg_0));
  LUT6 #(
    .INIT(64'h171717E817E8E8E8)) 
    val_i_2__13
       (.I0(p_5_out),
        .I1(p_9_in),
        .I2(p_10_in),
        .I3(\GOL_outputs[3] [2]),
        .I4(\GOL_outputs[3] [0]),
        .I5(p_1_out),
        .O(val_i_2__13_n_0));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_3__28
       (.I0(p_5_out),
        .I1(p_10_in),
        .I2(p_9_in),
        .O(val_i_3__28_n_0));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_4__29
       (.I0(p_5_out),
        .I1(p_10_in),
        .I2(p_4_out),
        .O(val_reg_1));
  FDRE #(
    .INIT(1'b0)) 
    val_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(val_reg_2),
        .Q(p_5_out),
        .R(rst_IBUF));
endmodule

(* ORIG_REF_NAME = "GOL_cell" *) 
module GOL_cell_24
   (p_4_out,
    val_reg_0,
    val_reg_1,
    rst_IBUF,
    val_reg_2,
    clk_IBUF_BUFG,
    p_5_out,
    val_reg_3,
    \GOL_outputs[3] ,
    p_6_in,
    p_10_in,
    p_11_in,
    p_0_out,
    p_3_out);
  output p_4_out;
  output val_reg_0;
  output val_reg_1;
  input rst_IBUF;
  input val_reg_2;
  input clk_IBUF_BUFG;
  input p_5_out;
  input val_reg_3;
  input [2:0]\GOL_outputs[3] ;
  input p_6_in;
  input p_10_in;
  input p_11_in;
  input p_0_out;
  input p_3_out;

  wire [2:0]\GOL_outputs[3] ;
  wire clk_IBUF_BUFG;
  wire p_0_out;
  wire p_10_in;
  wire p_11_in;
  wire p_3_out;
  wire p_4_out;
  wire p_5_out;
  wire p_6_in;
  wire rst_IBUF;
  wire val_i_2__16_n_0;
  wire val_i_3__23_n_0;
  wire val_reg_0;
  wire val_reg_1;
  wire val_reg_2;
  wire val_reg_3;

  LUT6 #(
    .INIT(64'h8332322C322C2CC8)) 
    val_i_1__23
       (.I0(p_5_out),
        .I1(val_i_2__16_n_0),
        .I2(val_i_3__23_n_0),
        .I3(val_reg_3),
        .I4(\GOL_outputs[3] [2]),
        .I5(p_6_in),
        .O(val_reg_0));
  LUT6 #(
    .INIT(64'h171717E817E8E8E8)) 
    val_i_2__16
       (.I0(p_4_out),
        .I1(p_10_in),
        .I2(p_11_in),
        .I3(\GOL_outputs[3] [0]),
        .I4(\GOL_outputs[3] [1]),
        .I5(p_0_out),
        .O(val_i_2__16_n_0));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_3__23
       (.I0(p_4_out),
        .I1(p_11_in),
        .I2(p_10_in),
        .O(val_i_3__23_n_0));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_4__30
       (.I0(p_4_out),
        .I1(p_11_in),
        .I2(p_3_out),
        .O(val_reg_1));
  FDRE #(
    .INIT(1'b0)) 
    val_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(val_reg_2),
        .Q(p_4_out),
        .R(rst_IBUF));
endmodule

(* ORIG_REF_NAME = "GOL_cell" *) 
module GOL_cell_25
   (p_3_out,
    val_reg_0,
    val_reg_1,
    rst_IBUF,
    val_reg_2,
    clk_IBUF_BUFG,
    p_4_out,
    val_reg_3,
    \GOL_outputs[3] ,
    p_7_in,
    p_11_in,
    p_6_in,
    p_5_out,
    p_2_out);
  output p_3_out;
  output val_reg_0;
  output val_reg_1;
  input rst_IBUF;
  input val_reg_2;
  input clk_IBUF_BUFG;
  input p_4_out;
  input val_reg_3;
  input [2:0]\GOL_outputs[3] ;
  input p_7_in;
  input p_11_in;
  input p_6_in;
  input p_5_out;
  input p_2_out;

  wire [2:0]\GOL_outputs[3] ;
  wire clk_IBUF_BUFG;
  wire p_11_in;
  wire p_2_out;
  wire p_3_out;
  wire p_4_out;
  wire p_5_out;
  wire p_6_in;
  wire p_7_in;
  wire rst_IBUF;
  wire val_i_2__2_n_0;
  wire val_i_3__24_n_0;
  wire val_reg_0;
  wire val_reg_1;
  wire val_reg_2;
  wire val_reg_3;

  LUT6 #(
    .INIT(64'h8332322C322C2CC8)) 
    val_i_1__24
       (.I0(p_4_out),
        .I1(val_i_2__2_n_0),
        .I2(val_i_3__24_n_0),
        .I3(val_reg_3),
        .I4(\GOL_outputs[3] [0]),
        .I5(p_7_in),
        .O(val_reg_0));
  LUT6 #(
    .INIT(64'h171717E817E8E8E8)) 
    val_i_2__2
       (.I0(p_3_out),
        .I1(p_11_in),
        .I2(p_6_in),
        .I3(\GOL_outputs[3] [1]),
        .I4(\GOL_outputs[3] [2]),
        .I5(p_5_out),
        .O(val_i_2__2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_3__24
       (.I0(p_3_out),
        .I1(p_6_in),
        .I2(p_11_in),
        .O(val_i_3__24_n_0));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_4__31
       (.I0(p_3_out),
        .I1(p_6_in),
        .I2(p_2_out),
        .O(val_reg_1));
  FDRE #(
    .INIT(1'b0)) 
    val_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(val_reg_2),
        .Q(p_3_out),
        .R(rst_IBUF));
endmodule

(* ORIG_REF_NAME = "GOL_cell" *) 
module GOL_cell_26
   (p_2_out,
    val_reg_0,
    val_reg_1,
    rst_IBUF,
    val_reg_2,
    clk_IBUF_BUFG,
    p_3_out,
    val_reg_3,
    \GOL_outputs[3] ,
    p_8_in,
    p_6_in,
    p_7_in,
    p_4_out,
    p_1_out);
  output p_2_out;
  output val_reg_0;
  output val_reg_1;
  input rst_IBUF;
  input val_reg_2;
  input clk_IBUF_BUFG;
  input p_3_out;
  input val_reg_3;
  input [2:0]\GOL_outputs[3] ;
  input p_8_in;
  input p_6_in;
  input p_7_in;
  input p_4_out;
  input p_1_out;

  wire [2:0]\GOL_outputs[3] ;
  wire clk_IBUF_BUFG;
  wire p_1_out;
  wire p_2_out;
  wire p_3_out;
  wire p_4_out;
  wire p_6_in;
  wire p_7_in;
  wire p_8_in;
  wire rst_IBUF;
  wire val_i_2__17_n_0;
  wire val_i_3__25_n_0;
  wire val_reg_0;
  wire val_reg_1;
  wire val_reg_2;
  wire val_reg_3;

  LUT6 #(
    .INIT(64'h8332322C322C2CC8)) 
    val_i_1__25
       (.I0(p_3_out),
        .I1(val_i_2__17_n_0),
        .I2(val_i_3__25_n_0),
        .I3(val_reg_3),
        .I4(\GOL_outputs[3] [0]),
        .I5(p_8_in),
        .O(val_reg_0));
  LUT6 #(
    .INIT(64'h171717E817E8E8E8)) 
    val_i_2__17
       (.I0(p_2_out),
        .I1(p_6_in),
        .I2(p_7_in),
        .I3(\GOL_outputs[3] [1]),
        .I4(\GOL_outputs[3] [2]),
        .I5(p_4_out),
        .O(val_i_2__17_n_0));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_3__25
       (.I0(p_2_out),
        .I1(p_7_in),
        .I2(p_6_in),
        .O(val_i_3__25_n_0));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_4__32
       (.I0(p_2_out),
        .I1(p_7_in),
        .I2(p_1_out),
        .O(val_reg_1));
  FDRE #(
    .INIT(1'b0)) 
    val_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(val_reg_2),
        .Q(p_2_out),
        .R(rst_IBUF));
endmodule

(* ORIG_REF_NAME = "GOL_cell" *) 
module GOL_cell_27
   (p_1_out,
    val_reg_0,
    val_reg_1,
    rst_IBUF,
    val_reg_2,
    clk_IBUF_BUFG,
    p_2_out,
    val_reg_3,
    \GOL_outputs[3] ,
    p_9_in,
    p_7_in,
    p_8_in,
    p_3_out,
    p_0_out);
  output p_1_out;
  output val_reg_0;
  output val_reg_1;
  input rst_IBUF;
  input val_reg_2;
  input clk_IBUF_BUFG;
  input p_2_out;
  input val_reg_3;
  input [2:0]\GOL_outputs[3] ;
  input p_9_in;
  input p_7_in;
  input p_8_in;
  input p_3_out;
  input p_0_out;

  wire [2:0]\GOL_outputs[3] ;
  wire clk_IBUF_BUFG;
  wire p_0_out;
  wire p_1_out;
  wire p_2_out;
  wire p_3_out;
  wire p_7_in;
  wire p_8_in;
  wire p_9_in;
  wire rst_IBUF;
  wire val_i_2__23_n_0;
  wire val_i_3__26_n_0;
  wire val_reg_0;
  wire val_reg_1;
  wire val_reg_2;
  wire val_reg_3;

  LUT6 #(
    .INIT(64'h8332322C322C2CC8)) 
    val_i_1__26
       (.I0(p_2_out),
        .I1(val_i_2__23_n_0),
        .I2(val_i_3__26_n_0),
        .I3(val_reg_3),
        .I4(\GOL_outputs[3] [0]),
        .I5(p_9_in),
        .O(val_reg_0));
  LUT6 #(
    .INIT(64'h171717E817E8E8E8)) 
    val_i_2__23
       (.I0(p_1_out),
        .I1(p_7_in),
        .I2(p_8_in),
        .I3(\GOL_outputs[3] [1]),
        .I4(\GOL_outputs[3] [2]),
        .I5(p_3_out),
        .O(val_i_2__23_n_0));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_3__26
       (.I0(p_1_out),
        .I1(p_8_in),
        .I2(p_7_in),
        .O(val_i_3__26_n_0));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_4__33
       (.I0(p_1_out),
        .I1(p_8_in),
        .I2(p_0_out),
        .O(val_reg_1));
  FDRE #(
    .INIT(1'b0)) 
    val_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(val_reg_2),
        .Q(p_1_out),
        .R(rst_IBUF));
endmodule

(* ORIG_REF_NAME = "GOL_cell" *) 
module GOL_cell_28
   (p_0_out,
    val_reg_0,
    val_reg_1,
    rst_IBUF,
    val_reg_2,
    clk_IBUF_BUFG,
    p_1_out,
    val_reg_3,
    \GOL_outputs[3] ,
    p_10_in,
    p_8_in,
    p_9_in,
    p_2_out,
    p_5_out);
  output p_0_out;
  output val_reg_0;
  output val_reg_1;
  input rst_IBUF;
  input val_reg_2;
  input clk_IBUF_BUFG;
  input p_1_out;
  input val_reg_3;
  input [2:0]\GOL_outputs[3] ;
  input p_10_in;
  input p_8_in;
  input p_9_in;
  input p_2_out;
  input p_5_out;

  wire [2:0]\GOL_outputs[3] ;
  wire clk_IBUF_BUFG;
  wire p_0_out;
  wire p_10_in;
  wire p_1_out;
  wire p_2_out;
  wire p_5_out;
  wire p_8_in;
  wire p_9_in;
  wire rst_IBUF;
  wire val_i_2__29_n_0;
  wire val_i_3__27_n_0;
  wire val_reg_0;
  wire val_reg_1;
  wire val_reg_2;
  wire val_reg_3;

  LUT6 #(
    .INIT(64'h8332322C322C2CC8)) 
    val_i_1__27
       (.I0(p_1_out),
        .I1(val_i_2__29_n_0),
        .I2(val_i_3__27_n_0),
        .I3(val_reg_3),
        .I4(\GOL_outputs[3] [0]),
        .I5(p_10_in),
        .O(val_reg_0));
  LUT6 #(
    .INIT(64'h171717E817E8E8E8)) 
    val_i_2__29
       (.I0(p_0_out),
        .I1(p_8_in),
        .I2(p_9_in),
        .I3(\GOL_outputs[3] [1]),
        .I4(\GOL_outputs[3] [2]),
        .I5(p_2_out),
        .O(val_i_2__29_n_0));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_3__27
       (.I0(p_0_out),
        .I1(p_9_in),
        .I2(p_8_in),
        .O(val_i_3__27_n_0));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_4__34
       (.I0(p_0_out),
        .I1(p_9_in),
        .I2(p_5_out),
        .O(val_reg_1));
  FDRE #(
    .INIT(1'b0)) 
    val_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(val_reg_2),
        .Q(p_0_out),
        .R(rst_IBUF));
endmodule

(* ORIG_REF_NAME = "GOL_cell" *) 
module GOL_cell_29
   (p_11_in,
    val_reg_0,
    val_reg_1,
    val_reg_2,
    rst_IBUF,
    val_reg_3,
    clk_IBUF_BUFG,
    p_10_in,
    val_reg_4,
    p_1_out,
    \GOL_outputs[0]_0 ,
    \GOL_outputs[0]_4 ,
    \GOL_outputs[0]_5 ,
    p_0_out,
    p_5_out,
    p_9_in,
    p_6_in,
    row_IBUF);
  output p_11_in;
  output val_reg_0;
  output val_reg_1;
  output val_reg_2;
  input rst_IBUF;
  input val_reg_3;
  input clk_IBUF_BUFG;
  input p_10_in;
  input val_reg_4;
  input p_1_out;
  input \GOL_outputs[0]_0 ;
  input \GOL_outputs[0]_4 ;
  input \GOL_outputs[0]_5 ;
  input p_0_out;
  input p_5_out;
  input p_9_in;
  input p_6_in;
  input [0:0]row_IBUF;

  wire \GOL_outputs[0]_0 ;
  wire \GOL_outputs[0]_4 ;
  wire \GOL_outputs[0]_5 ;
  wire clk_IBUF_BUFG;
  wire p_0_out;
  wire p_10_in;
  wire p_11_in;
  wire p_1_out;
  wire p_5_out;
  wire p_6_in;
  wire p_9_in;
  wire [0:0]row_IBUF;
  wire rst_IBUF;
  wire val_i_2__1_n_0;
  wire val_i_3__34_n_0;
  wire val_reg_0;
  wire val_reg_1;
  wire val_reg_2;
  wire val_reg_3;
  wire val_reg_4;

  LUT3 #(
    .INIT(8'hB8)) 
    val_OBUF_inst_i_20
       (.I0(p_11_in),
        .I1(row_IBUF),
        .I2(p_5_out),
        .O(val_reg_2));
  LUT6 #(
    .INIT(64'h8332322C322C2CC8)) 
    val_i_1__34
       (.I0(p_10_in),
        .I1(val_i_2__1_n_0),
        .I2(val_i_3__34_n_0),
        .I3(val_reg_4),
        .I4(p_1_out),
        .I5(\GOL_outputs[0]_0 ),
        .O(val_reg_0));
  LUT6 #(
    .INIT(64'h171717E817E8E8E8)) 
    val_i_2__1
       (.I0(p_11_in),
        .I1(\GOL_outputs[0]_4 ),
        .I2(\GOL_outputs[0]_5 ),
        .I3(p_0_out),
        .I4(p_5_out),
        .I5(p_9_in),
        .O(val_i_2__1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_3__34
       (.I0(p_11_in),
        .I1(\GOL_outputs[0]_5 ),
        .I2(\GOL_outputs[0]_4 ),
        .O(val_i_3__34_n_0));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_4
       (.I0(p_11_in),
        .I1(\GOL_outputs[0]_5 ),
        .I2(p_6_in),
        .O(val_reg_1));
  FDRE #(
    .INIT(1'b0)) 
    val_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(val_reg_3),
        .Q(p_11_in),
        .R(rst_IBUF));
endmodule

(* ORIG_REF_NAME = "GOL_cell" *) 
module GOL_cell_3
   (\GOL_outputs[0]_4 ,
    val_reg_0,
    val_reg_1,
    rst_IBUF,
    val_reg_2,
    clk_IBUF_BUFG,
    \GOL_outputs[0]_3 ,
    val_reg_3,
    p_7_in,
    p_3_in,
    p_1_in,
    p_2_in,
    p_8_in,
    p_9_in,
    \GOL_outputs[0]_2 ,
    \GOL_outputs[0]_5 );
  output \GOL_outputs[0]_4 ;
  output val_reg_0;
  output val_reg_1;
  input rst_IBUF;
  input val_reg_2;
  input clk_IBUF_BUFG;
  input \GOL_outputs[0]_3 ;
  input val_reg_3;
  input p_7_in;
  input p_3_in;
  input p_1_in;
  input p_2_in;
  input p_8_in;
  input p_9_in;
  input \GOL_outputs[0]_2 ;
  input \GOL_outputs[0]_5 ;

  wire \GOL_outputs[0]_2 ;
  wire \GOL_outputs[0]_3 ;
  wire \GOL_outputs[0]_4 ;
  wire \GOL_outputs[0]_5 ;
  wire clk_IBUF_BUFG;
  wire p_1_in;
  wire p_2_in;
  wire p_3_in;
  wire p_7_in;
  wire p_8_in;
  wire p_9_in;
  wire rst_IBUF;
  wire val_i_2__27_n_0;
  wire val_i_3__2_n_0;
  wire val_reg_0;
  wire val_reg_1;
  wire val_reg_2;
  wire val_reg_3;

  LUT6 #(
    .INIT(64'h8332322C322C2CC8)) 
    val_i_1__2
       (.I0(\GOL_outputs[0]_3 ),
        .I1(val_i_2__27_n_0),
        .I2(val_i_3__2_n_0),
        .I3(val_reg_3),
        .I4(p_7_in),
        .I5(p_3_in),
        .O(val_reg_0));
  LUT6 #(
    .INIT(64'h171717E817E8E8E8)) 
    val_i_2__27
       (.I0(\GOL_outputs[0]_4 ),
        .I1(p_1_in),
        .I2(p_2_in),
        .I3(p_8_in),
        .I4(p_9_in),
        .I5(\GOL_outputs[0]_2 ),
        .O(val_i_2__27_n_0));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_3__2
       (.I0(\GOL_outputs[0]_4 ),
        .I1(p_2_in),
        .I2(p_1_in),
        .O(val_i_3__2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_4__9
       (.I0(\GOL_outputs[0]_4 ),
        .I1(p_2_in),
        .I2(\GOL_outputs[0]_5 ),
        .O(val_reg_1));
  FDRE #(
    .INIT(1'b0)) 
    val_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(val_reg_2),
        .Q(\GOL_outputs[0]_4 ),
        .R(rst_IBUF));
endmodule

(* ORIG_REF_NAME = "GOL_cell" *) 
module GOL_cell_30
   (p_6_in,
    val_reg_0,
    val_reg_1,
    val_reg_2,
    rst_IBUF,
    val_reg_3,
    clk_IBUF_BUFG,
    p_11_in,
    val_reg_4,
    p_0_out,
    \GOL_outputs[0]_1 ,
    \GOL_outputs[0]_5 ,
    \GOL_outputs[0]_0 ,
    p_5_out,
    p_4_out,
    p_10_in,
    p_7_in,
    row_IBUF);
  output p_6_in;
  output val_reg_0;
  output val_reg_1;
  output val_reg_2;
  input rst_IBUF;
  input val_reg_3;
  input clk_IBUF_BUFG;
  input p_11_in;
  input val_reg_4;
  input p_0_out;
  input \GOL_outputs[0]_1 ;
  input \GOL_outputs[0]_5 ;
  input \GOL_outputs[0]_0 ;
  input p_5_out;
  input p_4_out;
  input p_10_in;
  input p_7_in;
  input [0:0]row_IBUF;

  wire \GOL_outputs[0]_0 ;
  wire \GOL_outputs[0]_1 ;
  wire \GOL_outputs[0]_5 ;
  wire clk_IBUF_BUFG;
  wire p_0_out;
  wire p_10_in;
  wire p_11_in;
  wire p_4_out;
  wire p_5_out;
  wire p_6_in;
  wire p_7_in;
  wire [0:0]row_IBUF;
  wire rst_IBUF;
  wire val_i_2_n_0;
  wire val_i_3__29_n_0;
  wire val_reg_0;
  wire val_reg_1;
  wire val_reg_2;
  wire val_reg_3;
  wire val_reg_4;

  LUT3 #(
    .INIT(8'hB8)) 
    val_OBUF_inst_i_22
       (.I0(p_6_in),
        .I1(row_IBUF),
        .I2(p_4_out),
        .O(val_reg_2));
  LUT6 #(
    .INIT(64'h8332322C322C2CC8)) 
    val_i_1__29
       (.I0(p_11_in),
        .I1(val_i_2_n_0),
        .I2(val_i_3__29_n_0),
        .I3(val_reg_4),
        .I4(p_0_out),
        .I5(\GOL_outputs[0]_1 ),
        .O(val_reg_0));
  LUT6 #(
    .INIT(64'h171717E817E8E8E8)) 
    val_i_2
       (.I0(p_6_in),
        .I1(\GOL_outputs[0]_5 ),
        .I2(\GOL_outputs[0]_0 ),
        .I3(p_5_out),
        .I4(p_4_out),
        .I5(p_10_in),
        .O(val_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_3__29
       (.I0(p_6_in),
        .I1(\GOL_outputs[0]_0 ),
        .I2(\GOL_outputs[0]_5 ),
        .O(val_i_3__29_n_0));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_4__0
       (.I0(p_6_in),
        .I1(\GOL_outputs[0]_0 ),
        .I2(p_7_in),
        .O(val_reg_1));
  FDRE #(
    .INIT(1'b0)) 
    val_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(val_reg_3),
        .Q(p_6_in),
        .R(rst_IBUF));
endmodule

(* ORIG_REF_NAME = "GOL_cell" *) 
module GOL_cell_31
   (p_7_in,
    val_reg_0,
    val_reg_1,
    val_reg_2,
    rst_IBUF,
    val_reg_3,
    clk_IBUF_BUFG,
    p_6_in,
    val_reg_4,
    p_5_out,
    \GOL_outputs[0]_2 ,
    \GOL_outputs[0]_0 ,
    \GOL_outputs[0]_1 ,
    p_4_out,
    p_3_out,
    p_11_in,
    p_8_in,
    row_IBUF);
  output p_7_in;
  output val_reg_0;
  output val_reg_1;
  output val_reg_2;
  input rst_IBUF;
  input val_reg_3;
  input clk_IBUF_BUFG;
  input p_6_in;
  input val_reg_4;
  input p_5_out;
  input \GOL_outputs[0]_2 ;
  input \GOL_outputs[0]_0 ;
  input \GOL_outputs[0]_1 ;
  input p_4_out;
  input p_3_out;
  input p_11_in;
  input p_8_in;
  input [0:0]row_IBUF;

  wire \GOL_outputs[0]_0 ;
  wire \GOL_outputs[0]_1 ;
  wire \GOL_outputs[0]_2 ;
  wire clk_IBUF_BUFG;
  wire p_11_in;
  wire p_3_out;
  wire p_4_out;
  wire p_5_out;
  wire p_6_in;
  wire p_7_in;
  wire p_8_in;
  wire [0:0]row_IBUF;
  wire rst_IBUF;
  wire val_i_2__7_n_0;
  wire val_i_3__30_n_0;
  wire val_reg_0;
  wire val_reg_1;
  wire val_reg_2;
  wire val_reg_3;
  wire val_reg_4;

  LUT3 #(
    .INIT(8'hB8)) 
    val_OBUF_inst_i_16
       (.I0(p_7_in),
        .I1(row_IBUF),
        .I2(p_3_out),
        .O(val_reg_2));
  LUT6 #(
    .INIT(64'h8332322C322C2CC8)) 
    val_i_1__30
       (.I0(p_6_in),
        .I1(val_i_2__7_n_0),
        .I2(val_i_3__30_n_0),
        .I3(val_reg_4),
        .I4(p_5_out),
        .I5(\GOL_outputs[0]_2 ),
        .O(val_reg_0));
  LUT6 #(
    .INIT(64'h171717E817E8E8E8)) 
    val_i_2__7
       (.I0(p_7_in),
        .I1(\GOL_outputs[0]_0 ),
        .I2(\GOL_outputs[0]_1 ),
        .I3(p_4_out),
        .I4(p_3_out),
        .I5(p_11_in),
        .O(val_i_2__7_n_0));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_3__30
       (.I0(p_7_in),
        .I1(\GOL_outputs[0]_1 ),
        .I2(\GOL_outputs[0]_0 ),
        .O(val_i_3__30_n_0));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_4__1
       (.I0(p_7_in),
        .I1(\GOL_outputs[0]_1 ),
        .I2(p_8_in),
        .O(val_reg_1));
  FDRE #(
    .INIT(1'b0)) 
    val_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(val_reg_3),
        .Q(p_7_in),
        .R(rst_IBUF));
endmodule

(* ORIG_REF_NAME = "GOL_cell" *) 
module GOL_cell_32
   (p_8_in,
    val_reg_0,
    val_reg_1,
    val_reg_2,
    rst_IBUF,
    val_reg_3,
    clk_IBUF_BUFG,
    p_7_in,
    val_reg_4,
    p_4_out,
    \GOL_outputs[0]_3 ,
    \GOL_outputs[0]_1 ,
    \GOL_outputs[0]_2 ,
    p_3_out,
    p_2_out,
    p_6_in,
    p_9_in,
    row_IBUF);
  output p_8_in;
  output val_reg_0;
  output val_reg_1;
  output val_reg_2;
  input rst_IBUF;
  input val_reg_3;
  input clk_IBUF_BUFG;
  input p_7_in;
  input val_reg_4;
  input p_4_out;
  input \GOL_outputs[0]_3 ;
  input \GOL_outputs[0]_1 ;
  input \GOL_outputs[0]_2 ;
  input p_3_out;
  input p_2_out;
  input p_6_in;
  input p_9_in;
  input [0:0]row_IBUF;

  wire \GOL_outputs[0]_1 ;
  wire \GOL_outputs[0]_2 ;
  wire \GOL_outputs[0]_3 ;
  wire clk_IBUF_BUFG;
  wire p_2_out;
  wire p_3_out;
  wire p_4_out;
  wire p_6_in;
  wire p_7_in;
  wire p_8_in;
  wire p_9_in;
  wire [0:0]row_IBUF;
  wire rst_IBUF;
  wire val_i_2__19_n_0;
  wire val_i_3__31_n_0;
  wire val_reg_0;
  wire val_reg_1;
  wire val_reg_2;
  wire val_reg_3;
  wire val_reg_4;

  LUT3 #(
    .INIT(8'hB8)) 
    val_OBUF_inst_i_18
       (.I0(p_8_in),
        .I1(row_IBUF),
        .I2(p_2_out),
        .O(val_reg_2));
  LUT6 #(
    .INIT(64'h8332322C322C2CC8)) 
    val_i_1__31
       (.I0(p_7_in),
        .I1(val_i_2__19_n_0),
        .I2(val_i_3__31_n_0),
        .I3(val_reg_4),
        .I4(p_4_out),
        .I5(\GOL_outputs[0]_3 ),
        .O(val_reg_0));
  LUT6 #(
    .INIT(64'h171717E817E8E8E8)) 
    val_i_2__19
       (.I0(p_8_in),
        .I1(\GOL_outputs[0]_1 ),
        .I2(\GOL_outputs[0]_2 ),
        .I3(p_3_out),
        .I4(p_2_out),
        .I5(p_6_in),
        .O(val_i_2__19_n_0));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_3__31
       (.I0(p_8_in),
        .I1(\GOL_outputs[0]_2 ),
        .I2(\GOL_outputs[0]_1 ),
        .O(val_i_3__31_n_0));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_4__2
       (.I0(p_8_in),
        .I1(\GOL_outputs[0]_2 ),
        .I2(p_9_in),
        .O(val_reg_1));
  FDRE #(
    .INIT(1'b0)) 
    val_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(val_reg_3),
        .Q(p_8_in),
        .R(rst_IBUF));
endmodule

(* ORIG_REF_NAME = "GOL_cell" *) 
module GOL_cell_33
   (p_9_in,
    val_reg_0,
    val_reg_1,
    val_reg_2,
    rst_IBUF,
    val_reg_3,
    clk_IBUF_BUFG,
    p_8_in,
    val_reg_4,
    p_3_out,
    \GOL_outputs[0]_4 ,
    \GOL_outputs[0]_2 ,
    \GOL_outputs[0]_3 ,
    p_2_out,
    p_1_out,
    p_7_in,
    p_10_in,
    row_IBUF);
  output p_9_in;
  output val_reg_0;
  output val_reg_1;
  output val_reg_2;
  input rst_IBUF;
  input val_reg_3;
  input clk_IBUF_BUFG;
  input p_8_in;
  input val_reg_4;
  input p_3_out;
  input \GOL_outputs[0]_4 ;
  input \GOL_outputs[0]_2 ;
  input \GOL_outputs[0]_3 ;
  input p_2_out;
  input p_1_out;
  input p_7_in;
  input p_10_in;
  input [0:0]row_IBUF;

  wire \GOL_outputs[0]_2 ;
  wire \GOL_outputs[0]_3 ;
  wire \GOL_outputs[0]_4 ;
  wire clk_IBUF_BUFG;
  wire p_10_in;
  wire p_1_out;
  wire p_2_out;
  wire p_3_out;
  wire p_7_in;
  wire p_8_in;
  wire p_9_in;
  wire [0:0]row_IBUF;
  wire rst_IBUF;
  wire val_i_2__25_n_0;
  wire val_i_3__32_n_0;
  wire val_reg_0;
  wire val_reg_1;
  wire val_reg_2;
  wire val_reg_3;
  wire val_reg_4;

  LUT3 #(
    .INIT(8'hB8)) 
    val_OBUF_inst_i_12
       (.I0(p_9_in),
        .I1(row_IBUF),
        .I2(p_1_out),
        .O(val_reg_2));
  LUT6 #(
    .INIT(64'h8332322C322C2CC8)) 
    val_i_1__32
       (.I0(p_8_in),
        .I1(val_i_2__25_n_0),
        .I2(val_i_3__32_n_0),
        .I3(val_reg_4),
        .I4(p_3_out),
        .I5(\GOL_outputs[0]_4 ),
        .O(val_reg_0));
  LUT6 #(
    .INIT(64'h171717E817E8E8E8)) 
    val_i_2__25
       (.I0(p_9_in),
        .I1(\GOL_outputs[0]_2 ),
        .I2(\GOL_outputs[0]_3 ),
        .I3(p_2_out),
        .I4(p_1_out),
        .I5(p_7_in),
        .O(val_i_2__25_n_0));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_3__32
       (.I0(p_9_in),
        .I1(\GOL_outputs[0]_3 ),
        .I2(\GOL_outputs[0]_2 ),
        .O(val_i_3__32_n_0));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_4__3
       (.I0(p_9_in),
        .I1(\GOL_outputs[0]_3 ),
        .I2(p_10_in),
        .O(val_reg_1));
  FDRE #(
    .INIT(1'b0)) 
    val_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(val_reg_3),
        .Q(p_9_in),
        .R(rst_IBUF));
endmodule

(* ORIG_REF_NAME = "GOL_cell" *) 
module GOL_cell_34
   (p_10_in,
    val_reg_0,
    val_reg_1,
    val_reg_2,
    rst_IBUF,
    val_reg_3,
    clk_IBUF_BUFG,
    p_9_in,
    val_reg_4,
    p_2_out,
    \GOL_outputs[0]_5 ,
    \GOL_outputs[0]_3 ,
    \GOL_outputs[0]_4 ,
    p_1_out,
    p_0_out,
    p_8_in,
    p_11_in,
    row_IBUF);
  output p_10_in;
  output val_reg_0;
  output val_reg_1;
  output val_reg_2;
  input rst_IBUF;
  input val_reg_3;
  input clk_IBUF_BUFG;
  input p_9_in;
  input val_reg_4;
  input p_2_out;
  input \GOL_outputs[0]_5 ;
  input \GOL_outputs[0]_3 ;
  input \GOL_outputs[0]_4 ;
  input p_1_out;
  input p_0_out;
  input p_8_in;
  input p_11_in;
  input [0:0]row_IBUF;

  wire \GOL_outputs[0]_3 ;
  wire \GOL_outputs[0]_4 ;
  wire \GOL_outputs[0]_5 ;
  wire clk_IBUF_BUFG;
  wire p_0_out;
  wire p_10_in;
  wire p_11_in;
  wire p_1_out;
  wire p_2_out;
  wire p_8_in;
  wire p_9_in;
  wire [0:0]row_IBUF;
  wire rst_IBUF;
  wire val_i_2__31_n_0;
  wire val_i_3__33_n_0;
  wire val_reg_0;
  wire val_reg_1;
  wire val_reg_2;
  wire val_reg_3;
  wire val_reg_4;

  LUT3 #(
    .INIT(8'hB8)) 
    val_OBUF_inst_i_14
       (.I0(p_10_in),
        .I1(row_IBUF),
        .I2(p_0_out),
        .O(val_reg_2));
  LUT6 #(
    .INIT(64'h8332322C322C2CC8)) 
    val_i_1__33
       (.I0(p_9_in),
        .I1(val_i_2__31_n_0),
        .I2(val_i_3__33_n_0),
        .I3(val_reg_4),
        .I4(p_2_out),
        .I5(\GOL_outputs[0]_5 ),
        .O(val_reg_0));
  LUT6 #(
    .INIT(64'h171717E817E8E8E8)) 
    val_i_2__31
       (.I0(p_10_in),
        .I1(\GOL_outputs[0]_3 ),
        .I2(\GOL_outputs[0]_4 ),
        .I3(p_1_out),
        .I4(p_0_out),
        .I5(p_8_in),
        .O(val_i_2__31_n_0));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_3__33
       (.I0(p_10_in),
        .I1(\GOL_outputs[0]_4 ),
        .I2(\GOL_outputs[0]_3 ),
        .O(val_i_3__33_n_0));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_4__4
       (.I0(p_10_in),
        .I1(\GOL_outputs[0]_4 ),
        .I2(p_11_in),
        .O(val_reg_1));
  FDRE #(
    .INIT(1'b0)) 
    val_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(val_reg_3),
        .Q(p_10_in),
        .R(rst_IBUF));
endmodule

(* ORIG_REF_NAME = "GOL_cell" *) 
module GOL_cell_4
   (\GOL_outputs[0]_5 ,
    val_reg_0,
    val_reg_1,
    rst_IBUF,
    val_reg_2,
    clk_IBUF_BUFG,
    \GOL_outputs[0]_4 ,
    val_reg_3,
    p_8_in,
    p_4_in,
    p_2_in,
    p_3_in,
    p_9_in,
    p_10_in,
    \GOL_outputs[0]_3 ,
    \GOL_outputs[0]_0 );
  output \GOL_outputs[0]_5 ;
  output val_reg_0;
  output val_reg_1;
  input rst_IBUF;
  input val_reg_2;
  input clk_IBUF_BUFG;
  input \GOL_outputs[0]_4 ;
  input val_reg_3;
  input p_8_in;
  input p_4_in;
  input p_2_in;
  input p_3_in;
  input p_9_in;
  input p_10_in;
  input \GOL_outputs[0]_3 ;
  input \GOL_outputs[0]_0 ;

  wire \GOL_outputs[0]_0 ;
  wire \GOL_outputs[0]_3 ;
  wire \GOL_outputs[0]_4 ;
  wire \GOL_outputs[0]_5 ;
  wire clk_IBUF_BUFG;
  wire p_10_in;
  wire p_2_in;
  wire p_3_in;
  wire p_4_in;
  wire p_8_in;
  wire p_9_in;
  wire rst_IBUF;
  wire val_i_2__33_n_0;
  wire val_i_3__3_n_0;
  wire val_reg_0;
  wire val_reg_1;
  wire val_reg_2;
  wire val_reg_3;

  LUT6 #(
    .INIT(64'h8332322C322C2CC8)) 
    val_i_1__3
       (.I0(\GOL_outputs[0]_4 ),
        .I1(val_i_2__33_n_0),
        .I2(val_i_3__3_n_0),
        .I3(val_reg_3),
        .I4(p_8_in),
        .I5(p_4_in),
        .O(val_reg_0));
  LUT6 #(
    .INIT(64'h171717E817E8E8E8)) 
    val_i_2__33
       (.I0(\GOL_outputs[0]_5 ),
        .I1(p_2_in),
        .I2(p_3_in),
        .I3(p_9_in),
        .I4(p_10_in),
        .I5(\GOL_outputs[0]_3 ),
        .O(val_i_2__33_n_0));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_3__3
       (.I0(\GOL_outputs[0]_5 ),
        .I1(p_3_in),
        .I2(p_2_in),
        .O(val_i_3__3_n_0));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_4__10
       (.I0(\GOL_outputs[0]_5 ),
        .I1(p_3_in),
        .I2(\GOL_outputs[0]_0 ),
        .O(val_reg_1));
  FDRE #(
    .INIT(1'b0)) 
    val_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(val_reg_2),
        .Q(\GOL_outputs[0]_5 ),
        .R(rst_IBUF));
endmodule

(* ORIG_REF_NAME = "GOL_cell" *) 
module GOL_cell_5
   (p_5_in,
    val_reg_0,
    val_reg_1,
    rst_IBUF,
    val_reg_2,
    clk_IBUF_BUFG,
    p_4_in,
    val_reg_3,
    \GOL_outputs[0]_4 ,
    \GOL_outputs[2] ,
    \GOL_outputs[0]_5 ,
    \GOL_outputs[0]_0 ,
    p_3_in,
    p_0_in);
  output p_5_in;
  output val_reg_0;
  output val_reg_1;
  input rst_IBUF;
  input val_reg_2;
  input clk_IBUF_BUFG;
  input p_4_in;
  input val_reg_3;
  input \GOL_outputs[0]_4 ;
  input [2:0]\GOL_outputs[2] ;
  input \GOL_outputs[0]_5 ;
  input \GOL_outputs[0]_0 ;
  input p_3_in;
  input p_0_in;

  wire \GOL_outputs[0]_0 ;
  wire \GOL_outputs[0]_4 ;
  wire \GOL_outputs[0]_5 ;
  wire [2:0]\GOL_outputs[2] ;
  wire clk_IBUF_BUFG;
  wire p_0_in;
  wire p_3_in;
  wire p_4_in;
  wire p_5_in;
  wire rst_IBUF;
  wire val_i_2__11_n_0;
  wire val_i_3__10_n_0;
  wire val_reg_0;
  wire val_reg_1;
  wire val_reg_2;
  wire val_reg_3;

  LUT6 #(
    .INIT(64'h8332322C322C2CC8)) 
    val_i_1__10
       (.I0(p_4_in),
        .I1(val_i_2__11_n_0),
        .I2(val_i_3__10_n_0),
        .I3(val_reg_3),
        .I4(\GOL_outputs[0]_4 ),
        .I5(\GOL_outputs[2] [0]),
        .O(val_reg_0));
  LUT6 #(
    .INIT(64'h171717E817E8E8E8)) 
    val_i_2__11
       (.I0(p_5_in),
        .I1(\GOL_outputs[2] [1]),
        .I2(\GOL_outputs[2] [2]),
        .I3(\GOL_outputs[0]_5 ),
        .I4(\GOL_outputs[0]_0 ),
        .I5(p_3_in),
        .O(val_i_2__11_n_0));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_3__10
       (.I0(p_5_in),
        .I1(\GOL_outputs[2] [2]),
        .I2(\GOL_outputs[2] [1]),
        .O(val_i_3__10_n_0));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_4__11
       (.I0(p_5_in),
        .I1(\GOL_outputs[2] [2]),
        .I2(p_0_in),
        .O(val_reg_1));
  FDRE #(
    .INIT(1'b0)) 
    val_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(val_reg_2),
        .Q(p_5_in),
        .R(rst_IBUF));
endmodule

(* ORIG_REF_NAME = "GOL_cell" *) 
module GOL_cell_6
   (p_0_in,
    val_reg_0,
    val_reg_1,
    rst_IBUF,
    val_reg_2,
    clk_IBUF_BUFG,
    p_5_in,
    val_reg_3,
    \GOL_outputs[0]_5 ,
    \GOL_outputs[2] ,
    \GOL_outputs[0]_0 ,
    \GOL_outputs[0]_1 ,
    p_4_in,
    p_1_in);
  output p_0_in;
  output val_reg_0;
  output val_reg_1;
  input rst_IBUF;
  input val_reg_2;
  input clk_IBUF_BUFG;
  input p_5_in;
  input val_reg_3;
  input \GOL_outputs[0]_5 ;
  input [2:0]\GOL_outputs[2] ;
  input \GOL_outputs[0]_0 ;
  input \GOL_outputs[0]_1 ;
  input p_4_in;
  input p_1_in;

  wire \GOL_outputs[0]_0 ;
  wire \GOL_outputs[0]_1 ;
  wire \GOL_outputs[0]_5 ;
  wire [2:0]\GOL_outputs[2] ;
  wire clk_IBUF_BUFG;
  wire p_0_in;
  wire p_1_in;
  wire p_4_in;
  wire p_5_in;
  wire rst_IBUF;
  wire val_i_2__5_n_0;
  wire val_i_3__5_n_0;
  wire val_reg_0;
  wire val_reg_1;
  wire val_reg_2;
  wire val_reg_3;

  LUT6 #(
    .INIT(64'h8332322C322C2CC8)) 
    val_i_1__5
       (.I0(p_5_in),
        .I1(val_i_2__5_n_0),
        .I2(val_i_3__5_n_0),
        .I3(val_reg_3),
        .I4(\GOL_outputs[0]_5 ),
        .I5(\GOL_outputs[2] [1]),
        .O(val_reg_0));
  LUT6 #(
    .INIT(64'h171717E817E8E8E8)) 
    val_i_2__5
       (.I0(p_0_in),
        .I1(\GOL_outputs[2] [2]),
        .I2(\GOL_outputs[2] [0]),
        .I3(\GOL_outputs[0]_0 ),
        .I4(\GOL_outputs[0]_1 ),
        .I5(p_4_in),
        .O(val_i_2__5_n_0));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_3__5
       (.I0(p_0_in),
        .I1(\GOL_outputs[2] [0]),
        .I2(\GOL_outputs[2] [2]),
        .O(val_i_3__5_n_0));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_4__12
       (.I0(p_0_in),
        .I1(\GOL_outputs[2] [0]),
        .I2(p_1_in),
        .O(val_reg_1));
  FDSE #(
    .INIT(1'b0)) 
    val_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(val_reg_2),
        .Q(p_0_in),
        .S(rst_IBUF));
endmodule

(* ORIG_REF_NAME = "GOL_cell" *) 
module GOL_cell_7
   (p_1_in,
    val_reg_0,
    val_reg_1,
    rst_IBUF,
    val_reg_2,
    clk_IBUF_BUFG,
    p_0_in,
    val_reg_3,
    \GOL_outputs[0]_0 ,
    \GOL_outputs[2] ,
    \GOL_outputs[0]_1 ,
    \GOL_outputs[0]_2 ,
    p_5_in,
    p_2_in);
  output p_1_in;
  output val_reg_0;
  output val_reg_1;
  input rst_IBUF;
  input val_reg_2;
  input clk_IBUF_BUFG;
  input p_0_in;
  input val_reg_3;
  input \GOL_outputs[0]_0 ;
  input [2:0]\GOL_outputs[2] ;
  input \GOL_outputs[0]_1 ;
  input \GOL_outputs[0]_2 ;
  input p_5_in;
  input p_2_in;

  wire \GOL_outputs[0]_0 ;
  wire \GOL_outputs[0]_1 ;
  wire \GOL_outputs[0]_2 ;
  wire [2:0]\GOL_outputs[2] ;
  wire clk_IBUF_BUFG;
  wire p_0_in;
  wire p_1_in;
  wire p_2_in;
  wire p_5_in;
  wire rst_IBUF;
  wire val_i_2__4_n_0;
  wire val_i_3__6_n_0;
  wire val_reg_0;
  wire val_reg_1;
  wire val_reg_2;
  wire val_reg_3;

  LUT6 #(
    .INIT(64'h8332322C322C2CC8)) 
    val_i_1__6
       (.I0(p_0_in),
        .I1(val_i_2__4_n_0),
        .I2(val_i_3__6_n_0),
        .I3(val_reg_3),
        .I4(\GOL_outputs[0]_0 ),
        .I5(\GOL_outputs[2] [2]),
        .O(val_reg_0));
  LUT6 #(
    .INIT(64'h171717E817E8E8E8)) 
    val_i_2__4
       (.I0(p_1_in),
        .I1(\GOL_outputs[2] [0]),
        .I2(\GOL_outputs[2] [1]),
        .I3(\GOL_outputs[0]_1 ),
        .I4(\GOL_outputs[0]_2 ),
        .I5(p_5_in),
        .O(val_i_2__4_n_0));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_3__6
       (.I0(p_1_in),
        .I1(\GOL_outputs[2] [1]),
        .I2(\GOL_outputs[2] [0]),
        .O(val_i_3__6_n_0));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_4__13
       (.I0(p_1_in),
        .I1(\GOL_outputs[2] [1]),
        .I2(p_2_in),
        .O(val_reg_1));
  FDSE #(
    .INIT(1'b0)) 
    val_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(val_reg_2),
        .Q(p_1_in),
        .S(rst_IBUF));
endmodule

(* ORIG_REF_NAME = "GOL_cell" *) 
module GOL_cell_8
   (p_2_in,
    val_reg_0,
    val_reg_1,
    rst_IBUF,
    val_reg_2,
    clk_IBUF_BUFG,
    p_1_in,
    val_reg_3,
    \GOL_outputs[0]_1 ,
    \GOL_outputs[2] ,
    \GOL_outputs[0]_2 ,
    \GOL_outputs[0]_3 ,
    p_0_in,
    p_3_in);
  output p_2_in;
  output val_reg_0;
  output val_reg_1;
  input rst_IBUF;
  input val_reg_2;
  input clk_IBUF_BUFG;
  input p_1_in;
  input val_reg_3;
  input \GOL_outputs[0]_1 ;
  input [2:0]\GOL_outputs[2] ;
  input \GOL_outputs[0]_2 ;
  input \GOL_outputs[0]_3 ;
  input p_0_in;
  input p_3_in;

  wire \GOL_outputs[0]_1 ;
  wire \GOL_outputs[0]_2 ;
  wire \GOL_outputs[0]_3 ;
  wire [2:0]\GOL_outputs[2] ;
  wire clk_IBUF_BUFG;
  wire p_0_in;
  wire p_1_in;
  wire p_2_in;
  wire p_3_in;
  wire rst_IBUF;
  wire val_i_2__18_n_0;
  wire val_i_3__7_n_0;
  wire val_reg_0;
  wire val_reg_1;
  wire val_reg_2;
  wire val_reg_3;

  LUT6 #(
    .INIT(64'h8332322C322C2CC8)) 
    val_i_1__7
       (.I0(p_1_in),
        .I1(val_i_2__18_n_0),
        .I2(val_i_3__7_n_0),
        .I3(val_reg_3),
        .I4(\GOL_outputs[0]_1 ),
        .I5(\GOL_outputs[2] [2]),
        .O(val_reg_0));
  LUT6 #(
    .INIT(64'h171717E817E8E8E8)) 
    val_i_2__18
       (.I0(p_2_in),
        .I1(\GOL_outputs[2] [0]),
        .I2(\GOL_outputs[2] [1]),
        .I3(\GOL_outputs[0]_2 ),
        .I4(\GOL_outputs[0]_3 ),
        .I5(p_0_in),
        .O(val_i_2__18_n_0));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_3__7
       (.I0(p_2_in),
        .I1(\GOL_outputs[2] [1]),
        .I2(\GOL_outputs[2] [0]),
        .O(val_i_3__7_n_0));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_4__14
       (.I0(p_2_in),
        .I1(\GOL_outputs[2] [1]),
        .I2(p_3_in),
        .O(val_reg_1));
  FDRE #(
    .INIT(1'b0)) 
    val_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(val_reg_2),
        .Q(p_2_in),
        .R(rst_IBUF));
endmodule

(* ORIG_REF_NAME = "GOL_cell" *) 
module GOL_cell_9
   (p_3_in,
    val_reg_0,
    val_reg_1,
    rst_IBUF,
    val_reg_2,
    clk_IBUF_BUFG,
    p_2_in,
    val_reg_3,
    \GOL_outputs[0]_2 ,
    \GOL_outputs[2] ,
    \GOL_outputs[0]_3 ,
    \GOL_outputs[0]_4 ,
    p_1_in,
    p_4_in);
  output p_3_in;
  output val_reg_0;
  output val_reg_1;
  input rst_IBUF;
  input val_reg_2;
  input clk_IBUF_BUFG;
  input p_2_in;
  input val_reg_3;
  input \GOL_outputs[0]_2 ;
  input [2:0]\GOL_outputs[2] ;
  input \GOL_outputs[0]_3 ;
  input \GOL_outputs[0]_4 ;
  input p_1_in;
  input p_4_in;

  wire \GOL_outputs[0]_2 ;
  wire \GOL_outputs[0]_3 ;
  wire \GOL_outputs[0]_4 ;
  wire [2:0]\GOL_outputs[2] ;
  wire clk_IBUF_BUFG;
  wire p_1_in;
  wire p_2_in;
  wire p_3_in;
  wire p_4_in;
  wire rst_IBUF;
  wire val_i_2__24_n_0;
  wire val_i_3__8_n_0;
  wire val_reg_0;
  wire val_reg_1;
  wire val_reg_2;
  wire val_reg_3;

  LUT6 #(
    .INIT(64'h8332322C322C2CC8)) 
    val_i_1__8
       (.I0(p_2_in),
        .I1(val_i_2__24_n_0),
        .I2(val_i_3__8_n_0),
        .I3(val_reg_3),
        .I4(\GOL_outputs[0]_2 ),
        .I5(\GOL_outputs[2] [2]),
        .O(val_reg_0));
  LUT6 #(
    .INIT(64'h171717E817E8E8E8)) 
    val_i_2__24
       (.I0(p_3_in),
        .I1(\GOL_outputs[2] [0]),
        .I2(\GOL_outputs[2] [1]),
        .I3(\GOL_outputs[0]_3 ),
        .I4(\GOL_outputs[0]_4 ),
        .I5(p_1_in),
        .O(val_i_2__24_n_0));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_3__8
       (.I0(p_3_in),
        .I1(\GOL_outputs[2] [1]),
        .I2(\GOL_outputs[2] [0]),
        .O(val_i_3__8_n_0));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'h96)) 
    val_i_4__15
       (.I0(p_3_in),
        .I1(\GOL_outputs[2] [1]),
        .I2(p_4_in),
        .O(val_reg_1));
  FDSE #(
    .INIT(1'b0)) 
    val_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(val_reg_2),
        .Q(p_3_in),
        .S(rst_IBUF));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
