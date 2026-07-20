module Shift_Unit #(parameter inputWidth = 16,outputWidth = 32)(
    input [inputWidth - 1:0] A,B,
    input [1:0] Shift_FUN,
    input CLK,
    input RST,
    input Shift_Enable,
    output reg [outputWidth - 1:0] Shift_OUT,
    output reg Shift_Flag
);
    always @(posedge CLK or negedge RST) begin
        if (!RST) begin
            Shift_OUT <= 0;
            Shift_Flag <= 0;
        end
        else if (Shift_Enable) begin
            case (Shift_FUN)
                2'b00: begin 
                    Shift_OUT <= A >> 1;
                    Shift_Flag <= 1;
                end
                2'b01: begin
                    Shift_OUT <= A << 1;
                    Shift_Flag <= 1;
                end
                2'b10: begin 
                    Shift_OUT <= B >> 1;
                    Shift_Flag <= 1;
                end
                2'b11: begin 
                    Shift_OUT <= B << 1;
                    Shift_Flag <= 1;
                end
                default : begin 
                    Shift_OUT <= 0;
                    Shift_Flag <= 0;
                end
            endcase
        end
        else begin
            Shift_OUT <= 0;
            Shift_Flag <= 0;
        end
    end
endmodule //Shift_Unit