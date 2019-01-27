//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/01/19 10:17:14
// Design Name: 
// Module Name: uart_top
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


module uart_top(
    output txd,
    input rxd,
    input clk
    );
    wire clk_9600;
    wire receive_ack;
    wire [7:0] data;
    uart_tx uart_tx(
        .clk(clk_9600),
        .txd(txd),
        .rst(1),
        .data_o(data),
        .receive_ack(receive_ack)
    );
    uart_rx uart_rx(
            .clk(clk_9600),
            .rxd(rxd),
            .data_i(data),
            .receive_ack(receive_ack)
     );
     clk_div clk_div(
        .clk(clk),
        .clk_out(clk_9600)
     );
endmodule
