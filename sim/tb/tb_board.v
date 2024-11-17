// Testbench for board module
`timescale 1ns/1ps

module tb_board();

    reg             clk             ;   // clock
    reg             rstn            ;   // reset
    reg             player_move     ;   // player move
    reg             computer_move   ;   // computer move
    reg     [3:0]   player_address  ;   // player address
    reg     [3:0]   computer_address;   // computer address
    wire    [1:0]   led_0           ;   // output led_0
    wire    [1:0]   led_1           ;   // output led_1
    wire    [1:0]   led_2           ;   // output led_2
    wire    [1:0]   led_3           ;   // output led_3
    wire    [1:0]   led_4           ;   // output led_4
    wire    [1:0]   led_5           ;   // output led_5
    wire    [1:0]   led_6           ;   // output led_6
    wire    [1:0]   led_7           ;   // output led_7
    wire    [1:0]   led_8           ;   // output led_8
    wire            illegal_move    ;   // output illegal_move signal
    wire            tie             ;   // output tie signal   (平局)
    wire            win             ;   // output win signal
    wire    [1:0]   winner          ;   // output winner , PLAYER or COMPUTER


    board uut(
              .clk             (clk             ),
              .rstn            (rstn            ),
              .player_move     (player_move     ),
              .computer_move   (computer_move   ),
              .player_address  (player_address  ),
              .computer_address(computer_address),

              .led_0           (led_0           ),
              .led_1           (led_1           ),
              .led_2           (led_2           ),
              .led_3           (led_3           ),
              .led_4           (led_4           ),
              .led_5           (led_5           ),
              .led_6           (led_6           ),
              .led_7           (led_7           ),
              .led_8           (led_8           ),
              .illegal_move    (illegal_move    ),
              .tie             (tie             ),
              .win             (win             ),
              .winner          (winner          )
          );

    initial
    begin
        clk   = 1'b0;
        rstn  = 1'b0;
        player_address = 4'd0;
        player_move = 1'b0;
        computer_address = 4'd0;
        computer_move = 1'b0;
        #20;
        rstn  = 1'b1;
    end

    always #20 clk = ~clk;

    initial
    begin
        #100;
        tie_mode();
        #100;
        rstn  = 1'b0;
        #20;
        rstn  = 1'b1;
        player_win();


        // player  (4'd4);
        // computer(4'd3);
        // player  (4'd0);
        // computer(4'd8);
        // player  (4'd1);
        // computer(4'd7);
        // player  (4'd2);
        // // 此时玩家胜利

    end

    task player(
            input  [3:0]   address
        );
        begin
            #20;
            player_address = address;
            #20;
            player_move = 1'b1;
            #20;
            player_move = 1'b0;
            #20;

        end
    endtask

    task computer(
            input  [3:0]   address
        );
        begin
            #20;
            computer_address = address;
            #20;
            computer_move = 1'b1;
            #20;
            computer_move = 1'b0;
            #20;

        end
    endtask

    // 平局
    task tie_mode();
        begin
            computer(4'd0);
            player  (4'd1);
            player  (4'd2);
            player  (4'd3);
            computer(4'd4);
            computer(4'd5);
            player  (4'd6);
            computer(4'd7);
            player  (4'd8);
        end
    endtask

    // 玩家胜利
    task player_win();
        begin
            player  (4'd4);
            computer(4'd3);
            player  (4'd0);
            computer(4'd8);
            player  (4'd1);
            computer(4'd7);
            player  (4'd2);
        end
    endtask
endmodule
