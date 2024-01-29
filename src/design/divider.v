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

module divider (
  input clk,
  input rst_n,
  input [13:0] tiaoPin,
  output  clk_out
);

  reg [13:0] counter;
  reg clk_out_1;
  always @(posedge clk or negedge rst_n) begin
    if (rst_n) begin
      counter <= 14'd0;
      clk_out_1 <= 1'b0;
    end
     else begin
      if (counter == tiaoPin) begin
        counter <= 14'd0;
        clk_out_1 <= ~clk_out_1;
      end    
      if (counter == 14'd0) begin
            counter <= 14'd1;
            clk_out_1 <= 1'b1;
          end    
      else begin
        counter <= counter + 1;
      end
    end
  end
 
assign clk_out=clk_out_1;
endmodule