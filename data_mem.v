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
    input wire [11:0] Addr,      // Bellek adresi (hangi adrese yaz?laca??n? s?yl?yor)
    input wire [31:0] DataIn,    // Yazma verisi (i?lemci taraf?ndan belle?e yaz?lacak olan veriyi ta??r)
    input wire [2:0]MemOp,       // Okuma/Yazma islemi icin kontrol sinyali  
    input wire MemWr,            // Belle?e yazma sinyali                  
    output reg [31:0] DataOut,    // Okunan veri    
    output reg [7:0]tx_data,
    input [7:0]rx_data,
    input rx_ready,
    input tx_busy                

    );
    
     reg [7:0] dmem[0:2047];   

   initial begin
    $readmemb("memory_initialization_file.mif", dmem);
end

    /*  
    Gelen MemOp ve MemWr sinyalleri anlamlari:
    MemWr + 3 bit MemOp
    0000 -> LB,  0001 -> LH,  0010 -> LW,  0011 -> LBU, 0100 -> LHU
    1000 -> SB,  1001 -> SH,  1010 -> SW

    */


    always @(posedge clk or negedge clk or negedge rst) begin
        if (!rst) begin
            // Reset durumunda ??k??? s?f?rla
            DataOut <= 32'b0;
        end else begin
            // Yazma islemleri 
            case ({MemWr, MemOp})
                //SB
                4'b1000 : begin
                    dmem[Addr] <= DataIn[7:0];    // ilk byte
                end
                //SH
                4'b1001 : begin
                    dmem[Addr]     <= DataIn[7:0];    // ilk byte
                    dmem[Addr+1]   <= DataIn[15:8];   // ikinci byte
                end
                //SW
                4'b1010 : begin
                    //eger adres 0x404 ise uart secilmistir
                    if (Addr == 12'h404 & rx_ready) begin
                        dmem[Addr] <= rx_data;  //uarttan gelen data 
                    end else begin
                        dmem[Addr]     <= DataIn[7:0];    // ilk byte
                        dmem[Addr+1]   <= DataIn[15:8];   // ikinci byte
                        dmem[Addr+2]   <= DataIn[23:16];  // ucuncu byte
                        dmem[Addr+3]   <= DataIn[31:24];  // dorduncu byte
                    end
                end
            
            //Okuma islemleri
                //LB
                //Okuma islemi signed olarak yapildigi icin ilk 24 bite ilgili byte'in MSB'si yazilir 
                4'b0000 : DataOut[31:0] <= {{24{dmem[Addr][7]}}, dmem[Addr]};

                //LH
                //Okuma islemi signed olarak yapildigi icin ilk 16 bite ilgili byte'in MSB'si yazilir 
                4'b0001 : DataOut[31:0] <= {{16{dmem[Addr + 1][7]}}, dmem[Addr + 1], dmem[Addr]};

                //LW
                //Secili 4 byte birlestirilir
                4'b0010 : begin
                        //adres 0x400 secilmis ise ve tx mesgul degilse
                        if(Addr == 12'h400 & !tx_busy) begin
                            tx_data <= dmem[Addr];
                        end else begin
                            DataOut[31:0] <= {dmem[Addr + 3], dmem[Addr + 2], dmem[Addr + 1], dmem[Addr]};     
                        end
                    end

                //LBU
                //Unsigned oldugu icin ilk 24 bit 0 olur
                4'b0011 : DataOut <= {24'b0, dmem[Addr]};
                    
                //LHU
                //Unsigned oldugu icin ilk 16 bit 0 olur
                4'b0100 : DataOut <= {16'b0, dmem[Addr + 1], dmem[Addr]};
            endcase
        end
    end

endmodule
