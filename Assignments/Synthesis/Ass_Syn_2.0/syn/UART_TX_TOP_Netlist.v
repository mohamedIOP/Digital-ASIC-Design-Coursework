/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : O-2018.06-SP1
// Date      : Sun Sep  6 10:07:54 2026
/////////////////////////////////////////////////////////////


module UART_TX_FSM ( parEn, serDone, dataValid, CLK, RST, serEn, busy, regData, 
        muxSel );
  output [1:0] muxSel;
  input parEn, serDone, dataValid, CLK, RST;
  output serEn, busy, regData;
  wire   N55, n5, n6, n7, n8, n9, n1, n2, n4;
  wire   [2:0] currentState;
  wire   [2:0] nextState;
  assign busy = N55;

  DFFRQX2M \currentState_reg[2]  ( .D(nextState[2]), .CK(CLK), .RN(RST), .Q(
        currentState[2]) );
  DFFRX4M \currentState_reg[0]  ( .D(nextState[0]), .CK(CLK), .RN(RST), .Q(
        currentState[0]), .QN(n1) );
  DFFRX2M \currentState_reg[1]  ( .D(nextState[1]), .CK(CLK), .RN(RST), .Q(
        currentState[1]), .QN(n2) );
  NAND3X12M U3 ( .A(n1), .B(n2), .C(n5), .Y(N55) );
  AOI32X1M U4 ( .A0(currentState[2]), .A1(n1), .A2(currentState[1]), .B0(n2), 
        .B1(n4), .Y(n8) );
  NAND2X2M U5 ( .A(currentState[1]), .B(n4), .Y(n7) );
  NOR2X2M U6 ( .A(n1), .B(n7), .Y(serEn) );
  INVX2M U7 ( .A(n7), .Y(muxSel[1]) );
  NAND2X2M U8 ( .A(n7), .B(muxSel[0]), .Y(nextState[1]) );
  NAND2X4M U9 ( .A(currentState[0]), .B(n4), .Y(muxSel[0]) );
  AND3X2M U10 ( .A(dataValid), .B(n1), .C(n5), .Y(regData) );
  INVX2M U11 ( .A(currentState[2]), .Y(n4) );
  AOI21X4M U12 ( .A0(n2), .A1(currentState[2]), .B0(muxSel[1]), .Y(n5) );
  OAI2B2X1M U13 ( .A1N(dataValid), .A0(n8), .B0(muxSel[0]), .B1(n9), .Y(
        nextState[0]) );
  AND2X2M U14 ( .A(serDone), .B(currentState[1]), .Y(n9) );
  NOR2X2M U15 ( .A(n6), .B(n7), .Y(nextState[2]) );
  AOI2B1X1M U16 ( .A1N(parEn), .A0(serDone), .B0(n1), .Y(n6) );
endmodule


module Serializer ( pData, serEn, regData, CLK, RST, serData, serDone );
  input [7:0] pData;
  input serEn, regData, CLK, RST;
  output serData, serDone;
  wire   N1, N2, N3, \counter[3] , n5, n6, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n1, n2, n3, n4, n7, n8, n9, n24,
         n25, n26, n27, n28, n29, n30, n31;
  wire   [7:0] pDataReg;

  DFFRQX2M \counter_reg[3]  ( .D(n20), .CK(CLK), .RN(RST), .Q(\counter[3] ) );
  DFFRQX2M \counter_reg[2]  ( .D(n21), .CK(CLK), .RN(RST), .Q(N3) );
  DFFRQX2M \pDataReg_reg[7]  ( .D(n19), .CK(CLK), .RN(RST), .Q(pDataReg[7]) );
  DFFRQX2M \pDataReg_reg[5]  ( .D(n17), .CK(CLK), .RN(RST), .Q(pDataReg[5]) );
  DFFRQX2M \pDataReg_reg[3]  ( .D(n15), .CK(CLK), .RN(RST), .Q(pDataReg[3]) );
  DFFRQX2M \pDataReg_reg[1]  ( .D(n13), .CK(CLK), .RN(RST), .Q(pDataReg[1]) );
  DFFRQX2M \pDataReg_reg[6]  ( .D(n18), .CK(CLK), .RN(RST), .Q(pDataReg[6]) );
  DFFRQX2M \pDataReg_reg[4]  ( .D(n16), .CK(CLK), .RN(RST), .Q(pDataReg[4]) );
  DFFRQX2M \pDataReg_reg[2]  ( .D(n14), .CK(CLK), .RN(RST), .Q(pDataReg[2]) );
  DFFRQX2M \pDataReg_reg[0]  ( .D(n12), .CK(CLK), .RN(RST), .Q(pDataReg[0]) );
  DFFRX4M \counter_reg[0]  ( .D(n23), .CK(CLK), .RN(RST), .Q(N1), .QN(n26) );
  DFFRX4M \counter_reg[1]  ( .D(n22), .CK(CLK), .RN(RST), .Q(N2), .QN(n25) );
  AOI22X2M U3 ( .A0(n31), .A1(n10), .B0(n28), .B1(n30), .Y(n11) );
  OAI21X2M U4 ( .A0(N2), .A1(n10), .B0(n11), .Y(n5) );
  INVX2M U5 ( .A(N3), .Y(n29) );
  INVX4M U6 ( .A(n10), .Y(n30) );
  INVX6M U7 ( .A(n2), .Y(n31) );
  OAI32X2M U8 ( .A0(n6), .A1(n28), .A2(n25), .B0(n27), .B1(n29), .Y(n21) );
  NAND2X2M U9 ( .A(n30), .B(n29), .Y(n6) );
  INVX2M U10 ( .A(n5), .Y(n27) );
  NAND2X4M U11 ( .A(serEn), .B(n31), .Y(n10) );
  CLKBUFX6M U12 ( .A(regData), .Y(n2) );
  OAI32X2M U13 ( .A0(n28), .A1(N2), .A2(n10), .B0(n11), .B1(n25), .Y(n22) );
  AO22X1M U14 ( .A0(n30), .A1(serDone), .B0(\counter[3] ), .B1(n1), .Y(n20) );
  AO21XLM U15 ( .A0(n30), .A1(n29), .B0(n5), .Y(n1) );
  OAI32X2M U16 ( .A0(n28), .A1(n2), .A2(n30), .B0(N1), .B1(n10), .Y(n23) );
  AO22X1M U17 ( .A0(pData[6]), .A1(n2), .B0(pDataReg[6]), .B1(n31), .Y(n18) );
  AO22X1M U18 ( .A0(pData[2]), .A1(n2), .B0(pDataReg[2]), .B1(n31), .Y(n14) );
  AO22X1M U19 ( .A0(pData[3]), .A1(n2), .B0(pDataReg[3]), .B1(n31), .Y(n15) );
  AO22X1M U20 ( .A0(pData[7]), .A1(n2), .B0(pDataReg[7]), .B1(n31), .Y(n19) );
  AO22X1M U21 ( .A0(pData[4]), .A1(n2), .B0(pDataReg[4]), .B1(n31), .Y(n16) );
  AO22X1M U22 ( .A0(pData[1]), .A1(n2), .B0(pDataReg[1]), .B1(n31), .Y(n13) );
  AO22X1M U23 ( .A0(pData[5]), .A1(n2), .B0(pDataReg[5]), .B1(n31), .Y(n17) );
  AO22X1M U24 ( .A0(n2), .A1(pData[0]), .B0(pDataReg[0]), .B1(n31), .Y(n12) );
  INVX4M U25 ( .A(N1), .Y(n28) );
  NOR4X4M U26 ( .A(n29), .B(n25), .C(n28), .D(\counter[3] ), .Y(serDone) );
  AOI22X1M U27 ( .A0(pDataReg[2]), .A1(n26), .B0(pDataReg[3]), .B1(N1), .Y(n4)
         );
  AOI22X1M U28 ( .A0(pDataReg[0]), .A1(n26), .B0(pDataReg[1]), .B1(N1), .Y(n3)
         );
  OA22X1M U29 ( .A0(n25), .A1(n4), .B0(N2), .B1(n3), .Y(n24) );
  AOI22X1M U30 ( .A0(pDataReg[6]), .A1(n26), .B0(pDataReg[7]), .B1(N1), .Y(n8)
         );
  AOI22X1M U31 ( .A0(pDataReg[4]), .A1(n26), .B0(pDataReg[5]), .B1(N1), .Y(n7)
         );
  OAI22X1M U32 ( .A0(n8), .A1(n25), .B0(N2), .B1(n7), .Y(n9) );
  OAI2BB2X1M U33 ( .B0(n24), .B1(N3), .A0N(N3), .A1N(n9), .Y(serData) );
endmodule


module Parity_Calc ( pData, parTyp, regData, CLK, RST, parBit );
  input [7:0] pData;
  input parTyp, regData, CLK, RST;
  output parBit;
  wire   n1, n3, n4, n5, n6, n7, n2;

  DFFRQX2M parBit_reg ( .D(n7), .CK(CLK), .RN(RST), .Q(parBit) );
  XOR3XLM U2 ( .A(pData[5]), .B(pData[4]), .C(n6), .Y(n3) );
  CLKXOR2X2M U3 ( .A(pData[7]), .B(pData[6]), .Y(n6) );
  XNOR2X2M U4 ( .A(pData[3]), .B(pData[2]), .Y(n5) );
  OAI2BB2X1M U5 ( .B0(n1), .B1(n2), .A0N(parBit), .A1N(n2), .Y(n7) );
  INVX2M U6 ( .A(regData), .Y(n2) );
  XOR3XLM U7 ( .A(n3), .B(parTyp), .C(n4), .Y(n1) );
  XOR3XLM U8 ( .A(pData[1]), .B(pData[0]), .C(n5), .Y(n4) );
endmodule


module Mux_4X1 ( A, S, Y );
  input [3:0] A;
  input [1:0] S;
  output Y;
  wire   n5, n2, n3, n4;

  CLKBUFX8M U1 ( .A(n5), .Y(Y) );
  OAI2B2X1M U2 ( .A1N(S[1]), .A0(n2), .B0(S[1]), .B1(n3), .Y(n5) );
  AOI22X1M U3 ( .A0(A[0]), .A1(n4), .B0(S[0]), .B1(A[1]), .Y(n3) );
  AOI22X1M U4 ( .A0(A[2]), .A1(n4), .B0(A[3]), .B1(S[0]), .Y(n2) );
  INVX2M U5 ( .A(S[0]), .Y(n4) );
endmodule


module UART_TX_TOP ( pData, dataValid, parEn, parTyp, CLK, RST, txOut, busy );
  input [7:0] pData;
  input dataValid, parEn, parTyp, CLK, RST;
  output txOut, busy;
  wire   serDoneInternal, serEnInternal, regDataInternal, serDataInternal,
         parBitInternal;
  wire   [1:0] muxSelInternal;

  UART_TX_FSM FSM_Block ( .parEn(parEn), .serDone(serDoneInternal), 
        .dataValid(dataValid), .CLK(CLK), .RST(RST), .serEn(serEnInternal), 
        .busy(busy), .regData(regDataInternal), .muxSel(muxSelInternal) );
  Serializer Serializer_Block ( .pData(pData), .serEn(serEnInternal), 
        .regData(regDataInternal), .CLK(CLK), .RST(RST), .serData(
        serDataInternal), .serDone(serDoneInternal) );
  Parity_Calc Parity_Calc_Block ( .pData(pData), .parTyp(parTyp), .regData(
        regDataInternal), .CLK(CLK), .RST(RST), .parBit(parBitInternal) );
  Mux_4X1 Mux_4X1_BLock ( .A({parBitInternal, serDataInternal, 1'b1, 1'b0}), 
        .S(muxSelInternal), .Y(txOut) );
endmodule

