`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/28 14:54:09
// Design Name: 
// Module Name: b_m_d_f
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


module dff(
input clk,D,
output reg Q,
output nQ
    );
    always @(posedge clk)
    Q<=D;
    assign nQ=~Q;
endmodule
