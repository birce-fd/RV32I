`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.10.2024 10:31:55
// Design Name: 
// Module Name: uart
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


module uart(
    input wire clk,         // Ana saat sinyali
    input wire reset,       // Reset sinyali
    input wire send,        // Gönderim komutu
    input wire [7:0] tx_data,  // Gönderilecek veri
    input wire rx,          // UART RX hattý
    output wire tx,         // UART TX hattý
    output wire busy,       // Gönderim meþgul mü
    output wire [7:0] rx_data,  // Alýnan veri
    output wire rx_ready    // Veri alýndý sinyali
);

 wire tick;
    baud_gen baud_gen_inst (
        .clk(clk),
        .reset(reset),
        .tick(tick)
    );
    
    uart_tx uart_tx_inst (
        .clk(tick),
        .reset(reset),
        .data(tx_data),
        .send(send),
        .tx(tx),
        .busy(busy)
    );
    
     uart_rx uart_rx_inst (
        .clk(tick),
        .reset(reset),
        .rx(rx),
        .data(rx_data),
        .ready(rx_ready)
    );


endmodule



