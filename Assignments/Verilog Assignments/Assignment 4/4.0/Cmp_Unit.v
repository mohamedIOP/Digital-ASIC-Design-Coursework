module Cmp_Unit #(parameter inputWidth = 16,outputWidth = 32)(
    input signed [inputWidth - 1:0] A,B,
    input [1:0] Cmp_FUN,
    input CLK,
    input RST,
    input Cmp_Enable,
    output reg [outputWidth - 1:0] Cmp_OUT,
    output reg Cmp_Flag
);
    always @(posedge CLK or negedge RST) begin
        if (!RST) begin
            Cmp_OUT <= 0;
            Cmp_Flag <= 0;
        end
        else if (Cmp_Enable) begin
            case (Cmp_FUN)
                2'b00: begin  // NOP (ALU_FUN=1000)
                    Cmp_OUT <= 0;
                    Cmp_Flag <= 1;
                end
                2'b01: begin  // A == B (ALU_FUN=1001)
                    Cmp_OUT <= (A == B) ? 1 : 0;
                    Cmp_Flag <= 1;
                end
                2'b10: begin  // A > B (ALU_FUN=1010)
                    Cmp_OUT <= (A > B) ? 2 : 0;
                    Cmp_Flag <= 1;
                end
                2'b11: begin  // A < B (ALU_FUN=1011)
                    Cmp_OUT <= (A < B) ? 3 : 0;
                    Cmp_Flag <= 1;
                end
            endcase
        end
        else begin
            Cmp_OUT <= 0;
            Cmp_Flag <= 0;
        end
    end
endmodule //Cmp_Unit