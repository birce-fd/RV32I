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
   
    always @(*) begin
        
        case (ctrl)
            4'b0000 : result = a + b;                       //ADD, ADDI
            4'b0001 : result = ($signed(a) < $signed(b)) ? 1 : 0;  //SLTI SLT
            4'b0010 : result = a < b ? 1 : 0;               //SLTIU   SLTU
            4'b0011 : result = a ^ b;                       //XORI, XOR
            4'b0100 : result = a | b;                       //ORI, OR
            4'b0111 : result = a & b;                       //ANDI, AND
            4'b1000 : result = a << b[4:0];                 //SLLI, SLL
            4'b1001 : result = a >> b[4:0];                 //SRLI, SRL
            4'b1010 : result = $signed(a) >>> b[4:0];       //SRAI, SRA
            4'b1011 : result = a - b;                       //SUB
        
            default :;
        endcase
        end
    
    
    //Eger sonuc = 0 ise zeroFlag 1 olmali
    assign zeroFlag = result ? 0 : 1;
    assign LessFlag = ($signed(a) < $signed(b)) ? 1 : 0;
    
endmodule
