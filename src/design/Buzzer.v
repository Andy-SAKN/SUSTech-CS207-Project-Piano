`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/06 20:12:26
// Design Name: 
// Module Name: Buzzer
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


module Buzzer (
  input  clk,reset, 
  input  [4:0] music_free,
  input   [4:0] music_auto,
  input  [4:0] music_learn,
  input   [4:0] music_change,// Clock signal
  input  [1:0] mode, // Note (Input 1 outputs a signal for 'do, 2 for 're, 3 for 'mi, 4, and so on)
  output wire speaker,
  output [4:0] music
);
`include "constants.v"
  wire [31:0] notes [21:0];
  reg [31:0] counter = 0;
  reg pwm = 0;
  reg [4:0] last ;
  reg [4:0] note;
  assign music = note;
  
  // Frequencies of do, re, mi, fa, so, la, si
  // Obtain the ratio of how long the buzzer should be active in one second
  assign notes[0] = silence;
  assign notes[1] = do_low;
  assign notes[2] = re_low;
  assign notes[3] = me_low;
  assign notes[4] = fa_low;
  assign notes[5] = so_low;
  assign notes[6] = la_low;
  assign notes[7] = si_low;
  
  assign notes[8] = do_mid;
  assign notes[9] = re_mid;
  assign notes[10] = me_mid;
  assign notes[11] = fa_mid;
  assign notes[12] = so_mid;
  assign notes[13] = la_mid;
  assign notes[14] = si_mid;
  
  assign notes[15] = do_high;
  assign notes[16] = re_high;
  assign notes[17] = me_high;
  assign notes[18] = fa_high;
  assign notes[19] = so_high;
  assign notes[20] = la_high;
  assign notes[21] = si_high;

always @(music_free, music_auto,music_learn,music_change,mode,reset) begin
  case(mode)
  2'b00: note = music_free;
  2'b01: note = music_auto;
  2'b10: note = music_learn;
  2'b11: note = music_change;
  default:note = 0;
  endcase
end

  always @(posedge clk, negedge reset) begin
    if(!reset)begin
        pwm <= 0;
        last <= 0;
        counter <= 0;
    end
    else begin
  if(last!=note)begin
  last<=note;
  counter<=0;
  pwm<=0;
  end
  else begin
    if (counter < notes[note]) begin
      counter <= counter + 1'b1;
    end else begin
      pwm <= ~pwm;
      counter <= 0;
    end
    end
    end
  end



  assign speaker = pwm; // Output a PWM signal to the buzzer

endmodule
