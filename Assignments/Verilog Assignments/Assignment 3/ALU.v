module ALU(
    input [15:0] A,B,
    input [3:0] ALU_FUN,
    input CLK,
    output reg [15:0] ALU_OUT,
    output reg Carry_Flag,
    output Arith_Flag,Logic_Flag,CMP_Flag,Shift_Flag
);
    reg [15:0] ALU_OUT_Comb;
    assign  Arith_Flag = (!ALU_FUN[2] && !ALU_FUN[3]),
            Logic_Flag = (!ALU_FUN[3] && ALU_FUN[2]) || (ALU_FUN[3] && !ALU_FUN[2] && !ALU_FUN[1]),
            CMP_Flag = (ALU_FUN[3] && !ALU_FUN[2] && ALU_FUN[1]) || (ALU_FUN[3] && ALU_FUN[2] && !ALU_FUN[1] && !ALU_FUN[0]),
            Shift_Flag = (ALU_FUN[3] && ALU_FUN[2] && !ALU_FUN[1] && ALU_FUN[0]) || (ALU_FUN[3] && ALU_FUN[2] && ALU_FUN[1] && !ALU_FUN[0]);
    always @(posedge CLK) begin
        ALU_OUT <= ALU_OUT_Comb;
    end
    always @(*) begin
        Carry_Flag = 0; // default value
        case (ALU_FUN)
            4'b0000: {Carry_Flag, ALU_OUT_Comb} = {1'b0, A} + {1'b0, B};
            4'b0001: {Carry_Flag, ALU_OUT_Comb} = {1'b0, A} - {1'b0, B};
            4'b0010: ALU_OUT_Comb = A * B;
            4'b0011: ALU_OUT_Comb = A / B;
            4'b0100: ALU_OUT_Comb = A & B;
            4'b0101: ALU_OUT_Comb = A | B;
            4'b0110: ALU_OUT_Comb = ~(A & B);
            4'b0111: ALU_OUT_Comb = ~(A | B);
            4'b1000: ALU_OUT_Comb = (A ^ B);
            4'b1001: ALU_OUT_Comb = (A ~^ B);
            4'b1010: ALU_OUT_Comb = (A == B) ? 16'd1 : 16'd0;
            4'b1011: ALU_OUT_Comb = (A > B)  ? 16'd2 : 16'd0;
            4'b1100: ALU_OUT_Comb = (A < B)  ? 16'd3 : 16'd0;
            4'b1101: ALU_OUT_Comb = A >> 1;
            4'b1110: ALU_OUT_Comb = A << 1;
            default: ALU_OUT_Comb = 0;
        endcase
    end
endmodule
