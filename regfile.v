`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.10.2024 13:55:47
// Design Name: 
// Module Name: regfile
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


module regfile(rna, rnb, d, addr, we, clk, clr, qa, qb);
    input [4:0]rna, rnb;    //Cikis icin secilecek olan rs1 ve rs2
    input [31:0]d;          //register'a yazilacak olan data
    input [4:0]addr;        //yazma islemi yapilacak register adresi
    input we;               //write enable
    input clk, clr;         //clock, clear
    output reg [31:0]qa, qb;    //rs1 ve rs2
    
    reg [31:0]reg_file[31:0];
    
    initial begin
        reg_file[0] = 0;
    end
    
    always @ (posedge clk or negedge clr) begin
        if (!clr)   
            reg_file[addr] <= 0;
        //yazma islemi
        else if (we)
            //reg_file[addr] <= d;
            reg_file[addr] <= (addr[0] == 0) ? 0 : d;
    end
    //okuma islemi
    always @(*) begin
        qa <= reg_file[rna];
        qb <= reg_file[rnb];
    end
endmodule
