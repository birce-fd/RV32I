`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.10.2024 17:42:33
// Design Name: 
// Module Name: branch_condition
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


module branch_condition(branch, LessFlag, ZeroFlag, PCAsrc, PCBsrc);
    input [2:0]branch;
    input LessFlag, ZeroFlag;
    output reg PCAsrc, PCBsrc;
    
    
    /*
    BEQ   000
    BNE   001
    BLT   010
    BGE   011
    BLTU  010
    BGEU  011
    NO BR 111
    */

    //  PCA = 0 -> imm, PCA = 1 -> 4
    //  PCB = 0 -> PC,  PCB = 1 -> rs1
    
    //  PCArsc ve PCBsrc 2x1 mux girişleri için select ucu olacak. Eger branch condition saglanmamis ise
    //  PCAsrc = 1 ve PCBsrc = 0 (PC + 4) olacagi icin default olarak PCA = 1 ve PCB = 0 
    //  olsun, kosul saglanmis ise PCAsrc = 0 olsun (PC + offset).
    
    initial begin
        PCAsrc = 1;
        PCBsrc = 0;
    end
    
    always @ (*) begin
        
        case (branch)
            //  BEQ
            3'b000 : PCAsrc = (ZeroFlag == 1) ? 0 : 1;
            //  BNE
            3'b001 : PCAsrc = (ZeroFlag != 1) ? 0 : 1;
            //  BLT BLTU
            3'b010 : PCAsrc = (LessFlag == 1) ? 0 : 1;
            //  BGE BGEU
            3'b011 : PCAsrc = (LessFlag != 1) ? 0 : 1;
            //  NO BRANCH
            3'b111 : PCAsrc = 1;
            default : PCAsrc = 1;
        endcase
    
    end
endmodule
