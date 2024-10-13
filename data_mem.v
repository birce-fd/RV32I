`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.10.2024 00:56:05
// Design Name: 
// Module Name: data_mem
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


module data_mem(
    input wire clk,              //ckl sinyali
    input wire [31:0] Addr,      // Bellek adresi (hangi adrese yaz�laca��n� s�yl�yor)
    input wire [31:0] DataIn,    // Yazma verisi (i�lemci taraf�ndan belle�e yaz�lacak olan veriyi ta��r)
    input wire MemOp,            // Okuma/Yazma i�lemi kontrol sinyali 
    input wire MemWr,            // Belle�e yazma sinyali 
    output reg [31:0] DataOut    // Okunan veri 

    );
    
     reg [31:0] memory [0:255];   

    always @(posedge clk) begin
        if (MemWr && MemOp) begin
            memory[Addr[7:0]] <= DataIn;  // Yazma i�lemi (Addr'nin alt 8 biti)
        end
    end

    always @(*) begin
        if (!MemWr && MemOp) begin
            DataOut = memory[Addr[7:0]];  // Okuma i�lemi
        end else begin
            DataOut = 32'b0;              // Okuma yap�lmad���nda s�f�rla
        end
    end

endmodule
