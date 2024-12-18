module board
    (
        input   wire            clk             ,   // clock
        input   wire            rstn            ,   // reset

        input   wire            player_move     ,   // player move
        input   wire            computer_move   ,   // computer move
        input   wire    [3:0]   player_address  ,   // player address
        input   wire    [3:0]   computer_address,   // computer address

        output  wire    [1:0]   led_0           ,   // output led_0
        output  wire    [1:0]   led_1           ,   // output led_1
        output  wire    [1:0]   led_2           ,   // output led_2
        output  wire    [1:0]   led_3           ,   // output led_3
        output  wire    [1:0]   led_4           ,   // output led_4
        output  wire    [1:0]   led_5           ,   // output led_5
        output  wire    [1:0]   led_6           ,   // output led_6
        output  wire    [1:0]   led_7           ,   // output led_7
        output  wire    [1:0]   led_8           ,   // output led_8

        output  reg             illegal_move    ,   // output illegal_move signal
        output  reg             tie             ,   // output tie signal   (平局)
        output  reg             win             ,   // output win signal
        output  reg     [1:0]   winner              // output winner , PLAYER or COMPUTER
    );

    parameter EMPTY     = 2'b00;
    parameter PLAYER    = 2'b01;
    parameter COMPUTER  = 2'b10;
    parameter TEST      = 2'b11;

    // 棋盘数据
    reg     [1:0] board [8:0];

    // 是否有子信号
    reg     [8:0] piece;

    // 棋盘数据输出
    assign led_0 = board[0];
    assign led_1 = board[1];
    assign led_2 = board[2];
    assign led_3 = board[3];
    assign led_4 = board[4];
    assign led_5 = board[5];
    assign led_6 = board[6];
    assign led_7 = board[7];
    assign led_8 = board[8];


    always @( *)
    begin
        piece[0] = |board[0];
        piece[1] = |board[1];
        piece[2] = |board[2];
        piece[3] = |board[3];
        piece[4] = |board[4];
        piece[5] = |board[5];
        piece[6] = |board[6];
        piece[7] = |board[7];
        piece[8] = |board[8];
    end




    // 棋盘输入与非法落子检测
    always @(posedge clk or negedge rstn)
    begin
        // 棋盘初始化，默认EMPTY
        if (rstn == 1'b0)
        begin
            board[0] <= EMPTY;
            board[1] <= EMPTY;
            board[2] <= EMPTY;
            board[3] <= EMPTY;
            board[4] <= EMPTY;
            board[5] <= EMPTY;
            board[6] <= EMPTY;
            board[7] <= EMPTY;
            board[8] <= EMPTY;
            illegal_move <= 1'b0;
        end
        else
        begin
            // 玩家下棋
            if (player_move)
            begin
                // 棋盘已有子
                if (piece[player_address] == 1'b1)
                begin
                    illegal_move <= 1'b1;
                end
                else
                begin
                    // 棋盘数据输入
                    board[player_address] = PLAYER;
                    illegal_move <= 1'b0;
                end
            end
            // 电脑下棋
            else if (computer_move)
            begin
                // 棋盘已有子
                if (piece[computer_address] == 1'b1)
                begin
                    illegal_move <= 1'b1;
                end
                else
                begin
                    // 棋盘数据输入
                    board[computer_address] = COMPUTER;
                    illegal_move <= 1'b0;
                end
            end
            else
            begin
                illegal_move <= 1'b0;
            end
        end
    end


    // 判断胜利与胜者
    always @(posedge clk or negedge rstn)
    begin
        if (rstn == 1'b0)
        begin
            win <= 1'b0;
            winner <= 2'd0;
        end
        else if (&{board[3*0+0][0],board[3*0+1][0],board[3*0+2][0]}||       // 玩家第一行
                 &{board[3*1+0][0],board[3*1+1][0],board[3*1+2][0]}||       // 玩家第二行
                 &{board[3*2+0][0],board[3*2+1][0],board[3*2+2][0]}||       // 玩家第三行
                 &{board[3*0+0][0],board[3*1+0][0],board[3*2+0][0]}||       // 玩家第一列
                 &{board[3*0+1][0],board[3*1+1][0],board[3*2+1][0]}||       // 玩家第二列
                 &{board[3*0+2][0],board[3*1+2][0],board[3*2+2][0]}||       // 玩家第三列
                 &{board[3*0+0][0],board[3*1+1][0],board[3*2+2][0]}||       // 玩家左上到右下
                 &{board[3*2+0][0],board[3*1+1][0],board[3*0+2][0]})        // 玩家右上到左下
        begin
            win     <= 1'b1;
            winner  <= PLAYER;
        end
        else if (&{board[3*0+0][1],board[3*0+1][1],board[3*0+2][1]}||       // 电脑第一行
                 &{board[3*1+0][1],board[3*1+1][1],board[3*1+2][1]}||       // 电脑第二行
                 &{board[3*2+0][1],board[3*2+1][1],board[3*2+2][1]}||       // 电脑第三行
                 &{board[3*0+0][1],board[3*1+0][1],board[3*2+0][1]}||       // 电脑第一列
                 &{board[3*0+1][1],board[3*1+1][1],board[3*2+1][1]}||       // 电脑第二列
                 &{board[3*0+2][1],board[3*1+2][1],board[3*2+2][1]}||       // 电脑第三列
                 &{board[3*0+0][1],board[3*1+1][1],board[3*2+2][1]}||       // 电脑左上到右下
                 &{board[3*2+0][1],board[3*1+1][1],board[3*0+2][1]})        // 电脑右上到左下
        begin
            win     <= 1'b1;
            winner  <= COMPUTER;
        end
        else
        begin
            win <= 1'b0;
            winner <= 2'd0;
        end
    end

    // 判断是否平局
    always @(posedge clk or negedge rstn)
    begin
        if (rstn == 1'b0)
        begin
            tie <= 1'b0;
        end
        // piece和win都延后了棋盘数据一拍
        else if (piece == 9'b111111111 && win == 1'b0)
        begin
            tie <= 1'b1;
        end
        else
        begin
            tie <= 1'b0;
        end
    end

endmodule
