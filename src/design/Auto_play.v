`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/06 21:11:30
// Design Name: 
// Module Name: Auto_play
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


module Auto_play(
input clk,
input rst,
input [2:0] choice,
output  [4:0] music_auto 

    );
    `include "constants.v"
    reg[4:0] music = 0;
    wire clk_bps;
    wire [13:0] tiaoPin = 14'd5000;
    assign music_auto = music;
    counter counterForAutoPlay(clk,rst,tiaoPin,clk_bps);
    
    integer index = 0;
    integer length = 0; 
    reg[500:0] beat;
    integer time_per = 0;
    integer time_per_count = 0;
   reg[1000:0] song = 0;
    reg[2:0] last_choice = 0;
    always @(index,rst)begin

      case(beat[(index) * 2 + 1 -: 2])
   2'b00 : time_per = 2;
   2'b01 : time_per = 3;
   2'b10 : time_per = 4;
   2'b11 : time_per = 5;
  
   default : time_per = 2;
  endcase
    end
     always @ (posedge clk,negedge rst)begin
  if(~rst)
       music <= 5'b00000;
       else
      begin
       if(choice != last_choice) begin
               last_choice <= choice;
              index <= 0;
              time_per_count <= 0;
              music <= 0;
       end
       else begin
        
       
        
        case(choice)
                   3'b001: beat <= LittleStar_beat;
                   3'b010: beat <= ChunXiaQiuDong_beat;
                   3'b100: beat <= JLJT_beat;
                   default : beat <= 0;
              
                endcase
       
        case(choice)
                   3'b001: length <= LittleStar_length;
                   3'b010: length <= ChunXiaQiuDong_Length;
                   3'b100: length <= JLJT_length;
                   default : length <= 0;
               endcase
        
         case(choice)
                   3'b001: song <=LittleStar;
                   3'b010: song <= ChunXiaQiuDong;
                   3'b100: song <= JLJT;
                   default : song <= 0;
               endcase
      
   
   
    if(clk_bps) begin
 
        if(time_per_count<time_per)
        begin
            time_per_count <= time_per_count+1;
        end
        else
        begin
            
    if(index == length-1) 
       begin
       index <= 0;
       time_per_count <= 0;
       end
    else begin
    $display("Song: %b", song);
   index <= index + 1;
   time_per_count <= 0;
        end
        end
       
 
 if(time_per_count==time_per)
       music <= 5'd0;
       else
       begin
  music <= 5'b0|song[(index) * 5 +4 -:5];
       end
  end
  else begin

  end
  end
      end
     end
endmodule
