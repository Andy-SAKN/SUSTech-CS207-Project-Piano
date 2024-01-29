`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/05 17:04:09
// Design Name: 
// Module Name: counter
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
module counter(
input clk,
input rst_n,
input [13:0] tiaoPin,
output clk_bps
    );
    reg [13:0] cnt_first,cnt_second;
    always@(posedge clk,negedge rst_n)begin
    if(!rst_n)
    cnt_first <= 14'd0;
    else if(cnt_first == tiaoPin)
    cnt_first <= 14'd0;
    else
    cnt_first <= cnt_first + 1'b1;
    end
    always@(posedge clk,negedge rst_n)begin
    if(!rst_n)
    cnt_second <= 14'd0;
    else if(cnt_second == tiaoPin)
    cnt_second <= 14'd0;
    else if (cnt_first == tiaoPin)
    cnt_second <= cnt_second + 1'b1;
    else
    cnt_second <= cnt_second;
    end
    assign clk_bps = cnt_second == tiaoPin;
endmodule
