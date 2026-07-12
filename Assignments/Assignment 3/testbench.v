`timescale 1us/1ns
module ALU_TB;
    reg [15:0] A_TB,B_TB;
    reg [3:0] ALU_FUN_TB;
    reg CLK_TB;
    wire [15:0] ALU_OUT_TB;
    wire Carry_Flag_TB,Arith_Flag_TB,Logic_Flag_TB,CMP_Flag_TB,Shift_Flag_TB;
    ALU DUT_ALU (
        .A(A_TB),.B(B_TB),
        .ALU_FUN(ALU_FUN_TB),
        .CLK(CLK_TB),
        .ALU_OUT(ALU_OUT_TB),
        .Carry_Flag(Carry_Flag_TB),.Arith_Flag(Arith_Flag_TB),.Logic_Flag(Logic_Flag_TB),.CMP_Flag(CMP_Flag_TB),.Shift_Flag(Shift_Flag_TB)
    );
    initial begin
        CLK_TB = 0;
        forever begin
            #5 CLK_TB = ~CLK_TB;
        end
    end
    initial begin
        $monitor("At Time: %0t,ALU_OUT: %0b_%0b_%b_%0b,C_F: %0b,A_F: %0b,L_F: %0b,CMP_F: %0b,S_F: %0b",$time
                ,ALU_OUT_TB[15:12],ALU_OUT_TB[11:8],ALU_OUT_TB[7:4],ALU_OUT_TB[3:0]
                ,Carry_Flag_TB,Arith_Flag_TB,Logic_Flag_TB,CMP_Flag_TB,Shift_Flag_TB);
    end
    initial begin
        $dumpfile("ALU_TB.vcd");
        $dumpvars;
    end
    initial fork 
        A_TB = 16'hF;B_TB = 16'hF;ALU_FUN_TB = 4'h0;
        // Base Cases
        #10 ALU_FUN_TB = 4'h1;
        #20 ALU_FUN_TB = 4'h2;
        #30 ALU_FUN_TB = 4'h3;
        #40 ALU_FUN_TB = 4'h4;
        #50 ALU_FUN_TB = 4'h5;
        #60 ALU_FUN_TB = 4'h6;
        #70 ALU_FUN_TB = 4'h7;
        #80 ALU_FUN_TB = 4'h8;
        #90 ALU_FUN_TB = 4'h9;
        #100 ALU_FUN_TB = 4'hA;
        #110 ALU_FUN_TB = 4'hB;
        #120 ALU_FUN_TB = 4'hC;
        #130 ALU_FUN_TB = 4'hD;
        #140 ALU_FUN_TB = 4'hE;
        #150 ALU_FUN_TB = 4'hF;
        // Corner Cases
        #160 A_TB = 16'h8000;#160 B_TB = 16'h8000;
        #170 ALU_FUN_TB = 4'h0; // Carry Test Addition
        #180 A_TB = 16'h0000;#180 B_TB = 16'h8000;
        #190 ALU_FUN_TB = 4'h1; // Carry Test Subtracion,Smaller Than
        #200 A_TB = 16'h1000;#200 B_TB = 16'h0100;
        #210 ALU_FUN_TB = 4'b1011; // A > B
        #220 A_TB = 16'h8000;#220 ALU_FUN_TB = 4'b1110; // All Zero by shift left
        #230 A_TB = 16'h0001;#230 ALU_FUN_TB = 4'b1101; // All Zero by shift right
        #250 $finish;
    join
endmodule
