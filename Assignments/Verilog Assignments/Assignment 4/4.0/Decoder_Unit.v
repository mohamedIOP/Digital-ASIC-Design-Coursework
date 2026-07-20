module Decoder_Unit (
    input [1:0] Input,
    output reg Zero,One,Two,Three
);
    always @(*) begin
        Zero = 0;
        One = 0;
        Two = 0;
        Three = 0;
        case (Input)
            2'b00: Zero = 1;
            2'b01: One = 1;
            2'b10: Two = 1;
            2'b11: Three = 1;
            default : begin
                Zero = 0;
                One = 0;
                Two = 0;
                Three = 0;
            end
        endcase
    end
endmodule //Decoder_Unit