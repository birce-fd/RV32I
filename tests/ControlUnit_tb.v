`timescale 1ns / 1ps

module ControlUnit_tb;

    // Giriş sinyalleri
    reg [31:0] instr;

    // Çıkış sinyalleri
    wire ALUAsrc;
    wire [1:0] ALUBsrc;
    wire [3:0] ALUctrl;
    wire [2:0] Branch;
    wire memToReg;
    wire [2:0] MemOp;
    wire MemWr;
    wire RegWr;

    // ControlUnit modülünü örnekle
    ControlUnit controlUnit (
        .instr(instr),
        .ALUAsrc(ALUAsrc),
        .ALUBsrc(ALUBsrc),
        .ALUctrl(ALUctrl),
        .Branch(Branch),
        .memToReg(memToReg),
        .MemOp(MemOp),
        .MemWr(MemWr),
        .RegWr(RegWr)
    );

    // Test işlemleri
    initial begin
        // Test 1: LUI
        instr = 32'b00000000000000000000000000110111; // LUI
        #10; 
        $display("LUI -> ALUAsrc: %b, ALUBsrc: %b, ALUctrl: %b, Branch: %b, memToReg: %b, MemOp: %b, MemWr: %b, RegWr: %b", 
                 ALUAsrc, ALUBsrc, ALUctrl, Branch, memToReg, MemOp, MemWr, RegWr);
        
        // Test 2: ADDI
        instr = 32'b00000000000000000000000000010011; // ADDI
        #10; 
        $display("ADDI -> ALUAsrc: %b, ALUBsrc: %b, ALUctrl: %b, Branch: %b, memToReg: %b, MemOp: %b, MemWr: %b, RegWr: %b", 
                 ALUAsrc, ALUBsrc, ALUctrl, Branch, memToReg, MemOp, MemWr, RegWr);
        
        // Test 3: SLT
        instr = 32'b00000000000000000000000000110011; // SLT
        #10; 
        $display("SLT -> ALUAsrc: %b, ALUBsrc: %b, ALUctrl: %b, Branch: %b, memToReg: %b, MemOp: %b, MemWr: %b, RegWr: %b", 
                 ALUAsrc, ALUBsrc, ALUctrl, Branch, memToReg, MemOp, MemWr, RegWr);
        
        // Test 4: JAL
        instr = 32'b00000000000000000000000001101111; // JAL
        #10; 
        $display("JAL -> ALUAsrc: %b, ALUBsrc: %b, ALUctrl: %b, Branch: %b, memToReg: %b, MemOp: %b, MemWr: %b, RegWr: %b", 
                 ALUAsrc, ALUBsrc, ALUctrl, Branch, memToReg, MemOp, MemWr, RegWr);

        // Test 5: SW
        instr = 32'b00000000000000000000000000100011; // SW
        #10; 
        $display("SW -> ALUAsrc: %b, ALUBsrc: %b, ALUctrl: %b, Branch: %b, memToReg: %b, MemOp: %b, MemWr: %b, RegWr: %b", 
                 ALUAsrc, ALUBsrc, ALUctrl, Branch, memToReg, MemOp, MemWr, RegWr);

        // Test 6: LW
        instr = 32'b00000000000000000000000000000011; // LW
        #10; 
        $display("LW -> ALUAsrc: %b, ALUBsrc: %b, ALUctrl: %b, Branch: %b, memToReg: %b, MemOp: %b, MemWr: %b, RegWr: %b", 
                 ALUAsrc, ALUBsrc, ALUctrl, Branch, memToReg, MemOp, MemWr, RegWr);
        
        // Test tamamlandığında simülasyonu durdur
        $finish;
    end

endmodule
