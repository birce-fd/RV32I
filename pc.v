`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ��gen tak�m�
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


module program_counter(clk, clr, pc, next_pc);
   input clk, clr;
   output reg [31:0] pc;
   input [31:0] next_pc;

   always @ (posedge clk, negedge clr) begin

      if(!clr)
         pc <= 0;
      else 
         pc <= next_pc;
   end

endmodule
