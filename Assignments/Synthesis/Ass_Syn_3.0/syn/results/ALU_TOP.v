/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : O-2018.06-SP1
// Date      : Thu Sep 10 13:06:08 2026
/////////////////////////////////////////////////////////////


module add_unit_DW01_add_0 ( A, B, CI, SUM, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] SUM;
  input CI;
  output CO;
  wire   n1, n2, n3, n4, n5;
  wire   [8:1] carry;

  ADDFHX8M U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(SUM[4])
         );
  ADDFHX8M U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(SUM[6])
         );
  ADDFHX8M U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(SUM[5])
         );
  ADDFHX8M U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(SUM[2])
         );
  ADDFHX8M U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(SUM[3])
         );
  ADDFHX8M U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(SUM[8]), .S(SUM[7])
         );
  CLKNAND2X8M U1 ( .A(n4), .B(A[1]), .Y(n2) );
  CLKNAND2X8M U2 ( .A(n4), .B(B[1]), .Y(n5) );
  CLKAND2X16M U3 ( .A(B[0]), .B(A[0]), .Y(n4) );
  CLKNAND2X12M U4 ( .A(n2), .B(n5), .Y(n1) );
  OR2X12M U5 ( .A(n3), .B(n1), .Y(carry[2]) );
  AND2X2M U6 ( .A(B[1]), .B(A[1]), .Y(n3) );
  XOR3XLM U7 ( .A(n4), .B(B[1]), .C(A[1]), .Y(SUM[1]) );
  CLKXOR2X2M U8 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module add_unit ( clk, rst_n, en, a, b, sum, cout, valid );
  input [7:0] a;
  input [7:0] b;
  output [7:0] sum;
  input clk, rst_n, en;
  output cout, valid;
  wire   en_reg, n2, n3, n4, n5, n6, n7, n8, n9, n10, n1, n12, n13, n14, n15,
         n16, n17, n18;
  wire   [8:0] add_result;

  add_unit_DW01_add_0 add_34 ( .A({1'b0, a}), .B({1'b0, b}), .CI(1'b0), .SUM(
        add_result) );
  DFFRQX2M en_reg_reg ( .D(en), .CK(clk), .RN(rst_n), .Q(en_reg) );
  DFFRQX2M valid_reg ( .D(n17), .CK(clk), .RN(rst_n), .Q(valid) );
  DFFRQX2M \sum_reg[1]  ( .D(n3), .CK(clk), .RN(rst_n), .Q(sum[1]) );
  DFFRQX2M \sum_reg[0]  ( .D(n2), .CK(clk), .RN(rst_n), .Q(sum[0]) );
  DFFRQX1M \sum_reg[5]  ( .D(n7), .CK(clk), .RN(rst_n), .Q(sum[5]) );
  DFFRQX1M \sum_reg[4]  ( .D(n6), .CK(clk), .RN(rst_n), .Q(sum[4]) );
  DFFRQX1M \sum_reg[3]  ( .D(n5), .CK(clk), .RN(rst_n), .Q(sum[3]) );
  DFFRQX1M \sum_reg[2]  ( .D(n4), .CK(clk), .RN(rst_n), .Q(sum[2]) );
  DFFRQX2M \sum_reg[7]  ( .D(n9), .CK(clk), .RN(rst_n), .Q(sum[7]) );
  DFFRQX2M \sum_reg[6]  ( .D(n8), .CK(clk), .RN(rst_n), .Q(sum[6]) );
  DFFRQX1M cout_reg ( .D(n10), .CK(clk), .RN(rst_n), .Q(cout) );
  INVX4M U3 ( .A(n17), .Y(n18) );
  NAND2X4M U4 ( .A(n14), .B(n13), .Y(n10) );
  NAND2X12M U5 ( .A(add_result[7]), .B(n17), .Y(n16) );
  NAND2X12M U6 ( .A(n12), .B(n1), .Y(n8) );
  NAND2X12M U7 ( .A(add_result[6]), .B(n17), .Y(n12) );
  CLKNAND2X12M U8 ( .A(n15), .B(n16), .Y(n9) );
  CLKNAND2X2M U9 ( .A(sum[6]), .B(n18), .Y(n1) );
  NAND2X12M U10 ( .A(add_result[8]), .B(n17), .Y(n14) );
  BUFX6M U11 ( .A(en_reg), .Y(n17) );
  NAND2X2M U12 ( .A(sum[7]), .B(n18), .Y(n15) );
  NAND2X2M U14 ( .A(cout), .B(n18), .Y(n13) );
  AO22X1M U15 ( .A0(sum[4]), .A1(n18), .B0(add_result[4]), .B1(n17), .Y(n6) );
  AO22X1M U16 ( .A0(sum[5]), .A1(n18), .B0(add_result[5]), .B1(n17), .Y(n7) );
  AO22X1M U17 ( .A0(sum[0]), .A1(n18), .B0(n17), .B1(add_result[0]), .Y(n2) );
  AO22X1M U18 ( .A0(sum[1]), .A1(n18), .B0(add_result[1]), .B1(n17), .Y(n3) );
  AO22X1M U19 ( .A0(sum[2]), .A1(n18), .B0(add_result[2]), .B1(n17), .Y(n4) );
  AO22X1M U20 ( .A0(sum[3]), .A1(n18), .B0(add_result[3]), .B1(n17), .Y(n5) );
endmodule


module mult_unit_DW01_add_18 ( A, B, CI, SUM, CO );
  input [11:0] A;
  input [11:0] B;
  output [11:0] SUM;
  input CI;
  output CO;
  wire   \A[1] , \A[0] , n1, n2, n3, n4, n5, n6, n7, n8, n10, n11, n12, n13,
         n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27,
         n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41,
         n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55,
         n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66;
  assign SUM[1] = \A[1] ;
  assign \A[1]  = A[1];
  assign SUM[0] = \A[0] ;
  assign \A[0]  = A[0];

  CLKNAND2X2M U2 ( .A(n41), .B(n42), .Y(n40) );
  OR2X12M U3 ( .A(A[6]), .B(B[6]), .Y(n27) );
  INVX6M U4 ( .A(n15), .Y(n52) );
  INVX3M U5 ( .A(A[5]), .Y(n63) );
  INVX4M U6 ( .A(B[5]), .Y(n64) );
  NAND2X5M U7 ( .A(B[5]), .B(A[5]), .Y(n28) );
  XOR2X8M U8 ( .A(n20), .B(n21), .Y(SUM[7]) );
  BUFX6M U9 ( .A(B[3]), .Y(n1) );
  INVX6M U10 ( .A(n43), .Y(n39) );
  NAND2X12M U11 ( .A(B[2]), .B(A[2]), .Y(n43) );
  XNOR2X2M U12 ( .A(n5), .B(n29), .Y(SUM[5]) );
  OR2X8M U13 ( .A(A[5]), .B(B[5]), .Y(n26) );
  CLKNAND2X8M U14 ( .A(n11), .B(A[8]), .Y(n50) );
  CLKNAND2X12M U15 ( .A(n41), .B(n66), .Y(n35) );
  NAND2X4M U16 ( .A(n1), .B(A[3]), .Y(n41) );
  OR2X6M U17 ( .A(A[3]), .B(n1), .Y(n42) );
  NAND2X6M U18 ( .A(n38), .B(n35), .Y(n65) );
  NAND2X4M U19 ( .A(B[6]), .B(n4), .Y(n25) );
  NAND2X2M U20 ( .A(n49), .B(n50), .Y(n46) );
  NAND2X6M U21 ( .A(n59), .B(n49), .Y(n58) );
  CLKAND2X6M U22 ( .A(n17), .B(n18), .Y(n2) );
  INVX6M U23 ( .A(n29), .Y(n34) );
  XNOR2X2M U24 ( .A(B[9]), .B(A[9]), .Y(n3) );
  XNOR2X2M U25 ( .A(n35), .B(n36), .Y(SUM[4]) );
  AND2X8M U26 ( .A(n27), .B(n22), .Y(n62) );
  AND2X2M U27 ( .A(n22), .B(n18), .Y(n21) );
  NAND2X4M U28 ( .A(A[8]), .B(n11), .Y(n8) );
  XNOR2X8M U29 ( .A(n12), .B(n3), .Y(SUM[9]) );
  OAI21X4M U30 ( .A0(n23), .A1(n24), .B0(n25), .Y(n20) );
  XOR2X4M U31 ( .A(n30), .B(n31), .Y(SUM[6]) );
  NAND2X2M U32 ( .A(n28), .B(n32), .Y(n30) );
  NAND2X6M U33 ( .A(n48), .B(n15), .Y(n60) );
  CLKAND2X2M U34 ( .A(n27), .B(n25), .Y(n31) );
  CLKNAND2X16M U35 ( .A(n2), .B(n19), .Y(n16) );
  XNOR2X4M U36 ( .A(n11), .B(A[8]), .Y(n7) );
  AND2X4M U37 ( .A(n27), .B(n22), .Y(n54) );
  BUFX20M U38 ( .A(B[8]), .Y(n11) );
  NAND2X12M U39 ( .A(n17), .B(n18), .Y(n6) );
  NAND2X2M U40 ( .A(n26), .B(n27), .Y(n24) );
  NOR2BX8M U41 ( .AN(n28), .B(n29), .Y(n23) );
  INVX1M U42 ( .A(A[8]), .Y(n13) );
  CLKAND2X4M U43 ( .A(n48), .B(B[10]), .Y(n47) );
  NAND2BX4M U44 ( .AN(n8), .B(n48), .Y(n59) );
  BUFX10M U45 ( .A(A[6]), .Y(n4) );
  NAND2X6M U46 ( .A(B[7]), .B(A[7]), .Y(n18) );
  NOR2X12M U47 ( .A(n57), .B(n58), .Y(n56) );
  AOI2B1X8M U48 ( .A1N(n6), .A0(n19), .B0(n60), .Y(n57) );
  NAND3X12M U49 ( .A(n53), .B(n54), .C(n26), .Y(n51) );
  NAND2X5M U50 ( .A(n29), .B(n33), .Y(n32) );
  NAND2X12M U51 ( .A(n39), .B(n42), .Y(n66) );
  CLKNAND2X12M U52 ( .A(A[9]), .B(B[9]), .Y(n49) );
  OR2X12M U53 ( .A(A[9]), .B(B[9]), .Y(n48) );
  OAI21X3M U54 ( .A0(A[5]), .A1(B[5]), .B0(n28), .Y(n5) );
  NAND2X12M U55 ( .A(n37), .B(n65), .Y(n29) );
  AOI2B1X8M U56 ( .A1N(n6), .A0(n51), .B0(n52), .Y(n45) );
  OAI21X8M U57 ( .A0(n45), .A1(n46), .B0(n47), .Y(n44) );
  NAND2X4M U58 ( .A(B[4]), .B(A[4]), .Y(n37) );
  NAND3X12M U59 ( .A(n4), .B(B[6]), .C(n22), .Y(n17) );
  OR2X8M U60 ( .A(A[4]), .B(B[4]), .Y(n38) );
  XNOR2X2M U61 ( .A(n16), .B(n7), .Y(SUM[8]) );
  XNOR2X8M U62 ( .A(n44), .B(B[11]), .Y(SUM[11]) );
  NAND2X2M U63 ( .A(n37), .B(n38), .Y(n36) );
  XNOR2X2M U64 ( .A(n39), .B(n40), .Y(SUM[3]) );
  NAND2X2M U65 ( .A(B[5]), .B(A[5]), .Y(n55) );
  INVX2M U66 ( .A(n11), .Y(n14) );
  OR2X1M U67 ( .A(A[5]), .B(B[5]), .Y(n33) );
  NOR2BX2M U68 ( .AN(n43), .B(n10), .Y(SUM[2]) );
  NOR2X2M U69 ( .A(A[2]), .B(B[2]), .Y(n10) );
  OAI2BB2X8M U70 ( .B0(n13), .B1(n14), .A0N(n15), .A1N(n16), .Y(n12) );
  CLKNAND2X16M U71 ( .A(n34), .B(n55), .Y(n53) );
  XNOR2X8M U72 ( .A(n56), .B(B[10]), .Y(SUM[10]) );
  OR2X12M U73 ( .A(A[8]), .B(n11), .Y(n15) );
  NAND3X12M U74 ( .A(n61), .B(n26), .C(n62), .Y(n19) );
  OAI21X8M U75 ( .A0(n63), .A1(n64), .B0(n34), .Y(n61) );
  OR2X12M U76 ( .A(B[7]), .B(A[7]), .Y(n22) );
endmodule


module mult_unit_DW01_add_19 ( A, B, CI, SUM, CO );
  input [15:0] A;
  input [15:0] B;
  output [15:0] SUM;
  input CI;
  output CO;
  wire   \B[3] , \B[2] , net5446, net5445, net5433, net5432, net5431, net5427,
         net5423, net5420, net5405, net5403, net5401, net5345, net5344,
         net5340, net6065, net6226, net6453, net6452, net6576, net6575,
         net6915, net6935, net6937, net6877, net6274, net6160, net5407,
         net5400, net5396, net9017, net6916, net6679, net6677, net5596,
         net5426, net5411, net5408, net5399, n1, n2, n3, n5, n6, n7, n8, n9,
         n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23,
         n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37,
         n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51,
         n52;
  assign SUM[1] = B[1];
  assign SUM[0] = B[0];
  assign SUM[3] = \B[3] ;
  assign \B[3]  = B[3];
  assign SUM[2] = \B[2] ;
  assign \B[2]  = B[2];

  AND2X2M U2 ( .A(n37), .B(n35), .Y(n41) );
  NAND2X2M U3 ( .A(B[6]), .B(A[6]), .Y(n35) );
  AND2X8M U4 ( .A(B[14]), .B(n5), .Y(net6937) );
  NAND2X5M U5 ( .A(B[7]), .B(A[7]), .Y(n39) );
  BUFX32M U6 ( .A(net5399), .Y(net5596) );
  CLKNAND2X12M U7 ( .A(B[9]), .B(A[9]), .Y(n16) );
  NAND2X2M U8 ( .A(n14), .B(net5345), .Y(n31) );
  CLKBUFX12M U9 ( .A(net5344), .Y(n14) );
  XNOR2X4M U10 ( .A(B[12]), .B(A[12]), .Y(n13) );
  BUFX18M U11 ( .A(B[8]), .Y(n1) );
  CLKNAND2X8M U12 ( .A(n30), .B(n31), .Y(n29) );
  XNOR2X8M U13 ( .A(n40), .B(n41), .Y(SUM[6]) );
  BUFX10M U14 ( .A(A[4]), .Y(n2) );
  XNOR2X8M U15 ( .A(n9), .B(n13), .Y(SUM[12]) );
  CLKINVX32M U16 ( .A(B[11]), .Y(n6) );
  CLKINVX20M U17 ( .A(n3), .Y(net5423) );
  BUFX20M U18 ( .A(A[11]), .Y(net6935) );
  INVX2M U19 ( .A(n36), .Y(n43) );
  XNOR2X2M U20 ( .A(n33), .B(n34), .Y(SUM[7]) );
  NAND2X2M U21 ( .A(n35), .B(n49), .Y(n34) );
  CLKINVX4M U22 ( .A(net6935), .Y(net6877) );
  AND2X8M U23 ( .A(B[11]), .B(net6935), .Y(n3) );
  CLKINVX20M U24 ( .A(net6935), .Y(net9017) );
  CLKNAND2X8M U25 ( .A(B[11]), .B(net6935), .Y(net5400) );
  AND2X2M U26 ( .A(n46), .B(n44), .Y(SUM[4]) );
  NAND2BX12M U27 ( .AN(net6935), .B(n6), .Y(net5426) );
  OR2X12M U28 ( .A(B[13]), .B(A[13]), .Y(n5) );
  AND2X12M U29 ( .A(n5), .B(net5596), .Y(net6677) );
  AOI21BX8M U30 ( .A0(net6679), .A1(n5), .B0N(net5408), .Y(net5411) );
  XNOR2X2M U31 ( .A(B[13]), .B(A[13]), .Y(net6065) );
  NAND2X8M U32 ( .A(B[13]), .B(A[13]), .Y(net5408) );
  XNOR2X8M U33 ( .A(n7), .B(net6916), .Y(SUM[14]) );
  CLKINVX4M U34 ( .A(B[14]), .Y(net6916) );
  NAND2X12M U35 ( .A(n8), .B(net5411), .Y(n7) );
  CLKAND2X3M U36 ( .A(B[12]), .B(A[12]), .Y(net6679) );
  NAND2X12M U37 ( .A(net6677), .B(n9), .Y(n8) );
  CLKNAND2X16M U38 ( .A(net5596), .B(n9), .Y(net5420) );
  NAND2X12M U39 ( .A(net5407), .B(net5408), .Y(net6274) );
  OR2X12M U40 ( .A(A[12]), .B(B[12]), .Y(net5399) );
  NAND2X4M U41 ( .A(B[12]), .B(A[12]), .Y(net5407) );
  NAND3X12M U42 ( .A(n11), .B(n10), .C(net5423), .Y(n9) );
  NAND2BX12M U43 ( .AN(net5401), .B(n12), .Y(n10) );
  NAND3X12M U44 ( .A(net5427), .B(net5405), .C(net5426), .Y(n11) );
  NAND2X12M U45 ( .A(net9017), .B(n6), .Y(n12) );
  AOI21BX8M U46 ( .A0(net6877), .A1(n6), .B0N(net5399), .Y(net5396) );
  NAND2X2M U47 ( .A(net5423), .B(n12), .Y(net6576) );
  AND2X12M U48 ( .A(net5400), .B(net5401), .Y(net6160) );
  AND2X8M U49 ( .A(net5401), .B(net5431), .Y(net6575) );
  CLKAND2X4M U50 ( .A(net5405), .B(net5401), .Y(net5432) );
  INVX6M U51 ( .A(net5432), .Y(net6453) );
  NAND2X4M U52 ( .A(net6452), .B(net5432), .Y(n27) );
  CLKINVX4M U53 ( .A(net5427), .Y(net6452) );
  NAND2X4M U54 ( .A(net5427), .B(net5405), .Y(net5431) );
  NAND2X8M U55 ( .A(net5446), .B(net5445), .Y(n17) );
  OR2X12M U56 ( .A(B[7]), .B(A[7]), .Y(n50) );
  OAI21X8M U57 ( .A0(A[7]), .A1(B[7]), .B0(n52), .Y(n47) );
  NAND2X12M U58 ( .A(n23), .B(n19), .Y(n15) );
  NAND2X12M U59 ( .A(n15), .B(net5405), .Y(n21) );
  NAND3X4M U60 ( .A(net5433), .B(net5345), .C(net5344), .Y(n23) );
  AND2X12M U61 ( .A(n17), .B(n22), .Y(n19) );
  NAND2X4M U62 ( .A(B[5]), .B(A[5]), .Y(n51) );
  NOR2X2M U63 ( .A(n43), .B(n28), .Y(n45) );
  NAND2X12M U64 ( .A(A[10]), .B(B[10]), .Y(net5401) );
  NAND2X12M U65 ( .A(n21), .B(net6160), .Y(n18) );
  AND2X8M U66 ( .A(net5345), .B(n30), .Y(n32) );
  NAND2BX12M U67 ( .AN(n49), .B(n50), .Y(n48) );
  OAI21X8M U68 ( .A0(n24), .A1(net6274), .B0(net6937), .Y(n20) );
  XNOR2X8M U69 ( .A(n20), .B(B[15]), .Y(SUM[15]) );
  CLKAND2X16M U70 ( .A(net5396), .B(n18), .Y(n24) );
  BUFX18M U71 ( .A(n16), .Y(n22) );
  NAND3X12M U72 ( .A(net5403), .B(n22), .C(net6915), .Y(net5427) );
  OAI21X1M U73 ( .A0(A[9]), .A1(B[9]), .B0(n22), .Y(net5340) );
  NAND2X12M U74 ( .A(net5420), .B(net5407), .Y(net6226) );
  AND2X2M U75 ( .A(A[6]), .B(B[6]), .Y(n52) );
  OR2X12M U76 ( .A(A[6]), .B(B[6]), .Y(n37) );
  BUFX2M U77 ( .A(n1), .Y(n25) );
  CLKAND2X12M U78 ( .A(A[8]), .B(n1), .Y(net5445) );
  NAND2X12M U79 ( .A(net5446), .B(net5445), .Y(net6915) );
  XOR2X8M U80 ( .A(n14), .B(n32), .Y(SUM[8]) );
  NAND2X3M U81 ( .A(n25), .B(A[8]), .Y(n30) );
  NAND3X12M U82 ( .A(n36), .B(n37), .C(n38), .Y(n49) );
  XOR2X8M U83 ( .A(net6576), .B(net6575), .Y(SUM[11]) );
  OR2X12M U84 ( .A(B[9]), .B(A[9]), .Y(net5433) );
  OR2X12M U85 ( .A(B[9]), .B(A[9]), .Y(net5446) );
  OR2X12M U86 ( .A(n1), .B(A[8]), .Y(net5345) );
  NAND2BX8M U87 ( .AN(net6452), .B(net6453), .Y(n26) );
  CLKNAND2X12M U88 ( .A(n26), .B(n27), .Y(SUM[10]) );
  XNOR2X2M U89 ( .A(n44), .B(n45), .Y(SUM[5]) );
  XNOR2X8M U90 ( .A(net5340), .B(n29), .Y(SUM[9]) );
  XNOR2X8M U91 ( .A(net6226), .B(net6065), .Y(SUM[13]) );
  NAND2X6M U92 ( .A(n44), .B(n51), .Y(n38) );
  OR2X4M U93 ( .A(A[5]), .B(B[5]), .Y(n36) );
  NAND2X8M U94 ( .A(B[4]), .B(n2), .Y(n44) );
  OR2X1M U95 ( .A(n2), .B(B[4]), .Y(n46) );
  NOR2X2M U96 ( .A(n44), .B(n43), .Y(n42) );
  NOR2X2M U97 ( .A(n42), .B(n28), .Y(n40) );
  AND2X1M U98 ( .A(B[5]), .B(A[5]), .Y(n28) );
  OAI21X1M U99 ( .A0(A[7]), .A1(B[7]), .B0(n39), .Y(n33) );
  OR2X12M U100 ( .A(A[10]), .B(B[10]), .Y(net5405) );
  NAND3X12M U101 ( .A(net5433), .B(net5345), .C(net5344), .Y(net5403) );
  NAND3X12M U102 ( .A(n39), .B(n47), .C(n48), .Y(net5344) );
endmodule


module mult_unit ( clk, rst_n, en, a, b, product, valid );
  input [7:0] a;
  input [7:0] b;
  output [15:0] product;
  input clk, rst_n, en;
  output valid;
  wire   en_reg, \pp[0][0] , \pp[2][0] , n19, n20, n21, n23, n30, n33, n34,
         n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47,
         \level5[9] , \level5[8] , \level5[7] , \level5[6] , \level5[5] ,
         \level5[4] , \level5[3] , \level5[2] , \level5[1] , \level5[15] ,
         \level5[14] , \level5[13] , \level5[12] , \level5[11] , \level5[10] ,
         \level5[0] , \level4[9] , \level4[8] , \level4[7] , \level4[6] ,
         \level4[5] , \level4[4] , \level4[12] , \level4[11] , \level4[10] ,
         \add_1_root_add_0_root_add_131/SUM[3] ,
         \add_1_root_add_0_root_add_131/SUM[4] ,
         \add_1_root_add_0_root_add_131/SUM[5] ,
         \add_1_root_add_0_root_add_131/SUM[6] ,
         \add_1_root_add_0_root_add_131/SUM[7] ,
         \add_1_root_add_0_root_add_131/SUM[8] ,
         \add_1_root_add_0_root_add_131/SUM[9] ,
         \add_1_root_add_0_root_add_131/SUM[10] ,
         \add_1_root_add_0_root_add_131/SUM[11] ,
         \add_2_root_add_0_root_add_131/SUM[1] ,
         \add_2_root_add_0_root_add_131/SUM[2] ,
         \add_2_root_add_0_root_add_131/SUM[3] ,
         \add_2_root_add_0_root_add_131/SUM[4] ,
         \add_2_root_add_0_root_add_131/SUM[5] ,
         \add_2_root_add_0_root_add_131/SUM[6] ,
         \add_2_root_add_0_root_add_131/SUM[7] ,
         \add_2_root_add_0_root_add_131/SUM[8] ,
         \add_2_root_add_0_root_add_131/SUM[9] , net4969, net4973, net4978,
         net4979, net4990, net4991, net4995, net4998, net5008, net5011,
         net5019, net5021, net5027, net5030, net5031, net5036, net5037,
         net5039, net5043, net5045, net5048, net5050, net5054, net5058,
         net5059, net5061, net5062, net5064, net5065, net5066, net5069,
         net5071, net5072, net5073, net5085, net5094, net5147, net5460,
         net5470, net5469, net5598, net5602, net5619, net6068, net6079,
         net6291, net6344, net6423, net6422, net6540, net6547, net6561,
         net6570, net6599, net6600, net6682, net6692, net6754, net6787,
         net6810, net6838, net6841, net6884, net6900, net6938, net6940,
         net6945, net6957, net6989, net7007, net7014, net7013, net7019,
         net7018, net6758, net7022, net6538, net6537, net5000, net4997,
         net4996, net6953, net5026, net6663, net8244, net8299, net8516,
         net8503, net8498, net8494, net8474, net8460, net8458, net8457,
         net8399, net8561, net8575, net8846, net8842, net8961, net8969,
         net8976, net9033, net9035, net9043, net9083, net9109, net9178,
         net9242, net9266, net9308, net9213, net8321, net6972, net6839,
         net5049, net5047, net4983, net4976, net8991, net8572, net8387,
         net5044, net4993, net4986, net6689, net5033, net5018, net5017,
         net5005, net9224, net9164, net9097, net8495, net8493, net8462,
         net6593, net6592, net5088, net9278, net8881, net8261, net6708,
         net6631, net5079, net5077, net5076, net5025, net6135, net5588,
         net5507, net5046, net4999, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10,
         n11, n12, n13, n14, n15, n16, n17, n18, n22, n24, n25, n26, n27, n28,
         n29, n31, n32, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58,
         n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72,
         n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86,
         n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100,
         n101, n102, n103, n104, n105, n106, n107, n108, n109, n110, n111,
         n112, n113, n114, n115, n116, n117, n118, n119, n120, n121, n122,
         n123, n124, n125, n126, n127, n128, n129, n130, n131, n132, n133,
         n134, n135, n136, n137, n138, n139, n140, n141, n142, n143, n144,
         n145, n146, n147, n148, n149, n150, n151, n152, n153, n154, n155,
         n156, n157, n158, n159, n160, n161, n162, n163, n164, n165, n166,
         n167, n168, n169, n170, n171, n172, n173, n174, n175, n176, n177,
         n178, n179, n180, n181, n182, n183, n184, n185, n186, n187, n188,
         n189, n190, n191, n192, n193, n194, n195, n196, n197, n198, n199,
         n200, n201, n202, n203, n204, n205, n206, n207, n208, n209, n210,
         n211, n212, n213, n214, n215, n216, n217, n218, n219, n220, n221,
         n222, n223, n224, n225, n226, n227, n228, n229, n230, n231, n232,
         n233, n234, n235, n236, n237, n238, n239, n240, n241, n242, n243,
         n244, n245;
  wire   [11:0] level3;
  wire   [15:0] pipeline_level3;
  wire   [15:0] level7;
  assign product[15] = net6810;
  assign product[14] = net6940;

  DFFRX4M \a_reg_reg[7]  ( .D(a[7]), .CK(clk), .RN(rst_n), .Q(n33), .QN(n96)
         );
  DFFRHQX8M \pipeline_level3_reg[8]  ( .D(level3[8]), .CK(clk), .RN(rst_n), 
        .Q(pipeline_level3[8]) );
  DFFRHQX8M \pipeline_level3_reg[7]  ( .D(level3[7]), .CK(clk), .RN(rst_n), 
        .Q(pipeline_level3[7]) );
  mult_unit_DW01_add_18 add_0_root_add_0_root_add_131 ( .A({1'b0, 1'b0, 
        \add_2_root_add_0_root_add_131/SUM[9] , 
        \add_2_root_add_0_root_add_131/SUM[8] , 
        \add_2_root_add_0_root_add_131/SUM[7] , 
        \add_2_root_add_0_root_add_131/SUM[6] , 
        \add_2_root_add_0_root_add_131/SUM[5] , 
        \add_2_root_add_0_root_add_131/SUM[4] , 
        \add_2_root_add_0_root_add_131/SUM[3] , 
        \add_2_root_add_0_root_add_131/SUM[2] , 
        \add_2_root_add_0_root_add_131/SUM[1] , \pp[0][0] }), .B({
        \add_1_root_add_0_root_add_131/SUM[11] , 
        \add_1_root_add_0_root_add_131/SUM[10] , 
        \add_1_root_add_0_root_add_131/SUM[9] , 
        \add_1_root_add_0_root_add_131/SUM[8] , 
        \add_1_root_add_0_root_add_131/SUM[7] , 
        \add_1_root_add_0_root_add_131/SUM[6] , 
        \add_1_root_add_0_root_add_131/SUM[5] , 
        \add_1_root_add_0_root_add_131/SUM[4] , 
        \add_1_root_add_0_root_add_131/SUM[3] , \pp[2][0] , 1'b0, 1'b0}), .CI(
        1'b0), .SUM(level3) );
  mult_unit_DW01_add_19 add_0_root_add_0_root_add_135 ( .A({1'b0, 1'b0, n70, 
        \level4[12] , \level4[11] , \level4[10] , \level4[9] , \level4[8] , 
        \level4[7] , \level4[6] , \level4[5] , \level4[4] , 1'b0, 1'b0, 1'b0, 
        1'b0}), .B({\level5[15] , \level5[14] , \level5[13] , \level5[12] , 
        \level5[11] , \level5[10] , \level5[9] , \level5[8] , \level5[7] , 
        \level5[6] , \level5[5] , \level5[4] , \level5[3] , \level5[2] , 
        \level5[1] , \level5[0] }), .CI(1'b0), .SUM(level7) );
  DFFRHQX4M \pipeline_level3_reg[10]  ( .D(level3[10]), .CK(clk), .RN(rst_n), 
        .Q(pipeline_level3[10]) );
  DFFRQX2M \pipeline_level3_reg[3]  ( .D(level3[3]), .CK(clk), .RN(rst_n), .Q(
        \level5[3] ) );
  DFFRQX2M \pipeline_level3_reg[2]  ( .D(level3[2]), .CK(clk), .RN(rst_n), .Q(
        \level5[2] ) );
  DFFRQX2M \pipeline_level3_reg[1]  ( .D(level3[1]), .CK(clk), .RN(rst_n), .Q(
        \level5[1] ) );
  DFFRQX2M \pipeline_level3_reg[0]  ( .D(level3[0]), .CK(clk), .RN(rst_n), .Q(
        \level5[0] ) );
  DFFRQX2M valid_reg ( .D(net5469), .CK(clk), .RN(rst_n), .Q(valid) );
  DFFRQX2M \product_reg[6]  ( .D(n40), .CK(clk), .RN(rst_n), .Q(product[6]) );
  DFFRQX2M \product_reg[4]  ( .D(n38), .CK(clk), .RN(rst_n), .Q(product[4]) );
  DFFRQX2M \product_reg[3]  ( .D(n37), .CK(clk), .RN(rst_n), .Q(product[3]) );
  DFFRQX2M \product_reg[2]  ( .D(n36), .CK(clk), .RN(rst_n), .Q(product[2]) );
  DFFRQX2M \product_reg[1]  ( .D(n35), .CK(clk), .RN(rst_n), .Q(product[1]) );
  DFFRQX2M \product_reg[0]  ( .D(n34), .CK(clk), .RN(rst_n), .Q(product[0]) );
  DFFRQX2M \product_reg[10]  ( .D(n44), .CK(clk), .RN(rst_n), .Q(product[10])
         );
  DFFRQX2M \product_reg[11]  ( .D(n45), .CK(clk), .RN(rst_n), .Q(product[11])
         );
  DFFRQX2M \product_reg[9]  ( .D(n43), .CK(clk), .RN(rst_n), .Q(product[9]) );
  DFFRQX2M \pipeline_level3_reg[4]  ( .D(level3[4]), .CK(clk), .RN(rst_n), .Q(
        \level5[4] ) );
  DFFRQX2M \product_reg[8]  ( .D(n42), .CK(clk), .RN(rst_n), .Q(product[8]) );
  DFFRQX2M \product_reg[7]  ( .D(n41), .CK(clk), .RN(rst_n), .Q(product[7]) );
  DFFRHQX8M \pipeline_level3_reg[6]  ( .D(level3[6]), .CK(clk), .RN(rst_n), 
        .Q(net8575) );
  DFFRHQX8M \b_reg_reg[6]  ( .D(b[6]), .CK(clk), .RN(rst_n), .Q(net6291) );
  DFFRQX2M \product_reg[5]  ( .D(n39), .CK(clk), .RN(rst_n), .Q(product[5]) );
  DFFRHQX8M \a_reg_reg[0]  ( .D(a[0]), .CK(clk), .RN(rst_n), .Q(net6344) );
  DFFRHQX8M \a_reg_reg[2]  ( .D(a[2]), .CK(clk), .RN(rst_n), .Q(net6422) );
  DFFRHQX8M \b_reg_reg[4]  ( .D(b[4]), .CK(clk), .RN(rst_n), .Q(n91) );
  DFFRHQX8M \a_reg_reg[1]  ( .D(a[1]), .CK(clk), .RN(rst_n), .Q(net6540) );
  DFFRHQX8M \a_reg_reg[4]  ( .D(a[4]), .CK(clk), .RN(rst_n), .Q(net6884) );
  DFFRHQX8M \b_reg_reg[7]  ( .D(b[7]), .CK(clk), .RN(rst_n), .Q(net6900) );
  DFFRHQX8M \a_reg_reg[6]  ( .D(a[6]), .CK(clk), .RN(rst_n), .Q(net7018) );
  DFFRHQX8M \product_reg[13]  ( .D(n47), .CK(clk), .RN(rst_n), .Q(product[13])
         );
  DFFRHQX8M \b_reg_reg[5]  ( .D(b[5]), .CK(clk), .RN(rst_n), .Q(n23) );
  DFFRHQX4M \pipeline_level3_reg[11]  ( .D(level3[11]), .CK(clk), .RN(rst_n), 
        .Q(pipeline_level3[11]) );
  DFFRX2M \b_reg_reg[2]  ( .D(b[2]), .CK(clk), .RN(rst_n), .Q(n20), .QN(n75)
         );
  DFFRX4M \b_reg_reg[3]  ( .D(b[3]), .CK(clk), .RN(rst_n), .Q(n21), .QN(
        net6938) );
  DFFRQX2M \pipeline_level3_reg[5]  ( .D(level3[5]), .CK(clk), .RN(rst_n), .Q(
        \level5[5] ) );
  DFFRHQX4M \product_reg[15]  ( .D(net6079), .CK(clk), .RN(rst_n), .Q(net6810)
         );
  DFFRHQX8M \pipeline_level3_reg[9]  ( .D(level3[9]), .CK(clk), .RN(rst_n), 
        .Q(net7007) );
  DFFRHQX1M \product_reg[12]  ( .D(n46), .CK(clk), .RN(rst_n), .Q(product[12])
         );
  DFFRHQX2M \b_reg_reg[0]  ( .D(b[0]), .CK(clk), .RN(rst_n), .Q(n83) );
  DFFRHQX8M \a_reg_reg[5]  ( .D(a[5]), .CK(clk), .RN(rst_n), .Q(n30) );
  DFFRHQX8M \a_reg_reg[3]  ( .D(a[3]), .CK(clk), .RN(rst_n), .Q(net6600) );
  DFFRHQX2M \b_reg_reg[1]  ( .D(b[1]), .CK(clk), .RN(rst_n), .Q(n19) );
  DFFRHQX8M en_reg_reg ( .D(en), .CK(clk), .RN(rst_n), .Q(en_reg) );
  DFFRHQX4M \product_reg[14]  ( .D(n22), .CK(clk), .RN(rst_n), .Q(net6940) );
  XOR3X4M U3 ( .A(n186), .B(n187), .C(n190), .Y(
        \add_2_root_add_0_root_add_131/SUM[3] ) );
  NAND2BX4M U4 ( .AN(n193), .B(n189), .Y(n190) );
  INVX14M U5 ( .A(net6422), .Y(net6423) );
  XOR2X4M U6 ( .A(net4990), .B(n52), .Y(net6570) );
  CLKXOR2X12M U7 ( .A(n77), .B(net5039), .Y(net4990) );
  INVX16M U8 ( .A(n49), .Y(net5094) );
  BUFX24M U9 ( .A(net6600), .Y(n49) );
  NAND2X8M U10 ( .A(n141), .B(n140), .Y(n142) );
  INVX16M U11 ( .A(net9043), .Y(net6068) );
  INVX16M U12 ( .A(net6841), .Y(n47) );
  NAND2X4M U13 ( .A(n18), .B(n2), .Y(n3) );
  NAND2X5M U14 ( .A(n1), .B(n245), .Y(n4) );
  NAND2X12M U15 ( .A(n3), .B(n4), .Y(\level5[7] ) );
  INVX8M U16 ( .A(n18), .Y(n1) );
  INVX1M U17 ( .A(n245), .Y(n2) );
  CLKBUFX12M U18 ( .A(net9033), .Y(n18) );
  CLKINVX16M U19 ( .A(n234), .Y(n245) );
  CLKNAND2X8M U20 ( .A(n95), .B(n94), .Y(n5) );
  NAND2X12M U21 ( .A(n166), .B(n6), .Y(n171) );
  CLKINVX16M U22 ( .A(n5), .Y(n6) );
  OR2X1M U23 ( .A(n174), .B(n16), .Y(n94) );
  OR2X12M U24 ( .A(n105), .B(n175), .Y(n95) );
  NOR2X12M U25 ( .A(net4973), .B(net6068), .Y(n7) );
  INVX12M U26 ( .A(n245), .Y(n8) );
  NOR2X12M U27 ( .A(n7), .B(n8), .Y(net5048) );
  INVX16M U28 ( .A(net4979), .Y(net4973) );
  CLKAND2X6M U29 ( .A(n149), .B(n120), .Y(n9) );
  OR2X12M U30 ( .A(n9), .B(n148), .Y(n131) );
  CLKINVX12M U31 ( .A(n82), .Y(n148) );
  XNOR2X2M U32 ( .A(n174), .B(n159), .Y(n10) );
  XNOR2X4M U33 ( .A(n67), .B(n11), .Y(\add_2_root_add_0_root_add_131/SUM[6] )
         );
  INVX2M U34 ( .A(n10), .Y(n11) );
  NAND2X4M U35 ( .A(net6940), .B(n12), .Y(n13) );
  NAND2X8M U36 ( .A(level7[14]), .B(en_reg), .Y(n14) );
  CLKNAND2X12M U37 ( .A(n13), .B(n14), .Y(n22) );
  INVXLM U38 ( .A(en_reg), .Y(n12) );
  INVX2M U39 ( .A(n114), .Y(n86) );
  NAND2X6M U40 ( .A(net5072), .B(n233), .Y(net5031) );
  INVX20M U41 ( .A(pipeline_level3[7]), .Y(net6972) );
  AND2X6M U42 ( .A(net8299), .B(net9097), .Y(n48) );
  INVX24M U43 ( .A(net6787), .Y(net8299) );
  INVX20M U44 ( .A(net6135), .Y(net5588) );
  INVX10M U45 ( .A(n131), .Y(n138) );
  AND2X8M U46 ( .A(n137), .B(n141), .Y(n107) );
  NAND2BX12M U47 ( .AN(net9035), .B(n117), .Y(n120) );
  OR2X4M U48 ( .A(net9035), .B(net6938), .Y(n225) );
  CLKNAND2X16M U49 ( .A(net9035), .B(net6592), .Y(net5066) );
  OR3X8M U50 ( .A(net5011), .B(net5598), .C(n25), .Y(n239) );
  INVX16M U51 ( .A(n176), .Y(n165) );
  CLKINVX12M U52 ( .A(n118), .Y(n147) );
  INVX32M U53 ( .A(net9242), .Y(\level5[12] ) );
  INVX20M U54 ( .A(n84), .Y(n106) );
  XOR3X8M U55 ( .A(n224), .B(n88), .C(n228), .Y(
        \add_1_root_add_0_root_add_131/SUM[5] ) );
  CLKINVX24M U56 ( .A(n112), .Y(\level4[12] ) );
  INVX12M U57 ( .A(net8399), .Y(net8976) );
  MXI2X6M U58 ( .A(net5037), .B(net8460), .S0(net8399), .Y(net5507) );
  INVX20M U59 ( .A(net8387), .Y(net8399) );
  XNOR3X4M U60 ( .A(n102), .B(n229), .C(net6957), .Y(
        \add_1_root_add_0_root_add_131/SUM[4] ) );
  AOI21X8M U61 ( .A0(net8846), .A1(n28), .B0(net9224), .Y(net8495) );
  CLKINVX32M U62 ( .A(n110), .Y(\add_2_root_add_0_root_add_131/SUM[5] ) );
  NAND2BX4M U63 ( .AN(net5085), .B(n113), .Y(n183) );
  CLKBUFX32M U64 ( .A(n83), .Y(n113) );
  XOR2X8M U65 ( .A(net5061), .B(net8969), .Y(net4976) );
  NAND2BX8M U66 ( .AN(net9035), .B(n113), .Y(n191) );
  BUFX18M U67 ( .A(net6423), .Y(net9035) );
  INVX4M U68 ( .A(n222), .Y(n74) );
  CLKXOR2X16M U69 ( .A(net5058), .B(net6593), .Y(net9043) );
  NAND3X8M U70 ( .A(net8299), .B(net9097), .C(net9164), .Y(net8462) );
  BUFX32M U71 ( .A(net7007), .Y(net9164) );
  BUFX8M U72 ( .A(n220), .Y(n15) );
  NAND2BXLM U73 ( .AN(net7019), .B(n117), .Y(n129) );
  NAND2BXLM U74 ( .AN(net7019), .B(n114), .Y(n173) );
  INVX16M U75 ( .A(net7018), .Y(net7019) );
  XNOR3X8M U76 ( .A(net5018), .B(net6953), .C(net4996), .Y(net9242) );
  NAND2X8M U77 ( .A(net4997), .B(net4998), .Y(net4996) );
  INVX12M U78 ( .A(n30), .Y(net5147) );
  NAND2BX8M U79 ( .AN(pipeline_level3[10]), .B(net5085), .Y(net5072) );
  INVXLM U80 ( .A(pipeline_level3[10]), .Y(net8457) );
  XOR2X2M U81 ( .A(n232), .B(n231), .Y(\add_1_root_add_0_root_add_131/SUM[3] )
         );
  NAND2BX12M U82 ( .AN(n145), .B(n147), .Y(n141) );
  INVX20M U83 ( .A(n81), .Y(n145) );
  BUFX10M U84 ( .A(n180), .Y(n16) );
  OR2X8M U85 ( .A(n183), .B(n184), .Y(n175) );
  XNOR3X4M U86 ( .A(n192), .B(n191), .C(n193), .Y(
        \add_2_root_add_0_root_add_131/SUM[2] ) );
  CLKINVX24M U87 ( .A(n188), .Y(n193) );
  CLKINVX16M U88 ( .A(n15), .Y(n199) );
  NAND2BX2M U89 ( .AN(net5085), .B(net5460), .Y(n220) );
  CLKINVX12M U90 ( .A(n182), .Y(n162) );
  CLKINVX16M U91 ( .A(n161), .Y(n185) );
  NAND2BX2M U92 ( .AN(net5094), .B(n114), .Y(n184) );
  NAND2BX4M U93 ( .AN(net5094), .B(net5460), .Y(n222) );
  NAND2BX8M U94 ( .AN(n229), .B(net6957), .Y(n227) );
  INVX2M U95 ( .A(n235), .Y(n237) );
  INVXLM U96 ( .A(n134), .Y(n69) );
  CLKBUFX32M U97 ( .A(n20), .Y(n115) );
  OR2X4M U98 ( .A(net9164), .B(n49), .Y(n26) );
  CLKAND2X12M U99 ( .A(net6758), .B(net8321), .Y(net9224) );
  NOR2X4M U100 ( .A(n49), .B(net9164), .Y(n62) );
  INVX10M U101 ( .A(net8474), .Y(net8458) );
  INVX2M U102 ( .A(n105), .Y(n163) );
  CLKAND2X6M U103 ( .A(n16), .B(n174), .Y(n105) );
  INVX2M U104 ( .A(net9308), .Y(net8261) );
  NAND2BX2M U105 ( .AN(net5147), .B(n114), .Y(n180) );
  INVX4M U106 ( .A(n178), .Y(n164) );
  NAND2BX8M U107 ( .AN(net5085), .B(n116), .Y(n118) );
  NAND2BX8M U108 ( .AN(n138), .B(n107), .Y(n133) );
  INVX10M U109 ( .A(net8575), .Y(net9178) );
  INVX12M U110 ( .A(n196), .Y(n232) );
  NAND2BX4M U111 ( .AN(net8244), .B(n76), .Y(n230) );
  NAND2BX8M U112 ( .AN(net5094), .B(n113), .Y(n186) );
  OR2X4M U113 ( .A(net5085), .B(n86), .Y(n182) );
  INVX2M U114 ( .A(net4995), .Y(net5018) );
  INVX4M U115 ( .A(n89), .Y(n244) );
  CLKINVX16M U116 ( .A(n243), .Y(n87) );
  CLKXOR2X8M U117 ( .A(n157), .B(n156), .Y(\level4[5] ) );
  BUFX24M U118 ( .A(net5050), .Y(net8244) );
  INVX2M U119 ( .A(n197), .Y(n223) );
  INVX2M U120 ( .A(n198), .Y(n218) );
  OAI2B2X4M U121 ( .A1N(n237), .A0(n236), .B0(net5021), .B1(n235), .Y(
        \level5[15] ) );
  NAND2BX2M U122 ( .AN(n102), .B(n227), .Y(n228) );
  AND2X2M U123 ( .A(n204), .B(n99), .Y(\add_1_root_add_0_root_add_131/SUM[11] ) );
  MX2X2M U124 ( .A(level7[12]), .B(product[12]), .S0(net8561), .Y(n46) );
  MX2X4M U125 ( .A(product[9]), .B(level7[9]), .S0(net5470), .Y(n43) );
  MX2X3M U126 ( .A(product[11]), .B(level7[11]), .S0(net5470), .Y(n45) );
  CLKINVX24M U127 ( .A(net8881), .Y(net9278) );
  OR2X6M U128 ( .A(net7022), .B(n51), .Y(net9213) );
  OR2X6M U129 ( .A(net9178), .B(net9266), .Y(n72) );
  NOR2X8M U130 ( .A(net8244), .B(n50), .Y(n73) );
  NOR2BX8M U131 ( .AN(net6989), .B(net6938), .Y(net6957) );
  CLKINVX8M U132 ( .A(net5050), .Y(net6989) );
  MXI2X12M U133 ( .A(level7[15]), .B(net6810), .S0(n17), .Y(net6663) );
  CLKINVX40M U134 ( .A(net5470), .Y(n17) );
  INVX20M U135 ( .A(net5050), .Y(net6758) );
  NAND3X12M U136 ( .A(net8881), .B(n26), .C(net5066), .Y(net8494) );
  NAND2X4M U137 ( .A(net9097), .B(net8881), .Y(n32) );
  INVX18M U138 ( .A(net6344), .Y(net9266) );
  AOI21BX2M U139 ( .A0(net5005), .A1(net5019), .B0N(net5008), .Y(n236) );
  BUFX10M U140 ( .A(net5025), .Y(net6631) );
  CLKXOR2X8M U141 ( .A(net6547), .B(net5588), .Y(\level5[10] ) );
  INVX16M U142 ( .A(pipeline_level3[8]), .Y(net6592) );
  CLKINVX40M U143 ( .A(net6787), .Y(n31) );
  INVX2M U144 ( .A(net7013), .Y(net7014) );
  INVX4M U145 ( .A(net8299), .Y(net7013) );
  NAND4X12M U146 ( .A(net5069), .B(net8881), .C(net6758), .D(net8321), .Y(
        net5064) );
  NAND2X12M U147 ( .A(net8299), .B(n28), .Y(net5062) );
  INVX32M U148 ( .A(net6972), .Y(net8321) );
  NAND2BX4M U149 ( .AN(net6787), .B(net8321), .Y(n66) );
  AND2X12M U150 ( .A(net8991), .B(net5044), .Y(net8572) );
  OR3X8M U151 ( .A(net6631), .B(net5026), .C(net5027), .Y(net5021) );
  INVX4M U152 ( .A(n51), .Y(n56) );
  CLKINVX8M U153 ( .A(net6631), .Y(net5076) );
  NAND2BX4M U154 ( .AN(net8961), .B(n115), .Y(n229) );
  CLKXOR2X2M U155 ( .A(n221), .B(n222), .Y(n24) );
  XNOR2X8M U156 ( .A(net5021), .B(n237), .Y(n25) );
  INVX2M U157 ( .A(n59), .Y(n57) );
  INVX4M U158 ( .A(net5044), .Y(net4986) );
  INVX12M U159 ( .A(net6592), .Y(net6593) );
  INVX2M U160 ( .A(n16), .Y(n159) );
  INVX2M U161 ( .A(n121), .Y(n136) );
  NAND2BX4M U162 ( .AN(net7019), .B(n116), .Y(n121) );
  AND2X12M U163 ( .A(net9109), .B(n114), .Y(n27) );
  CLKINVX16M U164 ( .A(net5037), .Y(net5039) );
  OA21X2M U165 ( .A0(net5036), .A1(net5037), .B0(n52), .Y(n55) );
  NAND2BX8M U166 ( .AN(net5071), .B(pipeline_level3[11]), .Y(net5030) );
  INVX8M U167 ( .A(net5094), .Y(net8498) );
  INVX2M U168 ( .A(net5469), .Y(net8561) );
  MX2X4M U169 ( .A(product[10]), .B(level7[10]), .S0(net5469), .Y(n44) );
  NAND2X12M U170 ( .A(net8846), .B(net8881), .Y(net8842) );
  CLKINVX16M U171 ( .A(n68), .Y(\level4[10] ) );
  INVX8M U172 ( .A(n31), .Y(n50) );
  NAND2BX8M U173 ( .AN(net6787), .B(net5619), .Y(net5058) );
  OA21X4M U174 ( .A0(n108), .A1(n215), .B0(n214), .Y(n217) );
  XNOR3X4M U175 ( .A(net6972), .B(net5054), .C(net6945), .Y(net9033) );
  AND2X12M U176 ( .A(net8575), .B(net6344), .Y(n28) );
  NAND2BX12M U177 ( .AN(n29), .B(net4999), .Y(n53) );
  OAI21X8M U178 ( .A0(net5588), .A1(net8572), .B0(net4993), .Y(n29) );
  INVX32M U179 ( .A(net6291), .Y(net6787) );
  BUFX32M U180 ( .A(n49), .Y(net9097) );
  NAND2BX12M U181 ( .AN(net5050), .B(n31), .Y(net5054) );
  MXI2X12M U182 ( .A(n48), .B(n32), .S0(net9164), .Y(net8969) );
  AOI21BX8M U183 ( .A0(n53), .A1(net5033), .B0N(net6692), .Y(net5598) );
  AO21X8M U184 ( .A0(n53), .A1(net5033), .B0(net6689), .Y(net5005) );
  OA21X4M U185 ( .A0(net8572), .A1(net5588), .B0(net4993), .Y(net4991) );
  OAI2BB2X8M U186 ( .B0(n56), .B1(net4976), .A0N(net5047), .A1N(net5046), .Y(
        net6135) );
  NAND2BX12M U187 ( .AN(net7022), .B(n56), .Y(net5046) );
  INVX5M U188 ( .A(net5059), .Y(n51) );
  CLKAND2X4M U189 ( .A(net7022), .B(n51), .Y(net6537) );
  XNOR2X8M U190 ( .A(net4978), .B(n51), .Y(net6839) );
  NAND2BX12M U191 ( .AN(net5507), .B(n55), .Y(net4999) );
  NAND3X12M U192 ( .A(net4999), .B(net5000), .C(net4993), .Y(net4997) );
  CLKINVX8M U193 ( .A(n54), .Y(n52) );
  NAND2BX12M U194 ( .AN(n52), .B(net4990), .Y(net4998) );
  NAND2BX2M U195 ( .AN(net5045), .B(net6884), .Y(n54) );
  INVX20M U196 ( .A(net6900), .Y(net5045) );
  AO22X2M U197 ( .A0(net9308), .A1(net8399), .B0(net5030), .B1(net5031), .Y(
        net5026) );
  CLKXOR2X16M U198 ( .A(net5005), .B(net6708), .Y(\level5[13] ) );
  CLKXOR2X16M U199 ( .A(n58), .B(n59), .Y(net6708) );
  NAND2BX12M U200 ( .AN(n58), .B(n57), .Y(net5008) );
  NAND2BX12M U201 ( .AN(n57), .B(n58), .Y(net5019) );
  NAND2BX1M U202 ( .AN(net5045), .B(net7018), .Y(n59) );
  INVX20M U203 ( .A(n60), .Y(n58) );
  CLKXOR2X16M U204 ( .A(net6682), .B(net5079), .Y(n60) );
  OA21X8M U205 ( .A0(net5077), .A1(net8261), .B0(net5076), .Y(net5079) );
  XNOR2X8M U206 ( .A(net8474), .B(net5076), .Y(net6953) );
  NAND2BX1M U207 ( .AN(net9278), .B(net7018), .Y(net5025) );
  NAND2BX12M U208 ( .AN(net9278), .B(n30), .Y(net5071) );
  CLKINVX40M U209 ( .A(net6787), .Y(net8881) );
  NAND3X12M U210 ( .A(net5619), .B(net6593), .C(n31), .Y(net5088) );
  INVX6M U211 ( .A(n61), .Y(net5077) );
  NAND2BX12M U212 ( .AN(net5031), .B(net8976), .Y(n61) );
  OA21X8M U213 ( .A0(net8494), .A1(net8495), .B0(n63), .Y(net8493) );
  CLKINVX32M U214 ( .A(net8493), .Y(net8387) );
  OA21X8M U215 ( .A0(net5088), .A1(n62), .B0(net8462), .Y(n63) );
  NAND2BX2M U216 ( .AN(net5045), .B(net9097), .Y(net5044) );
  NAND3X3M U217 ( .A(net5619), .B(net6593), .C(net8299), .Y(net5065) );
  NAND2X12M U218 ( .A(net6423), .B(net6592), .Y(net5069) );
  BUFX32M U219 ( .A(net6422), .Y(net5619) );
  NOR2X6M U220 ( .A(net6599), .B(net4995), .Y(net6689) );
  OA21X8M U221 ( .A0(net5017), .A1(net5018), .B0(net4998), .Y(net5033) );
  XNOR2X8M U222 ( .A(net8458), .B(net5076), .Y(net5017) );
  NAND2BX12M U223 ( .AN(net8991), .B(net4986), .Y(net4993) );
  CLKXOR2X8M U224 ( .A(net6754), .B(net4986), .Y(net6547) );
  XNOR2X8M U225 ( .A(n64), .B(pipeline_level3[10]), .Y(net8991) );
  XNOR2X8M U226 ( .A(net8387), .B(net5043), .Y(n64) );
  XNOR2X8M U227 ( .A(net8387), .B(net5043), .Y(net8516) );
  MXI2X12M U228 ( .A(product[13]), .B(level7[13]), .S0(en_reg), .Y(net6841) );
  INVX2M U229 ( .A(en_reg), .Y(n65) );
  INVX4M U230 ( .A(n65), .Y(net5469) );
  INVX4M U231 ( .A(n65), .Y(net5470) );
  INVX16M U232 ( .A(net8969), .Y(net6561) );
  OR3X8M U233 ( .A(net9266), .B(net6787), .C(net9178), .Y(net6945) );
  CLKXOR2X16M U234 ( .A(net6839), .B(net4976), .Y(net6838) );
  AO22X8M U235 ( .A0(net5048), .A1(net9033), .B0(net4973), .B1(net5049), .Y(
        net5047) );
  AND2X8M U236 ( .A(net9213), .B(net5047), .Y(net6538) );
  XNOR2X8M U237 ( .A(net4983), .B(net9043), .Y(net5049) );
  OAI2B2X8M U238 ( .A1N(n28), .A0(net8842), .B0(net8244), .B1(n66), .Y(net4983) );
  OAI2B1X8M U239 ( .A1N(net6972), .A0(net6758), .B0(net5069), .Y(net9083) );
  NAND2X8M U240 ( .A(net6972), .B(net5050), .Y(net8846) );
  INVX32M U241 ( .A(net6540), .Y(net5050) );
  AOI21BX8M U242 ( .A0(net5073), .A1(n233), .B0N(net5030), .Y(net9308) );
  OR2X4M U243 ( .A(n147), .B(n81), .Y(n139) );
  AND2X12M U244 ( .A(net8498), .B(n117), .Y(n81) );
  OAI21BX8M U245 ( .A0(n106), .A1(n179), .B0N(n164), .Y(n67) );
  NAND2BX4M U246 ( .AN(net7019), .B(n113), .Y(n174) );
  XOR3X4M U247 ( .A(n136), .B(n135), .C(n69), .Y(n68) );
  BUFX20M U248 ( .A(n19), .Y(n114) );
  INVX6M U249 ( .A(net5072), .Y(n78) );
  CLKAND2X6M U250 ( .A(n33), .B(n126), .Y(n70) );
  INVX8M U251 ( .A(n120), .Y(n150) );
  INVX20M U252 ( .A(net9266), .Y(net9109) );
  NAND2BX12M U253 ( .AN(net5031), .B(net8976), .Y(n71) );
  NAND2BX4M U254 ( .AN(net5045), .B(net5619), .Y(net5059) );
  NAND2BX2M U255 ( .AN(net8961), .B(n116), .Y(n154) );
  BUFX12M U256 ( .A(n122), .Y(n90) );
  INVX14M U257 ( .A(net5036), .Y(net5073) );
  CLKINVX32M U258 ( .A(n90), .Y(n143) );
  OAI2BB2X8M U259 ( .B0(n72), .B1(net8842), .A0N(net8321), .A1N(n73), .Y(
        net5602) );
  OAI2B1X8M U260 ( .A1N(n221), .A0(n74), .B0(n197), .Y(n211) );
  NAND2BX8M U261 ( .AN(n149), .B(n150), .Y(n137) );
  NAND2X12M U262 ( .A(n71), .B(net9308), .Y(net8474) );
  INVX2M U263 ( .A(n75), .Y(n76) );
  CLKINVX8M U264 ( .A(n151), .Y(n157) );
  NAND2BX12M U265 ( .AN(n144), .B(n143), .Y(n132) );
  CLKXOR2X8M U266 ( .A(net9178), .B(net4969), .Y(\level5[6] ) );
  NAND2BX2M U267 ( .AN(net7019), .B(n115), .Y(n198) );
  NAND2BX4M U268 ( .AN(net5085), .B(n115), .Y(n221) );
  NAND2BX8M U269 ( .AN(net5094), .B(n115), .Y(n224) );
  OA21X8M U270 ( .A0(net8399), .A1(n78), .B0(net8503), .Y(n77) );
  CLKXOR2X8M U271 ( .A(net5071), .B(pipeline_level3[11]), .Y(net5037) );
  BUFX32M U272 ( .A(n240), .Y(n89) );
  NAND2BX12M U273 ( .AN(net8244), .B(n113), .Y(n194) );
  AOI21BX8M U274 ( .A0(n144), .A1(n90), .B0N(n139), .Y(n111) );
  CLKNAND2X16M U275 ( .A(n139), .B(n146), .Y(n140) );
  CLKINVX4M U276 ( .A(n226), .Y(n102) );
  NAND2BX12M U277 ( .AN(net6787), .B(net6884), .Y(net5043) );
  AND4X12M U278 ( .A(n116), .B(n117), .C(net6989), .D(n119), .Y(n82) );
  NAND2X12M U279 ( .A(net9266), .B(net8961), .Y(n119) );
  XNOR3X4M U280 ( .A(n147), .B(n145), .C(n146), .Y(\level4[8] ) );
  AOI21BX8M U281 ( .A0(n111), .A1(n133), .B0N(n132), .Y(n135) );
  NAND2X12M U282 ( .A(net5044), .B(net6754), .Y(n80) );
  NAND2BX4M U283 ( .AN(n199), .B(n219), .Y(n213) );
  XOR3X4M U284 ( .A(n128), .B(n129), .C(n130), .Y(\level4[11] ) );
  NAND2BX12M U285 ( .AN(net5094), .B(n116), .Y(n149) );
  NAND2BX2M U286 ( .AN(net7013), .B(n33), .Y(net5027) );
  INVX24M U287 ( .A(net5027), .Y(net6682) );
  NAND2BX12M U288 ( .AN(n241), .B(n245), .Y(n243) );
  XOR3X8M U289 ( .A(n173), .B(n172), .C(n171), .Y(
        \add_2_root_add_0_root_add_131/SUM[7] ) );
  CLKXOR2X16M U290 ( .A(n126), .B(n127), .Y(n112) );
  NAND2BX4M U291 ( .AN(net8244), .B(n114), .Y(n160) );
  INVX16M U292 ( .A(net5619), .Y(net8961) );
  CLKINVX24M U293 ( .A(net6663), .Y(net6079) );
  INVXLM U294 ( .A(n23), .Y(n85) );
  NAND2BX4M U295 ( .AN(net8961), .B(n114), .Y(n187) );
  OR2X4M U296 ( .A(n221), .B(n222), .Y(n212) );
  INVX4M U297 ( .A(n212), .Y(n109) );
  NAND2BX4M U298 ( .AN(net9266), .B(net6900), .Y(n234) );
  CLKNAND2X16M U299 ( .A(n97), .B(net5065), .Y(net5061) );
  OR2X12M U300 ( .A(net6538), .B(net6537), .Y(n79) );
  NAND2BX4M U301 ( .AN(net5045), .B(net6989), .Y(net4979) );
  XOR2X8M U302 ( .A(net8457), .B(net8516), .Y(net6754) );
  OR2X12M U303 ( .A(net5039), .B(net5073), .Y(net8460) );
  XNOR2X8M U304 ( .A(net8458), .B(net6631), .Y(net6599) );
  CLKXOR2X16M U305 ( .A(net5061), .B(net6561), .Y(net7022) );
  BUFX2M U306 ( .A(net5036), .Y(net8503) );
  NAND2X12M U307 ( .A(n80), .B(n79), .Y(net5000) );
  OR2X4M U308 ( .A(net6599), .B(net4995), .Y(net6692) );
  XNOR3X4M U309 ( .A(net8321), .B(net5054), .C(net6945), .Y(n241) );
  AND2X12M U310 ( .A(n169), .B(n170), .Y(
        \add_2_root_add_0_root_add_131/SUM[9] ) );
  NAND2BX2M U311 ( .AN(net5045), .B(n30), .Y(net4995) );
  INVX18M U312 ( .A(net6884), .Y(net5085) );
  NAND2BX8M U313 ( .AN(net8244), .B(n116), .Y(n155) );
  CLKINVX40M U314 ( .A(net6838), .Y(\level5[9] ) );
  CLKNAND2X16M U315 ( .A(n175), .B(n176), .Y(n84) );
  BUFX32M U316 ( .A(n21), .Y(net5460) );
  NAND2BX12M U317 ( .AN(net9266), .B(net5460), .Y(n196) );
  OR2X4M U318 ( .A(net5147), .B(n85), .Y(n134) );
  NAND2BX2M U319 ( .AN(net5045), .B(n33), .Y(n235) );
  BUFX32M U320 ( .A(n23), .Y(n117) );
  CLKXOR2X16M U321 ( .A(n210), .B(n98), .Y(
        \add_1_root_add_0_root_add_131/SUM[9] ) );
  INVX8M U322 ( .A(n206), .Y(n210) );
  NAND2BX8M U323 ( .AN(net5147), .B(n116), .Y(n122) );
  OAI21X8M U324 ( .A0(n89), .A1(net4973), .B0(n87), .Y(n242) );
  NAND2BX4M U325 ( .AN(net5147), .B(n115), .Y(n219) );
  INVX2M U326 ( .A(n213), .Y(n215) );
  INVX20M U327 ( .A(net5019), .Y(net5011) );
  XNOR2X8M U328 ( .A(n223), .B(n24), .Y(\add_1_root_add_0_root_add_131/SUM[6] ) );
  NAND2BX8M U329 ( .AN(n155), .B(n157), .Y(n153) );
  XOR3X4M U330 ( .A(n244), .B(net4973), .C(n243), .Y(\level5[8] ) );
  XNOR3X4M U331 ( .A(n154), .B(n153), .C(n152), .Y(\level4[6] ) );
  NAND3X12M U332 ( .A(n100), .B(n101), .C(n227), .Y(n197) );
  ADDFHX8M U333 ( .A(n203), .B(n206), .CI(n202), .CO(n205) );
  BUFX24M U334 ( .A(n205), .Y(n99) );
  XNOR3X8M U335 ( .A(n144), .B(n143), .C(n142), .Y(\level4[9] ) );
  NAND2BX12M U336 ( .AN(net5085), .B(n117), .Y(n144) );
  BUFX8M U337 ( .A(n225), .Y(n88) );
  NAND2BX12M U338 ( .AN(n138), .B(n137), .Y(n146) );
  AOI21BX8M U339 ( .A0(n89), .A1(net4973), .B0N(n242), .Y(net4978) );
  XOR3X4M U340 ( .A(n181), .B(n106), .C(n182), .Y(n110) );
  OR2X12M U341 ( .A(n224), .B(n88), .Y(n101) );
  OR2X12M U342 ( .A(n224), .B(n226), .Y(n100) );
  NAND2BX4M U343 ( .AN(n219), .B(n199), .Y(n214) );
  OR2X12M U344 ( .A(n186), .B(n188), .Y(n92) );
  OR2X12M U345 ( .A(n186), .B(n187), .Y(n93) );
  NAND3X12M U346 ( .A(n92), .B(n93), .C(n189), .Y(n161) );
  ADDFHX8M U347 ( .A(n168), .B(n171), .CI(n167), .CO(n170) );
  NAND2BX8M U348 ( .AN(net9266), .B(n117), .Y(n151) );
  CLKXOR2X16M U349 ( .A(net4991), .B(net6570), .Y(\level5[11] ) );
  OA21X8M U350 ( .A0(net9083), .A1(net5062), .B0(net5064), .Y(n97) );
  CLKXOR2X2M U351 ( .A(n209), .B(n208), .Y(n98) );
  INVX2M U352 ( .A(n207), .Y(n209) );
  NAND2BXLM U353 ( .AN(net7019), .B(net5460), .Y(n208) );
  INVX12M U354 ( .A(n177), .Y(n179) );
  NAND2BX12M U355 ( .AN(n230), .B(n232), .Y(n226) );
  OAI211X8M U356 ( .A0(net5598), .A1(net5011), .B0(n25), .C0(net5008), .Y(n238) );
  OAI2BB2X8M U357 ( .B0(n134), .B1(n121), .A0N(n123), .A1N(n111), .Y(n130) );
  NAND2BX12M U358 ( .AN(pipeline_level3[11]), .B(net5071), .Y(n233) );
  INVX1M U359 ( .A(n216), .Y(n201) );
  AOI32X4M U360 ( .A0(n214), .A1(n211), .A2(n212), .B0(n198), .B1(n216), .Y(
        n200) );
  AND2X12M U361 ( .A(n201), .B(n218), .Y(n103) );
  AND2X12M U362 ( .A(n213), .B(n200), .Y(n104) );
  XOR2X8M U363 ( .A(n99), .B(n204), .Y(\add_1_root_add_0_root_add_131/SUM[10] ) );
  NOR2BX12M U364 ( .AN(n211), .B(n109), .Y(n108) );
  OR2X12M U365 ( .A(n103), .B(n104), .Y(n206) );
  NAND2BX12M U366 ( .AN(n194), .B(n27), .Y(n188) );
  AO21X8M U367 ( .A0(n183), .A1(n184), .B0(n185), .Y(n176) );
  NAND2BX4M U368 ( .AN(n162), .B(n181), .Y(n177) );
  XNOR2X1M U369 ( .A(n27), .B(n194), .Y(\add_2_root_add_0_root_add_131/SUM[1] ) );
  XOR2X8M U370 ( .A(net5602), .B(net6068), .Y(n240) );
  INVX12M U371 ( .A(n160), .Y(n192) );
  AND2X1M U372 ( .A(n115), .B(net9109), .Y(\pp[2][0] ) );
  AND2X1M U373 ( .A(n116), .B(net9109), .Y(\level4[4] ) );
  NAND2BXLM U374 ( .AN(n96), .B(n116), .Y(n128) );
  NAND2BXLM U375 ( .AN(n96), .B(n115), .Y(n207) );
  INVX2M U376 ( .A(n155), .Y(n156) );
  XNOR3X2M U377 ( .A(n183), .B(n185), .C(n184), .Y(
        \add_2_root_add_0_root_add_131/SUM[4] ) );
  XNOR3X4M U378 ( .A(n219), .B(n108), .C(n15), .Y(
        \add_1_root_add_0_root_add_131/SUM[7] ) );
  XOR3X4M U379 ( .A(n148), .B(n149), .C(n150), .Y(\level4[7] ) );
  INVX2M U380 ( .A(n230), .Y(n231) );
  NAND2BX2M U381 ( .AN(net5147), .B(net5460), .Y(n216) );
  NAND2BXLM U382 ( .AN(n96), .B(n113), .Y(n172) );
  INVX2M U383 ( .A(n158), .Y(n169) );
  NAND2BX2M U384 ( .AN(n96), .B(n114), .Y(n158) );
  INVX2M U385 ( .A(n195), .Y(n204) );
  NAND2BX2M U386 ( .AN(n96), .B(net5460), .Y(n195) );
  AND2X1M U387 ( .A(n113), .B(net9109), .Y(\pp[0][0] ) );
  AND2X1M U388 ( .A(n113), .B(n33), .Y(n167) );
  CLKBUFX32M U389 ( .A(n91), .Y(n116) );
  AND2X1M U390 ( .A(n116), .B(n33), .Y(n125) );
  MX2X2M U391 ( .A(product[6]), .B(level7[6]), .S0(net5469), .Y(n40) );
  AND2X1M U392 ( .A(n115), .B(n33), .Y(n202) );
  MX2X2M U393 ( .A(product[8]), .B(level7[8]), .S0(net5469), .Y(n42) );
  MX2X2M U394 ( .A(product[7]), .B(level7[7]), .S0(net5470), .Y(n41) );
  MX2X2M U395 ( .A(product[5]), .B(level7[5]), .S0(net5470), .Y(n39) );
  MX2X2M U396 ( .A(product[4]), .B(level7[4]), .S0(net5469), .Y(n38) );
  MX2X2M U397 ( .A(product[0]), .B(level7[0]), .S0(net5469), .Y(n34) );
  MX2X2M U398 ( .A(product[2]), .B(level7[2]), .S0(net5469), .Y(n36) );
  MX2X2M U399 ( .A(product[1]), .B(level7[1]), .S0(net5470), .Y(n35) );
  MX2X2M U400 ( .A(product[3]), .B(level7[3]), .S0(net5470), .Y(n37) );
  AND2X1M U401 ( .A(net5460), .B(net7018), .Y(n203) );
  AND2X1M U402 ( .A(n114), .B(net7018), .Y(n168) );
  AND2X1M U403 ( .A(n117), .B(net7018), .Y(n124) );
  CLKXOR2X16M U404 ( .A(n170), .B(n169), .Y(
        \add_2_root_add_0_root_add_131/SUM[8] ) );
  NAND2BX2M U405 ( .AN(net8244), .B(n117), .Y(n152) );
  XOR3X4M U406 ( .A(n218), .B(n217), .C(n216), .Y(
        \add_1_root_add_0_root_add_131/SUM[8] ) );
  OAI211X8M U407 ( .A0(n165), .A1(n164), .B0(n163), .C0(n177), .Y(n166) );
  NAND2BX12M U408 ( .AN(n191), .B(n192), .Y(n189) );
  NAND2BX12M U409 ( .AN(net5043), .B(pipeline_level3[10]), .Y(net5036) );
  ADDFHX8M U410 ( .A(n125), .B(n124), .CI(n130), .CO(n126) );
  NAND2BX2M U411 ( .AN(net9266), .B(net7014), .Y(net4969) );
  OAI211X8M U412 ( .A0(n25), .A1(net5008), .B0(n238), .C0(n239), .Y(
        \level5[14] ) );
  AOI32X4M U413 ( .A0(n107), .A1(n132), .A2(n131), .B0(n121), .B1(n134), .Y(
        n123) );
  NAND2BX4M U414 ( .AN(n96), .B(n117), .Y(n127) );
  NAND2BX4M U415 ( .AN(net5147), .B(n113), .Y(n181) );
  NAND2BX4M U416 ( .AN(n181), .B(n162), .Y(n178) );
endmodule


module alu8_top ( clk, rst_n, mode, add_en, mul_en, a, b, result, valid );
  input [7:0] a;
  input [7:0] b;
  output [15:0] result;
  input clk, rst_n, mode, add_en, mul_en;
  output valid;
  wire   add_cout, add_valid, mul_valid, n2, n3, n4, n5, n6, n7, n8, n9, n10;
  wire   [7:0] add_sum;
  wire   [15:0] mul_product;

  AO22X8M U2 ( .A0(mul_valid), .A1(n8), .B0(add_valid), .B1(n9), .Y(valid) );
  AO22X8M U6 ( .A0(mul_product[6]), .A1(n8), .B0(add_sum[6]), .B1(n9), .Y(
        result[6]) );
  AO22X8M U7 ( .A0(mul_product[5]), .A1(n8), .B0(add_sum[5]), .B1(n9), .Y(
        result[5]) );
  AO22X8M U8 ( .A0(mul_product[4]), .A1(n8), .B0(add_sum[4]), .B1(n9), .Y(
        result[4]) );
  AO22X8M U9 ( .A0(mul_product[3]), .A1(n8), .B0(add_sum[3]), .B1(n9), .Y(
        result[3]) );
  AO22X8M U10 ( .A0(mul_product[2]), .A1(n8), .B0(add_sum[2]), .B1(n9), .Y(
        result[2]) );
  AO22X8M U11 ( .A0(mul_product[1]), .A1(n8), .B0(add_sum[1]), .B1(n9), .Y(
        result[1]) );
  AO22X8M U18 ( .A0(mul_product[0]), .A1(n8), .B0(add_sum[0]), .B1(n9), .Y(
        result[0]) );
  add_unit u_add ( .clk(clk), .rst_n(rst_n), .en(add_en), .a({a[7:1], n3}), 
        .b({b[7:1], n2}), .sum(add_sum), .cout(add_cout), .valid(add_valid) );
  mult_unit u_mul ( .clk(clk), .rst_n(rst_n), .en(mul_en), .a({a[7:1], n3}), 
        .b({b[7:1], n2}), .product(mul_product), .valid(mul_valid) );
  BUFX8M U20 ( .A(b[0]), .Y(n2) );
  AND2X8M U21 ( .A(mul_product[14]), .B(n8), .Y(result[14]) );
  BUFX8M U22 ( .A(a[0]), .Y(n3) );
  BUFX10M U23 ( .A(n10), .Y(n9) );
  CLKBUFX12M U24 ( .A(mode), .Y(n8) );
  CLKINVX1M U25 ( .A(mode), .Y(n10) );
  AND2X2M U26 ( .A(mul_product[8]), .B(n8), .Y(n6) );
  NAND2X2M U27 ( .A(add_sum[7]), .B(n9), .Y(n5) );
  AND2X2M U28 ( .A(add_cout), .B(n9), .Y(n7) );
  NAND2X2M U29 ( .A(mul_product[7]), .B(n8), .Y(n4) );
  NAND2X8M U30 ( .A(n4), .B(n5), .Y(result[7]) );
  OR2X8M U31 ( .A(n6), .B(n7), .Y(result[8]) );
  AND2X8M U32 ( .A(mul_product[15]), .B(n8), .Y(result[15]) );
  AND2X8M U33 ( .A(mul_product[13]), .B(n8), .Y(result[13]) );
  AND2X8M U34 ( .A(mul_product[9]), .B(n8), .Y(result[9]) );
  AND2X8M U35 ( .A(mul_product[10]), .B(n8), .Y(result[10]) );
  AND2X8M U36 ( .A(mul_product[11]), .B(n8), .Y(result[11]) );
  AND2X8M U37 ( .A(mul_product[12]), .B(n8), .Y(result[12]) );
endmodule

