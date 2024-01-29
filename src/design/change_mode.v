`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/07 13:12:02
// Design Name: 
// Module Name: Change_mode
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


module Change_mode(
input reset,
input [2:0] note,
input [7:0] touch,
input [1:0] mode,
output reg [23:0] anJian = 24'b111_110_101_100_011_010_001_000,
output  reg[4:0] music
    );
     `include "constants.v"
     always @* begin
        if(!reset||mode!=2'b11) begin
            music <= 0; 
        end
        else
        begin
        
        case (touch)
               8'b10000000: anJian[note * 3 + 2 -: 3] <= 3'd0;
               8'b01000000: anJian[note * 3 + 2 -: 3] <= 3'd1;
               8'b00100000: anJian[note * 3 + 2 -: 3] <= 3'd2;
               8'b00010000: anJian[note * 3 + 2 -: 3] <= 3'd3;
               8'b00001000: anJian[note * 3 + 2 -: 3] <= 3'd4;
               8'b00000100: anJian[note * 3 + 2 -: 3] <= 3'd5;
               8'b00000010: anJian[note * 3 + 2 -: 3] <= 3'd6;
               8'b00000001: anJian[note * 3 + 2 -: 3] <= 3'd7;
               default : anJian[note * 3 + 2 -: 3] <= 3'd0;
             endcase
         
         
         
        case (note)
               0: music <= 5'd8;
               1: music <= 5'd9;
               2: music <= 5'd10;
               3: music <= 5'd11;
               4: music <= 5'd12;
               5: music <= 5'd13;
               6: music <= 5'd14;
               7: music <= 5'd0;

               default : music <= 5'd0;
             endcase
         
        end
        
    end             
endmodule
