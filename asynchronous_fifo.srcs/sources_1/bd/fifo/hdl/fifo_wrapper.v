//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
//Date        : Tue Jul 19 11:15:27 2022
//Host        : panther running 64-bit major release  (build 9200)
//Command     : generate_target fifo_wrapper.bd
//Design      : fifo_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module fifo_wrapper
   (rd_en,
    read_dout,
    read_empty,
    reset_rtl,
    sys_clock,
    wr_din,
    wr_en,
    wr_full);
  input rd_en;
  output [4:0]read_dout;
  output read_empty;
  input reset_rtl;
  input sys_clock;
  input [4:0]wr_din;
  input wr_en;
  output wr_full;

  wire rd_en;
  wire [4:0]read_dout;
  wire read_empty;
  wire reset_rtl;
  wire sys_clock;
  wire [4:0]wr_din;
  wire wr_en;
  wire wr_full;

  fifo fifo_i
       (.rd_en(rd_en),
        .read_dout(read_dout),
        .read_empty(read_empty),
        .reset_rtl(reset_rtl),
        .sys_clock(sys_clock),
        .wr_din(wr_din),
        .wr_en(wr_en),
        .wr_full(wr_full));
endmodule
