`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.10.2024 11:16:38
// Design Name: 
// Module Name: uart_rx
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


module uart_rx(
    input wire clk,         // Ana saat sinyali
    input wire reset,       // Reset sinyali
    input wire rx,          // UART RX hattý (gelen veri)
    output reg [7:0] data,  // Alýnan veri
    output reg ready        // Veri alýndý sinyali
    );
    
    parameter IDLE = 2'b00, START = 2'b01, DATA = 2'b10, STOP = 2'b11;
    reg [1:0] state, next_state;
    reg [3:0] bit_index;
    reg [7:0] shift_reg;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            ready <= 0;
            bit_index <= 0;
        end else begin
            state <= next_state;
            case (state)
                IDLE: begin
                    ready <= 0;
                    if (rx == 1'b0) begin  // Start biti (0) tespit edildi
                        next_state <= START;
                    end
                end
                START: begin
                    if (rx == 1'b0) begin  // Start bitini doðrula
                        next_state <= DATA;
                        bit_index <= 0;
                    end
                end
                DATA: begin
                    shift_reg[bit_index] <= rx;  // Veriyi sýrayla oku
                    if (bit_index == 7)
                        next_state <= STOP;
                    else
                        bit_index <= bit_index + 1;
                end
                STOP: begin
                    if (rx == 1'b1) begin  // Stop biti (1)
                        data <= shift_reg;
                        ready <= 1;
                        next_state <= IDLE;
                    end
                end
            endcase
        end
    end
endmodule
