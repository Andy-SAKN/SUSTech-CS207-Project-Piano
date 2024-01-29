`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/21 22:27:40
// Design Name: 
// Module Name: xiaoDou
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


module xiaoDou2(
input clk,rst,wrong,
output right
    );
    //Change accuracy rate through tiaoPin
    wire Q1,nQ1;
    wire clk_bps;
   
     wire [13:0] tiaoPin = 14'd4000;
    counter counter_xiaoDou1(clk,rst,tiaoPin,clk_bps);
     dff dff_inst1 (
         .clk(clk_bps),
         .D(wrong),
         .Q(Q1),
         .nQ(nQ1)
     );
     assign right = Q1;
     
   
     
endmodule
