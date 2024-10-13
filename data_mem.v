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
    input wire [31:0] Addr,      // Bellek adresi (hangi adrese yazýlacaðýný söylüyor)
    input wire [31:0] DataIn,    // Yazma verisi (iþlemci tarafýndan belleðe yazýlacak olan veriyi taþýr)
    input wire MemOp,            // Okuma/Yazma iþlemi kontrol sinyali 
    input wire MemWr,            // Belleðe yazma sinyali 
    output reg [31:0] DataOut    // Okunan veri 

    );
    
     reg [31:0] memory [0:255];   

    always @(posedge clk) begin
        if (MemWr && MemOp) begin
            memory[Addr[7:0]] <= DataIn;  // Yazma iþlemi (Addr'nin alt 8 biti)
        end
    end

    always @(*) begin
        if (!MemWr && MemOp) begin
            DataOut = memory[Addr[7:0]];  // Okuma iþlemi
        end else begin
            DataOut = 32'b0;              // Okuma yapýlmadýðýnda sýfýrla
        end
    end

endmodule
