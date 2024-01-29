module rank (
    input [2:0] user,
    input [2:0] choice,
    input [79:0] LittleStar,
    input [79:0] JiLeJingTu,
    input [79:0] ChunXiaQiuDong,
    output reg [2:0] rank,
    output reg [9:0] highestScore
);
reg[79:0] currentSong = 0;
reg[9:0] currentScore = 0;
reg[9:0] temp = 0;
integer k = 0;
integer i = 0;
integer j = 0;
integer flag = 0;

always @* begin
    case(choice)
                     3'b001: currentSong = LittleStar;
                     3'b010: currentSong = JiLeJingTu;
                     3'b100: currentSong = ChunXiaQiuDong;
                     default : currentSong = 0;
                 endcase

    currentScore = currentSong[user * 10+9 -:10];
    highestScore = currentScore;
    for (i = 0; i < 7; i = i + 1) begin
        for (j = 0; j < 7 - i; j = j + 1) begin
            if (currentSong[j * 10+9 -:10] < currentSong[(j+1) * 10+9 -:10]) begin
                // Swap Scores
                temp = currentSong[j * 10+9 -:10];
                currentSong[j * 10+9 -:10] = currentSong[(j+1) * 10+9 -:10];
                currentSong[(j+1) * 10+9 -:10] = temp;
            end
        end
    end
    flag = 0;
    for(k = 0;k<8;k=k+1) begin
    if(currentScore==currentSong[k * 10+9 -:10])begin
       if(flag==0)begin
       rank = k;
       flag = 1;
       end 
       else begin
       end
    end
    else
    begin
    end
    end

end
    

endmodule
