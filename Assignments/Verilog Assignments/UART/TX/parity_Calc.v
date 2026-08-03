module parity_Calc(
    input [7:0] pData,
    input dataValid,parTyp,
    input CLK,RST,
    output reg parBit
);
    // Calculating the number of odd ones
    wire oddCount;
    assign oddCount = ^pData;
    always @(posedge CLK) begin
        if(!RST) begin
            parBit <= 0;
        end
        else if (parTyp) begin
            parBit <= !(oddCount); // if it odd parity so if the number is odd assert parity bit to zero else to one
        end
        else if (!parTyp) begin
            parBit <= oddCount; // if the it even parity so if the number is odd assert parity bit to one else to zero
        end
    end
endmodule