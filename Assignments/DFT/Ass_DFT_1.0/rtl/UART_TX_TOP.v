module UART_TX_TOP (
    input SI,
    input SE,
    input test_mode,
    input scan_clk,
    input scan_rst,
    output SO,
    input [7:0] pData,
    input dataValid,parEn,parTyp,
    input CLK,RST,
    output txOut,busy
);
    wire serDoneInternal,serEnInternal,regDataInternal,
         serDataInternal,
         parBitInternal;
    wire [1:0] muxSelInternal;
    wire CLK_MUXED;
    wire RST_MUXED;
    
    mux2X1 mux2X1_CLK_SCAN (
        .IN_0(CLK),
        .IN_1(scan_clk),
        .SEL(test_mode),
        .OUT(CLK_MUXED)
    );

    mux2X1 mux2X1_RST_SCAN (
        .IN_0(RST),
        .IN_1(scan_rst),
        .SEL(test_mode),
        .OUT(RST_MUXED)
    );

    UART_TX_FSM FSM_Block (
        .parEn(parEn),.serDone(serDoneInternal),.dataValid(dataValid),
        .CLK(CLK_MUXED),.RST(RST_MUXED),
        .serEn(serEnInternal),.busy(busy),.regData(regDataInternal),
        .muxSel(muxSelInternal)
    );
    Serializer Serializer_Block (
        .pData(pData),
        .serEn(serEnInternal),.regData(regDataInternal),
        .CLK(CLK_MUXED),.RST(RST_MUXED),
        .serData(serDataInternal),.serDone(serDoneInternal)
    );
    Parity_Calc Parity_Calc_Block (
        .pData(pData),
        .parTyp(parTyp),.regData(regDataInternal),
        .CLK(CLK_MUXED),.RST(RST_MUXED),
        .parBit(parBitInternal)
    );
    Mux_4X1 Mux_4X1_BLock (
        .A({parBitInternal,serDataInternal,1'b1,1'b0}),
        .S(muxSelInternal),
        .Y(txOut)
    );
endmodule //UART_TX_TOP