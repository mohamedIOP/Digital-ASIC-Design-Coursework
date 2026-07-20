module Logic_Unit #(parameter inputWidth = 16,outputWidth = 32)(
    input [inputWidth - 1:0] A,B,
    input [1:0] Logic_FUN,
    input CLK,
    input RST,
    input Logic_Enable,
    output reg [outputWidth - 1:0] Logic_OUT,
    output reg Logic_Flag
);
    always @(posedge CLK or negedge RST) begin
        if (!RST) begin
            Logic_OUT <= 0;
            Logic_Flag <= 0;
        end
        else if (Logic_Enable) begin
            case (Logic_FUN)
                2'b00: begin 
                    Logic_OUT <= A & B;
                    Logic_Flag <= 1;
                end
                2'b01: begin
                    Logic_OUT <= A | B;
                    Logic_Flag <= 1;
                end
                2'b10: begin 
                    Logic_OUT <= ~(A & B);
                    Logic_Flag <= 1;
                end
                2'b11: begin 
                    Logic_OUT <= ~(A | B);
                    Logic_Flag <= 1;
                end
                default : begin 
                    Logic_OUT <= 0;
                    Logic_Flag <= 0;
                end
            endcase
        end
        else begin
            Logic_OUT <= 0;
            Logic_Flag <= 0;
        end
    end
endmodule //Logic_Unit