`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.10.2024 17:33:29
// Design Name: 
// Module Name: mux_4x1
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


module mux_4x1(a, b, c, d, s, q);

    input [31:0]a, b, c, d;
    input [1:0]s;
    output reg [31:0]q;
    
    always @(s) begin
        
        case (s)
            2'b00 : q = a;
            2'b01 : q = b;
            2'b10 : q = c;
            2'b11 : q = d;
        endcase
    end
endmodule
