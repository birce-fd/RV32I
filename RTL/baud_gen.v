`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.10.2024 11:07:46
// Design Name: 
// Module Name: baud_gen
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


module baud_gen(
    input wire clk,        // Ana saat sinyali
    input wire reset,      // Reset sinyali
    output reg tick        // Baud rate tick (gönderme/alma sinyali)
    );
 parameter BAUD_DIV = 10417;  // Baud rate için clock bölme faktörü (örn: 9600 baud için)
    
 reg [15:0] counter;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
            tick <= 0;
        end else begin
            if (counter == BAUD_DIV) begin
                counter <= 0;
                tick <= 1;
            end else begin
                counter <= counter + 1;
                tick <= 0;
            end
        end
    end
endmodule
