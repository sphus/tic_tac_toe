`timescale 1ns/1ps

module tic_tac_toe
    (
        input   wire        clk                 ,   // clock
        input   wire        rstn                ,   // reset
        input   wire        player_move         ,   // player move
        input   wire        computer_move       ,   // computer move
        input   wire [3:0]  player_adderss      ,   // player address
        input   wire [3:0]  computer_adderss    ,   // computer address

        output  wire [1:0]  pos_led1            ,   //led1 output
        output  wire [1:0]  pos_led2            ,   //led2 output
        output  wire [1:0]  pos_led3            ,   //led3 output
        output  wire [1:0]  pos_led4            ,   //led4 output
        output  wire [1:0]  pos_led5            ,   //led5 output
        output  wire [1:0]  pos_led6            ,   //led6 output
        output  wire [1:0]  pos_led7            ,   //led7 output
        output  wire [1:0]  pos_led8            ,   //led8 output
        output  wire [1:0]  pos_led9            ,   //led9 output

        output  wire        win                 ,   //output winsigal
        output  wire        winner              ,   //output winner, 0:computer win, 1:player win
        output  wire        draw                ,   //output draw (平局)
        output  wire        illegal_move            //output illegal_move
    );


    
    // 棋盘信息
    parameter EMPTY     = 2'b00;
    parameter PLAYER    = 2'b01;
    parameter COMPUTER  = 2'b10;

    // 状态机信息
    parameter IDLE      = 4'b0001;
    parameter PLAYER    = 4'b0010;
    parameter COMPUTER  = 4'b0100;
    parameter DONE      = 4'b1000;


endmodule
