`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.10.2024 16:49:18
// Design Name: 
// Module Name: tb_RV32I
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


module tb_RV32I(
    input rx,
    output tx);
    
    //reg [4:0]rna, rnb;  //Cikis icin secilecek olan rs1 ve rs2
    wire [31:0]data;     //register'a yazilacak olan data
    wire [31:0]im_to_rf;    //buyruk
    wire wre;            //write enable
    reg clk, clr;
    wire [31:0]rs1, rs2;
    
    
    
    regfile rf (
        
        .rna(im_to_rf[19:15]),
        .rnb(im_to_rf[24:20]),
        .d(data),
        .addr(im_to_rf[11:7]),
        .we(wre),
        .clk(clk),
        .clr(clr),
        .qa(rs1),
        .qb(rs2)
        
        );
        
    wire [31:0]next_pc;
    instr_mem im (
        .clk(clk),
        .addr(next_pc),
        .instr(im_to_rf)
        
        );
    
    
    wire ALUAsrc;
    wire [1:0]ALUBsrc;
    wire [3:0]ALUctrl;
    wire [2:0]Branch, memOp;
    wire memToReg,memWr, PCAsrc, PCBsrc;
    
    ControlUnit CU(
        .instr(im_to_rf),
        .ALUAsrc(ALUAsrc),
        .ALUBsrc(ALUBsrc),
        .ALUctrl(ALUctrl),
        .Branch(Branch),
        .memToReg(memToReg),
        .MemOp(memOp),
        .MemWr(memWr),
        .RegWr(wre)
            );
    // 0000000 00001 00010 000 00011 0110011    ADD x1, x2, x3
    // 0100000 00001 00010 000 00011 0110011    SUB x1, x2, x3
    // 0000000 00001 00010 000 00011 0010011    ADDI 1, x2, x3
    
    wire [31:0]PC;
    wire [31:0]muxa_to_alu;
    mux_2x1 ALUAmux (
            .a(PC),
            .b(rs1),
            .s(ALUAsrc),
            .q(muxa_to_alu)
            );
            
            
    wire [31:0]imm32;
    wire [31:0]muxb_to_alu;
    
    mux_4x1 ALUBmux (
            .a(rs2),
            .b(imm32),
            .c(32'h00000004),
            .d(32'bx),
            .s(ALUBsrc),
            .q(muxb_to_alu)
            );
    
    wire [31:0]result;
    wire ZeroFlag, LessFlag;
    ALU alu (
        .a(muxa_to_alu),
        .b(muxb_to_alu),
        .ctrl(ALUctrl),
        .result(result),
        .zeroFlag(ZeroFlag),
        .LessFlag(LessFlag)
        );
        
    ImmGen immGen (
            .Instr(im_to_rf),
            .outImm(imm32)
            );
    
    branch_condition bc (
            .branch(Branch),
            .LessFlag(LessFlag),
            .ZeroFlag(ZeroFlag),
            .PCAsrc(PCAsrc),
            .PCBsrc(PCBsrc)
            );
    wire [31:0]pca, pcb;
    mux_2x1 PCAmux  (
            .a(32'h00000004),
            .b(imm32),
            .s(PCAsrc),
            .q(pca)
            );
    mux_2x1 PCBmux (
            .a(rs1),
            .b(PC),
            .s(PCBsrc),
            .q(pcb)
            );
            
    
    assign next_pc = pca + pcb;
    ProgramCounter pc(
            .clk(clk),
            .clr(clr),
            .pc(PC),
            .next_pc(next_pc)
            );
            
    wire [31:0] mem_to_mux;
    mux_2x1 MEMmux (
            .a(result),
            .b(mem_to_mux),
            .s(memToReg),
            .q(data)
            );
    
    
    wire [7:0]tx_data, rx_data;
    wire ready, busy, send;
    data_mem dmem (
            .clk(clk),
            .rst(clr),
            .Addr(result[11:0]),
            .DataIn(rs2),
            .MemOp(memOp),
            .MemWr(memWr),
            .DataOut(mem_to_mux),
            .tx_data(tx_data),
            .rx_data(rx_data),
            .rx_ready(ready),
            .tx_busy(busy),
            .send(send)
            );
            
    uart uart(
            .clk(clk),
            .reset(clr),
            .send(send),
            .tx_data(tx_data),
            .rx(rx),
            .tx(tx),
            .busy(busy),
            .rx_data(rx_data),
            .rx_ready(ready)
            );
    initial begin
        clk = 0;
        clr = 1;
        
        #1000;
        $display("PC: %h, Instruction: %h, A: %d, B: %d, result: %d", PC, im_to_rf, muxa_to_alu, muxb_to_alu, result);
        #1000;
        $display("PC: %h, Instruction: %h, A: %d, B: %d, result: %d", PC, im_to_rf, muxa_to_alu, muxb_to_alu, result);
        #1000;
        $display("PC: %h, Instruction: %h, A: %d, B: %d, result: %d", PC, im_to_rf, muxa_to_alu, muxb_to_alu, result);        
        #1000;
        $display("PC: %h, Instruction: %h, A: %d, B: %d, result: %d", PC, im_to_rf, muxa_to_alu, muxb_to_alu, result);
        #1000;
        $display("PC: %h, Instruction: %h, A: %d, B: %d, result: %d", PC, im_to_rf, muxa_to_alu, muxb_to_alu, result);
        #1000;
        $display("PC: %h, Instruction: %h, A: %d, B: %d, result: %d", PC, im_to_rf, muxa_to_alu, muxb_to_alu, result);
        #1000;
        $display("PC: %h, Instruction: %h, A: %d, B: %d, result: %d", PC, im_to_rf, muxa_to_alu, muxb_to_alu, result);
        #1000;
        $display("PC: %h, Instruction: %h, A: %d, B: %d, result: %d", PC, im_to_rf, muxa_to_alu, muxb_to_alu, result);
        #1000;
        $display("PC: %h, Instruction: %h, A: %d, B: %d, result: %d", PC, im_to_rf, muxa_to_alu, muxb_to_alu, result);
        $finish;
        
    end
    
    always #500 clk = ~clk;
    
    
endmodule
