module Arithmetic_Unit #(parameter inputWidth = 16,outputWidth = 32) (
    input signed [inputWidth - 1:0] A,B,
    input [1:0] ARITHMETIC_FUN,
    input RST,
    input CLK,
    input Arith_Enable,
    output reg signed [outputWidth - 1:0] Arith_OUT,
    output reg Arith_Flag
);
    reg signed [outputWidth - 1:0] Arith_OUT_D;
    wire Arith_Flag_D;
    assign Arith_Flag_D = Arith_Enable;
    always @(posedge CLK or negedge RST) begin
        if (!RST) begin
            Arith_Flag <= 0;
        end
        else
            Arith_Flag <= Arith_Flag_D;
    end
    always @(posedge CLK or negedge RST) begin
        if (!RST) begin
            Arith_OUT <= 0;
        end
        else begin
            Arith_OUT <= Arith_OUT_D;
        end
    end
    always @(*) begin
        if (Arith_Enable) begin
            case (ARITHMETIC_FUN)
                2'b00: Arith_OUT_D = A + B;
                2'b01: Arith_OUT_D = A - B;
                2'b10: Arith_OUT_D = A * B;
                2'b11: Arith_OUT_D = A / B;
                default: Arith_OUT_D = 'b0;
            endcase
        end
        else
            Arith_OUT_D = 'b0;
    end
endmodule //Arithmetic_Unit