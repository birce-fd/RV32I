`timescale 1ns / 1ps



module mux2_1(
input  in0,in1,s,
output c
    );
    assign c = s ? in1 : in0; 
endmodule
