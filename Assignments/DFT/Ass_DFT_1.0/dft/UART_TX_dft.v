/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : O-2018.06-SP1
// Date      : Sun Sep  6 08:40:30 2026
/////////////////////////////////////////////////////////////


module mux2X1_1 ( IN_0, IN_1, SEL, OUT );
  input IN_0, IN_1, SEL;
  output OUT;


  MX2X2M U1 ( .A(IN_0), .B(IN_1), .S0(SEL), .Y(OUT) );
endmodule


module mux2X1_0 ( IN_0, IN_1, SEL, OUT );
  input IN_0, IN_1, SEL;
  output OUT;


  MX2X2M U1 ( .A(IN_0), .B(IN_1), .S0(SEL), .Y(OUT) );
endmodule


module UART_TX_FSM_test_1 ( parEn, serDone, dataValid, CLK, RST, serEn, busy, 
        regData, muxSel, test_si, test_so, test_se );
  output [1:0] muxSel;
  input parEn, serDone, dataValid, CLK, RST, test_si, test_se;
  output serEn, busy, regData, test_so;
  wire   currentState_1_, currentState_0_, n5, n6, n7, n8, n9, n1, n2, n4;
  wire   [2:0] nextState;

  NAND3X2M U3 ( .A(n1), .B(n2), .C(n5), .Y(busy) );
  NOR2X2M U4 ( .A(n1), .B(n7), .Y(serEn) );
  INVX2M U5 ( .A(n7), .Y(muxSel[1]) );
  NAND2X2M U6 ( .A(n7), .B(muxSel[0]), .Y(nextState[1]) );
  AND3X2M U7 ( .A(dataValid), .B(n1), .C(n5), .Y(regData) );
  AOI21X2M U8 ( .A0(n2), .A1(test_so), .B0(muxSel[1]), .Y(n5) );
  NAND2X2M U9 ( .A(currentState_1_), .B(n4), .Y(n7) );
  NAND2X2M U10 ( .A(currentState_0_), .B(n4), .Y(muxSel[0]) );
  INVX2M U11 ( .A(test_so), .Y(n4) );
  OAI2B2X1M U12 ( .A1N(dataValid), .A0(n8), .B0(muxSel[0]), .B1(n9), .Y(
        nextState[0]) );
  AOI32X1M U13 ( .A0(test_so), .A1(n1), .A2(currentState_1_), .B0(n2), .B1(n4), 
        .Y(n8) );
  AND2X2M U14 ( .A(serDone), .B(currentState_1_), .Y(n9) );
  NOR2X2M U15 ( .A(n6), .B(n7), .Y(nextState[2]) );
  AOI2B1X1M U16 ( .A1N(parEn), .A0(serDone), .B0(n1), .Y(n6) );
  INVX2M U17 ( .A(currentState_0_), .Y(n1) );
  INVX2M U18 ( .A(currentState_1_), .Y(n2) );
  SDFFRQX2M currentState_reg_2_ ( .D(nextState[2]), .SI(currentState_1_), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(test_so) );
  SDFFRQX2M currentState_reg_0_ ( .D(nextState[0]), .SI(test_si), .SE(test_se), 
        .CK(CLK), .RN(RST), .Q(currentState_0_) );
  SDFFRQX2M currentState_reg_1_ ( .D(nextState[1]), .SI(currentState_0_), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(currentState_1_) );
endmodule


module Serializer_test_1 ( pData, serEn, regData, CLK, RST, serData, serDone, 
        test_si, test_so, test_se );
  input [7:0] pData;
  input serEn, regData, CLK, RST, test_si, test_se;
  output serData, serDone, test_so;
  wire   N1, N2, N3, counter_3_, pDataReg_6_, pDataReg_5_, pDataReg_4_,
         pDataReg_3_, pDataReg_2_, pDataReg_1_, pDataReg_0_, n5, n6, n10, n11,
         n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n1, n2,
         n3, n4, n7, n8, n9, n24, n25, n26, n27, n28, n29;

  INVX2M U3 ( .A(n10), .Y(n28) );
  OAI32X1M U4 ( .A0(n6), .A1(n26), .A2(n24), .B0(n25), .B1(n27), .Y(n21) );
  NAND2X2M U5 ( .A(n28), .B(n27), .Y(n6) );
  INVX2M U6 ( .A(n5), .Y(n25) );
  AOI22X1M U7 ( .A0(n29), .A1(n10), .B0(n26), .B1(n28), .Y(n11) );
  NAND2X2M U8 ( .A(serEn), .B(n29), .Y(n10) );
  INVX2M U9 ( .A(regData), .Y(n29) );
  OAI32X1M U10 ( .A0(n26), .A1(N2), .A2(n10), .B0(n11), .B1(n24), .Y(n22) );
  OAI32X1M U11 ( .A0(n26), .A1(regData), .A2(n28), .B0(N1), .B1(n10), .Y(n23)
         );
  OAI21X2M U12 ( .A0(N2), .A1(n10), .B0(n11), .Y(n5) );
  AO22X1M U13 ( .A0(n28), .A1(serDone), .B0(counter_3_), .B1(n1), .Y(n20) );
  AO21XLM U14 ( .A0(n28), .A1(n27), .B0(n5), .Y(n1) );
  INVX2M U15 ( .A(N2), .Y(n24) );
  AO22X1M U16 ( .A0(regData), .A1(pData[0]), .B0(pDataReg_0_), .B1(n29), .Y(
        n12) );
  AO22X1M U17 ( .A0(pData[1]), .A1(regData), .B0(pDataReg_1_), .B1(n29), .Y(
        n13) );
  AO22X1M U18 ( .A0(pData[2]), .A1(regData), .B0(pDataReg_2_), .B1(n29), .Y(
        n14) );
  AO22X1M U19 ( .A0(pData[3]), .A1(regData), .B0(pDataReg_3_), .B1(n29), .Y(
        n15) );
  AO22X1M U20 ( .A0(pData[4]), .A1(regData), .B0(pDataReg_4_), .B1(n29), .Y(
        n16) );
  AO22X1M U21 ( .A0(pData[5]), .A1(regData), .B0(pDataReg_5_), .B1(n29), .Y(
        n17) );
  AO22X1M U22 ( .A0(pData[6]), .A1(regData), .B0(pDataReg_6_), .B1(n29), .Y(
        n18) );
  AO22X1M U23 ( .A0(pData[7]), .A1(regData), .B0(test_so), .B1(n29), .Y(n19)
         );
  NOR4X1M U24 ( .A(n27), .B(n24), .C(n26), .D(counter_3_), .Y(serDone) );
  INVX2M U25 ( .A(N3), .Y(n27) );
  INVX2M U26 ( .A(N1), .Y(n26) );
  AOI22X1M U27 ( .A0(pDataReg_2_), .A1(n26), .B0(pDataReg_3_), .B1(N1), .Y(n3)
         );
  AOI22X1M U28 ( .A0(pDataReg_0_), .A1(n26), .B0(pDataReg_1_), .B1(N1), .Y(n2)
         );
  OA22X1M U29 ( .A0(n24), .A1(n3), .B0(N2), .B1(n2), .Y(n9) );
  AOI22X1M U30 ( .A0(pDataReg_6_), .A1(n26), .B0(test_so), .B1(N1), .Y(n7) );
  AOI22X1M U31 ( .A0(pDataReg_4_), .A1(n26), .B0(pDataReg_5_), .B1(N1), .Y(n4)
         );
  OAI22X1M U32 ( .A0(n7), .A1(n24), .B0(N2), .B1(n4), .Y(n8) );
  OAI2BB2X1M U33 ( .B0(n9), .B1(N3), .A0N(N3), .A1N(n8), .Y(serData) );
  SDFFRQX2M counter_reg_3_ ( .D(n20), .SI(N3), .SE(test_se), .CK(CLK), .RN(RST), .Q(counter_3_) );
  SDFFRQX2M pDataReg_reg_7_ ( .D(n19), .SI(pDataReg_6_), .SE(test_se), .CK(CLK), .RN(RST), .Q(test_so) );
  SDFFRQX2M pDataReg_reg_5_ ( .D(n17), .SI(pDataReg_4_), .SE(test_se), .CK(CLK), .RN(RST), .Q(pDataReg_5_) );
  SDFFRQX2M pDataReg_reg_3_ ( .D(n15), .SI(pDataReg_2_), .SE(test_se), .CK(CLK), .RN(RST), .Q(pDataReg_3_) );
  SDFFRQX2M pDataReg_reg_1_ ( .D(n13), .SI(pDataReg_0_), .SE(test_se), .CK(CLK), .RN(RST), .Q(pDataReg_1_) );
  SDFFRQX2M pDataReg_reg_6_ ( .D(n18), .SI(pDataReg_5_), .SE(test_se), .CK(CLK), .RN(RST), .Q(pDataReg_6_) );
  SDFFRQX2M pDataReg_reg_4_ ( .D(n16), .SI(pDataReg_3_), .SE(test_se), .CK(CLK), .RN(RST), .Q(pDataReg_4_) );
  SDFFRQX2M pDataReg_reg_2_ ( .D(n14), .SI(pDataReg_1_), .SE(test_se), .CK(CLK), .RN(RST), .Q(pDataReg_2_) );
  SDFFRQX2M pDataReg_reg_0_ ( .D(n12), .SI(counter_3_), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(pDataReg_0_) );
  SDFFRQX2M counter_reg_2_ ( .D(n21), .SI(N2), .SE(test_se), .CK(CLK), .RN(RST), .Q(N3) );
  SDFFRQX2M counter_reg_0_ ( .D(n23), .SI(test_si), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(N1) );
  SDFFRQX2M counter_reg_1_ ( .D(n22), .SI(N1), .SE(test_se), .CK(CLK), .RN(RST), .Q(N2) );
endmodule


module Parity_Calc_test_1 ( pData, parTyp, regData, CLK, RST, parBit, test_si, 
        test_se );
  input [7:0] pData;
  input parTyp, regData, CLK, RST, test_si, test_se;
  output parBit;
  wire   n1, n3, n4, n5, n6, n7, n2;

  XNOR2X2M U2 ( .A(pData[3]), .B(pData[2]), .Y(n5) );
  XOR3XLM U3 ( .A(pData[5]), .B(pData[4]), .C(n6), .Y(n3) );
  CLKXOR2X2M U4 ( .A(pData[7]), .B(pData[6]), .Y(n6) );
  OAI2BB2X1M U5 ( .B0(n1), .B1(n2), .A0N(parBit), .A1N(n2), .Y(n7) );
  INVX2M U6 ( .A(regData), .Y(n2) );
  XOR3XLM U7 ( .A(n3), .B(parTyp), .C(n4), .Y(n1) );
  XOR3XLM U8 ( .A(pData[1]), .B(pData[0]), .C(n5), .Y(n4) );
  SDFFRQX2M parBit_reg ( .D(n7), .SI(test_si), .SE(test_se), .CK(CLK), .RN(RST), .Q(parBit) );
endmodule


module Mux_4X1 ( A, S, Y );
  input [3:0] A;
  input [1:0] S;
  output Y;
  wire   n2, n3, n1;

  OAI2B2X4M U1 ( .A1N(S[1]), .A0(n2), .B0(S[1]), .B1(n3), .Y(Y) );
  AOI22X1M U2 ( .A0(A[0]), .A1(n1), .B0(S[0]), .B1(A[1]), .Y(n3) );
  AOI22X1M U3 ( .A0(A[2]), .A1(n1), .B0(A[3]), .B1(S[0]), .Y(n2) );
  INVX2M U4 ( .A(S[0]), .Y(n1) );
endmodule


module UART_TX_TOP ( SI, SE, test_mode, scan_clk, scan_rst, SO, pData, 
        dataValid, parEn, parTyp, CLK, RST, txOut, busy );
  input [7:0] pData;
  input SI, SE, test_mode, scan_clk, scan_rst, dataValid, parEn, parTyp, CLK,
         RST;
  output SO, txOut, busy;
  wire   CLK_MUXED, RST_MUXED, serDoneInternal, serEnInternal, regDataInternal,
         serDataInternal, parBitInternal, n3;
  wire   [1:0] muxSelInternal;

  mux2X1_1 mux2X1_CLK_SCAN ( .IN_0(CLK), .IN_1(scan_clk), .SEL(test_mode), 
        .OUT(CLK_MUXED) );
  mux2X1_0 mux2X1_RST_SCAN ( .IN_0(RST), .IN_1(scan_rst), .SEL(test_mode), 
        .OUT(RST_MUXED) );
  UART_TX_FSM_test_1 FSM_Block ( .parEn(parEn), .serDone(serDoneInternal), 
        .dataValid(dataValid), .CLK(CLK_MUXED), .RST(RST_MUXED), .serEn(
        serEnInternal), .busy(busy), .regData(regDataInternal), .muxSel(
        muxSelInternal), .test_si(SI), .test_so(n3), .test_se(SE) );
  Serializer_test_1 Serializer_Block ( .pData(pData), .serEn(serEnInternal), 
        .regData(regDataInternal), .CLK(CLK_MUXED), .RST(RST_MUXED), .serData(
        serDataInternal), .serDone(serDoneInternal), .test_si(parBitInternal), 
        .test_so(SO), .test_se(SE) );
  Parity_Calc_test_1 Parity_Calc_Block ( .pData(pData), .parTyp(parTyp), 
        .regData(regDataInternal), .CLK(CLK_MUXED), .RST(RST_MUXED), .parBit(
        parBitInternal), .test_si(n3), .test_se(SE) );
  Mux_4X1 Mux_4X1_BLock ( .A({parBitInternal, serDataInternal, 1'b1, 1'b0}), 
        .S(muxSelInternal), .Y(txOut) );
endmodule

