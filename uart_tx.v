`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.10.2024 11:13:51
// Design Name: 
// Module Name: uart_tx
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


module uart_tx(
input wire clk,         // Ana saat sinyali
    input wire reset,       // Reset sinyali
    input wire [7:0] data,  // Gönderilecek veri
    input wire send,        // Gönderme sinyali
    output reg tx,          // UART TX hattý
    output reg busy         // Gönderim durumu (meþgul mü deðil mi?)
    );
    
    parameter IDLE = 2'b00, START = 2'b01, DATA = 2'b10, STOP = 2'b11;
    reg [1:0] state, next_state;
    reg [3:0] bit_index;
    reg [7:0] shift_reg;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            tx <= 1'b1;
            busy <= 0;
            bit_index <= 0;
        end else begin
            state <= next_state;
            case (state)
                IDLE: begin
                    tx <= 1'b1;  // Hat boþ (idle durumda 1)
                    busy <= 0;
                    if (send) begin
                        next_state <= START;
                        shift_reg <= data;
                        busy <= 1;
                    end
                end
                START: begin
                    tx <= 1'b0;  // Start bit (0)
                    next_state <= DATA;
                    bit_index <= 0;
                end
                DATA: begin
                    tx <= shift_reg[bit_index];  // Veriyi sýrayla gönder
                    if (bit_index == 7)
                        next_state <= STOP;
                    else
                        bit_index <= bit_index + 1;
                end
                STOP: begin
                    tx <= 1'b1;  // Stop bit (1)
                    next_state <= IDLE;
                end
            endcase
        end
    end
endmodule
