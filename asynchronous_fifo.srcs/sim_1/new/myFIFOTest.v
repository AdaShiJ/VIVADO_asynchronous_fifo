`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/19/2022 03:44:46 PM
// Design Name: 
// Module Name: myFIFOTest
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


module myFIFOTest(
);

  reg rd_en;
  reg rd_en_0;
  wire [4:0]read_dout;
  wire read_empty;
  wire [4:0]read_dout_0;
  wire read_empty_0;
  reg reset_rtl;
  reg reset_rtl_0;
  reg clk;
  reg [4:0]wr_din;
  reg [4:0]wr_din_0;
  reg wr_en;
  wire wr_full;
  wire wr_full_0;
  
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
    reset_rtl_0 = 0;
    wr_din = 4'b0;
    wr_din_0 = 4'b0;
    wr_en = 0;
    rd_en = 0;
    rd_en_0 = 0;

    #10
    #100
    reset_rtl = 1;
    reset_rtl_0 = 0;
    #1000
    reset_rtl_0 = 1;
   
    #20
    @(posedge clk)
    begin
        #1
        reset_rtl_0 = 0;
        wr_en = 1;
        wr_din = 4'b1;
        wr_din_0 = 4'b1;
    end
    #10    
    @(posedge clk)
    begin
        #1
        rd_en = 1;
        //rd_en_0 = 1;
        wr_din = 4'd2;
        wr_din_0 = 4'd2;
    end
    //wr_din = 2;
    #1
    for (i=0;i<16;i=i+1) begin
        @(posedge clk)
            #1
            rd_en_0 = 1;
            wr_din = 4'b0 + i + 3;
            wr_din_0 = 4'b0 + i + 3;
    end
    
    rd_en = 0; 
    rd_en_0 = 0; 
    wr_din = 12;  
    for (i=2;i<20;i=i+1) begin
        @(posedge clk)
            #1
            //if (i == 2) begin
            //    rd_en_0 = 0;
            //end
            wr_din = 4'b0 + i + 11;
            wr_din_0 = 4'b0 + i + 11;
    end
    
    rd_en = 1;
    //rd_en_0 = 1;
    wr_din = 4'd10;  
    wr_din_0 = 4'd8;  
    for (i=0;i<20;i=i+1) begin
        @(posedge clk)
            #1
            if (i == 0) begin
                rd_en_0 = 1;
            end
            wr_din = wr_din + 2;
            wr_din_0 = wr_din_0 + 2;
    end

    wr_en = 0;
    rd_en_0 = 0;
    
    #20
    rd_en = 0;
    
    #1000
    wr_en = 0;
    rd_en = 0;

    
    
  end
     
myFIFO myFIFO_u0 
   (
    .clk(clk),
    .rst(reset_rtl),
    .rd_en(rd_en),
    .wr_en(wr_en),
    .wr_din(wr_din),
    
    .rd_out(read_dout),
    .read_empty(read_empty),
    .wr_full(wr_full)
    );
    
    
fifo_wrapper fifo_u0 
   (
    .rd_en(rd_en_0),
    .read_dout(read_dout_0),
    .read_empty(read_empty_0),
    .reset_rtl(reset_rtl_0),
    .sys_clock(clk),
    .wr_din(wr_din),
    .wr_en(wr_en),
    .wr_full(wr_full_0)
    );

    
endmodule
