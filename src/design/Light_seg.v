`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/06 20:30:03
// Design Name: 
// Module Name: Light_seg
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


module Lightseg(
    input clk, reset,
    input [2:0] user, // Input: User, displayed on the leftmost digit
    input [2:0] order, // Input: Song number, displayed on the second leftmost digit
    input [1:0] mode, // Input: Mode, displayed on the rightmost digit
    input [1:0] timedifference, // Input: Current pressed time difference, displayed on the third leftmost digit (CBAS), single note score
    input [2:0] rank, // Input: Ranking
    output tub_sel1, // Output: Control the visibility of the leftmost four digits
    output tub_sel2, // Output: Control the visibility of the second leftmost four digits
    output tub_sel3, // Output: Control the visibility of the third leftmost four digits
    output tub_sel4, // Output: Control the visibility of the fourth leftmost four digits
    output tub_sel5, // Output: Control the visibility of the rightmost four digits
    output tub_sel6, // Output: Control the visibility of the second rightmost four digits
    output tub_sel7, // Output: Control the visibility of the third rightmost four digits
    output tub_sel8, // Output: Control the visibility of the fourth rightmost four digits 
    output [7:0] tub_control1, // Output: Control the content displayed on the left side
    output [7:0] tub_control2 // Output: Control the content displayed on the right side
    );
    
    reg[7:0] seg_out_reg1; // Control the content displayed on the leftmost four digits
    reg[7:0] seg_out_reg2; // Control the content displayed on the rightmost four digits
    reg[7:0] seg_en_reg; // Control the visibility of the four digits
    reg[2:0] scan_count; // Counter to control digit scanning
    wire clk_out;
    wire [13:0] tiaoPin = 14'd30;
    divider newclk(clk, reset, tiaoPin, clk_out);

    always @(posedge clk_out or posedge reset) begin
        if (reset) begin
            scan_count <= 3'b000;
        end
        else begin
            if(scan_count == 3'b111)
                scan_count <= 3'b000;
            else
                scan_count <= scan_count + 1;
        end

        if (reset) begin
            seg_en_reg <= 8'b00000000;
        end
        else begin
            case (mode)
                2'b00: begin // Free mode
                    seg_en_reg <= 8'b00000001;
                    {seg_out_reg1, seg_out_reg2} <= 8'b10001110; // Display F in free mode
                end
                2'b01: begin // Auto-play mode
                    seg_en_reg <= 8'b01000001;
                    seg_out_reg2 <= 8'b11101110; // Display A in auto-play mode
                    case (order)
                        0: seg_out_reg1 <= 8'b11111100; // Digit 0 encoding
                        1: seg_out_reg1 <= 8'b01100000; // Digit 1 encoding
                        2: seg_out_reg1 <= 8'b11011010; // Digit 2 encoding
                        3: seg_out_reg1 <= 8'b11110010; // Digit 3 encoding
                        4: seg_out_reg1 <= 8'b01100110; // Digit 4 encoding
                        5: seg_out_reg1 <= 8'b10110110; // Digit 5 encoding
                        6: seg_out_reg1 <= 8'b10111110; // Digit 6 encoding
                        7: seg_out_reg1 <= 8'b11100000; // Digit 7 encoding
                        default: seg_out_reg1 <= 8'b00000000;
                    endcase
                end
                2'b10: begin // Learning mode
                    case (scan_count)
                        3'b111: begin
                            seg_en_reg <= 8'b1000_0000;
                            case (user)
                                0: seg_out_reg1 <= 8'b11111100; // Digit 0 encoding
                                1: seg_out_reg1 <= 8'b01100000; // Digit 1 encoding
                                2: seg_out_reg1 <= 8'b11011010; // Digit 2 encoding
                                3: seg_out_reg1 <= 8'b11110010; // Digit 3 encoding
                                4: seg_out_reg1 <= 8'b01100110; // Digit 4 encoding
                                5: seg_out_reg1 <= 8'b10110110; // Digit 5 encoding
                                6: seg_out_reg1 <= 8'b10111110; // Digit 6 encoding
                                7: seg_out_reg1 <= 8'b11100000; // Digit 7 encoding
                                default: seg_out_reg1 <= 8'b00000000;
                            endcase
                        end 
                        3'b110: begin
                            seg_en_reg <= 8'b0100_0000;
                            case (order)
                                0: seg_out_reg1 <= 8'b11111100; // Digit 0 encoding
                                1: seg_out_reg1 <= 8'b01100000; // Digit 1 encoding
                                2: seg_out_reg1 <= 8'b11011010; // Digit 2 encoding
                                3: seg_out_reg1 <= 8'b11110010; // Digit 3 encoding
                                4: seg_out_reg1 <= 8'b01100110; // Digit 4 encoding
                                5: seg_out_reg1 <= 8'b10110110; // Digit 5 encoding
                                6: seg_out_reg1 <= 8'b10111110; // Digit 6 encoding
                                7: seg_out_reg1 <= 8'b11100000; // Digit 7 encoding
                                default: seg_out_reg1 <= 8'b00000000;
                            endcase
                        end
                        3'b101: begin
                            seg_en_reg <= 8'b0010_0000;
                            case (timedifference)
                                2'b01: seg_out_reg1 <= 8'b1111_1110; // B
                                2'b10: seg_out_reg1 <= 8'b1110_1110; // A
                                2'b11: seg_out_reg1 <= 8'b1011_0110; // S
                                default: seg_out_reg1 <= 8'b1001_1100; // C
                            endcase
                        end
                        3'b100: begin
                            seg_en_reg <= 8'b0001_0000;
                            case (rank)
                                0: seg_out_reg1 <= 8'b11111100; // Digit 0 encoding
                                1: seg_out_reg1 <= 8'b01100000; // Digit 1 encoding
                                2: seg_out_reg1 <= 8'b11011010; // Digit 2 encoding
                                3: seg_out_reg1 <= 8'b11110010; // Digit 3 encoding
                                4: seg_out_reg1 <= 8'b01100110; // Digit 4 encoding
                                5: seg_out_reg1 <= 8'b10110110; // Digit 5 encoding
                                6: seg_out_reg1 <= 8'b10111110; // Digit 6 encoding
                                7: seg_out_reg1 <= 8'b11100000; // Digit 7 encoding
                                default: seg_out_reg1 <= 8'b00000000;
                            endcase
                        end
                        3'b011: begin
                            seg_en_reg <= 8'b0000_0000; // Do not display
                        end
                        3'b010: begin
                            seg_en_reg <= 8'b0000_0000; // Do not display
                        end
                        3'b001: begin
                            seg_en_reg <= 8'b0000_0000; // Do not display
                        end
                        3'b000 : begin
                            seg_en_reg <= 8'b0000_0001;
                            seg_out_reg2 <= 8'b0001_1100; // L
                        end 
                        default: seg_en_reg <= 8'b0000_0000;
                    endcase
                end
                default: begin // Key adjustment mode
                    seg_en_reg <= 8'b00000001; // Rightmost digit is on
                    seg_out_reg1 <= 8'b10011100; // Display letter 'c' for change mode
                    seg_out_reg2 <= 8'b10011100; // c
                end
            endcase
        end
    end

    assign {tub_sel1, tub_sel2, tub_sel3, tub_sel4, tub_sel5, tub_sel6, tub_sel7, tub_sel8} = seg_en_reg;
    assign tub_control1 = seg_out_reg1;
    assign tub_control2 = seg_out_reg2;

endmodule
