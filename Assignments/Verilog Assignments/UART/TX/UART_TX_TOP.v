module UART_TX_TOP (
    input [7:0] pData,
    input dataValid,parEn,parTyp,
    input CLK,RST,
    output txOut,busy
);
    wire serDoneInternal,serEnInternal,regDataInternal,
         serDataInternal,
         parBitInternal;
    wire [1:0] muxSelInternal;
    UART_TX_FSM FSM_Block (
        .parEn(parEn),.serDone(serDoneInternal),.dataValid(dataValid),
        .CLK(CLK),.RST(RST),
        .serEn(serEnInternal),.busy(busy),.regData(regDataInternal),
        .muxSel(muxSelInternal)
    );
    Serializer Serializer_Block (
        .pData(pData),
        .serEn(serEnInternal),.regData(regDataInternal),
        .CLK(CLK),.RST(RST),
        .serData(serDataInternal),.serDone(serDoneInternal)
    );
    Parity_Calc Parity_Calc_Block (
        .pData(pData),
        .dataValid(dataValid),.parTyp(parTyp),
        .CLK(CLK),.RST(RST),
        .parBit(parBitInternal)
    );
    Mux_4X1 Mux_4X1_BLock (
        .A({1'b0,1'b1,serDataInternal,parBitInternal}),
        .S(muxSelInternal),
        .Y(txOut)
    );
endmodule //UART_TX_TOP