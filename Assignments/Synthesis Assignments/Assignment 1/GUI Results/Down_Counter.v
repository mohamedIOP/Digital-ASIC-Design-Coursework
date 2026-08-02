/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : O-2018.06-SP1
// Date      : Sun Aug  2 08:37:32 2026
/////////////////////////////////////////////////////////////


module Down_Counter ( clock, in, latch, dec, zero );
  input [3:0] in;
  input clock, latch, dec;
  output zero;
  wire   n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26,
         n27, n28, n29;
  wire   [3:0] counter;

  DFFQX2M \counter_reg[3]  ( .D(n15), .CK(clock), .Q(counter[3]) );
  DFFQX2M \counter_reg[2]  ( .D(n14), .CK(clock), .Q(counter[2]) );
  DFFQX2M \counter_reg[1]  ( .D(n13), .CK(clock), .Q(counter[1]) );
  DFFQX2M \counter_reg[0]  ( .D(n16), .CK(clock), .Q(counter[0]) );
  OAI21X1M U18 ( .A0(counter[0]), .A1(n17), .B0(n18), .Y(n16) );
  MXI2X1M U19 ( .A(in[0]), .B(n19), .S0(n20), .Y(n18) );
  AND2X1M U20 ( .A(counter[0]), .B(n17), .Y(n19) );
  AO2B2X1M U21 ( .B0(in[3]), .B1(latch), .A0(counter[3]), .A1N(n21), .Y(n15)
         );
  OA21X1M U22 ( .A0(n22), .A1(n17), .B0(n23), .Y(n21) );
  OAI221X1M U23 ( .A0(n24), .A1(n17), .B0(n23), .B1(n22), .C0(n25), .Y(n14) );
  CLKNAND2X2M U24 ( .A(in[2]), .B(latch), .Y(n25) );
  CLKINVX1M U25 ( .A(counter[2]), .Y(n22) );
  AOI21X1M U26 ( .A0(n26), .A1(counter[1]), .B0(n27), .Y(n23) );
  OAI2BB1X1M U27 ( .A0N(in[1]), .A1N(latch), .B0(n28), .Y(n13) );
  MXI2X1M U28 ( .A(n29), .B(n27), .S0(counter[1]), .Y(n28) );
  CLKMX2X2M U29 ( .A(n20), .B(counter[0]), .S0(n26), .Y(n27) );
  CLKINVX1M U30 ( .A(latch), .Y(n20) );
  NOR2X1M U31 ( .A(counter[0]), .B(n17), .Y(n29) );
  CLKINVX1M U32 ( .A(n26), .Y(n17) );
  NOR3BX1M U33 ( .AN(dec), .B(zero), .C(latch), .Y(n26) );
  NOR2X1M U34 ( .A(n24), .B(counter[3]), .Y(zero) );
  OR3X1M U35 ( .A(counter[1]), .B(counter[2]), .C(counter[0]), .Y(n24) );
endmodule

