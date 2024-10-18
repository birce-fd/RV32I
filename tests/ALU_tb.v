`timescale 1ns / 1ps

module ALU_tb;

    // Giriş sinyalleri
    reg [31:0] a;
    reg [31:0] b;
    reg [3:0] ctrl;

    // Çıkış sinyalleri
    wire [31:0] result;
    wire zeroFlag;
    wire LessFlag;

    // ALU modülünü örnekle
    ALU alu (
        .a(a),
        .b(b),
        .ctrl(ctrl),
        .result(result),
        .zeroFlag(zeroFlag),
        .LessFlag(LessFlag)
    );

    // Test işlemleri
    initial begin
        // Test 1: ADD
        a = 32'd15; 
        b = 32'd10; 
        ctrl = 4'b0000; 
        #10; 
        $display("ADD: %d + %d = %d, Zero: %b, Less: %b", a, b, result, zeroFlag, LessFlag);
        
        // Test 2: SLT (Signed Less Than)
        a = 32'd10; 
        b = 32'd15; 
        ctrl = 4'b0001; 
        #10; 
        $display("SLT: %d < %d = %d, Zero: %b, Less: %b", a, b, result, zeroFlag, LessFlag);
        
        // Test 3: SLTIU (Unsigned Less Than)
        a = 32'd15; 
        b = 32'd10; 
        ctrl = 4'b0010; 
        #10; 
        $display("SLTIU: %d < %d = %d, Zero: %b, Less: %b", a, b, result, zeroFlag, LessFlag);
        
        // Test 4: XOR
        a = 32'd15; 
        b = 32'd10; 
        ctrl = 4'b0011; 
        #10; 
        $display("XOR: %d ^ %d = %d, Zero: %b, Less: %b", a, b, result, zeroFlag, LessFlag);
        
        // Test 5: OR
        a = 32'd15; 
        b = 32'd10; 
        ctrl = 4'b0100; 
        #10; 
        $display("OR: %d | %d = %d, Zero: %b, Less: %b", a, b, result, zeroFlag, LessFlag);
        
        // Test 6: AND
        a = 32'd15; 
        b = 32'd10; 
        ctrl = 4'b0111; 
        #10; 
        $display("AND: %d & %d = %d, Zero: %b, Less: %b", a, b, result, zeroFlag, LessFlag);
        
        // Test 7: SLL (Shift Left Logical)
        a = 32'd1; 
        b = 32'd2; 
        ctrl = 4'b1000; 
        #10; 
        $display("SLL: %d << %d = %d, Zero: %b, Less: %b", a, b[4:0], result, zeroFlag, LessFlag);
        
        // Test 8: SRL (Shift Right Logical)
        a = 32'd4; 
        b = 32'd1; 
        ctrl = 4'b1001; 
        #10; 
        $display("SRL: %d >> %d = %d, Zero: %b, Less: %b", a, b[4:0], result, zeroFlag, LessFlag);
        
        // Test 9: SRA (Shift Right Arithmetic)
        a = 32'd4; 
        b = 32'd1; 
        ctrl = 4'b1010; 
        #10; 
        $display("SRA: %d >>> %d = %d, Zero: %b, Less: %b", a, b[4:0], result, zeroFlag, LessFlag);
        
        // Test 10: SUB
        a = 32'd15; 
        b = 32'd10; 
        ctrl = 4'b1011; 
        #10; 
        $display("SUB: %d - %d = %d, Zero: %b, Less: %b", a, b, result, zeroFlag, LessFlag);
        
        // Test tamamlandığında simülasyonu durdur
        $finish;
    end

endmodule
