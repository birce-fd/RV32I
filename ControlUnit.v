`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ahmet
// 
// Create Date: 06.10.2024 21:26:23
// Design Name: 
// Module Name: ControlUnit
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


module ControlUnit(instr, ALUAsrc, ALUBsrc, ALUctrl, Branch, memToReg, MemOp, MemWr, RegWr);
    input [31:0] instr; // [6:0]opcode, [31:25] func7, [14:12] func3
    output reg ALUAsrc;         // 0 -> rs1, 1 -> PC
    output reg [1:0]ALUBsrc;    // 00 -> rs2, 01 -> imm, 10 -> 4, 11 -> x
    output reg [3:0]ALUctrl;
    output reg [2:0]Branch;
    output reg memToReg;
    output reg MemOp;
    output reg MemWr;
    output reg RegWr;
    
    wire [6:0]op = instr[6:0];
    wire [2:0]func3 = instr[14:12];
    wire [6:0]func7 = instr[31:25];
    
    always @ (*)begin
        
        case (op)
        
        //  U TYPE
        //  LUI
        7'b0110111 : begin
                    
                    ALUAsrc = 0;
                    ALUBsrc = 2'b01;
                    ALUctrl = 4'b0;
                    Branch = 3'b111;
                    memToReg = 1;
                    MemOp = 0;
                    MemWr = 0;
                    RegWr = 1;
                    end
        //  AIUPC
        7'b0010111 : begin
                    
                    ALUAsrc = 1;    //PC
                    ALUBsrc = 2'b01;//imm
                    ALUctrl = 4'b0; //ADD
                    Branch = 3'b111;//No Branch
                    memToReg = 1;   //ALU result
                    MemOp = 0;      //Yazma okuma yok
                    MemWr = 0;
                    RegWr = 1;      //Registera yazilir
                    end
        //  R - TYPE
        7'b0110011 : begin
                    
                    ALUAsrc = 0;    //rs1
                    ALUBsrc = 2'b00;//rs2
                    Branch = 3'b111;//No Branch
                    memToReg = 1;   //ALU result
                    MemOp = 0;      //Yazma okuma yok
                    MemWr = 0;
                    RegWr = 1;      //Registera yazilir
                    
                    case (func3)
                    //  ADD, SUB
                    3'b000 : begin
                            ALUctrl = (func7 == 7'b0) ? 4'b0000 : 4'b1011; //ADD : SUB
                            end
                    //  SLL
                    3'b001 : begin
                            ALUctrl = 4'b1000;
                            end
                    //  SLT
                    3'b010 : begin
                            ALUctrl = 4'b0001;
                            end
                    //  SLTU
                    3'b011 : begin
                            ALUctrl = 4'b0010;
                            end
                    //  XOR
                    3'b100 : begin
                            ALUctrl = 4'b0011;
                            end
                    //  SRL, SRA
                    3'b101 : begin
                            ALUctrl = (func7 == 7'b0) ? 4'b1001 : 4'b1010; //SRL : SRA
                            end
                    //  OR
                    3'b110 : begin
                            ALUctrl = 4'b0100;
                            end
                    //AND
                    3'b111 : begin
                            ALUctrl = 4'b0111;
                            end
                    endcase
                    end
        endcase    
    end
    
    
endmodule
