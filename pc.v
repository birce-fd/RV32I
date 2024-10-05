`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: üçgen takýmý
// Engineer: Birce
// 
// Create Date: 05.10.2024 
// Design Name: 
// Module Name: program_counter
// Project Name: program counter
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


module program_counter(clk,immbj,jump,pcmux,pc
 );
input [31:0]immbj,jump;
input clk;
input [1:0]pcmux;
output reg[31:0] pc;

always@(posedge clk)

    begin
       case(pcmux)
           
          2'b11 : pc = pc + 4;
          2'b10 : pc = pc + immbj;
          2'b01 : pc = jump;  
          2'b00 : pc = 32'h0000_0000;
          default: pc = pc + 4;
          
       endcase
       
    end
endmodule
