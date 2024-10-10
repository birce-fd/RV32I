`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ahmet
// 
// Create Date: 06.10.2024 18:05:01
// Design Name: 
// Module Name: ImmGen
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


module ImmGen(Instr, outImm);
    input [31:0]Instr;
    output [31:0] outImm;
    
    assign outImm = select(Instr[31:0]);
    
    function [31:0]select;
        input [31:0]Instr;
        
        case (Instr[6:0]) 
        
            //  I - tip
            7'b0000011, 7'b0010011 : select = {{20{Instr[31]}}, Instr[31:20]};
            //  S - tip
            7'b0100011: select = {{20{Instr[31]}}, Instr[31:25], Instr[11:7]};
            //  B - tip
             7'b1100011: select = {{19{Instr[31]}}, Instr[31], Instr[7], Instr[30:25], Instr[11:8], 1'b0};
             // U - tip
             7'b0110111, 7'b0010111 : select = {Instr[31:12], 12'b0};
             // J - tip
             7'b1101111: select = {{11{Instr[31]}}, Instr[31], Instr[19:12], Instr[20], Instr[30:21], 1'b0};
             
            default : select = 32'b0;
            
        endcase
    endfunction
        
endmodule
