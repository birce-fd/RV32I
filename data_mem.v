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
    input wire rst,              
    input wire [11:0] Addr,      // Bellek adresi (hangi adrese yaz�laca��n� s�yl�yor)
    input wire [31:0] DataIn,    // Yazma verisi (i�lemci taraf�ndan belle�e yaz�lacak olan veriyi ta��r)
    input wire MemOp,            // Okuma/Yazma i�lemi kontrol sinyali 
    input wire MemWr,            // Belle�e yazma sinyali 
    output reg [31:0] DataOut    // Okunan veri 

    );
    
     reg [7:0] dmem[0:2047];   

   initial begin
    $readmemb("memory_initialization_file.mif", dmem);
end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset durumunda ��k��� s�f�rla
            DataOut <= 32'b0;
        end else begin
            // Yazma 
            if (MemWr && MemOp) begin
                // DataIn'i ilgili adrese yaz
                dmem[Addr]     <= DataIn[7:0];    // �lk byte
                dmem[Addr+1]   <= DataIn[15:8];   // �kinci byte
                dmem[Addr+2]   <= DataIn[23:16];  // ���nc� byte
                dmem[Addr+3]   <= DataIn[31:24];  // D�rd�nc� byte
            end
            // Okuma 
            else if (!MemWr && MemOp) begin
                // Byte byte bellekten okuma
                DataOut[7:0]   <= dmem[Addr];     // �lk byte
                DataOut[15:8]  <= dmem[Addr+1];   // �kinci byte
                DataOut[23:16] <= dmem[Addr+2];   // ���nc� byte
                DataOut[31:24] <= dmem[Addr+3];   // D�rd�nc� byte
            end
        end
    end
     

endmodule
