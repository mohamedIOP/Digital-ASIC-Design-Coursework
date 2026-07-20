module ALU_TOP #(parameter inputWidth = 16,outputWidth = 16) (
    input [inputWidth - 1:0] A,B,
    input [3:0] ALU_FUN,
    input CLK,
    input RST,
    output [outputWidth*2 - 1:0] Arith_OUT,
    output [outputWidth - 1:0] Logic_OUT,Cmp_OUT,Shift_OUT,
    output Arith_Flag,Logic_Flag,Cmp_Flag,Shift_Flag
);
    wire Arith_Enable,Logic_Enable,Cmp_Enable,Shift_Enable;
    Decoder_Unit Decoder_Unit_Block (.Input(ALU_FUN[3:2]),.Zero(Arith_Enable),.One(Logic_Enable),.Two(Cmp_Enable),.Three(Shift_Enable));
    Arithmetic_Unit #(.inputWidth(inputWidth),.outputWidth(outputWidth*2)) Arithmetic_Unit_Block 
    (.A(A),.B(B)
    ,.ARITHMETIC_FUN(ALU_FUN[1:0]),.RST(RST),.CLK(CLK),.Arith_Enable(Arith_Enable)
    ,.Arith_OUT(Arith_OUT),.Arith_Flag(Arith_Flag));
    Logic_Unit #(.inputWidth(inputWidth),.outputWidth(outputWidth)) Logic_Unit_Block
    (.A(A),.B(B)
    ,.Logic_FUN(ALU_FUN[1:0]),.RST(RST),.CLK(CLK),.Logic_Enable(Logic_Enable)
    ,.Logic_OUT(Logic_OUT),.Logic_Flag(Logic_Flag));
    Cmp_Unit #(.inputWidth(inputWidth),.outputWidth(outputWidth)) Cmp_Unit_Block
    (.A(A),.B(B)
    ,.Cmp_FUN(ALU_FUN[1:0]),.RST(RST),.CLK(CLK),.Cmp_Enable(Cmp_Enable)
    ,.Cmp_OUT(Cmp_OUT),.Cmp_Flag(Cmp_Flag));
    Shift_Unit #(.inputWidth(inputWidth),.outputWidth(outputWidth)) Shift_Unit_Block
    (.A(A),.B(B)
    ,.Shift_FUN(ALU_FUN[1:0]),.RST(RST),.CLK(CLK),.Shift_Enable(Shift_Enable)
    ,.Shift_OUT(Shift_OUT),.Shift_Flag(Shift_Flag));
endmodule //ALU_TOP