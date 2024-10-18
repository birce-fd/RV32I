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
    output reg [2:0]MemOp;
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
                    ALUAsrc = 0;    //rs1
                    ALUBsrc = 2'b01;//imm
                    ALUctrl = 4'b0; //ADD
                    Branch = 3'b110;//PC + 4
                    memToReg = 1;   //ALU result
                    MemOp = 3'bx;   //ALU result, ne secildigi onemsiz
                    MemWr = 0;      //yazma yok
                    RegWr = 1;      //Registera yazılır
                    end
        //  AIUPC
        7'b0010111 : begin
                    ALUAsrc = 1;    //PC
                    ALUBsrc = 2'b01;//imm
                    ALUctrl = 4'b0; //ADD
                    Branch = 3'b110;//PC + 4
                    memToReg = 1;   //ALU result
                    MemOp = 3'bx;   //ALU result, ne secildigi onemsiz
                    MemWr = 0;      //yazma yok
                    RegWr = 1;      //Registera yazilir
                    end
        //  R - TYPE
        7'b0110011 : begin
                    ALUAsrc = 0;    //rs1
                    ALUBsrc = 2'b00;//rs2
                    Branch = 3'b110;//PC + 4
                    memToReg = 1;   //ALU result
                    MemOp = 3'bx;   //ALU result, ne secildigi onemsiz
                    MemWr = 0;      //yazma yok
                    RegWr = 1;      //Registera yazilir
                    case (func3)
                    //  ADD, SUB
                    3'b000 : ALUctrl = (func7 == 7'b0) ? 4'b0000 : 4'b1011; //ADD : SUB
                    //  SLL
                    3'b001 : ALUctrl = 4'b1000;
                    //  SLT
                    3'b010 : ALUctrl = 4'b0001;
                    //  SLTU
                    3'b011 : ALUctrl = 4'b0010;
                    //  XOR
                    3'b100 : ALUctrl = 4'b0011;
                    //  SRL, SRA
                    3'b101 : ALUctrl = (func7 == 7'b0) ? 4'b1001 : 4'b1010; //SRL : SRA
                    //  OR
                    3'b110 : ALUctrl = 4'b0100;
                    //AND
                    3'b111 : ALUctrl = 4'b0111;
                    endcase
                    end
        //  I - TYPE
        7'b0010011 :  begin
                    ALUAsrc = 0;    //rs1
                    ALUBsrc = 2'b01;//offset
                    Branch = 3'b110;//PC + 4
                    memToReg = 1;   //ALU result
                    MemOp = 3'bx;   //ALU result, ne secildigi onemsiz
                    MemWr = 0;      //yazma yok
                    RegWr = 1;      //Registera yazilir
                    case (func3)
                    3'b000 : ALUctrl = 4'b0000; //ADDI
                    3'b010 : ALUctrl = 4'b0001; //SLTI    
                    3'b011 : ALUctrl = 4'b0001; //SLTIU
                    3'b100 : ALUctrl = 4'b0011; //XORI
                    3'b110 : ALUctrl = 4'b0100; //ORI
                    3'b111 : ALUctrl = 4'b0111; //ANDI
                    3'b001 : ALUctrl = (func7 == 7'b0) ? 4'b1000 : 4'bx; //SLLI
                    3'b101 : ALUctrl = (func7 == 7'b0) ? 4'b1001 : (func7 == 7'b0100000) ? 4'b1010 : 4'bx; //SRLI : SRAI : DC
                    endcase
                    end
        //  J - TYPE
        7'b1101111 : begin  //JAL
                    ALUAsrc = 1;    //PC
                    ALUBsrc = 2'b01;//offset
                    Branch = 3'b100;//PC + offset
                    memToReg = 1;   //ALU result
                    MemOp = 3'bx;   //ALU result, ne secildigi onemsiz
                    MemWr = 0;      //yazma yok
                    RegWr = 1;      //Registera yazilir
                    ALUctrl = 4'b0000;
                    end
        7'b1100111 : begin  //JALR
                    ALUAsrc = 1;    //PC
                    ALUBsrc = 2'b10;//+4
                    Branch = 3'b100;//PC + offset
                    memToReg = 1;   //ALU result
                    MemOp = 3'bx;   //ALU result, ne secildigi onemsiz
                    MemWr = 0;      //yazma yok
                    RegWr = 1;      //Registera yazilir
                    ALUctrl = 4'b0000;//ADD
                    end
        //  B - TYPE
        7'b1100111 : begin
                    ALUAsrc = 0;    //rs1
                    ALUBsrc = 2'b00;//rs2
                    memToReg = 1;   //ALU result
                    MemOp = 3'bx;   //ALU result, ne secildigi onemsiz
                    MemWr = 0;      //yazma yok
                    RegWr = 1;      //Registera yazilir
                    ALUctrl = 4'b1011;//SUB
                    case (func3)
                    //BEQ
                    3'b000 : Branch = 3'b000;//branch_condition'dan BEQ secilir  
                    //BNE
                    3'b001 : Branch = 3'b001;  //bc'dan BNE secilir
                    //BLT
                    3'b100 : Branch = 3'b010;  //bc'dan BLT secilir
                    //BGE
                    3'b101 : Branch = 3'b011;  //bc'dan BGE secilir
                    //BLTU
                    3'b110 : Branch = 3'b010;  //bc'dan BLTU secilir
                    //BGEU
                    3'b111: Branch = 3'b011;   //bc'dan BGEU secilir
                    endcase
                    end
        //  L - TYPE Memory buyruklari
        7'b0000011 : begin
                    ALUAsrc = 0;    //rs1
                    ALUBsrc = 2'b01;//offset
                    memToReg = 0;   //memory secilir
                    RegWr = 1;      //Registera yazilir
                    ALUctrl = 4'b0000;//Adres hesabi icin ADD
                    Branch = 3'b110;  //PC + 4
                    case (func3)
                        //LB
                        3'b000 : begin
                                MemOp = 3'b000;    //LB sinyali
                                MemWr = 0;          //okuma sinyali
                                end
                        //LH
                        3'b001 : begin
                                MemOp = 3'b001;    //LH sinyali
                                MemWr = 0;          //okuma sinyali
                                end
                        //LW
                        3'b010 : begin
                                MemOp = 3'b010;    //LW kodu
                                MemWr = 0;          //okuma sinyali
                                end
                        //LBU
                        3'b100 : begin
                                MemOp = 3'b011;    //LBU kodu
                                MemWr = 0;          //okuma sinyali
                                end
                        //LHU
                        3'b101 : begin
                                MemOp = 3'b100;    //LHU kodu
                                MemWr = 0;          //okuma sinyali
                                end
                    endcase
                    end
        //  S - TYPE
        7'b0100011 : begin
                    ALUAsrc = 0;    //rs1
                    ALUBsrc = 2'b01;//offset
                    memToReg = 0;   //memory secilir
                    RegWr = 1;      //Registera yazilir
                    ALUctrl = 4'b0000;//Adres hesabi icin ADD
                    Branch = 3'b110;  //PC + 4
                    case (func3)
                        //SB
                        3'b000 : begin
                                MemOp = 3'b000;    //SB kodu
                                MemWr = 1;          //yazma sinyali
                                end
                        3'b001 : begin
                                MemOp = 3'b001;    //SH kodu
                                MemWr = 1;          //yazma sinyali
                                end
                        3'b010 : begin
                                MemOp = 3'b010;    //SW kodu
                                MemWr = 1;          //yazma sinyali
                                end
                    endcase
                    end
        endcase    
    end
    
    
endmodule
