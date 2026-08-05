/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : O-2018.06-SP1
// Date      : Sun Aug  2 08:02:44 2026
/////////////////////////////////////////////////////////////


module Up_Dn_Counter ( IN, Load, Up, Down, clk, Counter, High, Low );
  input [4:0] IN;
  output [4:0] Counter;
  input Load, Up, Down, clk;
  output High, Low;
  wire   n19, n20, n21, n22, n23, n25, n26, n27, n28, n29, n30, n31, n32, n33,
         n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47,
         n48, n49, n50, n51, n52, n53, n54, n55, n56;

  DFFQX2M \Counter_reg[4]  ( .D(n22), .CK(clk), .Q(Counter[4]) );
  DFFQX2M \Counter_reg[3]  ( .D(n21), .CK(clk), .Q(Counter[3]) );
  DFFQX2M \Counter_reg[2]  ( .D(n20), .CK(clk), .Q(Counter[2]) );
  DFFQX2M \Counter_reg[1]  ( .D(n19), .CK(clk), .Q(Counter[1]) );
  DFFQX2M \Counter_reg[0]  ( .D(n23), .CK(clk), .Q(Counter[0]) );
  OAI2BB1X1M U25 ( .A0N(Load), .A1N(IN[0]), .B0(n25), .Y(n23) );
  MXI2X1M U26 ( .A(n26), .B(n27), .S0(Counter[0]), .Y(n25) );
  OAI221X1M U27 ( .A0(n28), .A1(n29), .B0(n30), .B1(n31), .C0(n32), .Y(n22) );
  CLKNAND2X2M U28 ( .A(IN[4]), .B(Load), .Y(n32) );
  XOR3XLM U29 ( .A(Counter[4]), .B(n33), .C(n34), .Y(n29) );
  OAI2BB2X1M U30 ( .B0(n35), .B1(n36), .A0N(n37), .A1N(n38), .Y(n34) );
  NOR2X1M U31 ( .A(n38), .B(n37), .Y(n35) );
  OAI221X1M U32 ( .A0(n28), .A1(n39), .B0(n36), .B1(n31), .C0(n40), .Y(n21) );
  CLKNAND2X2M U33 ( .A(IN[3]), .B(Load), .Y(n40) );
  XOR3XLM U34 ( .A(Counter[3]), .B(n33), .C(n37), .Y(n39) );
  OAI2BB1X1M U35 ( .A0N(n41), .A1N(n38), .B0(n42), .Y(n37) );
  OAI21X1M U36 ( .A0(n38), .A1(n41), .B0(Counter[2]), .Y(n42) );
  OAI221X1M U37 ( .A0(n28), .A1(n43), .B0(n44), .B1(n31), .C0(n45), .Y(n20) );
  CLKNAND2X2M U38 ( .A(IN[2]), .B(Load), .Y(n45) );
  XOR3XLM U39 ( .A(Counter[2]), .B(n33), .C(n41), .Y(n43) );
  OAI21X1M U40 ( .A0(n46), .A1(n33), .B0(n47), .Y(n41) );
  OAI221X1M U41 ( .A0(n48), .A1(n28), .B0(n49), .B1(n31), .C0(n50), .Y(n19) );
  CLKNAND2X2M U42 ( .A(IN[1]), .B(Load), .Y(n50) );
  CLKINVX1M U43 ( .A(n27), .Y(n31) );
  NOR2X1M U44 ( .A(Load), .B(n26), .Y(n27) );
  CLKINVX1M U45 ( .A(n26), .Y(n28) );
  AOI21X1M U46 ( .A0(n33), .A1(n51), .B0(Load), .Y(n26) );
  NAND3BX1M U47 ( .AN(High), .B(n52), .C(Up), .Y(n51) );
  NOR4X1M U48 ( .A(n30), .B(n36), .C(n44), .D(n47), .Y(High) );
  AOI21X1M U49 ( .A0(n53), .A1(n49), .B0(n54), .Y(n48) );
  MXI2X1M U50 ( .A(n55), .B(n47), .S0(n38), .Y(n54) );
  CLKNAND2X2M U51 ( .A(Counter[1]), .B(Counter[0]), .Y(n47) );
  CLKNAND2X2M U52 ( .A(Counter[1]), .B(n56), .Y(n55) );
  CLKINVX1M U53 ( .A(Counter[1]), .Y(n49) );
  CLKXOR2X2M U54 ( .A(n56), .B(n33), .Y(n53) );
  CLKINVX1M U55 ( .A(n38), .Y(n33) );
  NOR2X1M U56 ( .A(n52), .B(Low), .Y(n38) );
  CLKINVX1M U57 ( .A(Down), .Y(n52) );
  CLKINVX1M U58 ( .A(Counter[0]), .Y(n56) );
  AND4X1M U59 ( .A(n46), .B(n36), .C(n30), .D(n44), .Y(Low) );
  CLKINVX1M U60 ( .A(Counter[2]), .Y(n44) );
  CLKINVX1M U61 ( .A(Counter[4]), .Y(n30) );
  CLKINVX1M U62 ( .A(Counter[3]), .Y(n36) );
  NOR2X1M U63 ( .A(Counter[0]), .B(Counter[1]), .Y(n46) );
endmodule

