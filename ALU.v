`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ahmet
// 
// Create Date: 06.10.2024 21:14:41
// Design Name: 
// Module Name: ALU
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


module ALU(a, b, ctrl, result, zeroFlag, LessFlag);
    input [31:0]a, b;
    input [3:0]ctrl;
    output reg [31:0]result;
    output LessFlag;
    output zeroFlag;
    
    /*
    function [31:0]operation;
        input [31:0]a, b;
        input [3:0] ctrl;
    
           
        case (ctrl)
            5'b00000 : operation = a + b;                //ADD, ADDI
            5'b00001 : operation = (a - b < 0) ? 1 : 0;  //SLTI SLT
            5'b00010 : operation = a < b ? 1 : 0;        //SLTIU   SLTU
            5'b00011 : operation = a ^ b;                //XORI, XOR
            5'b00100 : operation = a | b;                //ORI, OR
            5'b00111 : operation = a & b;                //ANDI, AND
            5'b01000 : operation = a << b;               //SLLI, SLL
            5'b01001 : operation = a >> b;               //SRLI, SRL
            5'b01010 : operation = a >>> b;              //SRAI, SRA
            5'b01011 : operation = a - b;                //SUB
        
        default :;
        endcase
    endfunction
    */
    
    always @(*) begin
        
        case (ctrl)
            5'b0000 : result = a + b;                //ADD, ADDI
            5'b0001 : result = (a < b) ? 1 : 0;      //SLTI SLT
            5'b0010 : result = a < b ? 1 : 0;        //SLTIU   SLTU
            5'b0011 : result = a ^ b;                //XORI, XOR
            5'b0100 : result = a | b;                //ORI, OR
            5'b0111 : result = a & b;                //ANDI, AND
            5'b1000 : result = a << b;               //SLLI, SLL
            5'b1001 : result = a >> b;               //SRLI, SRL
            5'b1010 : result = a >>> b;              //SRAI, SRA
            5'b1011 : result = a - b;                //SUB
        
            default :;
        endcase
        end
    
    
    //Eger sonuc = 0 ise zeroFlag 1 olmali
    assign zeroFlag = result ? 0 : 1;
    assign LessFlag = (result < 0) ? 1 : 0;
    
endmodule
