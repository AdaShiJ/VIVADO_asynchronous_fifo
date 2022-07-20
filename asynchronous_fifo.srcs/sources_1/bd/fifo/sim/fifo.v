//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
//Date        : Tue Jul 19 11:15:27 2022
//Host        : panther running 64-bit major release  (build 9200)
//Command     : generate_target fifo.bd
//Design      : fifo
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "fifo,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=fifo,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=1,numReposBlks=1,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,da_board_cnt=2,da_clkrst_cnt=1,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "fifo.hwdef" *) 
module fifo
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
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RESET_RTL RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RESET_RTL, INSERT_VIP 0, POLARITY ACTIVE_HIGH" *) input reset_rtl;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.SYS_CLOCK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.SYS_CLOCK, CLK_DOMAIN fifo_sys_clock, FREQ_HZ 125000000, INSERT_VIP 0, PHASE 0.000" *) input sys_clock;
  input [4:0]wr_din;
  input wr_en;
  output wr_full;

  wire [4:0]fifo_generator_0_dout;
  wire fifo_generator_0_empty;
  wire fifo_generator_0_full;
  wire rd_en_1;
  wire reset_rtl_1;
  wire sys_clock_1;
  wire [4:0]wr_din_1;
  wire wr_en_1;

  assign rd_en_1 = rd_en;
  assign read_dout[4:0] = fifo_generator_0_dout;
  assign read_empty = fifo_generator_0_empty;
  assign reset_rtl_1 = reset_rtl;
  assign sys_clock_1 = sys_clock;
  assign wr_din_1 = wr_din[4:0];
  assign wr_en_1 = wr_en;
  assign wr_full = fifo_generator_0_full;
  fifo_fifo_generator_0_0 fifo_generator_0
       (.clk(sys_clock_1),
        .din(wr_din_1),
        .dout(fifo_generator_0_dout),
        .empty(fifo_generator_0_empty),
        .full(fifo_generator_0_full),
        .rd_en(rd_en_1),
        .srst(reset_rtl_1),
        .wr_en(wr_en_1));
endmodule
