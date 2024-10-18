`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.10.2024 00:21:22
// Design Name: 
// Module Name: instr_mem
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


module instr_mem(
    input wire clk,               // Clock signal
    input wire [9:0] addr,       // address input 
    output reg [31:0] instr       // 32-bit instruction output

    );
    
  reg [31:0] imem [0:511];   

 always @(posedge clk) begin
        instr <= imem[addr];    // ckl'nin y?kselen kenar?nda fetch instruction 
    end

  initial begin 
       $readmemh("D:\instruction_list.txt",imem) ;
       end
       
endmodule
