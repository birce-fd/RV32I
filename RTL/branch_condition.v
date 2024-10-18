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
    JAL   100
    JALR  101
    NO BR 111
    */
    //  PCA = 0 -> imm, PCA = 1 -> 4
    //  PCB = 0 -> PC,  PCB = 1 -> rs1
    
    
    
    //  Kosulsuz sekilde JAL ve JALR buruklarini calistirabilmek icin ZerFlag ve LEssFlag umursanmadan
    //  sadece gelen buyruk koduna gore islem yapılır
    
    
    initial begin
        PCAsrc = 1; //+4
        PCBsrc = 0; //PC
    end
    
    always @ (*) begin
        
        case (branch)
            3'b000 : begin  //BEQ
                        PCAsrc = (ZeroFlag == 1) ? 0 : 1;
                        PCBsrc = 0;
                    end
            3'b001 : begin  //BNE
                        PCAsrc = (ZeroFlag != 1) ? 0 : 1;
                        PCBsrc = 0;
                        end
            3'b010 : begin  //  BLT BLTU
                        PCAsrc = (LessFlag == 1) ? 0 : 1;
                        PCBsrc = 0;
                     end   
            3'b011 : begin  //  BGE BGEU
                    PCAsrc = (LessFlag != 1) ? 0 : 1;
                    PCBsrc = 0;
                    end  
            3'b100 : begin  //  JAL     PC + offset -> PCA = 0, PCB = 0
                    PCAsrc = 0;//imm
                    PCBsrc = 0;//PC
                    end          
            3'b101 : begin  //  JALR    rs1 + offset -> PCA = 0, PCB = 1
                     PCAsrc = 0;//imm
                     PCBsrc = 1;//rs1
                     end
            3'b110 : begin  
                    PCAsrc = 1;//+4
                    PCBsrc = 0;//PC
                    end
            3'b111 : begin
                    PCAsrc = 1;//+4
                    PCBsrc = 1;//rs1
                    end
            default : PCAsrc = 1;
        endcase
    
    end
endmodule
