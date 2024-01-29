`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/06 20:30:46
// Design Name: 
// Module Name: Main
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


module Main(
    input clk,reset,//_y means before xiaoDou
    input [2:0] user_y,
    input [2:0] choice_y,
    input [1:0] mode_y,
    input [7:0] touch_y,
    input [1:0] baDu_y,
    output tub_sel1,
    output tub_sel2,
    output tub_sel3,
    output tub_sel4,
    output tub_sel5,
    output tub_sel6,
    output tub_sel7,
    output tub_sel8,
    output [7:0] tub_control1,
    output [7:0] tub_control2,
    output  [7:0] led,
    output  [3:0]length_led,
    output t,
    output speaker
    );
     `include "constants.v"
       wire rst;
       wire [1:0] SAB;
       reg [79:0] LittleStar_s = 0;
       reg [79:0] JiLeJingTu_s = 0;
       reg [79:0] ChunXiaQiuDong_s = 0;
    wire [2:0] user;
    wire [1:0] baDu;
    wire [2:0] choice;
    wire [1:0] mode;
    wire [7:0] touch;
    wire [23:0] anJian;
    wire [4:0] music_free;
    wire [4:0] music_auto;
    wire [4:0] music_learn;
    wire [4:0] music_change;
    wire [1:0] length;
    wire [4:0] music;
    wire enable;
    wire [2:0] rank;
     wire [9:0] highestScore;
     wire [9:0] score;
     wire ligh_rst;
     assign ligh_rst = ~reset;
     assign t = 0;
     assign rst = reset;
     xiaoDou2 baDu_0 (
    .clk(clk),
    .rst(rst),
    .wrong(baDu_y[0]),
    .right(baDu[0])
  );

  xiaoDou2 baDu_1 (
    .clk(clk),
    .rst(rst),
    .wrong(baDu_y[1]),
    .right(baDu[1])
  );
  xiaoDou2 touch_0 (
      .clk(clk),
      .rst(rst),
      .wrong(touch_y[0]),
      .right(touch[0])
    );

xiaoDou2 touch_1 (
      .clk(clk),
      .rst(rst),
      .wrong(touch_y[1]),
      .right(touch[1])
    );
    xiaoDou2 touch_2 (
      .clk(clk),
      .rst(rst),
      .wrong(touch_y[2]),
      .right(touch[2])
    );
    xiaoDou2 touch_3 (
      .clk(clk),
      .rst(rst),
      .wrong(touch_y[3]),
      .right(touch[3])
    );
    xiaoDou2 touch_4 (
      .clk(clk),
      .rst(rst),
      .wrong(touch_y[4]),
      .right(touch[4])
    );
    xiaoDou2 touch_5 (
      .clk(clk),
      .rst(rst),
      .wrong(touch_y[5]),
      .right(touch[5])
    );
    xiaoDou2 touch_6 (
      .clk(clk),
      .rst(rst),
      .wrong(touch_y[6]),
      .right(touch[6])
    );
    xiaoDou2 touch_07(
      .clk(clk),
      .rst(rst),
      .wrong(touch_y[7]),
      .right(touch[7])
    );

    xiaoDou2 choice_0 (
      .clk(clk),
      .rst(rst),
      .wrong(choice_y[0]),
      .right(choice[0])
    );
     xiaoDou2 choice_1 (
      .clk(clk),
      .rst(rst),
      .wrong(choice_y[1]),
      .right(choice[1])
    );
     xiaoDou2 choice_2 (
      .clk(clk),
      .rst(rst),
      .wrong(choice_y[2]),
      .right(choice[2])
    );

 xiaoDou2 user_0 (
      .clk(clk),
      .rst(rst),
      .wrong(user_y[0]),
      .right(user[0])
    );

    xiaoDou2 user_1(
      .clk(clk),
      .rst(rst),
      .wrong(user_y[1]),
      .right(user[1])
    );

    xiaoDou2 user_2 (
      .clk(clk),
      .rst(rst),
      .wrong(user_y[2]),
      .right(user[2])
    );

    xiaoDou2 mode_0 (
      .clk(clk),
      .rst(rst),
      .wrong(mode_y[0]),
      .right(mode[0])
    );

    xiaoDou2 mode_1 (
      .clk(clk),
      .rst(rst),
      .wrong(mode_y[1]),
      .right(mode[1])
    );
     Led Led_u(
         .enable(enable),
         .reset(reset),
         .length(length),
         .mode(mode),
         .touch(touch),
         .music(music),
         .anJian(anJian),
         .led(led),
         .length_led(length_led)
       );
   
   Buzzer Buzzer_u(
           .clk(clk),
           .reset(reset),
           .music_free(music_free),
           .music_auto(music_auto),
           .music_learn(music_learn),
           .music_change(music_change),
           .mode(mode),
           .speaker(speaker),
           .music(music)
         );
         
         Free_mode Free_mode_u(
             .rst(reset),
             .baDu(baDu),
             .touch(touch),
             .anJian(anJian),
             .music(music_free)
           );
           
           Auto_play A_ (
               .clk(clk),
               .rst(reset),
               .choice(choice),
               .music_auto(music_auto)
             );
             
            Learning_mode inst_learning_mode (
                     .clk(clk),
                     .rst(rst),
                     .user(user),
                     .touch(touch),
                     .choice(choice),
                     .anJian(anJian),
                     .music(music_learn),
                     .enable(enable),
                     .SAB(SAB),
                     .score(score),
                     .length_led(length)
                 );
               
               Change_mode inst_change_mode (
                        .reset(reset),
                        .note(user),
                        .touch(touch),
                        .mode(mode),
                        .anJian(anJian),
                        .music(music_change)
                    );
                 
                 rank rang_u (
                     .user(user),
                     .choice(choice),
                     .LittleStar(LittleStar_s),
                     .JiLeJingTu(JiLeJingTu_s),
                     .ChunXiaQiuDong(ChunXiaQiuDong_s),
                     .rank(rank),
                     .highestScore(highestScore)
                   );
                   
                  Lightseg inst_lightseg (
                           .clk(clk),
                           .reset(ligh_rst),
                           .user(user),
                           .order(choice),
                           .mode(mode),
                           .timedifference(SAB),
                           .rank(rank),
                           .tub_sel1(tub_sel1),
                           .tub_sel2(tub_sel2),
                           .tub_sel3(tub_sel3),
                           .tub_sel4(tub_sel4),
                           .tub_sel5(tub_sel5),
                           .tub_sel6(tub_sel6),
                           .tub_sel7(tub_sel7),
                           .tub_sel8(tub_sel8),
                           .tub_control1(tub_control1),
                           .tub_control2(tub_control2)
                       );


always @(rst,user,score,choice) begin
if(!rst) begin
  LittleStar_s <= 0;
     JiLeJingTu_s <= 0;
      ChunXiaQiuDong_s <= 0;
end
else begin
if(choice==3'b001) begin
 if(score>LittleStar_s[user * 10+9 -:10])
        LittleStar_s[user * 10+9 -:10] = score;
end
else if(choice==3'b010) begin
  if(score>ChunXiaQiuDong_s[user * 10+9 -:10])
         ChunXiaQiuDong_s[user * 10+9 -:10] = score;
end
else if(choice==3'b100) begin
  if(score>JiLeJingTu_s[user * 10+9 -:10])
          JiLeJingTu_s[user * 10+9 -:10] = score;
end
end
end

endmodule
