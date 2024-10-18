`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.10.2024 13:12:52
// Design Name: 
// Module Name: tb_dmem
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


module tb_dmem(
 );
 
    reg clk;
    reg rst;
    reg [11:0] Addr;
    reg [31:0] DataIn;
    reg MemOp;
    reg MemWr;
    wire [31:0] DataOut;

    data_mem uut (
        .clk(clk),
        .rst(rst),
        .Addr(Addr),
        .DataIn(DataIn),
        .MemOp(MemOp),
        .MemWr(MemWr),
        .DataOut(DataOut)
    );

    // Saat sinyali üretimi
    initial clk = 0;
    always #5 clk = ~clk;

    // Test senaryosu
    initial begin
        // Baþlangýç deðerleri
        rst = 1;
        Addr = 0;
        DataIn = 0;
        MemOp = 0;
        MemWr = 0;

        // Reset iþlemini sonlandýr
        #10;
        rst = 0;

        // 1. Yazma iþlemi: 0x000 adresine 0xDEADBEEF yaz
        #10;
        Addr = 12'h000;
        DataIn = 32'hDEADBEEF;
        MemOp = 1;
        MemWr = 1;
        #10;
        MemWr = 0;

        // 2. Yazma iþlemi: 0x004 adresine 0x12345678 yaz
        #10;
        Addr = 12'h004;
        DataIn = 32'h12345678;
        MemOp = 1;
        MemWr = 1;
        #10;
        MemWr = 0;

        // 3. Okuma iþlemi: 0x000 adresinden veri oku
        #10;
        Addr = 12'h000;
        MemOp = 1;
        MemWr = 0;
        #10;

        // 4. Okuma iþlemi: 0x004 adresinden veri oku
        #10;
        Addr = 12'h004;
        MemOp = 1;
        MemWr = 0;
        #10;

        // Simülasyonu sonlandýr
        #20;
        $finish;
    end
endmodule
