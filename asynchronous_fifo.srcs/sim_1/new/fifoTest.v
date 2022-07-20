`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/18/2022 04:12:55 PM
// Design Name: 
// Module Name: fifoTest
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fifoTest(

    );
    
  reg rd_en;
  wire [4:0]read_dout;
  wire read_empty;
  reg reset_rtl;
  reg clk;
  reg [4:0]wr_din;
  reg wr_en;
  wire wr_full;
  
  integer i;
  
  initial begin
    clk = 0;
  end
  
  always begin
    #10
    clk = ~clk;
  end
  
  initial begin
    reset_rtl = 0;
    wr_din = 4'b0;
    wr_en = 0;
    rd_en = 0;

    #10
    #100
    reset_rtl = 1;
    #1000
    reset_rtl = 0;
    wr_en = 1;
    wr_din = 4'b0 + 1;
    //#20
    rd_en = 1;
    //wr_din = 2;
    #1
    for (i=0;i<16;i=i+1) begin
        @(posedge clk)
            #1
            wr_din = 4'b0 + i + 2;
    end
    
    rd_en = 0;  
    wr_din = 12;  
    for (i=2;i<20;i=i+1) begin
        @(posedge clk)
            #1
            wr_din = 4'b0 + i + 11;
    end
    
    rd_en = 1;
    wr_din = 4'd10;    
    for (i=0;i<20;i=i+1) begin
        @(posedge clk)
            #1
            wr_din = wr_din + 2;
    end
    
    //rd_en = 0;
    wr_en = 0;
    
    #1000
    wr_en = 0;
    rd_en = 0;

    
    
  end
     
fifo_wrapper fifo_u0 
   (
    .rd_en(rd_en),
    .read_dout(read_dout),
    .read_empty(read_empty),
    .reset_rtl(reset_rtl),
    .sys_clock(clk),
    .wr_din(wr_din),
    .wr_en(wr_en),
    .wr_full(wr_full)
    );

    
endmodule
