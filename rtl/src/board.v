module board (
        input   wire            clk             ,
        input   wire            rstn            ,

        input   wire            player_move     ,   // player move
        input   wire            computer_move   ,   // computer move
        input   wire    [3:0]   player_adderss  ,   // player address
        input   wire    [3:0]   computer_adderss,   // computer address


        output  wire    [17:0]  board_data      ,   // output board_data
        output  reg             illegal_move    ,   // output illegal_move
        output  reg             win             ,   // output winsigal
        output  wire            draw            ,   // output draw signal
        output  wire    [1:0]   winner              // output winner


    );



    parameter EMPTY     = 2'b00;
    parameter PLAYER    = 2'b01;
    parameter COMPUTER  = 2'b10;

    // 棋盘数据
    reg     [1:0] board [2:0][2:0];

    // 是否有子信号
    wire    [8:0] piece;

    always @(posedge clk or negedge rstn)
    begin

    end

    genvar k;
    genvar l;

    // 棋盘数据输出
    for (k = 0;k < 3;k = k + 1)
        for (l = 0;l < 3;l = l + 1)
            assign board_data[2*k+2*l] = board[k][l];

    // assign board_data = {board[2][2],board[2][1],board[2][0],board[1][2],board[1][1],board[1][0],board[0][2],board[0][1],board[0][0]};

    // 判断棋盘是否有子
    for (k = 0;k < 3;k = k + 1)
        for (l = 0;l < 3;l = l + 1)
            assign piece[k * 3 + l] = |board [k][l];

    // assign piece[0] = |board [0][0];
    // assign piece[1] = |board [0][1];
    // assign piece[2] = |board [0][2];
    // assign piece[3] = |board [1][0];
    // assign piece[4] = |board [1][1];
    // assign piece[5] = |board [1][2];
    // assign piece[6] = |board [2][0];
    // assign piece[7] = |board [2][1];
    // assign piece[8] = |board [2][2];

    integer i = 0;
    integer j = 0;

    always @(posedge clk or negedge rstn)
    begin
        // 棋盘初始化，默认EMPTY
        if (!rstn)
        begin
            for (i = 0;i < 3;i = i + 1)
                for (j = 0;j < 3;j = j + 1)
                    board[i][j] = EMPTY;
            // board[0][0] = EMPTY;
            // board[0][1] = EMPTY;
            // board[0][2] = EMPTY;
            // board[1][0] = EMPTY;
            // board[1][1] = EMPTY;
            // board[1][2] = EMPTY;
            // board[2][0] = EMPTY;
            // board[2][1] = EMPTY;
            // board[2][2] = EMPTY;
        end
        else
        begin
            // 玩家下棋
            if (player_move)
            begin
                // 棋盘已有子
                if (piece[player_adderss] == 1'b1)
                begin
                    illegal_move = 1'b1;
                end
                else
                begin
                    // 棋盘数据输入
                    board[player_adderss/3][player_adderss%3] = PLAYER;
                    illegal_move = 1'b0;
                end
            end
            // 电脑下棋
            else if (computer_move)
            begin
                // 棋盘已有子
                if (piece[computer_adderss] == 1'b1)
                begin
                    illegal_move = 1'b1;
                end
                else
                begin
                    // 棋盘数据输入
                    board[computer_adderss/3][computer_adderss%3] = COMPUTER;
                    illegal_move = 1'b0;
                end
            end
            else
            begin
                illegal_move = 1'b0;
            end
        end
    end

    // 判断是否胜利
    always @(posedge clk or negedge rstn)
    begin
        if (!rstn)
        begin
            win = 1'b0;
        end
        else if (board[0][0] == PLAYER && board[0][1] == PLAYER && board[0][2] == PLAYER)
        begin
            assign win = 1'b1;
        end
        else if (board[1][0] == PLAYER && board[1][1] == PLAYER && board[1][2] == PLAYER)
        begin
            assign win = 1'b1;
        end

    end

    // assign win = 1'b0;
    // assign draw = 1'b0;
    // assign winner = 2'b00;

endmodule
