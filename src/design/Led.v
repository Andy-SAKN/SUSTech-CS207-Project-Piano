`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/06 20:29:37
// Design Name: 
// Module Name: Led
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


module Led(
input reset,enable,
input [1:0] length,
input [1:0] mode,
input [7:0] touch,
input [4:0] music,
input  [23:0] anJian,
output reg[7:0] led,
output reg [3:0]length_led
    );
    integer i = 0;
    integer k = 8;
   
    
    always @* begin
     if(!reset)
     begin
        led = 8'b00000000;
        i = 0;
        k = 8;
        length_led = 0;
        
     end
     else
     begin
        if(mode==2'b10) begin
        case(length)
          2'd0: length_led = 4'b1000;
          2'd1: length_led = 4'b1100;
          2'd2: length_led = 4'b1110;
          2'd3: length_led = 4'b1111;           
        default : length_led = 0;
            endcase
        end
        else begin
        length_led = 0;
        end
        //切换按键，已经确认过的按键上面亮起灯，表示不能再选择
        if(mode==2'b11)
        begin
    led = touch;
        end
        //其它模式，根据音符决定亮哪个灯
        else if(mode==2'b00||mode==2'b01||mode==2'b10)
        begin
        case(music)
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
                       
                       default : k = 7;
            endcase
            if(k!=7)
    led = 8'b0 | (128 >> (anJian[k * 3 +2 -: 3]));
    else 
    led = 8'b0;
    
        end
        else
        led = 8'b00000000;
     end
end
endmodule
