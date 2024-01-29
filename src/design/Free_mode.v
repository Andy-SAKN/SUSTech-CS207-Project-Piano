`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/06 20:30:24
// Design Name: 
// Module Name: Music
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

module Free_mode(
    input rst, // Reset signal to initialize the mode
    input wire[1:0] baDu, // Control the octave, 00 for bass, 01 for mid, 11 for high
    input wire[7:0] touch, // Pressed keys, from left to right representing do-si, and the rightmost represents mute, legal input is required
    input wire [23:0] anJian, // Each three bits represent the position of the corresponding note's key. For example, "010" in the first three bits represents do, "111" in the 4th to 6th bits represents re, from left to right, from do to si, and the rightmost is mute.
    output reg[4:0] music // Output binary representation of the played note
);

`include "constants.v"

reg [7:0] anJianDuiYing [7:0]; // Array to map the keys to their corresponding locations
integer i = 0;

always @* begin
    if (~rst)
        music <= 5'b00000;
    else begin
        // Map the keys to their corresponding locations
        for (i = 0; i < 8; i = i + 1)
            anJianDuiYing[i] <= (128 >> (anJian[i * 3 + 2 -: 3]));

        // Determine the played note based on the octave and pressed keys
        case ({baDu, touch})
            {2'b00, anJianDuiYing[0]}: music <= 5'd1;
            {2'b00, anJianDuiYing[1]}: music <= 5'd2;
            {2'b00, anJianDuiYing[2]}: music <= 5'd3;
            {2'b00, anJianDuiYing[3]}: music <= 5'd4;
            {2'b00, anJianDuiYing[4]}: music <= 5'd5;
            {2'b00, anJianDuiYing[5]}: music <= 5'd6;
            {2'b00, anJianDuiYing[6]}: music <= 5'd7;
            {2'b00, anJianDuiYing[7]}: music <= 5'd0;

            {2'b01, anJianDuiYing[0]}: music <= 5'd8;
            {2'b01, anJianDuiYing[1]}: music <= 5'd9;
            {2'b01, anJianDuiYing[2]}: music <= 5'd10;
            {2'b01, anJianDuiYing[3]}: music <= 5'd11;
            {2'b01, anJianDuiYing[4]}: music <= 5'd12;
            {2'b01, anJianDuiYing[5]}: music <= 5'd13;
            {2'b01, anJianDuiYing[6]}: music <= 5'd14;
            {2'b01, anJianDuiYing[7]}: music <= 5'd0;

            {2'b11, anJianDuiYing[0]}: music <= 5'd15;
            {2'b11, anJianDuiYing[1]}: music <= 5'd16;
            {2'b11, anJianDuiYing[2]}: music <= 5'd17;
            {2'b11, anJianDuiYing[3]}: music <= 5'd18;
            {2'b11, anJianDuiYing[4]}: music <= 5'd19;
            {2'b11, anJianDuiYing[5]}: music <= 5'd20;
            {2'b11, anJianDuiYing[6]}: music <= 5'd21;
            {2'b11, anJianDuiYing[7]}: music <= 5'd0;

            default: music <= 5'b00000;
        endcase
    end
end

endmodule
