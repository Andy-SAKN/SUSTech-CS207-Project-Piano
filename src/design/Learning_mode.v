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


module Learning_mode(
input clk,rst,
input [2:0] user,
input [7:0] touch,
input [2:0] choice,
input [23:0] anJian,
output reg[4:0] music,
output reg enable = 0,
output reg[1:0] SAB,
output reg[9:0] score,
output [1:0] length_led
    );
    `include "constants.v"
    reg[7:0] anJianDuiYing = 0;
    wire clk_bps;
    wire [13:0] tiaoPin = 14'd6000;
    counter counterForAutoPlay(clk,rst,tiaoPin,clk_bps);
    reg [7:0] last_touch = 0;
    integer index = 0;
    integer length = 0; 
    reg[500:0] beat;
    integer time_per = 0;
    integer time_per_count = 0;
   reg[500:0] song = 0;
    reg[2:0] last_choice = 0;
    reg[2:0] last_user = 0;
    reg[9:0] last_score = 0;
      integer k = 0;
      integer difference = 0;
      integer performTime = 0;
      integer performTime_count = 0;
      integer check = 0;
      integer lastCheck = 0;
      integer flag = 0;
      integer once = 0;
      integer moShi = 0;
      reg [4:0] check_song = 5'b11111;
  
    assign length_led = time_per;
    
    always @(index,song,anJian,beat,clk_bps,rst)begin
 case(song[(index) * 5 +4 -:5])
         5'd0: k = 7;
         5'd1: k = 0;
         5'd2: k = 1;
         5'd3: k = 2;
         5'd4: k = 3;
         5'd5: k = 4;
         5'd6: k = 5;
         5'd7: k = 6;
         
         5'd8: k = 0;
         5'd9: k = 1;
         5'd10: k = 2;
         5'd11: k = 3;
         5'd12: k = 4;
         5'd13: k = 5;
         5'd14: k = 6;
         
         5'd15: k = 0;
         5'd16: k = 1;
         5'd17: k = 2;
         5'd18: k = 3;
         5'd19: k = 4;
         5'd20: k = 5;
         5'd21: k = 6;
                
                default : k = 8;
            endcase
check_song = song[(index) * 5 +4 -:5];
anJianDuiYing = 128 >> (anJian[k * 3 +2 -: 3]);

      case(beat[(index) * 2 + 1 -: 2])
   2'b00 : time_per = 2;
   2'b01 : time_per = 3;
   2'b10 : time_per = 4;
   2'b11 : time_per = 5;
  
   default : time_per = 2;
  endcase
    end

always @(check,rst)begin
    if(~rst)
    enable = 0;
    else if(check==1)
    enable = 1;
    else
    enable = 0;
end

always @(posedge clk,negedge rst) begin
   
    if(~rst) begin
    lastCheck <= 0;
    moShi <= 0;
    end
     else begin
     if(check!=lastCheck) begin
      
        if(check==1&&lastCheck==2) begin
        moShi <= 1;
        flag <= 1111;
        end
        else if(check==2&&lastCheck==1) begin
        moShi <= 2;
        flag <= 2222;
        end
        else begin
        moShi <= moShi;
        flag <= 0000;
        end
        lastCheck <= check;
     end
     else begin
      moShi <= moShi;
      lastCheck <= check;
     end
    end
    
end
     
     always @(touch,choice,user,last_choice,last_user,rst)begin
           if(~rst) begin
         SAB = 0;
         check = 0;
         
      end
      else begin 
      if(choice != last_choice||last_user!=user) begin      
               SAB = 0;             
               check = 0;
              
       end
       else begin
        if(difference<=3)
            SAB = 4-difference;
            else
            SAB = 0;

             if(touch==anJianDuiYing) begin
             check = 1;
            
             end
             else if(touch==0) begin
             check = 2;
            
             end
             else begin
             check = 0;
            
             end
       end
           
      end
     end
     

     
     
     
     
      
     
     
     always @ (posedge clk,negedge rst)begin
  if(~rst) begin
    once <= 1;
score <= 0;
 last_score <= 0;
  last_choice <= 0;
  last_user <= 0;
  song <= 0;
  beat <= 0;
  
       music <= 5'b00000;
       time_per_count <= 0;
       index <= 0;
       difference <= 0;
      performTime_count <= 0;
      performTime <= 0;
  end
       else
      begin
       if(choice != last_choice||last_user!=user) begin
               once <= 1;
              score <= 0;
              last_score <= 0;          
              last_choice <= choice;
              last_user <= user;
              index <= 0;
              time_per_count <= 0;
              music <= 0;
              difference <= 0;
              performTime_count <= 0;
              performTime <= 0;
       end
       else begin
       
        if(time_per-performTime>=0) begin
            difference <= time_per-performTime;
        end
        else begin
            difference <= performTime - time_per;
        end
       
        
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
       ;
//1
 if(moShi==1) begin
    once <= 1;
            performTime_count <= 0;
        end
        else begin
            performTime_count <= performTime_count + 1;
        end

        if(time_per_count<time_per)
        begin
            time_per_count <= time_per_count+1;
        end
        else
        begin
     //2
        if(moShi==2&&once)   
        begin 
             score <= last_score + SAB;  
             last_score <= score;      
    if(index == length-1) 
       begin
       index <= 0;
       time_per_count <= 0;
       performTime <= performTime_count;
       end
    else begin
   index <= index + 1;
   time_per_count <= 0;
        end
        once <= 0;
        end
        else begin
        end
       
        end
        
        
 
  
  music <= 5'b0|song[(index) * 5 +4 -:5];
  
      
  end
  else begin

  end
 
  end
      end
     end
endmodule
