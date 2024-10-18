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
    reg [2:0]MemOp;
    reg MemWr;
    wire [31:0] DataOut;
    wire [7:0]tx_data;
    reg [7:0]rx_data;
    reg rx_ready;
    reg tx_busy;

    data_mem uut (
        .clk(clk),
        .rst(rst),
        .Addr(Addr),
        .DataIn(DataIn),
        .MemOp(MemOp),
        .MemWr(MemWr),
        .DataOut(DataOut),
        .tx_data(tx_data),
        .rx_data(rx_data),
        .rx_ready(rx_ready),
        .tx_busy(tx_busy)
    );

    // Saat sinyali �retimi
    initial clk = 0;
    always #5 clk = ~clk;

    // Test senaryosu
    initial begin
        // Ba�lang�� de�erleri
        rst = 1;
        Addr = 0;
        DataIn = 0;
        MemOp = 0;
        MemWr = 0;

        // Reset i�lemini sonland�r
        #10;
        rst = 0;

        /*  
        Gelen MemOp ve MemWr sinyalleri anlamlari:
        MemWr + 3 bit MemOp
        0000 -> LB,  0001 -> LH,  0010 -> LW,  0011 -> LBU, 0100 -> LHU
        1000 -> SB,  1001 -> SH,  1010 -> SW
        */


        // 1. Yazma i�lemi: 0x000 adresine 0xDEADBEEF yaz
        #10;
        Addr = 12'h000;
        DataIn = 32'hDEADBEEF;
        MemOp = 3'b010;
        MemWr = 1;
        #10;
        MemWr = 0;

        // 2. Yazma i�lemi: 0x004 adresine 0x12345678 yaz
        #10;
        Addr = 12'h004;
        DataIn = 32'h12345678;
        MemOp = 3'b010;
        MemWr = 1;
        #10;
        MemWr = 0;

        // 3. Okuma i�lemi: 0x000 adresinden veri oku
        #10;
        Addr = 12'h000;
        MemOp = 3'b010;
        MemWr = 0;
        #10;

        // 4. Okuma i�lemi: 0x004 adresinden veri oku
        #10;
        Addr = 12'h004;
        MemOp = 3'b010;
        MemWr = 0;
        #10;

        // Sim�lasyonu sonland�r
        #20;
        $finish;
    end
endmodule
