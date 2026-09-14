/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : O-2018.06-SP1
// Date      : Thu Sep 10 13:11:57 2026
/////////////////////////////////////////////////////////////


module add_unit_DW01_add_0 ( A, B, CI, SUM, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] SUM;
  input CI;
  output CO;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11;
  wire   [8:1] carry;

  ADDFHX4M U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(SUM[4])
         );
  ADDFX2M U1_1 ( .A(A[1]), .B(B[1]), .CI(n11), .CO(carry[2]), .S(SUM[1]) );
  ADDFHX8M U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(SUM[2])
         );
  ADDFHX8M U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(SUM[3])
         );
  ADDFHX4M U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(SUM[8]), .S(SUM[7])
         );
  AND2X8M U1 ( .A(B[0]), .B(A[0]), .Y(n11) );
  NAND2X4M U2 ( .A(carry[6]), .B(B[6]), .Y(n9) );
  ADDFX4M U3 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(n2) );
  NAND2X6M U4 ( .A(carry[6]), .B(A[6]), .Y(n8) );
  NAND2X12M U5 ( .A(n2), .B(B[5]), .Y(n5) );
  XOR2X1M U6 ( .A(n2), .B(n3), .Y(SUM[5]) );
  AND2X12M U7 ( .A(n6), .B(n7), .Y(n1) );
  NAND2X12M U8 ( .A(n5), .B(n1), .Y(carry[6]) );
  XOR2X1M U9 ( .A(B[5]), .B(A[5]), .Y(n3) );
  NAND2X1M U10 ( .A(B[5]), .B(A[5]), .Y(n7) );
  NAND2X2M U11 ( .A(carry[5]), .B(A[5]), .Y(n6) );
  CLKXOR2X2M U12 ( .A(A[6]), .B(B[6]), .Y(n4) );
  XOR2X1M U13 ( .A(carry[6]), .B(n4), .Y(SUM[6]) );
  NAND2X1M U14 ( .A(A[6]), .B(B[6]), .Y(n10) );
  NAND3X2M U15 ( .A(n10), .B(n9), .C(n8), .Y(carry[7]) );
  CLKXOR2X2M U16 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module add_unit ( clk, rst_n, en, a, b, sum, cout, valid );
  input [7:0] a;
  input [7:0] b;
  output [7:0] sum;
  input clk, rst_n, en;
  output cout, valid;
  wire   en_reg, n2, n3, n4, n5, n6, n7, n8, n9, n10, n1, n12, n13, n14;
  wire   [8:0] add_result;

  add_unit_DW01_add_0 add_34 ( .A({1'b0, a}), .B({1'b0, b}), .CI(1'b0), .SUM(
        add_result) );
  DFFRQX2M en_reg_reg ( .D(en), .CK(clk), .RN(rst_n), .Q(en_reg) );
  DFFRQX2M valid_reg ( .D(n13), .CK(clk), .RN(rst_n), .Q(valid) );
  DFFRQX2M \sum_reg[6]  ( .D(n8), .CK(clk), .RN(rst_n), .Q(sum[6]) );
  DFFRQX2M \sum_reg[5]  ( .D(n7), .CK(clk), .RN(rst_n), .Q(sum[5]) );
  DFFRQX2M \sum_reg[4]  ( .D(n6), .CK(clk), .RN(rst_n), .Q(sum[4]) );
  DFFRQX2M \sum_reg[3]  ( .D(n5), .CK(clk), .RN(rst_n), .Q(sum[3]) );
  DFFRQX2M \sum_reg[2]  ( .D(n4), .CK(clk), .RN(rst_n), .Q(sum[2]) );
  DFFRQX2M \sum_reg[1]  ( .D(n3), .CK(clk), .RN(rst_n), .Q(sum[1]) );
  DFFRQX2M \sum_reg[0]  ( .D(n2), .CK(clk), .RN(rst_n), .Q(sum[0]) );
  DFFRQX2M cout_reg ( .D(n10), .CK(clk), .RN(rst_n), .Q(cout) );
  DFFRQX2M \sum_reg[7]  ( .D(n9), .CK(clk), .RN(rst_n), .Q(sum[7]) );
  AO22X1M U3 ( .A0(sum[6]), .A1(n14), .B0(add_result[6]), .B1(n13), .Y(n8) );
  INVX4M U4 ( .A(n13), .Y(n14) );
  CLKBUFX6M U5 ( .A(en_reg), .Y(n13) );
  NAND2X2M U6 ( .A(sum[7]), .B(n14), .Y(n1) );
  NAND2X2M U7 ( .A(add_result[7]), .B(n13), .Y(n12) );
  NAND2X2M U8 ( .A(n1), .B(n12), .Y(n9) );
  AO22X1M U9 ( .A0(sum[4]), .A1(n14), .B0(add_result[4]), .B1(n13), .Y(n6) );
  AO22X1M U10 ( .A0(sum[5]), .A1(n14), .B0(add_result[5]), .B1(n13), .Y(n7) );
  AO22X1M U11 ( .A0(cout), .A1(n14), .B0(add_result[8]), .B1(n13), .Y(n10) );
  AO22X1M U12 ( .A0(sum[0]), .A1(n14), .B0(n13), .B1(add_result[0]), .Y(n2) );
  AO22X1M U14 ( .A0(sum[1]), .A1(n14), .B0(add_result[1]), .B1(n13), .Y(n3) );
  AO22X1M U15 ( .A0(sum[2]), .A1(n14), .B0(add_result[2]), .B1(n13), .Y(n4) );
  AO22X1M U16 ( .A0(sum[3]), .A1(n14), .B0(add_result[3]), .B1(n13), .Y(n5) );
endmodule


module mult_unit_DW01_add_8 ( A, B, CI, SUM, CO );
  input [15:0] A;
  input [15:0] B;
  output [15:0] SUM;
  input CI;
  output CO;
  wire   n1, n2, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44,
         n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58,
         n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72,
         n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86,
         n87, n88, n89;
  assign SUM[1] = B[1];
  assign SUM[0] = B[0];

  INVX6M U2 ( .A(A[12]), .Y(n73) );
  NAND2XLM U3 ( .A(n46), .B(n47), .Y(n45) );
  INVX3M U4 ( .A(n74), .Y(n15) );
  CLKBUFX16M U5 ( .A(n67), .Y(n8) );
  CLKINVX20M U6 ( .A(n12), .Y(n64) );
  INVX12M U7 ( .A(n59), .Y(n17) );
  INVX5M U8 ( .A(B[12]), .Y(n74) );
  BUFX14M U9 ( .A(n32), .Y(n9) );
  CLKNAND2X16M U10 ( .A(n38), .B(n86), .Y(n32) );
  CLKNAND2X16M U11 ( .A(n32), .B(n35), .Y(n85) );
  AND2X6M U12 ( .A(n8), .B(n59), .Y(n19) );
  NOR2X12M U13 ( .A(n74), .B(n73), .Y(n26) );
  XNOR2X1M U14 ( .A(n44), .B(n45), .Y(SUM[5]) );
  NAND2X12M U15 ( .A(n50), .B(n88), .Y(n44) );
  INVX3M U16 ( .A(n70), .Y(n16) );
  XOR2X8M U17 ( .A(n15), .B(n11), .Y(n76) );
  CLKINVX20M U18 ( .A(n73), .Y(n11) );
  OAI2B2X8M U19 ( .A1N(n8), .A0(n70), .B0(n74), .B1(n73), .Y(n72) );
  NAND2X5M U20 ( .A(B[3]), .B(A[3]), .Y(n54) );
  OR2X12M U21 ( .A(A[3]), .B(B[3]), .Y(n55) );
  INVX24M U22 ( .A(n56), .Y(n52) );
  AND2X1M U23 ( .A(n56), .B(n57), .Y(SUM[2]) );
  CLKNAND2X16M U24 ( .A(n1), .B(A[2]), .Y(n56) );
  XOR2X8M U25 ( .A(n16), .B(n76), .Y(SUM[12]) );
  BUFX10M U26 ( .A(B[2]), .Y(n1) );
  INVX12M U27 ( .A(n14), .Y(n5) );
  INVX2M U28 ( .A(n18), .Y(n46) );
  NAND2X2M U29 ( .A(n38), .B(n39), .Y(n37) );
  OR2X6M U30 ( .A(A[4]), .B(B[4]), .Y(n51) );
  XNOR2X4M U31 ( .A(B[14]), .B(A[14]), .Y(n2) );
  XNOR2X2M U32 ( .A(n36), .B(n37), .Y(SUM[7]) );
  XNOR2X2M U33 ( .A(n4), .B(n41), .Y(SUM[6]) );
  NAND2X2M U34 ( .A(n42), .B(n43), .Y(n41) );
  XNOR2X2M U35 ( .A(n48), .B(n49), .Y(SUM[4]) );
  AND2X12M U36 ( .A(n62), .B(n61), .Y(n25) );
  AO21XLM U37 ( .A0(n47), .A1(n44), .B0(n18), .Y(n4) );
  CLKAND2X4M U38 ( .A(n27), .B(n84), .Y(n31) );
  NAND2X8M U39 ( .A(B[9]), .B(A[9]), .Y(n27) );
  NAND2X8M U40 ( .A(B[10]), .B(A[10]), .Y(n14) );
  NAND2X8M U41 ( .A(n30), .B(n84), .Y(n6) );
  NAND2X3M U42 ( .A(n34), .B(n29), .Y(n33) );
  INVX5M U43 ( .A(n28), .Y(n29) );
  NAND2X12M U44 ( .A(n6), .B(n27), .Y(n7) );
  AND2X8M U45 ( .A(A[11]), .B(B[11]), .Y(n12) );
  NAND2X3M U46 ( .A(B[12]), .B(A[12]), .Y(n61) );
  XNOR2X2M U47 ( .A(n7), .B(n82), .Y(SUM[10]) );
  CLKXOR2X16M U48 ( .A(n58), .B(B[15]), .Y(SUM[15]) );
  BUFX2M U49 ( .A(n30), .Y(n10) );
  INVX20M U50 ( .A(n75), .Y(n70) );
  NAND2X6M U51 ( .A(n66), .B(n14), .Y(n82) );
  NAND2BX12M U52 ( .AN(n70), .B(n19), .Y(n20) );
  AO21X8M U53 ( .A0(n47), .A1(n44), .B0(n18), .Y(n40) );
  CLKAND2X3M U54 ( .A(n68), .B(n64), .Y(n80) );
  XNOR2X1M U55 ( .A(n52), .B(n53), .Y(SUM[3]) );
  AND2X12M U56 ( .A(B[5]), .B(A[5]), .Y(n18) );
  NAND2X5M U57 ( .A(B[6]), .B(A[6]), .Y(n42) );
  NAND2X6M U58 ( .A(B[4]), .B(A[4]), .Y(n50) );
  NAND2X12M U59 ( .A(n40), .B(n43), .Y(n87) );
  NAND2X12M U60 ( .A(n54), .B(n89), .Y(n48) );
  CLKAND2X6M U61 ( .A(B[14]), .B(A[14]), .Y(n23) );
  NAND2X12M U62 ( .A(n52), .B(n55), .Y(n89) );
  NAND2X5M U63 ( .A(B[7]), .B(A[7]), .Y(n38) );
  NAND2X8M U64 ( .A(n68), .B(n5), .Y(n77) );
  XNOR2X8M U65 ( .A(n72), .B(n13), .Y(SUM[13]) );
  XNOR2X2M U66 ( .A(A[13]), .B(B[13]), .Y(n13) );
  CLKAND2X16M U67 ( .A(n67), .B(n68), .Y(n24) );
  OR2X8M U68 ( .A(B[6]), .B(A[6]), .Y(n43) );
  XOR2X1M U69 ( .A(n10), .B(n31), .Y(SUM[9]) );
  NAND2X12M U70 ( .A(n42), .B(n87), .Y(n36) );
  AOI21BX8M U71 ( .A0(n26), .A1(n59), .B0N(n62), .Y(n71) );
  AOI2BB1X8M U72 ( .A0N(B[14]), .A1N(A[14]), .B0(n17), .Y(n22) );
  XNOR2X4M U73 ( .A(n9), .B(n33), .Y(SUM[8]) );
  OR2X12M U74 ( .A(B[5]), .B(A[5]), .Y(n47) );
  CLKXOR2X8M U75 ( .A(n79), .B(n80), .Y(SUM[11]) );
  CLKNAND2X16M U76 ( .A(n30), .B(n84), .Y(n83) );
  NAND2X12M U77 ( .A(n51), .B(n48), .Y(n88) );
  NAND2X6M U78 ( .A(A[8]), .B(B[8]), .Y(n34) );
  OR2X12M U79 ( .A(B[7]), .B(A[7]), .Y(n39) );
  NAND2X12M U80 ( .A(n20), .B(n71), .Y(n69) );
  NAND2X12M U81 ( .A(n85), .B(n34), .Y(n30) );
  NAND2X2M U82 ( .A(B[10]), .B(A[10]), .Y(n63) );
  NAND2X2M U83 ( .A(n14), .B(n81), .Y(n79) );
  OR2X12M U84 ( .A(A[11]), .B(B[11]), .Y(n68) );
  AO21X8M U85 ( .A0(n21), .A1(n22), .B0(n23), .Y(n58) );
  OAI2BB1X4M U86 ( .A0N(n24), .A1N(n60), .B0(n25), .Y(n21) );
  NAND3X12M U87 ( .A(n81), .B(n64), .C(n63), .Y(n60) );
  OR2X12M U88 ( .A(B[9]), .B(A[9]), .Y(n84) );
  NAND2X12M U89 ( .A(n66), .B(n65), .Y(n81) );
  CLKNAND2X16M U90 ( .A(A[13]), .B(B[13]), .Y(n62) );
  XNOR2X8M U91 ( .A(n69), .B(n2), .Y(SUM[14]) );
  OR2X12M U92 ( .A(B[12]), .B(A[12]), .Y(n67) );
  NAND2X12M U93 ( .A(n36), .B(n39), .Y(n86) );
  NAND2XLM U94 ( .A(n50), .B(n51), .Y(n49) );
  NAND2XLM U95 ( .A(n54), .B(n55), .Y(n53) );
  OR2X1M U96 ( .A(A[2]), .B(n1), .Y(n57) );
  INVXLM U97 ( .A(n35), .Y(n28) );
  NAND2X12M U98 ( .A(n83), .B(n27), .Y(n65) );
  OR2X12M U99 ( .A(B[13]), .B(A[13]), .Y(n59) );
  NAND3X12M U100 ( .A(n78), .B(n77), .C(n64), .Y(n75) );
  NAND3X12M U101 ( .A(n68), .B(n66), .C(n7), .Y(n78) );
  OR2X12M U102 ( .A(A[10]), .B(B[10]), .Y(n66) );
  OR2X12M U103 ( .A(B[8]), .B(A[8]), .Y(n35) );
endmodule


module mult_unit ( clk, rst_n, en, a, b, product, valid );
  input [7:0] a;
  input [7:0] b;
  output [15:0] product;
  input clk, rst_n, en;
  output valid;
  wire   en_reg, n24, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44,
         n45, n46, n47, n48, \add_1_root_add_0_root_add_135/SUM[4] ,
         \add_1_root_add_0_root_add_135/SUM[5] ,
         \add_1_root_add_0_root_add_135/SUM[6] ,
         \add_1_root_add_0_root_add_135/SUM[9] ,
         \add_1_root_add_0_root_add_135/SUM[10] ,
         \add_1_root_add_0_root_add_135/SUM[11] ,
         \add_1_root_add_0_root_add_135/SUM[12] ,
         \add_1_root_add_0_root_add_135/SUM[13] ,
         \add_1_root_add_0_root_add_135/SUM[14] ,
         \add_1_root_add_0_root_add_135/SUM[15] ,
         \add_1_root_add_0_root_add_135/A[0] ,
         \add_1_root_add_0_root_add_135/A[1] ,
         \add_1_root_add_0_root_add_135/A[2] ,
         \add_1_root_add_0_root_add_135/A[3] ,
         \add_3_root_add_0_root_add_135/SUM[6] ,
         \add_3_root_add_0_root_add_135/SUM[7] ,
         \add_3_root_add_0_root_add_135/SUM[8] ,
         \add_3_root_add_0_root_add_135/SUM[9] ,
         \add_3_root_add_0_root_add_135/SUM[10] ,
         \add_3_root_add_0_root_add_135/SUM[12] ,
         \add_3_root_add_0_root_add_135/SUM[13] ,
         \add_3_root_add_0_root_add_135/SUM[14] ,
         \add_3_root_add_0_root_add_135/B[2] ,
         \add_3_root_add_0_root_add_135/B[3] ,
         \add_3_root_add_0_root_add_135/B[4] ,
         \add_3_root_add_0_root_add_135/B[5] , net4942, net5004, net5030,
         net5047, net5068, net5069, net5076, net5087, net5096, net5103,
         net5106, net5108, net5110, net5111, net5112, net5113, net5118,
         net5133, net5134, net5144, net5147, net5150, net5158, net5257,
         net5266, net5285, net5444, net5448, net5492, net5526, net5549,
         net5561, net5958, net6005, net6053, net6152, net6151, net6218,
         net6217, net6279, net6315, net6360, net6359, net6441, net6599,
         net6617, net6686, net6692, net6691, net6794, net6863, net6910,
         net6918, net7027, net7064, net7130, net7271, net7276, net7275,
         net7280, net7291, net7314, net7313, net7436, net7551, net7555,
         net7554, net4980, net5116, net5114, net5105, net5075, net6413,
         net5143, net5142, net5141, net5140, net5115, net5155, net5145, n1, n2,
         n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17,
         n18, n19, n20, n21, n22, n23, n25, n26, n27, n28, n29, n30, n31, n32,
         n33, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61,
         n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75,
         n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89,
         n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102,
         n103, n104, n105, n106, n107, n108, n109, n110, n111, n112, n113,
         n114, n115, n116, n117, n118, n119, n120, n121, n122, n123, n124,
         n125, n126, n127, n128, n129, n130, n131, n132, n133, n134, n135,
         n136, n137, n138, n139, n140, n141, n142, n143, n144, n145, n146,
         n147, n148, n149, n150, n151, n152, n153, n154, n155, n156, n157,
         n158, n159, n160, n161, n162, n163, n164, n165, n166, n167, n168,
         n169, n170, n171, n172, n173, n174, n175, n178, n179, n180, n181,
         n182, n183, n184, n185, n186, n187, n188, n189, n190, n191, n192,
         n193, n194, n195, n196, n197, n198, n199, n200, n201, n202, n203,
         n204, n205, n206, n207, n208, n209, n210, n211, n212, n213, n214,
         n215, n216, n217, n218, n219, n220, n221, n222, n223, n224, n225,
         n226, n227, n228, n229, n230, n231, n232, n233, n234, n235, n236,
         n237, n238, n239, n240, n241, n242, n243, n244, n245, n246, n247,
         n248, n249, n250, n251, n252, n253, n254, n255, n256, n257, n258,
         n259, n260, n261, n262, n263, n264, n265, n266, n267, n268, n269,
         n270, n271, n272, n273, n274, n275, n276, n277, n278, n279, n280,
         n281, n282, n283, n284, n285, n286, n287, n288, n289, n290, n291,
         n292, n293, n294, n295, n296, n297, n298, n299, n300, n301, n302,
         n303, n304, n305, n306, n307, n308, n309, n310, n311, n312, n313,
         n314, n315, n316, n317, n318, n319, n320, n321, n322, n323, n324,
         n325, n326, n327, n328, n329, n330, n331, n332, n333, n334, n335,
         n336, n337, n338, n339, n340, n341, n342, n343, n344, n345, n346,
         n347, n348, n349, n350, n351, n352, n353, n354, n355, n356, n357,
         n358, n359, n360, n361, n362, n363, n364, n365, n366, n367, n368,
         n369, n370, n371, n372, n373, n374, n375, n376, n377, n378, n379,
         n380, n381, n382, n383, n384, n385, n386, n387, n388, n389, n390,
         n391, n392, n393, n394, n395, n396, n397, n398, n399, n400, n401,
         n402, n403, n404, n405, n406, n407, n408, n409, n410, n411, n412,
         n413, n414, n415, n416, n417, n418, n419, n420, n421, n422, n423,
         n424, n425, n426, n427, n428, n429, n430, n431, n432, n433, n434,
         n435, n436, n437, n438, n439, n440, n441, n442, n443, n444, n445;
  wire   [15:0] level7;

  mult_unit_DW01_add_8 add_0_root_add_0_root_add_135 ( .A({1'b0, 
        \add_3_root_add_0_root_add_135/SUM[14] , 
        \add_3_root_add_0_root_add_135/SUM[13] , 
        \add_3_root_add_0_root_add_135/SUM[12] , n174, 
        \add_3_root_add_0_root_add_135/SUM[10] , 
        \add_3_root_add_0_root_add_135/SUM[9] , 
        \add_3_root_add_0_root_add_135/SUM[8] , 
        \add_3_root_add_0_root_add_135/SUM[7] , 
        \add_3_root_add_0_root_add_135/SUM[6] , 
        \add_3_root_add_0_root_add_135/B[5] , 
        \add_3_root_add_0_root_add_135/B[4] , 
        \add_3_root_add_0_root_add_135/B[3] , 
        \add_3_root_add_0_root_add_135/B[2] , 1'b0, 1'b0}), .B({
        \add_1_root_add_0_root_add_135/SUM[15] , 
        \add_1_root_add_0_root_add_135/SUM[14] , 
        \add_1_root_add_0_root_add_135/SUM[13] , 
        \add_1_root_add_0_root_add_135/SUM[12] , 
        \add_1_root_add_0_root_add_135/SUM[11] , 
        \add_1_root_add_0_root_add_135/SUM[10] , 
        \add_1_root_add_0_root_add_135/SUM[9] , n445, n444, 
        \add_1_root_add_0_root_add_135/SUM[6] , 
        \add_1_root_add_0_root_add_135/SUM[5] , 
        \add_1_root_add_0_root_add_135/SUM[4] , 
        \add_1_root_add_0_root_add_135/A[3] , 
        \add_1_root_add_0_root_add_135/A[2] , 
        \add_1_root_add_0_root_add_135/A[1] , 
        \add_1_root_add_0_root_add_135/A[0] }), .CI(1'b0), .SUM(level7) );
  DFFRQX2M en_reg_reg ( .D(en), .CK(clk), .RN(rst_n), .Q(en_reg) );
  DFFRQX2M valid_reg ( .D(n192), .CK(clk), .RN(rst_n), .Q(valid) );
  DFFRQX2M \product_reg[8]  ( .D(n42), .CK(clk), .RN(rst_n), .Q(product[8]) );
  DFFRQX2M \product_reg[7]  ( .D(n41), .CK(clk), .RN(rst_n), .Q(product[7]) );
  DFFRQX2M \product_reg[6]  ( .D(n40), .CK(clk), .RN(rst_n), .Q(product[6]) );
  DFFRQX2M \product_reg[5]  ( .D(n39), .CK(clk), .RN(rst_n), .Q(product[5]) );
  DFFRQX2M \product_reg[4]  ( .D(n38), .CK(clk), .RN(rst_n), .Q(product[4]) );
  DFFRQX2M \product_reg[3]  ( .D(n37), .CK(clk), .RN(rst_n), .Q(product[3]) );
  DFFRQX2M \product_reg[2]  ( .D(n36), .CK(clk), .RN(rst_n), .Q(product[2]) );
  DFFRQX2M \product_reg[1]  ( .D(n35), .CK(clk), .RN(rst_n), .Q(product[1]) );
  DFFRQX2M \product_reg[0]  ( .D(n34), .CK(clk), .RN(rst_n), .Q(product[0]) );
  DFFRQX2M \product_reg[11]  ( .D(n45), .CK(clk), .RN(rst_n), .Q(product[11])
         );
  DFFRQX2M \product_reg[10]  ( .D(n44), .CK(clk), .RN(rst_n), .Q(product[10])
         );
  DFFRQX2M \product_reg[9]  ( .D(n43), .CK(clk), .RN(rst_n), .Q(product[9]) );
  DFFRX2M \b_reg_reg[6]  ( .D(b[6]), .CK(clk), .RN(rst_n), .Q(n24) );
  DFFRHQX8M \a_reg_reg[5]  ( .D(a[5]), .CK(clk), .RN(rst_n), .Q(net6005) );
  DFFRHQX8M \b_reg_reg[1]  ( .D(b[1]), .CK(clk), .RN(rst_n), .Q(n155) );
  DFFRHQX8M \a_reg_reg[0]  ( .D(a[0]), .CK(clk), .RN(rst_n), .Q(net6151) );
  DFFRHQX8M \b_reg_reg[0]  ( .D(b[0]), .CK(clk), .RN(rst_n), .Q(n146) );
  DFFRHQX8M \a_reg_reg[7]  ( .D(a[7]), .CK(clk), .RN(rst_n), .Q(net6217) );
  DFFRHQX8M \b_reg_reg[4]  ( .D(b[4]), .CK(clk), .RN(rst_n), .Q(net6360) );
  DFFSRHQX8M \product_reg[13]  ( .D(n47), .CK(clk), .SN(1'b1), .RN(rst_n), .Q(
        product[13]) );
  DFFSRHQX8M \product_reg[15]  ( .D(n167), .CK(clk), .SN(1'b1), .RN(rst_n), 
        .Q(product[15]) );
  DFFRHQX8M \a_reg_reg[3]  ( .D(a[3]), .CK(clk), .RN(rst_n), .Q(net6599) );
  DFFRHQX8M \a_reg_reg[1]  ( .D(a[1]), .CK(clk), .RN(rst_n), .Q(net6279) );
  DFFRHQX8M \a_reg_reg[4]  ( .D(a[4]), .CK(clk), .RN(rst_n), .Q(net6686) );
  DFFRHQX8M \a_reg_reg[2]  ( .D(a[2]), .CK(clk), .RN(rst_n), .Q(net6691) );
  DFFRHQX8M \b_reg_reg[5]  ( .D(b[5]), .CK(clk), .RN(rst_n), .Q(net6863) );
  DFFRX2M \product_reg[14]  ( .D(n48), .CK(clk), .RN(rst_n), .Q(product[14])
         );
  DFFRHQX8M \b_reg_reg[7]  ( .D(b[7]), .CK(clk), .RN(rst_n), .Q(n27) );
  DFFRHQX2M \product_reg[12]  ( .D(n46), .CK(clk), .RN(rst_n), .Q(product[12])
         );
  DFFRHQX8M \b_reg_reg[2]  ( .D(b[2]), .CK(clk), .RN(rst_n), .Q(net6053) );
  DFFRHQX8M \b_reg_reg[3]  ( .D(b[3]), .CK(clk), .RN(rst_n), .Q(n154) );
  DFFRHQX8M \a_reg_reg[6]  ( .D(a[6]), .CK(clk), .RN(rst_n), .Q(net7313) );
  NAND3X6M U3 ( .A(n78), .B(n422), .C(n424), .Y(n65) );
  XNOR2X2M U4 ( .A(net5087), .B(n311), .Y(n71) );
  BUFX18M U5 ( .A(n430), .Y(n62) );
  INVX24M U6 ( .A(n360), .Y(n438) );
  CLKINVX16M U7 ( .A(n392), .Y(n427) );
  INVX12M U8 ( .A(n72), .Y(n368) );
  BUFX20M U9 ( .A(n413), .Y(n182) );
  INVX20M U10 ( .A(n121), .Y(n118) );
  CLKAND2X4M U11 ( .A(n246), .B(n23), .Y(
        \add_3_root_add_0_root_add_135/SUM[14] ) );
  CLKNAND2X16M U12 ( .A(n172), .B(n87), .Y(n402) );
  INVX6M U13 ( .A(n86), .Y(n87) );
  INVX8M U14 ( .A(n361), .Y(n433) );
  NAND2BX12M U15 ( .AN(n147), .B(n33), .Y(n436) );
  INVX24M U16 ( .A(net6005), .Y(n51) );
  INVX20M U17 ( .A(n125), .Y(n403) );
  INVX32M U18 ( .A(n63), .Y(n278) );
  INVX12M U19 ( .A(net6413), .Y(net5140) );
  INVX24M U20 ( .A(net6863), .Y(net5133) );
  NAND2X12M U21 ( .A(n181), .B(n401), .Y(n171) );
  BUFX2M U22 ( .A(n269), .Y(n1) );
  INVX24M U23 ( .A(n104), .Y(n432) );
  NAND3X8M U24 ( .A(n411), .B(n398), .C(n182), .Y(n172) );
  NAND2BX12M U25 ( .AN(n412), .B(n409), .Y(n398) );
  OR3X12M U26 ( .A(n403), .B(n103), .C(n382), .Y(n383) );
  AND3X6M U27 ( .A(n339), .B(n57), .C(n340), .Y(n341) );
  INVX24M U28 ( .A(n147), .Y(n113) );
  CLKINVX4M U29 ( .A(n97), .Y(n123) );
  INVX18M U30 ( .A(n312), .Y(n315) );
  NAND2X4M U31 ( .A(n343), .B(n99), .Y(n2) );
  NAND2X4M U32 ( .A(n346), .B(n345), .Y(n3) );
  INVX2M U33 ( .A(n342), .Y(n4) );
  AND3X4M U34 ( .A(n2), .B(n3), .C(n4), .Y(n330) );
  CLKINVX12M U35 ( .A(n422), .Y(n343) );
  INVX8M U36 ( .A(n329), .Y(n342) );
  AND2X8M U37 ( .A(n164), .B(n330), .Y(n17) );
  CLKXOR2X16M U38 ( .A(n7), .B(n208), .Y(n273) );
  CLKINVX24M U39 ( .A(n214), .Y(n261) );
  XNOR2X4M U40 ( .A(n303), .B(n14), .Y(n5) );
  XNOR2X8M U41 ( .A(net5448), .B(n6), .Y(n125) );
  INVX4M U42 ( .A(n5), .Y(n6) );
  BUFX14M U43 ( .A(net4980), .Y(net5448) );
  BUFX8M U44 ( .A(n179), .Y(n115) );
  CLKXOR2X16M U45 ( .A(n357), .B(n356), .Y(n130) );
  CLKBUFX24M U46 ( .A(n414), .Y(n59) );
  CLKINVX4M U47 ( .A(n414), .Y(n60) );
  XOR2X8M U48 ( .A(n171), .B(net4942), .Y(n170) );
  NAND2X5M U49 ( .A(n189), .B(n431), .Y(n102) );
  BUFX24M U50 ( .A(n146), .Y(n121) );
  CLKINVX40M U51 ( .A(n403), .Y(n407) );
  BUFX20M U52 ( .A(n30), .Y(net5549) );
  INVX12M U53 ( .A(n98), .Y(n387) );
  BUFX32M U54 ( .A(net6692), .Y(net7291) );
  INVX20M U55 ( .A(net6691), .Y(net6692) );
  INVX20M U56 ( .A(n349), .Y(n138) );
  NAND2BX12M U57 ( .AN(n156), .B(net6794), .Y(n349) );
  OR2X4M U58 ( .A(n305), .B(n322), .Y(n374) );
  BUFX16M U59 ( .A(n381), .Y(n181) );
  NAND2BX12M U60 ( .AN(n208), .B(n7), .Y(n203) );
  CLKINVX24M U61 ( .A(n206), .Y(n208) );
  BUFX32M U62 ( .A(n209), .Y(n7) );
  INVX20M U63 ( .A(n170), .Y(\add_1_root_add_0_root_add_135/SUM[11] ) );
  INVX3M U64 ( .A(n423), .Y(n81) );
  AND3X4M U65 ( .A(n194), .B(net5285), .C(net5549), .Y(n197) );
  NAND2BX12M U66 ( .AN(n441), .B(n443), .Y(n439) );
  INVX24M U67 ( .A(n358), .Y(n443) );
  NAND2BX12M U68 ( .AN(n441), .B(n443), .Y(n117) );
  BUFX24M U69 ( .A(n132), .Y(n8) );
  CLKINVX24M U70 ( .A(n323), .Y(n367) );
  NAND2BX8M U71 ( .AN(n147), .B(net6005), .Y(n323) );
  NAND2BX8M U72 ( .AN(n60), .B(n55), .Y(n388) );
  CLKINVX32M U73 ( .A(n55), .Y(n91) );
  INVX24M U74 ( .A(net6217), .Y(n9) );
  CLKINVX40M U75 ( .A(n9), .Y(n10) );
  XOR2X8M U76 ( .A(n288), .B(n287), .Y(n66) );
  NAND2BX8M U77 ( .AN(net5068), .B(net7555), .Y(n287) );
  CLKNAND2X12M U78 ( .A(n410), .B(n398), .Y(n399) );
  INVX6M U79 ( .A(n388), .Y(n410) );
  NAND2BX12M U80 ( .AN(n59), .B(n91), .Y(n411) );
  AND3X4M U81 ( .A(n8), .B(n415), .C(n70), .Y(n396) );
  OR2X12M U82 ( .A(n79), .B(n354), .Y(n161) );
  INVX16M U83 ( .A(n217), .Y(n266) );
  AOI21X8M U84 ( .A0(n182), .A1(n411), .B0(n410), .Y(n58) );
  INVX20M U85 ( .A(n181), .Y(n103) );
  NAND2BX12M U86 ( .AN(net5069), .B(net7555), .Y(net5134) );
  INVX20M U87 ( .A(n338), .Y(n294) );
  CLKINVX16M U88 ( .A(net5087), .Y(net7130) );
  NAND2BX12M U89 ( .AN(n303), .B(n304), .Y(n380) );
  CLKXOR2X16M U90 ( .A(n301), .B(n163), .Y(n303) );
  INVX20M U91 ( .A(n215), .Y(n268) );
  NAND2BX12M U92 ( .AN(net6910), .B(n195), .Y(n215) );
  INVX20M U93 ( .A(net5115), .Y(net5087) );
  CLKXOR2X16M U94 ( .A(n207), .B(n136), .Y(n269) );
  MX2X8M U95 ( .A(product[12]), .B(level7[12]), .S0(n192), .Y(n46) );
  NAND2BX1M U96 ( .AN(n272), .B(n271), .Y(n275) );
  INVX8M U97 ( .A(n270), .Y(n272) );
  CLKAND2X12M U98 ( .A(n299), .B(n298), .Y(n15) );
  CLKXOR2X16M U99 ( .A(n17), .B(n85), .Y(n84) );
  CLKBUFX32M U100 ( .A(net7313), .Y(net5492) );
  CLKINVX24M U101 ( .A(net7313), .Y(net7314) );
  OR3X8M U102 ( .A(net6918), .B(net5133), .C(net5134), .Y(net5143) );
  NOR2X12M U103 ( .A(n95), .B(net5133), .Y(n291) );
  NAND2BX8M U104 ( .AN(n408), .B(net4942), .Y(n382) );
  BUFX18M U105 ( .A(n369), .Y(n11) );
  XOR3X4M U106 ( .A(n434), .B(n130), .C(n435), .Y(
        \add_1_root_add_0_root_add_135/SUM[4] ) );
  NAND2BX1M U107 ( .AN(net6152), .B(net7555), .Y(n434) );
  NAND2BX8M U108 ( .AN(n156), .B(n10), .Y(n332) );
  NAND2X12M U109 ( .A(net7555), .B(n10), .Y(net5150) );
  INVX20M U110 ( .A(n10), .Y(net6218) );
  NAND2BX12M U111 ( .AN(n259), .B(n173), .Y(n255) );
  NAND2BX12M U112 ( .AN(n173), .B(n259), .Y(n249) );
  INVX24M U113 ( .A(n12), .Y(n219) );
  XNOR3X8M U114 ( .A(net5047), .B(n106), .C(n335), .Y(n129) );
  XNOR3X8M U115 ( .A(net5140), .B(net5141), .C(net5142), .Y(net5047) );
  NAND2BX8M U116 ( .AN(n282), .B(n13), .Y(n280) );
  XNOR2X8M U117 ( .A(n13), .B(n282), .Y(\add_3_root_add_0_root_add_135/B[3] )
         );
  NAND2BX4M U118 ( .AN(net6910), .B(net5285), .Y(n282) );
  XOR2X4M U119 ( .A(n326), .B(n69), .Y(n68) );
  INVX10M U120 ( .A(n346), .Y(n69) );
  CLKINVX32M U121 ( .A(n408), .Y(n401) );
  XOR3X8M U122 ( .A(n71), .B(n317), .C(n313), .Y(n408) );
  BUFX32M U123 ( .A(n223), .Y(n12) );
  XNOR3X4M U124 ( .A(n436), .B(n438), .C(n437), .Y(
        \add_1_root_add_0_root_add_135/A[3] ) );
  XOR3X8M U125 ( .A(n21), .B(net5075), .C(net5076), .Y(net4942) );
  BUFX32M U126 ( .A(n154), .Y(n194) );
  BUFX12M U127 ( .A(n175), .Y(n13) );
  BUFX32M U128 ( .A(net6053), .Y(net5285) );
  OAI211X8M U129 ( .A0(n7), .A1(n206), .B0(n205), .C0(n270), .Y(n207) );
  XNOR3X2M U130 ( .A(n439), .B(n440), .C(n25), .Y(
        \add_1_root_add_0_root_add_135/A[2] ) );
  INVX12M U131 ( .A(n129), .Y(n409) );
  OA22X8M U132 ( .A0(n169), .A1(n168), .B0(n266), .B1(n262), .Y(n159) );
  AND2X6M U133 ( .A(n262), .B(n266), .Y(n168) );
  NAND2BX12M U134 ( .AN(n221), .B(n219), .Y(n160) );
  INVX8M U135 ( .A(n233), .Y(n221) );
  XOR2X8M U136 ( .A(n178), .B(n236), .Y(n173) );
  CLKINVX40M U137 ( .A(n51), .Y(net6794) );
  NAND2BX12M U138 ( .AN(n285), .B(net5147), .Y(net5111) );
  INVX20M U139 ( .A(net5266), .Y(net5257) );
  NAND2BX12M U140 ( .AN(n51), .B(net5285), .Y(net5266) );
  INVX14M U141 ( .A(n234), .Y(n231) );
  NAND2BX4M U142 ( .AN(net6218), .B(net5285), .Y(n234) );
  INVX4M U143 ( .A(n99), .Y(n331) );
  INVX2M U144 ( .A(n305), .Y(n321) );
  XOR2X8M U145 ( .A(n322), .B(n321), .Y(n384) );
  NAND2BX8M U146 ( .AN(n156), .B(net6794), .Y(n328) );
  INVX4M U147 ( .A(n336), .Y(n85) );
  INVX20M U148 ( .A(n64), .Y(n394) );
  INVX4M U149 ( .A(n304), .Y(n319) );
  INVX10M U150 ( .A(n303), .Y(n320) );
  INVX2M U151 ( .A(n306), .Y(n377) );
  OR3X6M U152 ( .A(n184), .B(n254), .C(n245), .Y(n137) );
  NAND2BX4M U153 ( .AN(n147), .B(n10), .Y(n325) );
  NAND2X6M U154 ( .A(n324), .B(n328), .Y(n340) );
  NAND2BX8M U155 ( .AN(net5257), .B(n202), .Y(n199) );
  INVX4M U156 ( .A(n324), .Y(n327) );
  INVX4M U157 ( .A(n325), .Y(n346) );
  NAND2BX2M U158 ( .AN(net5147), .B(n285), .Y(net5112) );
  CLKAND2X6M U159 ( .A(n300), .B(net5150), .Y(n144) );
  INVX4M U160 ( .A(net5111), .Y(net5113) );
  INVX2M U161 ( .A(net5106), .Y(net5075) );
  INVX6M U162 ( .A(n106), .Y(n296) );
  XOR2X4M U163 ( .A(n285), .B(net5147), .Y(n311) );
  INVX14M U164 ( .A(n297), .Y(n314) );
  XOR2X8M U165 ( .A(n235), .B(n231), .Y(n223) );
  INVX8M U166 ( .A(n260), .Y(n216) );
  INVX12M U167 ( .A(n156), .Y(n105) );
  INVX6M U168 ( .A(net7271), .Y(n32) );
  INVX6M U169 ( .A(n366), .Y(n100) );
  INVX4M U170 ( .A(n247), .Y(n250) );
  INVX4M U171 ( .A(n225), .Y(n264) );
  INVX2M U172 ( .A(n249), .Y(n254) );
  CLKINVX20M U173 ( .A(n237), .Y(n257) );
  INVX4M U174 ( .A(n238), .Y(n259) );
  BUFX6M U175 ( .A(net7551), .Y(net6910) );
  INVX4M U176 ( .A(n394), .Y(n420) );
  INVX6M U177 ( .A(n157), .Y(n169) );
  INVX2M U178 ( .A(n319), .Y(n14) );
  XOR3X2M U179 ( .A(n427), .B(n426), .C(n425), .Y(n428) );
  XOR3X2M U180 ( .A(n275), .B(n274), .C(n273), .Y(
        \add_3_root_add_0_root_add_135/SUM[6] ) );
  OAI2B11X2M U181 ( .A1N(n373), .A0(n379), .B0(n375), .C0(n374), .Y(n376) );
  MX2X6M U182 ( .A(level7[14]), .B(product[14]), .S0(n191), .Y(n48) );
  MX2X4M U183 ( .A(product[9]), .B(level7[9]), .S0(n193), .Y(n43) );
  MX2X4M U184 ( .A(product[8]), .B(level7[8]), .S0(n192), .Y(n42) );
  INVX4M U185 ( .A(net5549), .Y(net7436) );
  CLKINVX6M U186 ( .A(net5069), .Y(n33) );
  OR3X6M U187 ( .A(n415), .B(n8), .C(n124), .Y(n418) );
  INVX24M U188 ( .A(n52), .Y(n53) );
  NOR2X12M U189 ( .A(n124), .B(n135), .Y(n26) );
  NAND3X4M U190 ( .A(n270), .B(n273), .C(n278), .Y(n211) );
  NAND2BX12M U191 ( .AN(net6152), .B(n180), .Y(n441) );
  INVX20M U192 ( .A(net5030), .Y(net5004) );
  INVX4M U193 ( .A(net5108), .Y(net5116) );
  INVX6M U194 ( .A(net5150), .Y(net5118) );
  AND3X12M U195 ( .A(n29), .B(net7555), .C(net5444), .Y(n16) );
  INVX4M U196 ( .A(n427), .Y(n114) );
  CLKAND2X16M U197 ( .A(n415), .B(n109), .Y(n18) );
  INVX4M U198 ( .A(n191), .Y(n193) );
  INVX2M U199 ( .A(n326), .Y(n345) );
  AND2X2M U200 ( .A(n255), .B(n247), .Y(n19) );
  NAND2BX4M U201 ( .AN(net7554), .B(net6794), .Y(net5141) );
  INVX2M U202 ( .A(n262), .Y(n265) );
  NAND2BX2M U203 ( .AN(net7291), .B(n195), .Y(n262) );
  XNOR2X2M U204 ( .A(n257), .B(n76), .Y(n20) );
  INVX2M U205 ( .A(n236), .Y(n240) );
  XNOR2X8M U206 ( .A(net5108), .B(n54), .Y(n21) );
  NAND2X12M U207 ( .A(n277), .B(n276), .Y(n22) );
  NAND2BX8M U208 ( .AN(net5133), .B(net5492), .Y(n300) );
  INVX4M U209 ( .A(n300), .Y(n283) );
  AND2X12M U210 ( .A(n137), .B(n244), .Y(n23) );
  BUFX4M U211 ( .A(n51), .Y(net6617) );
  CLKINVX32M U212 ( .A(net7554), .Y(net7555) );
  INVX6M U213 ( .A(n11), .Y(n412) );
  NAND2X2M U214 ( .A(net7271), .B(n180), .Y(n25) );
  INVX6M U215 ( .A(n415), .Y(n431) );
  INVX2M U216 ( .A(n241), .Y(n251) );
  NAND2BX2M U217 ( .AN(net7314), .B(n195), .Y(n241) );
  INVX4M U218 ( .A(n191), .Y(n192) );
  NOR2X4M U219 ( .A(net5133), .B(net6218), .Y(n163) );
  CLKXOR2X2M U220 ( .A(n443), .B(n442), .Y(
        \add_1_root_add_0_root_add_135/A[1] ) );
  INVX2M U221 ( .A(n441), .Y(n442) );
  INVX12M U222 ( .A(n424), .Y(n79) );
  CLKXOR2X8M U223 ( .A(n366), .B(net5004), .Y(n415) );
  AND3X8M U224 ( .A(n67), .B(n432), .C(n438), .Y(n365) );
  NAND2X2M U225 ( .A(n233), .B(n116), .Y(n224) );
  NAND2X2M U226 ( .A(n229), .B(n115), .Y(n116) );
  CLKINVX20M U227 ( .A(n348), .Y(n139) );
  INVX20M U228 ( .A(net6315), .Y(net7027) );
  AND4X4M U229 ( .A(n393), .B(n114), .C(n161), .D(n391), .Y(n395) );
  BUFX32M U230 ( .A(net5068), .Y(net6918) );
  INVX2M U231 ( .A(n27), .Y(n28) );
  OAI21X8M U232 ( .A0(net5526), .A1(n53), .B0(net5004), .Y(n95) );
  CLKBUFX32M U233 ( .A(net6691), .Y(net5526) );
  CLKAND2X16M U234 ( .A(n113), .B(n180), .Y(n77) );
  INVX16M U235 ( .A(n78), .Y(n80) );
  CLKINVX12M U236 ( .A(n89), .Y(n188) );
  OR2X12M U237 ( .A(n425), .B(n151), .Y(n393) );
  BUFX24M U238 ( .A(n353), .Y(n78) );
  CLKNAND2X12M U239 ( .A(n349), .B(n348), .Y(n140) );
  INVX2M U240 ( .A(n334), .Y(n186) );
  INVX8M U241 ( .A(n286), .Y(n334) );
  CLKXOR2X12M U242 ( .A(n390), .B(n424), .Y(n189) );
  INVX8M U243 ( .A(n120), .Y(n119) );
  OR2X6M U244 ( .A(n31), .B(n30), .Y(n29) );
  CLKINVX32M U245 ( .A(n425), .Y(n149) );
  BUFX32M U246 ( .A(net6599), .Y(n30) );
  BUFX32M U247 ( .A(net6279), .Y(n31) );
  NAND2X12M U248 ( .A(net7555), .B(net7271), .Y(net5030) );
  INVX32M U249 ( .A(n30), .Y(net5069) );
  CLKINVX24M U250 ( .A(net6360), .Y(net7554) );
  INVX20M U251 ( .A(n31), .Y(net7551) );
  BUFX32M U252 ( .A(n31), .Y(net7271) );
  OAI211X8M U253 ( .A0(net5561), .A1(net6794), .B0(n50), .C0(net5145), .Y(n49)
         );
  OAI211X8M U254 ( .A0(net5140), .A1(net5141), .B0(n49), .C0(net5143), .Y(
        net5115) );
  AOI21BX8M U255 ( .A0(net7291), .A1(net5155), .B0N(n16), .Y(n50) );
  CLKBUFX32M U256 ( .A(net6686), .Y(net5561) );
  NAND2BX4M U257 ( .AN(net5549), .B(net6918), .Y(net5145) );
  NAND2X12M U258 ( .A(net7064), .B(net5145), .Y(net5144) );
  INVX24M U259 ( .A(net6686), .Y(net5068) );
  OR3X12M U260 ( .A(net6152), .B(net7551), .C(net5069), .Y(net5155) );
  AOI21BX8M U261 ( .A0(net7291), .A1(net5155), .B0N(n16), .Y(net7064) );
  INVX32M U262 ( .A(n53), .Y(net6152) );
  INVX20M U263 ( .A(net6151), .Y(n52) );
  INVX14M U264 ( .A(n52), .Y(net6315) );
  XNOR3X8M U265 ( .A(net5140), .B(net5141), .C(net5142), .Y(net6359) );
  NAND2BX8M U266 ( .AN(net7554), .B(net5492), .Y(net5158) );
  CLKAND2X6M U267 ( .A(net5561), .B(net5444), .Y(net6413) );
  INVX24M U268 ( .A(net5133), .Y(net5444) );
  NAND2X12M U269 ( .A(net5144), .B(net5143), .Y(net5142) );
  NAND2BX2M U270 ( .AN(net6918), .B(n27), .Y(net5106) );
  AOI211X4M U271 ( .A0(net5113), .A1(net5108), .B0(net5114), .C0(net5075), .Y(
        net5105) );
  OAI32X4M U272 ( .A0(net5103), .A1(net5105), .A2(n15), .B0(n21), .B1(net5106), 
        .Y(net4980) );
  OAI32X4M U273 ( .A0(net5115), .A1(net5108), .A2(net5113), .B0(net5087), .B1(
        net5116), .Y(net5114) );
  OA21X8M U274 ( .A0(net5110), .A1(net5087), .B0(net5111), .Y(n54) );
  AND3X4M U275 ( .A(net5096), .B(n306), .C(n379), .Y(n309) );
  CLKXOR2X8M U276 ( .A(n17), .B(n332), .Y(n55) );
  NAND2BX8M U277 ( .AN(n338), .B(n337), .Y(n333) );
  NAND4X8M U278 ( .A(net7271), .B(n194), .C(net6315), .D(net5285), .Y(n90) );
  XOR3X8M U279 ( .A(n1), .B(n268), .C(n267), .Y(
        \add_3_root_add_0_root_add_135/SUM[7] ) );
  OR3X6M U280 ( .A(n18), .B(n124), .C(n62), .Y(n416) );
  NAND3X6M U281 ( .A(n418), .B(n122), .C(n416), .Y(n56) );
  XNOR3X8M U282 ( .A(n420), .B(n74), .C(n56), .Y(n444) );
  NAND2X12M U283 ( .A(n407), .B(n406), .Y(n404) );
  XNOR2X8M U284 ( .A(n256), .B(n20), .Y(n174) );
  NAND2BX8M U285 ( .AN(net5068), .B(n194), .Y(n202) );
  OAI211X8M U286 ( .A0(net7276), .A1(net5561), .B0(n197), .C0(n199), .Y(n201)
         );
  OR3X8M U287 ( .A(n341), .B(n342), .C(n343), .Y(n344) );
  NAND3X4M U288 ( .A(n143), .B(n432), .C(n142), .Y(n57) );
  OR2X12M U289 ( .A(n357), .B(n356), .Y(n142) );
  XNOR3X8M U290 ( .A(n11), .B(n131), .C(n58), .Y(
        \add_1_root_add_0_root_add_135/SUM[9] ) );
  XNOR3X8M U291 ( .A(n415), .B(n8), .C(n62), .Y(
        \add_1_root_add_0_root_add_135/SUM[5] ) );
  AO2B2X4M U292 ( .B0(n294), .B1(n295), .A0(n334), .A1N(n293), .Y(n335) );
  NAND2X12M U293 ( .A(n105), .B(net5492), .Y(n326) );
  NAND2BX4M U294 ( .AN(n328), .B(n327), .Y(n329) );
  NAND2X12M U295 ( .A(n179), .B(n229), .Y(n222) );
  INVX20M U296 ( .A(n155), .Y(n156) );
  NAND2X4M U297 ( .A(n113), .B(n180), .Y(n359) );
  XOR3X1M U298 ( .A(n69), .B(n326), .C(n344), .Y(n347) );
  BUFX32M U299 ( .A(n422), .Y(n61) );
  NAND2BX1M U300 ( .AN(net6918), .B(n195), .Y(n238) );
  INVX32M U301 ( .A(n146), .Y(n147) );
  INVX32M U302 ( .A(n126), .Y(n74) );
  XOR2X8M U303 ( .A(n429), .B(n428), .Y(\add_1_root_add_0_root_add_135/SUM[6] ) );
  CLKNAND2X16M U304 ( .A(n198), .B(n90), .Y(n63) );
  CLKXOR2X16M U305 ( .A(n294), .B(n337), .Y(n64) );
  NAND2X12M U306 ( .A(n65), .B(n108), .Y(n107) );
  NAND2BX4M U307 ( .AN(net5069), .B(net5444), .Y(n288) );
  CLKXOR2X8M U308 ( .A(n97), .B(n405), .Y(n83) );
  OR3X4M U309 ( .A(n424), .B(n423), .C(n331), .Y(n164) );
  INVX16M U310 ( .A(n189), .Y(n109) );
  INVX2M U311 ( .A(n130), .Y(n67) );
  NAND2X8M U312 ( .A(net5004), .B(n100), .Y(n351) );
  CLKINVX32M U313 ( .A(n88), .Y(\add_3_root_add_0_root_add_135/SUM[12] ) );
  INVX8M U314 ( .A(net5096), .Y(net6441) );
  OR2X6M U315 ( .A(n147), .B(net7551), .Y(n358) );
  CLKXOR2X16M U316 ( .A(n103), .B(n408), .Y(
        \add_1_root_add_0_root_add_135/SUM[10] ) );
  NAND2BX8M U317 ( .AN(n321), .B(n322), .Y(n373) );
  XNOR2X8M U318 ( .A(n344), .B(n68), .Y(n419) );
  NOR2X8M U319 ( .A(n101), .B(n347), .Y(n371) );
  NAND4X8M U320 ( .A(net7271), .B(net5526), .C(net5285), .D(n194), .Y(n198) );
  AND3X1M U321 ( .A(n178), .B(n238), .C(n240), .Y(n243) );
  OAI31X4M U322 ( .A0(n240), .A1(n259), .A2(n178), .B0(n251), .Y(n242) );
  CLKINVX40M U323 ( .A(n419), .Y(n126) );
  CLKINVX40M U324 ( .A(n387), .Y(n414) );
  NAND2X6M U325 ( .A(n75), .B(n111), .Y(n70) );
  CLKINVX32M U326 ( .A(n107), .Y(n111) );
  INVX2M U327 ( .A(n315), .Y(n133) );
  CLKINVX1M U328 ( .A(n103), .Y(n183) );
  AO21X8M U329 ( .A0(n184), .A1(n255), .B0(n254), .Y(n256) );
  OR3X4M U330 ( .A(n359), .B(n32), .C(net7291), .Y(n94) );
  CLKNAND2X16M U331 ( .A(n437), .B(n436), .Y(n361) );
  INVX3M U332 ( .A(net5448), .Y(net5096) );
  XOR2X8M U333 ( .A(net5087), .B(n311), .Y(n316) );
  MX2X4M U334 ( .A(product[10]), .B(level7[10]), .S0(n192), .Y(n44) );
  INVX12M U335 ( .A(n394), .Y(n127) );
  OA21X4M U336 ( .A0(n18), .A1(n62), .B0(n421), .Y(n429) );
  OR2X4M U337 ( .A(n430), .B(n18), .Y(n135) );
  NOR2BX12M U338 ( .AN(n180), .B(net5068), .Y(n72) );
  BUFX32M U339 ( .A(n155), .Y(n180) );
  NAND2X12M U340 ( .A(n184), .B(n19), .Y(n158) );
  XOR3XLM U341 ( .A(net6359), .B(n106), .C(n335), .Y(n131) );
  XOR2X8M U342 ( .A(net7130), .B(n311), .Y(n298) );
  INVX8M U343 ( .A(n432), .Y(n120) );
  OR2X4M U344 ( .A(n423), .B(n424), .Y(n151) );
  BUFX2M U345 ( .A(n407), .Y(n73) );
  NAND2BX8M U346 ( .AN(n261), .B(n260), .Y(n157) );
  NAND2BX12M U347 ( .AN(net5069), .B(net5285), .Y(n276) );
  CLKNAND2X12M U348 ( .A(n94), .B(n439), .Y(n360) );
  NAND2X12M U349 ( .A(n75), .B(n111), .Y(n417) );
  AND2X12M U350 ( .A(n82), .B(n427), .Y(n75) );
  NAND2BX12M U351 ( .AN(net6152), .B(n27), .Y(n289) );
  AOI2BB1X8M U352 ( .A0N(n273), .A1N(n270), .B0(net6152), .Y(n213) );
  INVX2M U353 ( .A(n253), .Y(n76) );
  XNOR3X2M U354 ( .A(n276), .B(n278), .C(n277), .Y(
        \add_3_root_add_0_root_add_135/B[5] ) );
  CLKBUFX4M U355 ( .A(net6315), .Y(net7280) );
  INVX6M U356 ( .A(net5526), .Y(net7275) );
  INVX8M U357 ( .A(net7275), .Y(net7276) );
  OAI21X6M U358 ( .A0(n394), .A1(n74), .B0(n122), .Y(n185) );
  AOI21BX8M U359 ( .A0(net5448), .A1(n380), .B0N(n379), .Y(n97) );
  AND4X8M U360 ( .A(n105), .B(net5526), .C(net5549), .D(n121), .Y(n104) );
  NAND2BX8M U361 ( .AN(n156), .B(net5526), .Y(n437) );
  NAND2BX12M U362 ( .AN(n409), .B(n412), .Y(n400) );
  AND4X12M U363 ( .A(net6441), .B(n380), .C(n377), .D(n373), .Y(n310) );
  NAND2BX4M U364 ( .AN(net7551), .B(net5444), .Y(n350) );
  NAND2BX4M U365 ( .AN(net6692), .B(net7555), .Y(n352) );
  OR2X12M U366 ( .A(n147), .B(net7314), .Y(n324) );
  NAND2BX12M U367 ( .AN(n147), .B(net5561), .Y(n356) );
  NOR3X12M U368 ( .A(n134), .B(n185), .C(n26), .Y(n370) );
  NAND2BX1M U369 ( .AN(net7436), .B(n195), .Y(n225) );
  NAND2BX8M U370 ( .AN(n276), .B(n204), .Y(n270) );
  OA21X2M U371 ( .A0(n424), .A1(n423), .B0(n61), .Y(n426) );
  NAND3X12M U372 ( .A(n79), .B(n80), .C(n81), .Y(n82) );
  INVX20M U373 ( .A(n339), .Y(n423) );
  CLKXOR2X16M U374 ( .A(n404), .B(n83), .Y(
        \add_1_root_add_0_root_add_135/SUM[13] ) );
  INVX8M U375 ( .A(n384), .Y(n405) );
  NAND2X8M U376 ( .A(n148), .B(n149), .Y(n150) );
  INVX12M U377 ( .A(n353), .Y(n425) );
  AND2X12M U378 ( .A(n102), .B(n430), .Y(n93) );
  NAND2BX8M U379 ( .AN(net7314), .B(n194), .Y(n235) );
  NAND3X2M U380 ( .A(net6441), .B(n373), .C(n380), .Y(n375) );
  NAND2X8M U381 ( .A(n399), .B(n400), .Y(n86) );
  CLKINVX6M U382 ( .A(n389), .Y(n122) );
  CLKXOR2X16M U383 ( .A(n252), .B(n241), .Y(n88) );
  CLKINVX32M U384 ( .A(n112), .Y(n406) );
  NAND2BX8M U385 ( .AN(n314), .B(n133), .Y(n313) );
  NAND2X8M U386 ( .A(n283), .B(net5118), .Y(n145) );
  XNOR3X8M U387 ( .A(n59), .B(n91), .C(n182), .Y(n445) );
  INVX3M U388 ( .A(n301), .Y(n302) );
  AO21X8M U389 ( .A0(net7027), .A1(net6692), .B0(net7551), .Y(n89) );
  BUFX24M U390 ( .A(n239), .Y(n178) );
  NAND2BX4M U391 ( .AN(n32), .B(n27), .Y(n286) );
  INVX20M U392 ( .A(n389), .Y(n92) );
  CLKNAND2X16M U393 ( .A(n92), .B(n93), .Y(n128) );
  NAND2BX12M U394 ( .AN(net6359), .B(n106), .Y(n297) );
  OAI211X8M U395 ( .A0(net5118), .A1(n283), .B0(net7130), .C0(net5112), .Y(
        n284) );
  AND2X12M U396 ( .A(n77), .B(n110), .Y(n96) );
  INVX4M U397 ( .A(n289), .Y(n337) );
  NAND3BX4M U398 ( .AN(n278), .B(n203), .C(n22), .Y(n205) );
  NAND2BX12M U399 ( .AN(n278), .B(n22), .Y(n271) );
  CLKAND2X12M U400 ( .A(net5561), .B(n425), .Y(n153) );
  XOR3X4M U401 ( .A(n334), .B(n293), .C(n333), .Y(n98) );
  OAI2B2X8M U402 ( .A1N(n11), .A0(n129), .B0(n55), .B1(n59), .Y(n372) );
  AOI21BX8M U403 ( .A0(n326), .A1(n325), .B0N(n340), .Y(n99) );
  NOR2BX8M U404 ( .AN(net7276), .B(n28), .Y(n106) );
  BUFX20M U405 ( .A(n258), .Y(n184) );
  NAND2BX8M U406 ( .AN(net5069), .B(n194), .Y(n209) );
  AO21X8M U407 ( .A0(n84), .A1(n414), .B0(n420), .Y(n101) );
  NAND2BX4M U408 ( .AN(net5133), .B(net6794), .Y(n285) );
  NAND2BX8M U409 ( .AN(net6692), .B(net5444), .Y(n290) );
  OAI2BB2X8M U410 ( .B0(n124), .B1(n421), .A0N(n84), .A1N(n414), .Y(n134) );
  OAI21X8M U411 ( .A0(net5068), .A1(net6692), .B0(net5069), .Y(n110) );
  INVX12M U412 ( .A(net5158), .Y(net5147) );
  CLKNAND2X16M U413 ( .A(n150), .B(n354), .Y(n108) );
  NAND4X12M U414 ( .A(n63), .B(n199), .C(n203), .D(n22), .Y(n200) );
  AND2X4M U415 ( .A(n78), .B(n61), .Y(n152) );
  XOR2X3M U416 ( .A(n390), .B(n424), .Y(n190) );
  CLKXOR2X8M U417 ( .A(n368), .B(n367), .Y(n390) );
  OR2X8M U418 ( .A(n318), .B(n15), .Y(net5076) );
  CLKINVX32M U419 ( .A(n417), .Y(n389) );
  NAND2BXLM U420 ( .AN(net6910), .B(n194), .Y(n279) );
  NAND3X12M U421 ( .A(n402), .B(n401), .C(net4942), .Y(n112) );
  XNOR3X8M U422 ( .A(n290), .B(net5134), .C(n291), .Y(n338) );
  OR3X12M U423 ( .A(n383), .B(n123), .C(n384), .Y(n385) );
  AOI2B1X8M U424 ( .A1N(n22), .A0(n273), .B0(n210), .Y(n212) );
  XNOR2X8M U425 ( .A(n390), .B(n424), .Y(n132) );
  OR3X12M U426 ( .A(n310), .B(n309), .C(n308), .Y(n386) );
  CLKINVX6M U427 ( .A(n423), .Y(n148) );
  NAND2BX12M U428 ( .AN(n257), .B(n253), .Y(n247) );
  NAND2BX2M U429 ( .AN(n118), .B(net7276), .Y(n440) );
  NAND2X12M U430 ( .A(n96), .B(n188), .Y(n143) );
  NAND2BX12M U431 ( .AN(net5068), .B(net5285), .Y(n206) );
  XNOR2X8M U432 ( .A(n288), .B(n287), .Y(n292) );
  OAI211X4M U433 ( .A0(n362), .A1(n119), .B0(net7555), .C0(net7280), .Y(n363)
         );
  NAND2BX12M U434 ( .AN(net6692), .B(n194), .Y(n277) );
  CLKINVX32M U435 ( .A(n277), .Y(n204) );
  AND4X12M U436 ( .A(n114), .B(n391), .C(n393), .D(n161), .Y(n124) );
  INVXLM U437 ( .A(n248), .Y(n245) );
  NAND2BX12M U438 ( .AN(n253), .B(n257), .Y(n248) );
  XNOR3X4M U439 ( .A(n281), .B(n280), .C(n279), .Y(
        \add_3_root_add_0_root_add_135/B[4] ) );
  OAI21X8M U440 ( .A0(n126), .A1(n127), .B0(n128), .Y(n397) );
  OA21X4M U441 ( .A0(n438), .A1(n433), .B0(n432), .Y(n435) );
  NAND2BX12M U442 ( .AN(n218), .B(n162), .Y(n233) );
  NOR2X12M U443 ( .A(net7314), .B(net5958), .Y(n162) );
  INVX32M U444 ( .A(n355), .Y(n424) );
  OAI211X8M U445 ( .A0(n202), .A1(net5266), .B0(n200), .C0(n201), .Y(n228) );
  CLKXOR2X16M U446 ( .A(n386), .B(n385), .Y(
        \add_1_root_add_0_root_add_135/SUM[14] ) );
  NAND2BX12M U447 ( .AN(net6152), .B(net5444), .Y(n366) );
  OA21X8M U448 ( .A0(n334), .A1(n66), .B0(n337), .Y(n295) );
  MX2X6M U449 ( .A(product[11]), .B(level7[11]), .S0(n193), .Y(n45) );
  NAND2BX8M U450 ( .AN(n367), .B(n368), .Y(n339) );
  NOR2X6M U451 ( .A(n271), .B(n273), .Y(n210) );
  OR3X12M U452 ( .A(n365), .B(n364), .C(n363), .Y(n430) );
  MX2X8M U453 ( .A(product[13]), .B(level7[13]), .S0(n193), .Y(n47) );
  NAND2BX12M U454 ( .AN(n162), .B(n218), .Y(n229) );
  AOI33X4M U455 ( .A0(n374), .A1(n307), .A2(n377), .B0(n306), .B1(n380), .B2(
        n373), .Y(n308) );
  CLKXOR2X16M U456 ( .A(net7064), .B(n292), .Y(n293) );
  NAND2BX12M U457 ( .AN(net6617), .B(n194), .Y(n218) );
  NAND2BX2M U458 ( .AN(net6218), .B(n194), .Y(n236) );
  NAND2BXLM U459 ( .AN(net6218), .B(n195), .Y(n196) );
  NAND4BX4M U460 ( .AN(n382), .B(n73), .C(n405), .D(n183), .Y(n378) );
  NAND2BX12M U461 ( .AN(n320), .B(n319), .Y(n379) );
  OAI2BB2X4M U462 ( .B0(n386), .B1(n378), .A0N(n377), .A1N(n376), .Y(
        \add_1_root_add_0_root_add_135/SUM[15] ) );
  CLKXOR2X2M U463 ( .A(net5257), .B(n202), .Y(n136) );
  NAND2BX12M U464 ( .AN(n269), .B(n268), .Y(n260) );
  NAND2BX8M U465 ( .AN(n302), .B(n163), .Y(n322) );
  NAND2X12M U466 ( .A(n138), .B(n139), .Y(n141) );
  NAND2X12M U467 ( .A(n140), .B(n141), .Y(n353) );
  NAND2BX12M U468 ( .AN(n118), .B(net5492), .Y(n348) );
  NAND2BX12M U469 ( .AN(n78), .B(n61), .Y(n354) );
  NAND3X12M U470 ( .A(n143), .B(n432), .C(n142), .Y(n355) );
  NAND2BX12M U471 ( .AN(n156), .B(net5549), .Y(n357) );
  OAI211X8M U472 ( .A0(n300), .A1(net5150), .B0(net5111), .C0(n284), .Y(n301)
         );
  CLKXOR2X16M U473 ( .A(n407), .B(n406), .Y(
        \add_1_root_add_0_root_add_135/SUM[12] ) );
  XOR3X8M U474 ( .A(n266), .B(n265), .C(n169), .Y(
        \add_3_root_add_0_root_add_135/SUM[8] ) );
  NAND2BX12M U475 ( .AN(n144), .B(n145), .Y(net5108) );
  NAND2BX12M U476 ( .AN(n368), .B(n367), .Y(n422) );
  OR2X12M U477 ( .A(n152), .B(n153), .Y(n391) );
  AO21X8M U478 ( .A0(n269), .A1(n215), .B0(n267), .Y(n214) );
  CLKBUFX32M U479 ( .A(n24), .Y(n195) );
  OAI211X8M U480 ( .A0(n250), .A1(n249), .B0(n158), .C0(n248), .Y(n252) );
  XNOR3X8M U481 ( .A(n162), .B(n218), .C(n179), .Y(n217) );
  XNOR3X8M U482 ( .A(n259), .B(n173), .C(n184), .Y(
        \add_3_root_add_0_root_add_135/SUM[10] ) );
  XOR2X8M U483 ( .A(n224), .B(n12), .Y(n263) );
  INVX2M U484 ( .A(net5285), .Y(net5958) );
  XOR3X8M U485 ( .A(n264), .B(n263), .C(n159), .Y(
        \add_3_root_add_0_root_add_135/SUM[9] ) );
  AO21X8M U486 ( .A0(net5047), .A1(n296), .B0(n187), .Y(n312) );
  AOI2BB2X8M U487 ( .B0(n294), .B1(n295), .A0N(n293), .A1N(n186), .Y(n187) );
  CLKINVX8M U488 ( .A(n299), .Y(n317) );
  NAND2X8M U489 ( .A(product[15]), .B(n191), .Y(n165) );
  NAND2X12M U490 ( .A(level7[15]), .B(n193), .Y(n166) );
  CLKNAND2X16M U491 ( .A(n166), .B(n165), .Y(n167) );
  NAND2X12M U492 ( .A(n178), .B(n240), .Y(n237) );
  INVX2M U493 ( .A(net5112), .Y(net5110) );
  XNOR2X8M U494 ( .A(n357), .B(n356), .Y(n362) );
  NAND2BX2M U495 ( .AN(net6152), .B(n195), .Y(n274) );
  AND2X1M U496 ( .A(net5285), .B(net7280), .Y(
        \add_3_root_add_0_root_add_135/B[2] ) );
  NAND2BX1M U497 ( .AN(net7291), .B(net5285), .Y(n281) );
  INVX2M U498 ( .A(n196), .Y(n246) );
  NAND2BX2M U499 ( .AN(net6617), .B(n27), .Y(n304) );
  NAND2BX2M U500 ( .AN(n28), .B(n10), .Y(n306) );
  NAND2BX2M U501 ( .AN(net7314), .B(n27), .Y(n305) );
  NAND2BX1M U502 ( .AN(net7436), .B(n27), .Y(n299) );
  MX2X2M U503 ( .A(product[7]), .B(level7[7]), .S0(n193), .Y(n41) );
  AND2X1M U504 ( .A(net6315), .B(n194), .Y(n175) );
  MX2X2M U505 ( .A(product[5]), .B(level7[5]), .S0(n193), .Y(n39) );
  MX2X2M U506 ( .A(product[6]), .B(level7[6]), .S0(n192), .Y(n40) );
  MX2X2M U507 ( .A(product[4]), .B(level7[4]), .S0(n192), .Y(n38) );
  MX2X2M U508 ( .A(product[3]), .B(level7[3]), .S0(n193), .Y(n37) );
  MX2X2M U509 ( .A(product[2]), .B(level7[2]), .S0(n192), .Y(n36) );
  MX2X2M U510 ( .A(product[1]), .B(level7[1]), .S0(n193), .Y(n35) );
  MX2X2M U511 ( .A(product[0]), .B(level7[0]), .S0(n192), .Y(n34) );
  INVX2M U512 ( .A(en_reg), .Y(n191) );
  BUFX32M U515 ( .A(n228), .Y(n179) );
  XOR3X4M U516 ( .A(n352), .B(n350), .C(n351), .Y(n392) );
  AOI211X4M U517 ( .A0(n317), .A1(n316), .B0(n315), .C0(n314), .Y(n318) );
  AND2X1M U518 ( .A(n121), .B(net7280), .Y(
        \add_1_root_add_0_root_add_135/A[0] ) );
  OAI211X8M U519 ( .A0(n235), .A1(n234), .B0(n233), .C0(n232), .Y(n239) );
  OAI211X8M U520 ( .A0(n231), .A1(n230), .B0(n179), .C0(n229), .Y(n232) );
  NAND2BX2M U521 ( .AN(net6617), .B(n195), .Y(n253) );
  AOI211X4M U522 ( .A0(n221), .A1(n12), .B0(n220), .C0(n264), .Y(n226) );
  CLKXOR2X16M U523 ( .A(n246), .B(n23), .Y(
        \add_3_root_add_0_root_add_135/SUM[13] ) );
  NAND4X12M U524 ( .A(n213), .B(n195), .C(n212), .D(n211), .Y(n267) );
  AOI211X4M U525 ( .A0(n265), .A1(n217), .B0(n261), .C0(n216), .Y(n227) );
  OAI222X4M U526 ( .A0(n160), .A1(n115), .B0(n222), .B1(n219), .C0(n160), .C1(
        n229), .Y(n220) );
  OAI32X4M U527 ( .A0(n227), .A1(n226), .A2(n168), .B0(n263), .B1(n225), .Y(
        n258) );
  CLKINVX8M U528 ( .A(n235), .Y(n230) );
  OAI32X4M U529 ( .A0(n250), .A1(n243), .A2(n242), .B0(n248), .B1(n241), .Y(
        n244) );
  AOI211X4M U530 ( .A0(n317), .A1(n316), .B0(n315), .C0(n314), .Y(net5103) );
  OR3X2M U531 ( .A(n320), .B(n305), .C(n304), .Y(n307) );
  CLKINVX8M U532 ( .A(n332), .Y(n336) );
  NAND2BX4M U533 ( .AN(n17), .B(n336), .Y(n369) );
  OAI32X4M U534 ( .A0(n362), .A1(n433), .A2(n117), .B0(n130), .B1(n361), .Y(
        n364) );
  NAND2BX4M U535 ( .AN(n415), .B(n190), .Y(n421) );
  OAI31X4M U536 ( .A0(n372), .A1(n370), .A2(n371), .B0(n400), .Y(n381) );
  OAI32X4M U537 ( .A0(n397), .A1(n396), .A2(n395), .B0(n394), .B1(n74), .Y(
        n413) );
endmodule


module alu8_top ( clk, rst_n, mode, add_en, mul_en, a, b, result, valid );
  input [7:0] a;
  input [7:0] b;
  output [15:0] result;
  input clk, rst_n, mode, add_en, mul_en;
  output valid;
  wire   add_cout, add_valid, mul_valid, n2, n3, n4, n5, n6;
  wire   [7:0] add_sum;
  wire   [15:0] mul_product;

  AO22X8M U2 ( .A0(mul_valid), .A1(n4), .B0(add_valid), .B1(n5), .Y(valid) );
  AO22X8M U4 ( .A0(mul_product[8]), .A1(n4), .B0(add_cout), .B1(n5), .Y(
        result[8]) );
  AO22X8M U5 ( .A0(mul_product[7]), .A1(n4), .B0(add_sum[7]), .B1(n5), .Y(
        result[7]) );
  AO22X8M U6 ( .A0(mul_product[6]), .A1(n4), .B0(add_sum[6]), .B1(n5), .Y(
        result[6]) );
  AO22X8M U7 ( .A0(mul_product[5]), .A1(n4), .B0(add_sum[5]), .B1(n5), .Y(
        result[5]) );
  AO22X8M U8 ( .A0(mul_product[4]), .A1(n4), .B0(add_sum[4]), .B1(n5), .Y(
        result[4]) );
  AO22X8M U9 ( .A0(mul_product[3]), .A1(n4), .B0(add_sum[3]), .B1(n5), .Y(
        result[3]) );
  AO22X8M U10 ( .A0(mul_product[2]), .A1(n4), .B0(add_sum[2]), .B1(n5), .Y(
        result[2]) );
  AO22X8M U11 ( .A0(mul_product[1]), .A1(n4), .B0(add_sum[1]), .B1(n5), .Y(
        result[1]) );
  AO22X8M U18 ( .A0(mul_product[0]), .A1(n4), .B0(add_sum[0]), .B1(n5), .Y(
        result[0]) );
  add_unit u_add ( .clk(clk), .rst_n(rst_n), .en(add_en), .a({a[7:1], n3}), 
        .b({b[7:1], n2}), .sum(add_sum), .cout(add_cout), .valid(add_valid) );
  mult_unit u_mul ( .clk(clk), .rst_n(rst_n), .en(mul_en), .a({a[7:1], n3}), 
        .b({b[7:1], n2}), .product(mul_product), .valid(mul_valid) );
  BUFX14M U20 ( .A(b[0]), .Y(n2) );
  BUFX14M U21 ( .A(a[0]), .Y(n3) );
  AND2X8M U22 ( .A(mul_product[14]), .B(n4), .Y(result[14]) );
  AND2X8M U23 ( .A(mul_product[9]), .B(n4), .Y(result[9]) );
  CLKBUFX6M U24 ( .A(n6), .Y(n5) );
  INVX2M U25 ( .A(n4), .Y(n6) );
  BUFX10M U26 ( .A(mode), .Y(n4) );
  AND2X8M U27 ( .A(mul_product[10]), .B(n4), .Y(result[10]) );
  AND2X8M U28 ( .A(mul_product[11]), .B(n4), .Y(result[11]) );
  AND2X8M U29 ( .A(mul_product[12]), .B(n4), .Y(result[12]) );
  AND2X8M U30 ( .A(mul_product[13]), .B(n4), .Y(result[13]) );
  AND2X8M U31 ( .A(mul_product[15]), .B(n4), .Y(result[15]) );
endmodule

