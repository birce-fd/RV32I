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


module ImmGen(OP, Instr, outImm);
    input [6:0]OP;
    input [31:7]Instr;
    output [31:0] outImm;
    
    assign outImm = select(OP);
    
    function [31:0]select;
        input [6:0]OP;
        
        case (OP)
            7'b0110111 : select = {12'b0, Instr[31:12]}; //LUI
            7'b0010111 : select = {12'b0, Instr[31:12]}; //AUIPC
            7'b1101111 : select = {12'b0, Instr[31], Instr[19:12], Instr[20], Instr[30:21]}; //JAL
            7'b1100111 : select = {20'b0, Instr[31:20]}; //JALR
            7'b1100011 : select = {20'b0, Instr[31], Instr[7], Instr[30:25], Instr[11:8]};  //BEQ, BNE, BLT, BGE, BLTU, BGEU 
            7'b0000011 : select = {20'b0, Instr[31:20]}; // LB, LH, LW, LBU, LHU
            7'b0100011 : select = {20'b0, Instr[31:25], Instr[11:7]};   //SB, SH, SW
            7'b0010011 : select = {20'b0, Instr[31:20]}; //  ADDI, SLTI, SLTIU, XORI, ORI
        endcase
    endfunction
        
endmodule
