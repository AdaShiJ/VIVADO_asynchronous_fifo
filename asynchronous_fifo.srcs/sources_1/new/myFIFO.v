`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/19/2022 02:26:47 PM
// Design Name: 
// Module Name: myFIFO
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


module myFIFO #(
    parameter FIFO_DEPTH  = 4, //2^4 = 16
    parameter FIFO_WIDTH  = 5
)
(
    input   clk,
    input   rst,
    input   rd_en,
    input   wr_en,
    input  [FIFO_WIDTH - 1 : 0]  wr_din,
    
    output [FIFO_WIDTH - 1 : 0]  rd_out,
    output reg  read_empty,
    output reg wr_full
    );
    
    wire rd_flag;
    wire wr_flag;
    //wire  rd_st = 0;
    //wire  wr_st = 0;
    wire [FIFO_DEPTH - 1 : 0]  rd_addr;
    wire [FIFO_DEPTH - 1 : 0]  wr_addr;
    wire [FIFO_DEPTH - 1 : 0]  rd_addr_nxt;
    wire [FIFO_DEPTH - 1 : 0]  wr_addr_nxt;
    reg [FIFO_DEPTH : 0]  rd_pt;
    reg [FIFO_DEPTH : 0]  wr_pt;
    reg [FIFO_WIDTH - 1 : 0]  fifo_buffer;
    reg rd_en1;
    //reg wr_full1;
    //reg wr_full2;
    wire rd_sin_nxt;
    wire wr_sin_nxt;
    //reg [FIFO_WIDTH - 1 : 0]  next_data;
    wire enable;
    wire rd_stop_pulse;

    localparam PT_MAX = 2**(FIFO_DEPTH+1)-1;
    localparam PT_ADDR_MAX = 2**(FIFO_DEPTH)-1;
    
    assign enable = rd_flag || wr_flag;
    assign rd_addr = rd_pt[FIFO_DEPTH - 1 : 0];
    assign wr_addr = wr_pt[FIFO_DEPTH - 1 : 0]; 
    assign rd_addr_nxt = rd_flag == 0 ? rd_addr : (rd_addr + 1 > PT_ADDR_MAX) ? 0 : rd_addr + 1;
    assign wr_addr_nxt = wr_flag == 0 ? wr_addr : (wr_addr + 1 > PT_ADDR_MAX) ? 0 : wr_addr + 1;
    assign rd_flag = read_empty ? 0 : rd_en; //rd_en && rd_st;
    assign wr_flag = wr_full ? 0 : wr_en; //wr_en && wr_st;
    assign rd_stop_pulse = rd_en1 && ~rd_en;
    //assign rd_st = read_empty ? 0 : rd_en;
    //assign wr_st = wr_full ? 0 : wr_en;
    //assign rd_sin_nxt = rd_flag == 0 ? rd_pt[FIFO_DEPTH] : (rd_addr + 1 > PT_ADDR_MAX) ? ~(rd_pt[FIFO_DEPTH]) : rd_pt[FIFO_DEPTH];
    //assign wr_sin_nxt = wr_flag == 0 ? wr_pt[FIFO_DEPTH] : (wr_addr + 1 > PT_ADDR_MAX) ? ~(wr_pt[FIFO_DEPTH]) : wr_pt[FIFO_DEPTH];
    //assign wr_full = wr_full1 || wr_full2;
    //assign read_empty = ;
    //assign rd_out = rd_flag ? next_data : 0;

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            rd_en1 <= 0;
        end
        else begin
            rd_en1 <= rd_en;
        end
    end


    always @(*) begin
        if (!rst) begin
            wr_full     = 0;
            read_empty  = 1;
        end
        else begin
            if (rd_addr != wr_addr) begin //if (rd_addr_nxt != wr_addr_nxt) begin //
                wr_full     = 0;
                read_empty  = 0;
            end
            else begin
                if (rd_pt[FIFO_DEPTH] == wr_pt[FIFO_DEPTH]) begin //if (rd_sin_nxt == wr_sin_nxt) begin//empty underflow
                    wr_full     = 0;
                    read_empty  = 1;
                end
                else begin //overflow must read first
                    wr_full     = 1;  
                    read_empty  = 0;                
                end
            end
        end
    end
    
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            rd_pt       <= 0;
            wr_pt       <= 0;
        end
        else begin
            if (rd_flag) begin
                //if (rd_stop_pulse) begin
                //    rd_pt <= rd_pt - 1;
                //end
                //else begin
                    if (rd_pt < PT_MAX) begin
                        rd_pt <= rd_pt + 1;
                    end
                    else begin
                        rd_pt <= 0;
                    end
                //end
            end
            else begin
                if (rd_stop_pulse) begin
                    rd_pt <= rd_pt - 1;
                end
                else
                    rd_pt <= rd_pt;
            end

            if (wr_flag) begin
                if (wr_pt < PT_MAX) begin
                    wr_pt <= wr_pt + 1;
                end
                else begin
                    wr_pt <= 0;
                end
            end
            else begin
                wr_pt <= wr_pt;
            end
        end
    end
    
mem mem (
    .clka(clk),
    .ena(wr_flag),

    .wea(wr_flag),
    .addra(wr_addr),
    .dina(wr_din),
    //.douta(),
    
    .clkb(clk),
    .enb(rd_flag),
    .addrb(rd_addr),
    .doutb(rd_out)
    );
endmodule
