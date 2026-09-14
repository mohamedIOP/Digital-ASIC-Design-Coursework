/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06
// Date      : Fri Aug 12 04:01:15 2022
/////////////////////////////////////////////////////////////


module mux2X1_1 ( IN_0, IN_1, SEL, OUT );
  input IN_0, IN_1, SEL;
  output OUT;
  wire   N0;
  assign N0 = SEL;

  MX2X6M U1 ( .A(IN_0), .B(IN_1), .S0(N0), .Y(OUT) );
endmodule


module mux2X1_0 ( IN_0, IN_1, SEL, OUT );
  input IN_0, IN_1, SEL;
  output OUT;
  wire   N0;
  assign N0 = SEL;

  MX2X2M U1 ( .A(IN_0), .B(IN_1), .S0(N0), .Y(OUT) );
endmodule


module Decoder ( IN, OUT );
  input [1:0] IN;
  output [3:0] OUT;
  wire   n1, n2;

  NOR2X6M U1 ( .A(IN[1]), .B(IN[0]), .Y(OUT[0]) );
  NOR2X2M U2 ( .A(n2), .B(n1), .Y(OUT[3]) );
  NOR2X6M U3 ( .A(IN[1]), .B(n2), .Y(OUT[1]) );
  NOR2X2M U4 ( .A(IN[0]), .B(n1), .Y(OUT[2]) );
  INVX2M U5 ( .A(IN[0]), .Y(n2) );
  INVX2M U6 ( .A(IN[1]), .Y(n1) );
endmodule


module ARITHMETIC_UNIT_DW_div_uns_0 ( a, b, quotient, remainder, divide_by_0
 );
  input [7:0] a;
  input [7:0] b;
  output [7:0] quotient;
  output [7:0] remainder;
  output divide_by_0;
  wire   \u_div/SumTmp[1][0] , \u_div/SumTmp[1][1] , \u_div/SumTmp[1][2] ,
         \u_div/SumTmp[1][3] , \u_div/SumTmp[1][4] , \u_div/SumTmp[1][5] ,
         \u_div/SumTmp[1][6] , \u_div/SumTmp[2][0] , \u_div/SumTmp[2][1] ,
         \u_div/SumTmp[2][2] , \u_div/SumTmp[2][3] , \u_div/SumTmp[2][4] ,
         \u_div/SumTmp[2][5] , \u_div/SumTmp[3][0] , \u_div/SumTmp[3][1] ,
         \u_div/SumTmp[3][2] , \u_div/SumTmp[3][3] , \u_div/SumTmp[3][4] ,
         \u_div/SumTmp[4][0] , \u_div/SumTmp[4][1] , \u_div/SumTmp[4][2] ,
         \u_div/SumTmp[4][3] , \u_div/SumTmp[5][0] , \u_div/SumTmp[5][1] ,
         \u_div/SumTmp[5][2] , \u_div/SumTmp[6][0] , \u_div/SumTmp[6][1] ,
         \u_div/SumTmp[7][0] , \u_div/CryTmp[0][1] , \u_div/CryTmp[0][2] ,
         \u_div/CryTmp[0][3] , \u_div/CryTmp[0][4] , \u_div/CryTmp[0][5] ,
         \u_div/CryTmp[0][6] , \u_div/CryTmp[0][7] , \u_div/CryTmp[1][1] ,
         \u_div/CryTmp[1][2] , \u_div/CryTmp[1][3] , \u_div/CryTmp[1][4] ,
         \u_div/CryTmp[1][5] , \u_div/CryTmp[1][6] , \u_div/CryTmp[1][7] ,
         \u_div/CryTmp[2][1] , \u_div/CryTmp[2][2] , \u_div/CryTmp[2][3] ,
         \u_div/CryTmp[2][4] , \u_div/CryTmp[2][5] , \u_div/CryTmp[2][6] ,
         \u_div/CryTmp[3][1] , \u_div/CryTmp[3][2] , \u_div/CryTmp[3][3] ,
         \u_div/CryTmp[3][4] , \u_div/CryTmp[3][5] , \u_div/CryTmp[4][1] ,
         \u_div/CryTmp[4][2] , \u_div/CryTmp[4][3] , \u_div/CryTmp[4][4] ,
         \u_div/CryTmp[5][1] , \u_div/CryTmp[5][2] , \u_div/CryTmp[5][3] ,
         \u_div/CryTmp[6][1] , \u_div/CryTmp[6][2] , \u_div/CryTmp[7][1] ,
         \u_div/PartRem[1][1] , \u_div/PartRem[1][2] , \u_div/PartRem[1][3] ,
         \u_div/PartRem[1][4] , \u_div/PartRem[1][5] , \u_div/PartRem[1][6] ,
         \u_div/PartRem[1][7] , \u_div/PartRem[2][1] , \u_div/PartRem[2][2] ,
         \u_div/PartRem[2][3] , \u_div/PartRem[2][4] , \u_div/PartRem[2][5] ,
         \u_div/PartRem[2][6] , \u_div/PartRem[3][1] , \u_div/PartRem[3][2] ,
         \u_div/PartRem[3][3] , \u_div/PartRem[3][4] , \u_div/PartRem[3][5] ,
         \u_div/PartRem[4][1] , \u_div/PartRem[4][2] , \u_div/PartRem[4][3] ,
         \u_div/PartRem[4][4] , \u_div/PartRem[5][1] , \u_div/PartRem[5][2] ,
         \u_div/PartRem[5][3] , \u_div/PartRem[6][1] , \u_div/PartRem[6][2] ,
         \u_div/PartRem[7][1] , n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11;

  ADDFX2M \u_div/u_fa_PartRem_0_6_1  ( .A(\u_div/PartRem[7][1] ), .B(n7), .CI(
        \u_div/CryTmp[6][1] ), .CO(\u_div/CryTmp[6][2] ), .S(
        \u_div/SumTmp[6][1] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_1_1  ( .A(\u_div/PartRem[2][1] ), .B(n7), .CI(
        \u_div/CryTmp[1][1] ), .CO(\u_div/CryTmp[1][2] ), .S(
        \u_div/SumTmp[1][1] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_2_1  ( .A(\u_div/PartRem[3][1] ), .B(n7), .CI(
        \u_div/CryTmp[2][1] ), .CO(\u_div/CryTmp[2][2] ), .S(
        \u_div/SumTmp[2][1] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_3_1  ( .A(\u_div/PartRem[4][1] ), .B(n7), .CI(
        \u_div/CryTmp[3][1] ), .CO(\u_div/CryTmp[3][2] ), .S(
        \u_div/SumTmp[3][1] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_4_1  ( .A(\u_div/PartRem[5][1] ), .B(n7), .CI(
        \u_div/CryTmp[4][1] ), .CO(\u_div/CryTmp[4][2] ), .S(
        \u_div/SumTmp[4][1] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_5_1  ( .A(\u_div/PartRem[6][1] ), .B(n7), .CI(
        \u_div/CryTmp[5][1] ), .CO(\u_div/CryTmp[5][2] ), .S(
        \u_div/SumTmp[5][1] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_0_1  ( .A(\u_div/PartRem[1][1] ), .B(n7), .CI(
        \u_div/CryTmp[0][1] ), .CO(\u_div/CryTmp[0][2] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_1_6  ( .A(\u_div/PartRem[2][6] ), .B(n2), .CI(
        \u_div/CryTmp[1][6] ), .CO(\u_div/CryTmp[1][7] ), .S(
        \u_div/SumTmp[1][6] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_2_5  ( .A(\u_div/PartRem[3][5] ), .B(n3), .CI(
        \u_div/CryTmp[2][5] ), .CO(\u_div/CryTmp[2][6] ), .S(
        \u_div/SumTmp[2][5] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_4_3  ( .A(\u_div/PartRem[5][3] ), .B(n5), .CI(
        \u_div/CryTmp[4][3] ), .CO(\u_div/CryTmp[4][4] ), .S(
        \u_div/SumTmp[4][3] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_3_4  ( .A(\u_div/PartRem[4][4] ), .B(n4), .CI(
        \u_div/CryTmp[3][4] ), .CO(\u_div/CryTmp[3][5] ), .S(
        \u_div/SumTmp[3][4] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_5_2  ( .A(\u_div/PartRem[6][2] ), .B(n6), .CI(
        \u_div/CryTmp[5][2] ), .CO(\u_div/CryTmp[5][3] ), .S(
        \u_div/SumTmp[5][2] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_0_6  ( .A(\u_div/PartRem[1][6] ), .B(n2), .CI(
        \u_div/CryTmp[0][6] ), .CO(\u_div/CryTmp[0][7] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_0_7  ( .A(\u_div/PartRem[1][7] ), .B(n1), .CI(
        \u_div/CryTmp[0][7] ), .CO(quotient[0]) );
  ADDFX2M \u_div/u_fa_PartRem_0_0_4  ( .A(\u_div/PartRem[1][4] ), .B(n4), .CI(
        \u_div/CryTmp[0][4] ), .CO(\u_div/CryTmp[0][5] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_0_5  ( .A(\u_div/PartRem[1][5] ), .B(n3), .CI(
        \u_div/CryTmp[0][5] ), .CO(\u_div/CryTmp[0][6] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_1_5  ( .A(\u_div/PartRem[2][5] ), .B(n3), .CI(
        \u_div/CryTmp[1][5] ), .CO(\u_div/CryTmp[1][6] ), .S(
        \u_div/SumTmp[1][5] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_1_4  ( .A(\u_div/PartRem[2][4] ), .B(n4), .CI(
        \u_div/CryTmp[1][4] ), .CO(\u_div/CryTmp[1][5] ), .S(
        \u_div/SumTmp[1][4] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_2_4  ( .A(\u_div/PartRem[3][4] ), .B(n4), .CI(
        \u_div/CryTmp[2][4] ), .CO(\u_div/CryTmp[2][5] ), .S(
        \u_div/SumTmp[2][4] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_1_3  ( .A(\u_div/PartRem[2][3] ), .B(n5), .CI(
        \u_div/CryTmp[1][3] ), .CO(\u_div/CryTmp[1][4] ), .S(
        \u_div/SumTmp[1][3] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_2_3  ( .A(\u_div/PartRem[3][3] ), .B(n5), .CI(
        \u_div/CryTmp[2][3] ), .CO(\u_div/CryTmp[2][4] ), .S(
        \u_div/SumTmp[2][3] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_3_3  ( .A(\u_div/PartRem[4][3] ), .B(n5), .CI(
        \u_div/CryTmp[3][3] ), .CO(\u_div/CryTmp[3][4] ), .S(
        \u_div/SumTmp[3][3] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_0_2  ( .A(\u_div/PartRem[1][2] ), .B(n6), .CI(
        \u_div/CryTmp[0][2] ), .CO(\u_div/CryTmp[0][3] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_0_3  ( .A(\u_div/PartRem[1][3] ), .B(n5), .CI(
        \u_div/CryTmp[0][3] ), .CO(\u_div/CryTmp[0][4] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_1_2  ( .A(\u_div/PartRem[2][2] ), .B(n6), .CI(
        \u_div/CryTmp[1][2] ), .CO(\u_div/CryTmp[1][3] ), .S(
        \u_div/SumTmp[1][2] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_2_2  ( .A(\u_div/PartRem[3][2] ), .B(n6), .CI(
        \u_div/CryTmp[2][2] ), .CO(\u_div/CryTmp[2][3] ), .S(
        \u_div/SumTmp[2][2] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_3_2  ( .A(\u_div/PartRem[4][2] ), .B(n6), .CI(
        \u_div/CryTmp[3][2] ), .CO(\u_div/CryTmp[3][3] ), .S(
        \u_div/SumTmp[3][2] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_4_2  ( .A(\u_div/PartRem[5][2] ), .B(n6), .CI(
        \u_div/CryTmp[4][2] ), .CO(\u_div/CryTmp[4][3] ), .S(
        \u_div/SumTmp[4][2] ) );
  INVX8M U1 ( .A(b[0]), .Y(n8) );
  NOR2X4M U2 ( .A(b[6]), .B(b[7]), .Y(n11) );
  AND3X4M U3 ( .A(n11), .B(n3), .C(\u_div/CryTmp[3][5] ), .Y(quotient[3]) );
  CLKAND2X4M U4 ( .A(\u_div/CryTmp[4][4] ), .B(n10), .Y(quotient[4]) );
  CLKAND2X4M U5 ( .A(\u_div/CryTmp[2][6] ), .B(n11), .Y(quotient[2]) );
  CLKAND2X4M U6 ( .A(\u_div/CryTmp[1][7] ), .B(n1), .Y(quotient[1]) );
  AND2X2M U7 ( .A(\u_div/CryTmp[5][3] ), .B(n9), .Y(quotient[5]) );
  MX2X1M U8 ( .A(\u_div/PartRem[3][2] ), .B(\u_div/SumTmp[2][2] ), .S0(
        quotient[2]), .Y(\u_div/PartRem[2][3] ) );
  MX2X1M U9 ( .A(\u_div/PartRem[3][3] ), .B(\u_div/SumTmp[2][3] ), .S0(
        quotient[2]), .Y(\u_div/PartRem[2][4] ) );
  MX2X1M U10 ( .A(\u_div/PartRem[4][3] ), .B(\u_div/SumTmp[3][3] ), .S0(
        quotient[3]), .Y(\u_div/PartRem[3][4] ) );
  MX2X1M U11 ( .A(\u_div/PartRem[4][2] ), .B(\u_div/SumTmp[3][2] ), .S0(
        quotient[3]), .Y(\u_div/PartRem[3][3] ) );
  MX2X1M U12 ( .A(\u_div/PartRem[5][3] ), .B(\u_div/SumTmp[4][3] ), .S0(
        quotient[4]), .Y(\u_div/PartRem[4][4] ) );
  MX2X1M U13 ( .A(\u_div/PartRem[5][2] ), .B(\u_div/SumTmp[4][2] ), .S0(
        quotient[4]), .Y(\u_div/PartRem[4][3] ) );
  MX2X1M U14 ( .A(\u_div/PartRem[6][2] ), .B(\u_div/SumTmp[5][2] ), .S0(
        quotient[5]), .Y(\u_div/PartRem[5][3] ) );
  MX2X1M U15 ( .A(\u_div/PartRem[3][4] ), .B(\u_div/SumTmp[2][4] ), .S0(
        quotient[2]), .Y(\u_div/PartRem[2][5] ) );
  MX2X1M U16 ( .A(\u_div/PartRem[3][5] ), .B(\u_div/SumTmp[2][5] ), .S0(
        quotient[2]), .Y(\u_div/PartRem[2][6] ) );
  MX2X1M U17 ( .A(\u_div/PartRem[4][4] ), .B(\u_div/SumTmp[3][4] ), .S0(
        quotient[3]), .Y(\u_div/PartRem[3][5] ) );
  AND3X2M U18 ( .A(n9), .B(n6), .C(\u_div/CryTmp[6][2] ), .Y(quotient[6]) );
  AND2X2M U19 ( .A(n10), .B(n5), .Y(n9) );
  MX2X1M U20 ( .A(\u_div/PartRem[3][1] ), .B(\u_div/SumTmp[2][1] ), .S0(
        quotient[2]), .Y(\u_div/PartRem[2][2] ) );
  MX2X1M U21 ( .A(\u_div/PartRem[4][1] ), .B(\u_div/SumTmp[3][1] ), .S0(
        quotient[3]), .Y(\u_div/PartRem[3][2] ) );
  MX2X1M U22 ( .A(\u_div/PartRem[5][1] ), .B(\u_div/SumTmp[4][1] ), .S0(
        quotient[4]), .Y(\u_div/PartRem[4][2] ) );
  MX2X1M U23 ( .A(\u_div/PartRem[6][1] ), .B(\u_div/SumTmp[5][1] ), .S0(
        quotient[5]), .Y(\u_div/PartRem[5][2] ) );
  MX2X1M U24 ( .A(\u_div/PartRem[7][1] ), .B(\u_div/SumTmp[6][1] ), .S0(
        quotient[6]), .Y(\u_div/PartRem[6][2] ) );
  INVX4M U25 ( .A(b[2]), .Y(n6) );
  INVX4M U26 ( .A(b[1]), .Y(n7) );
  OR2X2M U27 ( .A(a[7]), .B(n8), .Y(\u_div/CryTmp[7][1] ) );
  XNOR2X2M U28 ( .A(n8), .B(a[2]), .Y(\u_div/SumTmp[2][0] ) );
  XNOR2X2M U29 ( .A(n8), .B(a[3]), .Y(\u_div/SumTmp[3][0] ) );
  XNOR2X2M U30 ( .A(n8), .B(a[4]), .Y(\u_div/SumTmp[4][0] ) );
  XNOR2X2M U31 ( .A(n8), .B(a[5]), .Y(\u_div/SumTmp[5][0] ) );
  XNOR2X2M U32 ( .A(n8), .B(a[6]), .Y(\u_div/SumTmp[6][0] ) );
  XNOR2X2M U33 ( .A(n8), .B(a[7]), .Y(\u_div/SumTmp[7][0] ) );
  NAND2BX2M U34 ( .AN(a[0]), .B(b[0]), .Y(\u_div/CryTmp[0][1] ) );
  OR2X2M U35 ( .A(a[5]), .B(n8), .Y(\u_div/CryTmp[5][1] ) );
  OR2X2M U36 ( .A(a[4]), .B(n8), .Y(\u_div/CryTmp[4][1] ) );
  OR2X2M U37 ( .A(a[3]), .B(n8), .Y(\u_div/CryTmp[3][1] ) );
  OR2X2M U38 ( .A(a[2]), .B(n8), .Y(\u_div/CryTmp[2][1] ) );
  OR2X2M U39 ( .A(a[1]), .B(n8), .Y(\u_div/CryTmp[1][1] ) );
  OR2X2M U40 ( .A(a[6]), .B(n8), .Y(\u_div/CryTmp[6][1] ) );
  INVX4M U41 ( .A(b[4]), .Y(n4) );
  INVX4M U42 ( .A(b[5]), .Y(n3) );
  INVX4M U43 ( .A(b[3]), .Y(n5) );
  INVX2M U44 ( .A(b[6]), .Y(n2) );
  INVX2M U45 ( .A(b[7]), .Y(n1) );
  XNOR2X2M U46 ( .A(n8), .B(a[1]), .Y(\u_div/SumTmp[1][0] ) );
  CLKMX2X2M U47 ( .A(\u_div/PartRem[2][6] ), .B(\u_div/SumTmp[1][6] ), .S0(
        quotient[1]), .Y(\u_div/PartRem[1][7] ) );
  CLKMX2X2M U48 ( .A(a[7]), .B(\u_div/SumTmp[7][0] ), .S0(quotient[7]), .Y(
        \u_div/PartRem[7][1] ) );
  CLKMX2X2M U49 ( .A(\u_div/PartRem[2][5] ), .B(\u_div/SumTmp[1][5] ), .S0(
        quotient[1]), .Y(\u_div/PartRem[1][6] ) );
  CLKMX2X2M U50 ( .A(a[6]), .B(\u_div/SumTmp[6][0] ), .S0(quotient[6]), .Y(
        \u_div/PartRem[6][1] ) );
  CLKMX2X2M U51 ( .A(\u_div/PartRem[2][4] ), .B(\u_div/SumTmp[1][4] ), .S0(
        quotient[1]), .Y(\u_div/PartRem[1][5] ) );
  CLKMX2X2M U52 ( .A(a[5]), .B(\u_div/SumTmp[5][0] ), .S0(quotient[5]), .Y(
        \u_div/PartRem[5][1] ) );
  CLKMX2X2M U53 ( .A(\u_div/PartRem[2][3] ), .B(\u_div/SumTmp[1][3] ), .S0(
        quotient[1]), .Y(\u_div/PartRem[1][4] ) );
  CLKMX2X2M U54 ( .A(a[4]), .B(\u_div/SumTmp[4][0] ), .S0(quotient[4]), .Y(
        \u_div/PartRem[4][1] ) );
  CLKMX2X2M U55 ( .A(\u_div/PartRem[2][2] ), .B(\u_div/SumTmp[1][2] ), .S0(
        quotient[1]), .Y(\u_div/PartRem[1][3] ) );
  CLKMX2X2M U56 ( .A(a[3]), .B(\u_div/SumTmp[3][0] ), .S0(quotient[3]), .Y(
        \u_div/PartRem[3][1] ) );
  CLKMX2X2M U57 ( .A(\u_div/PartRem[2][1] ), .B(\u_div/SumTmp[1][1] ), .S0(
        quotient[1]), .Y(\u_div/PartRem[1][2] ) );
  CLKMX2X2M U58 ( .A(a[2]), .B(\u_div/SumTmp[2][0] ), .S0(quotient[2]), .Y(
        \u_div/PartRem[2][1] ) );
  CLKMX2X2M U59 ( .A(a[1]), .B(\u_div/SumTmp[1][0] ), .S0(quotient[1]), .Y(
        \u_div/PartRem[1][1] ) );
  AND4X1M U60 ( .A(\u_div/CryTmp[7][1] ), .B(n9), .C(n7), .D(n6), .Y(
        quotient[7]) );
  AND3X1M U61 ( .A(n11), .B(n4), .C(n3), .Y(n10) );
endmodule


module ARITHMETIC_UNIT_DW01_sub_0 ( A, B, CI, DIFF, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] DIFF;
  input CI;
  output CO;
  wire   n1, n2, n3, n4, n5, n6, n7, n8;
  wire   [9:0] carry;

  ADDFX2M U2_7 ( .A(A[7]), .B(n1), .CI(carry[7]), .CO(carry[8]), .S(DIFF[7])
         );
  ADDFX2M U2_6 ( .A(A[6]), .B(n2), .CI(carry[6]), .CO(carry[7]), .S(DIFF[6])
         );
  ADDFX2M U2_5 ( .A(A[5]), .B(n3), .CI(carry[5]), .CO(carry[6]), .S(DIFF[5])
         );
  ADDFX2M U2_4 ( .A(A[4]), .B(n4), .CI(carry[4]), .CO(carry[5]), .S(DIFF[4])
         );
  ADDFX2M U2_3 ( .A(A[3]), .B(n5), .CI(carry[3]), .CO(carry[4]), .S(DIFF[3])
         );
  ADDFX2M U2_2 ( .A(A[2]), .B(n6), .CI(carry[2]), .CO(carry[3]), .S(DIFF[2])
         );
  ADDFX2M U2_1 ( .A(A[1]), .B(n7), .CI(carry[1]), .CO(carry[2]), .S(DIFF[1])
         );
  XNOR2X2M U1 ( .A(n8), .B(A[0]), .Y(DIFF[0]) );
  INVX2M U2 ( .A(B[0]), .Y(n8) );
  INVX2M U3 ( .A(B[1]), .Y(n7) );
  OR2X2M U4 ( .A(A[0]), .B(n8), .Y(carry[1]) );
  INVX2M U5 ( .A(B[2]), .Y(n6) );
  INVX2M U6 ( .A(B[3]), .Y(n5) );
  INVX2M U7 ( .A(B[4]), .Y(n4) );
  INVX2M U8 ( .A(B[5]), .Y(n3) );
  INVX2M U9 ( .A(B[6]), .Y(n2) );
  INVX2M U10 ( .A(B[7]), .Y(n1) );
  CLKINVX1M U11 ( .A(carry[8]), .Y(DIFF[8]) );
endmodule


module ARITHMETIC_UNIT_DW01_add_0 ( A, B, CI, SUM, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [8:1] carry;

  ADDFX2M U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(SUM[8]), .S(SUM[7]) );
  ADDFX2M U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(SUM[6])
         );
  ADDFX2M U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(SUM[5])
         );
  ADDFX2M U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(SUM[4])
         );
  ADDFX2M U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(SUM[3])
         );
  ADDFX2M U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(SUM[2])
         );
  ADDFX2M U1_1 ( .A(A[1]), .B(B[1]), .CI(n1), .CO(carry[2]), .S(SUM[1]) );
  AND2X2M U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  CLKXOR2X2M U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module ARITHMETIC_UNIT_DW01_add_1 ( A, B, CI, SUM, CO );
  input [13:0] A;
  input [13:0] B;
  output [13:0] SUM;
  input CI;
  output CO;
  wire   n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20,
         n21, n22, n23, n24, n25, n26;

  OAI21BX4M U2 ( .A0(n19), .A1(n20), .B0N(n21), .Y(n17) );
  AOI2BB1X2M U3 ( .A0N(n8), .A1N(n11), .B0(n10), .Y(n24) );
  NOR2X2M U4 ( .A(B[8]), .B(A[8]), .Y(n14) );
  NOR2X2M U5 ( .A(B[9]), .B(A[9]), .Y(n11) );
  NOR2X2M U6 ( .A(B[10]), .B(A[10]), .Y(n23) );
  NOR2X2M U7 ( .A(B[11]), .B(A[11]), .Y(n19) );
  NAND2X2M U8 ( .A(A[7]), .B(B[7]), .Y(n13) );
  CLKXOR2X2M U9 ( .A(B[13]), .B(n16), .Y(SUM[13]) );
  INVX2M U10 ( .A(n7), .Y(SUM[6]) );
  INVX2M U11 ( .A(A[6]), .Y(n7) );
  CLKXOR2X2M U12 ( .A(A[7]), .B(B[7]), .Y(SUM[7]) );
  BUFX2M U13 ( .A(A[0]), .Y(SUM[0]) );
  BUFX2M U14 ( .A(A[1]), .Y(SUM[1]) );
  BUFX2M U15 ( .A(A[2]), .Y(SUM[2]) );
  BUFX2M U16 ( .A(A[3]), .Y(SUM[3]) );
  BUFX2M U17 ( .A(A[4]), .Y(SUM[4]) );
  BUFX2M U18 ( .A(A[5]), .Y(SUM[5]) );
  XNOR2X1M U19 ( .A(n8), .B(n9), .Y(SUM[9]) );
  NOR2X1M U20 ( .A(n10), .B(n11), .Y(n9) );
  CLKXOR2X2M U21 ( .A(n12), .B(n13), .Y(SUM[8]) );
  NAND2BX1M U22 ( .AN(n14), .B(n15), .Y(n12) );
  OAI2BB1X1M U23 ( .A0N(n17), .A1N(A[12]), .B0(n18), .Y(n16) );
  OAI21X1M U24 ( .A0(A[12]), .A1(n17), .B0(B[12]), .Y(n18) );
  XOR3XLM U25 ( .A(B[12]), .B(A[12]), .C(n17), .Y(SUM[12]) );
  XNOR2X1M U26 ( .A(n20), .B(n22), .Y(SUM[11]) );
  NOR2X1M U27 ( .A(n21), .B(n19), .Y(n22) );
  AND2X1M U28 ( .A(B[11]), .B(A[11]), .Y(n21) );
  OA21X1M U29 ( .A0(n23), .A1(n24), .B0(n25), .Y(n20) );
  CLKXOR2X2M U30 ( .A(n26), .B(n24), .Y(SUM[10]) );
  AND2X1M U31 ( .A(B[9]), .B(A[9]), .Y(n10) );
  OA21X1M U32 ( .A0(n13), .A1(n14), .B0(n15), .Y(n8) );
  CLKNAND2X2M U33 ( .A(B[8]), .B(A[8]), .Y(n15) );
  NAND2BX1M U34 ( .AN(n23), .B(n25), .Y(n26) );
  CLKNAND2X2M U35 ( .A(B[10]), .B(A[10]), .Y(n25) );
endmodule


module ARITHMETIC_UNIT_DW02_mult_0 ( A, B, TC, PRODUCT );
  input [7:0] A;
  input [7:0] B;
  output [15:0] PRODUCT;
  input TC;
  wire   \ab[7][7] , \ab[7][6] , \ab[7][5] , \ab[7][4] , \ab[7][3] ,
         \ab[7][2] , \ab[7][1] , \ab[7][0] , \ab[6][7] , \ab[6][6] ,
         \ab[6][5] , \ab[6][4] , \ab[6][3] , \ab[6][2] , \ab[6][1] ,
         \ab[6][0] , \ab[5][7] , \ab[5][6] , \ab[5][5] , \ab[5][4] ,
         \ab[5][3] , \ab[5][2] , \ab[5][1] , \ab[5][0] , \ab[4][7] ,
         \ab[4][6] , \ab[4][5] , \ab[4][4] , \ab[4][3] , \ab[4][2] ,
         \ab[4][1] , \ab[4][0] , \ab[3][7] , \ab[3][6] , \ab[3][5] ,
         \ab[3][4] , \ab[3][3] , \ab[3][2] , \ab[3][1] , \ab[3][0] ,
         \ab[2][7] , \ab[2][6] , \ab[2][5] , \ab[2][4] , \ab[2][3] ,
         \ab[2][2] , \ab[2][1] , \ab[2][0] , \ab[1][7] , \ab[1][6] ,
         \ab[1][5] , \ab[1][4] , \ab[1][3] , \ab[1][2] , \ab[1][1] ,
         \ab[1][0] , \ab[0][7] , \ab[0][6] , \ab[0][5] , \ab[0][4] ,
         \ab[0][3] , \ab[0][2] , \ab[0][1] , \CARRYB[7][6] , \CARRYB[7][5] ,
         \CARRYB[7][4] , \CARRYB[7][3] , \CARRYB[7][2] , \CARRYB[7][1] ,
         \CARRYB[7][0] , \CARRYB[6][6] , \CARRYB[6][5] , \CARRYB[6][4] ,
         \CARRYB[6][3] , \CARRYB[6][2] , \CARRYB[6][1] , \CARRYB[6][0] ,
         \CARRYB[5][6] , \CARRYB[5][5] , \CARRYB[5][4] , \CARRYB[5][3] ,
         \CARRYB[5][2] , \CARRYB[5][1] , \CARRYB[5][0] , \CARRYB[4][6] ,
         \CARRYB[4][5] , \CARRYB[4][4] , \CARRYB[4][3] , \CARRYB[4][2] ,
         \CARRYB[4][1] , \CARRYB[4][0] , \CARRYB[3][6] , \CARRYB[3][5] ,
         \CARRYB[3][4] , \CARRYB[3][3] , \CARRYB[3][2] , \CARRYB[3][1] ,
         \CARRYB[3][0] , \CARRYB[2][6] , \CARRYB[2][5] , \CARRYB[2][4] ,
         \CARRYB[2][3] , \CARRYB[2][2] , \CARRYB[2][1] , \CARRYB[2][0] ,
         \SUMB[7][6] , \SUMB[7][5] , \SUMB[7][4] , \SUMB[7][3] , \SUMB[7][2] ,
         \SUMB[7][1] , \SUMB[7][0] , \SUMB[6][6] , \SUMB[6][5] , \SUMB[6][4] ,
         \SUMB[6][3] , \SUMB[6][2] , \SUMB[6][1] , \SUMB[5][6] , \SUMB[5][5] ,
         \SUMB[5][4] , \SUMB[5][3] , \SUMB[5][2] , \SUMB[5][1] , \SUMB[4][6] ,
         \SUMB[4][5] , \SUMB[4][4] , \SUMB[4][3] , \SUMB[4][2] , \SUMB[4][1] ,
         \SUMB[3][6] , \SUMB[3][5] , \SUMB[3][4] , \SUMB[3][3] , \SUMB[3][2] ,
         \SUMB[3][1] , \SUMB[2][6] , \SUMB[2][5] , \SUMB[2][4] , \SUMB[2][3] ,
         \SUMB[2][2] , \SUMB[2][1] , \SUMB[1][6] , \SUMB[1][5] , \SUMB[1][4] ,
         \SUMB[1][3] , \SUMB[1][2] , \SUMB[1][1] , \A1[12] , \A1[11] ,
         \A1[10] , \A1[9] , \A1[8] , \A1[7] , \A1[6] , \A1[4] , \A1[3] ,
         \A1[2] , \A1[1] , \A1[0] , n3, n4, n5, n6, n7, n8, n9, n10, n11, n12,
         n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26,
         n27, n28, n29, n30, n31, n32;

  ADDFX2M S5_6 ( .A(\ab[7][6] ), .B(\CARRYB[6][6] ), .CI(\ab[6][7] ), .CO(
        \CARRYB[7][6] ), .S(\SUMB[7][6] ) );
  ADDFX2M S3_6_6 ( .A(\ab[6][6] ), .B(\CARRYB[5][6] ), .CI(\ab[5][7] ), .CO(
        \CARRYB[6][6] ), .S(\SUMB[6][6] ) );
  ADDFX2M S4_5 ( .A(\ab[7][5] ), .B(\CARRYB[6][5] ), .CI(\SUMB[6][6] ), .CO(
        \CARRYB[7][5] ), .S(\SUMB[7][5] ) );
  ADDFX2M S1_6_0 ( .A(\ab[6][0] ), .B(\CARRYB[5][0] ), .CI(\SUMB[5][1] ), .CO(
        \CARRYB[6][0] ), .S(\A1[4] ) );
  ADDFX2M S1_5_0 ( .A(\ab[5][0] ), .B(\CARRYB[4][0] ), .CI(\SUMB[4][1] ), .CO(
        \CARRYB[5][0] ), .S(\A1[3] ) );
  ADDFX2M S1_4_0 ( .A(\ab[4][0] ), .B(\CARRYB[3][0] ), .CI(\SUMB[3][1] ), .CO(
        \CARRYB[4][0] ), .S(\A1[2] ) );
  ADDFX2M S1_3_0 ( .A(\ab[3][0] ), .B(\CARRYB[2][0] ), .CI(\SUMB[2][1] ), .CO(
        \CARRYB[3][0] ), .S(\A1[1] ) );
  ADDFX2M S1_2_0 ( .A(\ab[2][0] ), .B(n9), .CI(\SUMB[1][1] ), .CO(
        \CARRYB[2][0] ), .S(\A1[0] ) );
  ADDFX2M S2_6_5 ( .A(\ab[6][5] ), .B(\CARRYB[5][5] ), .CI(\SUMB[5][6] ), .CO(
        \CARRYB[6][5] ), .S(\SUMB[6][5] ) );
  ADDFX2M S3_5_6 ( .A(\ab[5][6] ), .B(\CARRYB[4][6] ), .CI(\ab[4][7] ), .CO(
        \CARRYB[5][6] ), .S(\SUMB[5][6] ) );
  ADDFX2M S4_0 ( .A(\ab[7][0] ), .B(\CARRYB[6][0] ), .CI(\SUMB[6][1] ), .CO(
        \CARRYB[7][0] ), .S(\SUMB[7][0] ) );
  ADDFX2M S4_4 ( .A(\ab[7][4] ), .B(\CARRYB[6][4] ), .CI(\SUMB[6][5] ), .CO(
        \CARRYB[7][4] ), .S(\SUMB[7][4] ) );
  ADDFX2M S2_6_3 ( .A(\ab[6][3] ), .B(\CARRYB[5][3] ), .CI(\SUMB[5][4] ), .CO(
        \CARRYB[6][3] ), .S(\SUMB[6][3] ) );
  ADDFX2M S2_5_4 ( .A(\ab[5][4] ), .B(\CARRYB[4][4] ), .CI(\SUMB[4][5] ), .CO(
        \CARRYB[5][4] ), .S(\SUMB[5][4] ) );
  ADDFX2M S2_6_1 ( .A(\ab[6][1] ), .B(\CARRYB[5][1] ), .CI(\SUMB[5][2] ), .CO(
        \CARRYB[6][1] ), .S(\SUMB[6][1] ) );
  ADDFX2M S2_6_2 ( .A(\ab[6][2] ), .B(\CARRYB[5][2] ), .CI(\SUMB[5][3] ), .CO(
        \CARRYB[6][2] ), .S(\SUMB[6][2] ) );
  ADDFX2M S2_4_5 ( .A(\ab[4][5] ), .B(\CARRYB[3][5] ), .CI(\SUMB[3][6] ), .CO(
        \CARRYB[4][5] ), .S(\SUMB[4][5] ) );
  ADDFX2M S2_5_1 ( .A(\ab[5][1] ), .B(\CARRYB[4][1] ), .CI(\SUMB[4][2] ), .CO(
        \CARRYB[5][1] ), .S(\SUMB[5][1] ) );
  ADDFX2M S2_5_2 ( .A(\ab[5][2] ), .B(\CARRYB[4][2] ), .CI(\SUMB[4][3] ), .CO(
        \CARRYB[5][2] ), .S(\SUMB[5][2] ) );
  ADDFX2M S2_5_3 ( .A(\ab[5][3] ), .B(\CARRYB[4][3] ), .CI(\SUMB[4][4] ), .CO(
        \CARRYB[5][3] ), .S(\SUMB[5][3] ) );
  ADDFX2M S2_4_1 ( .A(\ab[4][1] ), .B(\CARRYB[3][1] ), .CI(\SUMB[3][2] ), .CO(
        \CARRYB[4][1] ), .S(\SUMB[4][1] ) );
  ADDFX2M S2_4_2 ( .A(\ab[4][2] ), .B(\CARRYB[3][2] ), .CI(\SUMB[3][3] ), .CO(
        \CARRYB[4][2] ), .S(\SUMB[4][2] ) );
  ADDFX2M S2_4_3 ( .A(\ab[4][3] ), .B(\CARRYB[3][3] ), .CI(\SUMB[3][4] ), .CO(
        \CARRYB[4][3] ), .S(\SUMB[4][3] ) );
  ADDFX2M S2_3_1 ( .A(\ab[3][1] ), .B(\CARRYB[2][1] ), .CI(\SUMB[2][2] ), .CO(
        \CARRYB[3][1] ), .S(\SUMB[3][1] ) );
  ADDFX2M S2_3_2 ( .A(\ab[3][2] ), .B(\CARRYB[2][2] ), .CI(\SUMB[2][3] ), .CO(
        \CARRYB[3][2] ), .S(\SUMB[3][2] ) );
  ADDFX2M S2_3_3 ( .A(\ab[3][3] ), .B(\CARRYB[2][3] ), .CI(\SUMB[2][4] ), .CO(
        \CARRYB[3][3] ), .S(\SUMB[3][3] ) );
  ADDFX2M S2_3_5 ( .A(\ab[3][5] ), .B(\CARRYB[2][5] ), .CI(\SUMB[2][6] ), .CO(
        \CARRYB[3][5] ), .S(\SUMB[3][5] ) );
  ADDFX2M S2_6_4 ( .A(\ab[6][4] ), .B(\CARRYB[5][4] ), .CI(\SUMB[5][5] ), .CO(
        \CARRYB[6][4] ), .S(\SUMB[6][4] ) );
  ADDFX2M S2_5_5 ( .A(\ab[5][5] ), .B(\CARRYB[4][5] ), .CI(\SUMB[4][6] ), .CO(
        \CARRYB[5][5] ), .S(\SUMB[5][5] ) );
  ADDFX2M S2_4_4 ( .A(\ab[4][4] ), .B(\CARRYB[3][4] ), .CI(\SUMB[3][5] ), .CO(
        \CARRYB[4][4] ), .S(\SUMB[4][4] ) );
  ADDFX2M S2_3_4 ( .A(\ab[3][4] ), .B(\CARRYB[2][4] ), .CI(\SUMB[2][5] ), .CO(
        \CARRYB[3][4] ), .S(\SUMB[3][4] ) );
  ADDFX2M S3_4_6 ( .A(\ab[4][6] ), .B(\CARRYB[3][6] ), .CI(\ab[3][7] ), .CO(
        \CARRYB[4][6] ), .S(\SUMB[4][6] ) );
  ADDFX2M S3_3_6 ( .A(\ab[3][6] ), .B(\CARRYB[2][6] ), .CI(\ab[2][7] ), .CO(
        \CARRYB[3][6] ), .S(\SUMB[3][6] ) );
  ADDFX2M S3_2_6 ( .A(\ab[2][6] ), .B(n8), .CI(\ab[1][7] ), .CO(\CARRYB[2][6] ), .S(\SUMB[2][6] ) );
  ADDFX2M S2_2_2 ( .A(\ab[2][2] ), .B(n5), .CI(\SUMB[1][3] ), .CO(
        \CARRYB[2][2] ), .S(\SUMB[2][2] ) );
  ADDFX2M S2_2_3 ( .A(\ab[2][3] ), .B(n4), .CI(\SUMB[1][4] ), .CO(
        \CARRYB[2][3] ), .S(\SUMB[2][3] ) );
  ADDFX2M S2_2_4 ( .A(\ab[2][4] ), .B(n3), .CI(\SUMB[1][5] ), .CO(
        \CARRYB[2][4] ), .S(\SUMB[2][4] ) );
  ADDFX2M S2_2_5 ( .A(\ab[2][5] ), .B(n7), .CI(\SUMB[1][6] ), .CO(
        \CARRYB[2][5] ), .S(\SUMB[2][5] ) );
  ADDFX2M S4_1 ( .A(\ab[7][1] ), .B(\CARRYB[6][1] ), .CI(\SUMB[6][2] ), .CO(
        \CARRYB[7][1] ), .S(\SUMB[7][1] ) );
  ADDFX2M S4_3 ( .A(\ab[7][3] ), .B(\CARRYB[6][3] ), .CI(\SUMB[6][4] ), .CO(
        \CARRYB[7][3] ), .S(\SUMB[7][3] ) );
  ADDFX2M S4_2 ( .A(\ab[7][2] ), .B(\CARRYB[6][2] ), .CI(\SUMB[6][3] ), .CO(
        \CARRYB[7][2] ), .S(\SUMB[7][2] ) );
  ADDFX2M S2_2_1 ( .A(\ab[2][1] ), .B(n6), .CI(\SUMB[1][2] ), .CO(
        \CARRYB[2][1] ), .S(\SUMB[2][1] ) );
  AND2X2M U2 ( .A(\ab[0][5] ), .B(\ab[1][4] ), .Y(n3) );
  AND2X2M U3 ( .A(\ab[0][4] ), .B(\ab[1][3] ), .Y(n4) );
  AND2X2M U4 ( .A(\ab[0][3] ), .B(\ab[1][2] ), .Y(n5) );
  AND2X2M U5 ( .A(\ab[0][2] ), .B(\ab[1][1] ), .Y(n6) );
  AND2X2M U6 ( .A(\ab[0][6] ), .B(\ab[1][5] ), .Y(n7) );
  AND2X2M U7 ( .A(\ab[0][7] ), .B(\ab[1][6] ), .Y(n8) );
  AND2X2M U8 ( .A(\ab[0][1] ), .B(\ab[1][0] ), .Y(n9) );
  AND2X2M U9 ( .A(\CARRYB[7][6] ), .B(\ab[7][7] ), .Y(n10) );
  NOR2X2M U10 ( .A(n28), .B(n24), .Y(\ab[0][4] ) );
  NOR2X2M U11 ( .A(n29), .B(n24), .Y(\ab[0][3] ) );
  CLKXOR2X2M U12 ( .A(\ab[1][3] ), .B(\ab[0][4] ), .Y(\SUMB[1][3] ) );
  NOR2X2M U13 ( .A(n31), .B(n24), .Y(\ab[0][1] ) );
  NOR2X2M U14 ( .A(n25), .B(n24), .Y(\ab[0][7] ) );
  NOR2X2M U15 ( .A(n26), .B(n24), .Y(\ab[0][6] ) );
  NOR2X2M U16 ( .A(n27), .B(n24), .Y(\ab[0][5] ) );
  NOR2X2M U17 ( .A(n30), .B(n24), .Y(\ab[0][2] ) );
  NOR2X2M U18 ( .A(n32), .B(n23), .Y(\ab[1][0] ) );
  NOR2X2M U19 ( .A(n26), .B(n23), .Y(\ab[1][6] ) );
  NOR2X2M U20 ( .A(n27), .B(n23), .Y(\ab[1][5] ) );
  NOR2X2M U21 ( .A(n28), .B(n23), .Y(\ab[1][4] ) );
  NOR2X2M U22 ( .A(n29), .B(n23), .Y(\ab[1][3] ) );
  NOR2X2M U23 ( .A(n30), .B(n23), .Y(\ab[1][2] ) );
  NOR2X2M U24 ( .A(n31), .B(n23), .Y(\ab[1][1] ) );
  NOR2X2M U25 ( .A(n17), .B(n25), .Y(\ab[7][7] ) );
  CLKXOR2X2M U26 ( .A(\CARRYB[7][2] ), .B(\SUMB[7][3] ), .Y(\A1[8] ) );
  AND2X2M U27 ( .A(\CARRYB[7][1] ), .B(\SUMB[7][2] ), .Y(n11) );
  CLKXOR2X2M U28 ( .A(\CARRYB[7][1] ), .B(\SUMB[7][2] ), .Y(\A1[7] ) );
  CLKXOR2X2M U29 ( .A(\CARRYB[7][3] ), .B(\SUMB[7][4] ), .Y(\A1[9] ) );
  AND2X2M U30 ( .A(\CARRYB[7][0] ), .B(\SUMB[7][1] ), .Y(n12) );
  AND2X2M U31 ( .A(\CARRYB[7][2] ), .B(\SUMB[7][3] ), .Y(n13) );
  CLKXOR2X2M U32 ( .A(\CARRYB[7][4] ), .B(\SUMB[7][5] ), .Y(\A1[10] ) );
  AND2X2M U33 ( .A(\CARRYB[7][3] ), .B(\SUMB[7][4] ), .Y(n14) );
  CLKXOR2X2M U34 ( .A(\CARRYB[7][5] ), .B(\SUMB[7][6] ), .Y(\A1[11] ) );
  AND2X2M U35 ( .A(\CARRYB[7][4] ), .B(\SUMB[7][5] ), .Y(n15) );
  CLKXOR2X2M U36 ( .A(\CARRYB[7][6] ), .B(\ab[7][7] ), .Y(\A1[12] ) );
  CLKXOR2X2M U37 ( .A(\CARRYB[7][0] ), .B(\SUMB[7][1] ), .Y(\A1[6] ) );
  AND2X2M U38 ( .A(\CARRYB[7][5] ), .B(\SUMB[7][6] ), .Y(n16) );
  XOR2X1M U39 ( .A(\ab[1][0] ), .B(\ab[0][1] ), .Y(PRODUCT[1]) );
  XOR2X1M U40 ( .A(\ab[1][2] ), .B(\ab[0][3] ), .Y(\SUMB[1][2] ) );
  XOR2X1M U41 ( .A(\ab[1][6] ), .B(\ab[0][7] ), .Y(\SUMB[1][6] ) );
  XOR2X1M U42 ( .A(\ab[1][5] ), .B(\ab[0][6] ), .Y(\SUMB[1][5] ) );
  XOR2X1M U43 ( .A(\ab[1][4] ), .B(\ab[0][5] ), .Y(\SUMB[1][4] ) );
  XOR2X1M U44 ( .A(\ab[1][1] ), .B(\ab[0][2] ), .Y(\SUMB[1][1] ) );
  INVX4M U45 ( .A(B[6]), .Y(n26) );
  INVX4M U46 ( .A(B[4]), .Y(n28) );
  INVX4M U47 ( .A(B[5]), .Y(n27) );
  INVX4M U48 ( .A(B[3]), .Y(n29) );
  INVX4M U49 ( .A(B[7]), .Y(n25) );
  INVX4M U50 ( .A(A[1]), .Y(n23) );
  INVX4M U51 ( .A(A[0]), .Y(n24) );
  INVX4M U52 ( .A(B[1]), .Y(n31) );
  INVX4M U53 ( .A(B[2]), .Y(n30) );
  INVX4M U54 ( .A(A[2]), .Y(n22) );
  INVX4M U55 ( .A(B[0]), .Y(n32) );
  INVX4M U56 ( .A(A[3]), .Y(n21) );
  INVX4M U57 ( .A(A[4]), .Y(n20) );
  INVX4M U58 ( .A(A[5]), .Y(n19) );
  INVX4M U59 ( .A(A[7]), .Y(n17) );
  INVX4M U60 ( .A(A[6]), .Y(n18) );
  NOR2X1M U62 ( .A(n17), .B(n26), .Y(\ab[7][6] ) );
  NOR2X1M U63 ( .A(n17), .B(n27), .Y(\ab[7][5] ) );
  NOR2X1M U64 ( .A(n17), .B(n28), .Y(\ab[7][4] ) );
  NOR2X1M U65 ( .A(n17), .B(n29), .Y(\ab[7][3] ) );
  NOR2X1M U66 ( .A(n17), .B(n30), .Y(\ab[7][2] ) );
  NOR2X1M U67 ( .A(n17), .B(n31), .Y(\ab[7][1] ) );
  NOR2X1M U68 ( .A(n17), .B(n32), .Y(\ab[7][0] ) );
  NOR2X1M U69 ( .A(n25), .B(n18), .Y(\ab[6][7] ) );
  NOR2X1M U70 ( .A(n26), .B(n18), .Y(\ab[6][6] ) );
  NOR2X1M U71 ( .A(n27), .B(n18), .Y(\ab[6][5] ) );
  NOR2X1M U72 ( .A(n28), .B(n18), .Y(\ab[6][4] ) );
  NOR2X1M U73 ( .A(n29), .B(n18), .Y(\ab[6][3] ) );
  NOR2X1M U74 ( .A(n30), .B(n18), .Y(\ab[6][2] ) );
  NOR2X1M U75 ( .A(n31), .B(n18), .Y(\ab[6][1] ) );
  NOR2X1M U76 ( .A(n32), .B(n18), .Y(\ab[6][0] ) );
  NOR2X1M U77 ( .A(n25), .B(n19), .Y(\ab[5][7] ) );
  NOR2X1M U78 ( .A(n26), .B(n19), .Y(\ab[5][6] ) );
  NOR2X1M U79 ( .A(n27), .B(n19), .Y(\ab[5][5] ) );
  NOR2X1M U80 ( .A(n28), .B(n19), .Y(\ab[5][4] ) );
  NOR2X1M U81 ( .A(n29), .B(n19), .Y(\ab[5][3] ) );
  NOR2X1M U82 ( .A(n30), .B(n19), .Y(\ab[5][2] ) );
  NOR2X1M U83 ( .A(n31), .B(n19), .Y(\ab[5][1] ) );
  NOR2X1M U84 ( .A(n32), .B(n19), .Y(\ab[5][0] ) );
  NOR2X1M U85 ( .A(n25), .B(n20), .Y(\ab[4][7] ) );
  NOR2X1M U86 ( .A(n26), .B(n20), .Y(\ab[4][6] ) );
  NOR2X1M U87 ( .A(n27), .B(n20), .Y(\ab[4][5] ) );
  NOR2X1M U88 ( .A(n28), .B(n20), .Y(\ab[4][4] ) );
  NOR2X1M U89 ( .A(n29), .B(n20), .Y(\ab[4][3] ) );
  NOR2X1M U90 ( .A(n30), .B(n20), .Y(\ab[4][2] ) );
  NOR2X1M U91 ( .A(n31), .B(n20), .Y(\ab[4][1] ) );
  NOR2X1M U92 ( .A(n32), .B(n20), .Y(\ab[4][0] ) );
  NOR2X1M U93 ( .A(n25), .B(n21), .Y(\ab[3][7] ) );
  NOR2X1M U94 ( .A(n26), .B(n21), .Y(\ab[3][6] ) );
  NOR2X1M U95 ( .A(n27), .B(n21), .Y(\ab[3][5] ) );
  NOR2X1M U96 ( .A(n28), .B(n21), .Y(\ab[3][4] ) );
  NOR2X1M U97 ( .A(n29), .B(n21), .Y(\ab[3][3] ) );
  NOR2X1M U98 ( .A(n30), .B(n21), .Y(\ab[3][2] ) );
  NOR2X1M U99 ( .A(n31), .B(n21), .Y(\ab[3][1] ) );
  NOR2X1M U100 ( .A(n32), .B(n21), .Y(\ab[3][0] ) );
  NOR2X1M U101 ( .A(n25), .B(n22), .Y(\ab[2][7] ) );
  NOR2X1M U102 ( .A(n26), .B(n22), .Y(\ab[2][6] ) );
  NOR2X1M U103 ( .A(n27), .B(n22), .Y(\ab[2][5] ) );
  NOR2X1M U104 ( .A(n28), .B(n22), .Y(\ab[2][4] ) );
  NOR2X1M U105 ( .A(n29), .B(n22), .Y(\ab[2][3] ) );
  NOR2X1M U106 ( .A(n30), .B(n22), .Y(\ab[2][2] ) );
  NOR2X1M U107 ( .A(n31), .B(n22), .Y(\ab[2][1] ) );
  NOR2X1M U108 ( .A(n32), .B(n22), .Y(\ab[2][0] ) );
  NOR2X1M U109 ( .A(n25), .B(n23), .Y(\ab[1][7] ) );
  NOR2X1M U110 ( .A(n32), .B(n24), .Y(PRODUCT[0]) );
  ARITHMETIC_UNIT_DW01_add_1 FS_1 ( .A({1'b0, \A1[12] , \A1[11] , \A1[10] , 
        \A1[9] , \A1[8] , \A1[7] , \A1[6] , \SUMB[7][0] , \A1[4] , \A1[3] , 
        \A1[2] , \A1[1] , \A1[0] }), .B({n10, n16, n15, n14, n13, n11, n12, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0}), .CI(1'b0), .SUM(
        PRODUCT[15:2]) );
endmodule


module ARITHMETIC_UNIT_test_1 ( A, B, ALU_FUNC, CLK, RST, Arith_enable, 
        Carry_OUT, Arith_OUT, Arith_Flag, test_si, test_se );
  input [7:0] A;
  input [7:0] B;
  input [1:0] ALU_FUNC;
  output [15:0] Arith_OUT;
  input CLK, RST, Arith_enable, test_si, test_se;
  output Carry_OUT, Arith_Flag;
  wire   N17, N18, N19, N20, N21, N22, N23, N24, N25, N26, N27, N28, N29, N30,
         N31, N32, N33, N34, N35, N36, N37, N38, N39, N40, N41, N42, N43, N44,
         N45, N46, N47, N48, N49, N50, N51, N52, N53, N54, N55, N56, N57, N58,
         n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40,
         n41, n42, n43, n44, n45, n46, n47, n48, n61, n62, n63, n64, n65, n66,
         n67, n68, n69, n70;
  wire   [15:0] Arith_OUT_comb;

  SDFFRQX1M Arith_Flag_reg ( .D(Arith_enable), .SI(test_si), .SE(test_se), 
        .CK(CLK), .RN(RST), .Q(Arith_Flag) );
  SDFFRQX1M \Arith_OUT_reg[6]  ( .D(Arith_OUT_comb[6]), .SI(Arith_OUT[5]), 
        .SE(test_se), .CK(CLK), .RN(n65), .Q(Arith_OUT[6]) );
  SDFFRQX1M \Arith_OUT_reg[5]  ( .D(Arith_OUT_comb[5]), .SI(Arith_OUT[4]), 
        .SE(test_se), .CK(CLK), .RN(n66), .Q(Arith_OUT[5]) );
  SDFFRQX1M \Arith_OUT_reg[7]  ( .D(Arith_OUT_comb[7]), .SI(Arith_OUT[6]), 
        .SE(test_se), .CK(CLK), .RN(n65), .Q(Arith_OUT[7]) );
  SDFFRQX1M \Arith_OUT_reg[9]  ( .D(Arith_OUT_comb[9]), .SI(Arith_OUT[8]), 
        .SE(test_se), .CK(CLK), .RN(n65), .Q(Arith_OUT[9]) );
  SDFFRQX1M Carry_OUT_reg ( .D(n68), .SI(Arith_OUT[15]), .SE(test_se), .CK(CLK), .RN(n65), .Q(Carry_OUT) );
  SDFFRQX1M \Arith_OUT_reg[8]  ( .D(n68), .SI(Arith_OUT[7]), .SE(test_se), 
        .CK(CLK), .RN(n65), .Q(Arith_OUT[8]) );
  SDFFRQX1M \Arith_OUT_reg[10]  ( .D(Arith_OUT_comb[10]), .SI(Arith_OUT[9]), 
        .SE(test_se), .CK(CLK), .RN(n65), .Q(Arith_OUT[10]) );
  SDFFRQX1M \Arith_OUT_reg[11]  ( .D(Arith_OUT_comb[11]), .SI(Arith_OUT[10]), 
        .SE(test_se), .CK(CLK), .RN(n65), .Q(Arith_OUT[11]) );
  SDFFRQX1M \Arith_OUT_reg[4]  ( .D(Arith_OUT_comb[4]), .SI(Arith_OUT[3]), 
        .SE(test_se), .CK(CLK), .RN(n66), .Q(Arith_OUT[4]) );
  SDFFRQX1M \Arith_OUT_reg[12]  ( .D(Arith_OUT_comb[12]), .SI(Arith_OUT[11]), 
        .SE(test_se), .CK(CLK), .RN(n65), .Q(Arith_OUT[12]) );
  SDFFRQX1M \Arith_OUT_reg[13]  ( .D(Arith_OUT_comb[13]), .SI(Arith_OUT[12]), 
        .SE(test_se), .CK(CLK), .RN(n65), .Q(Arith_OUT[13]) );
  SDFFRQX1M \Arith_OUT_reg[14]  ( .D(Arith_OUT_comb[14]), .SI(Arith_OUT[13]), 
        .SE(test_se), .CK(CLK), .RN(n65), .Q(Arith_OUT[14]) );
  SDFFRQX1M \Arith_OUT_reg[15]  ( .D(Arith_OUT_comb[15]), .SI(Arith_OUT[14]), 
        .SE(test_se), .CK(CLK), .RN(n65), .Q(Arith_OUT[15]) );
  SDFFRQX1M \Arith_OUT_reg[3]  ( .D(Arith_OUT_comb[3]), .SI(Arith_OUT[2]), 
        .SE(test_se), .CK(CLK), .RN(n66), .Q(Arith_OUT[3]) );
  SDFFRQX1M \Arith_OUT_reg[2]  ( .D(Arith_OUT_comb[2]), .SI(Arith_OUT[1]), 
        .SE(test_se), .CK(CLK), .RN(n66), .Q(Arith_OUT[2]) );
  SDFFRQX1M \Arith_OUT_reg[1]  ( .D(Arith_OUT_comb[1]), .SI(Arith_OUT[0]), 
        .SE(test_se), .CK(CLK), .RN(n66), .Q(Arith_OUT[1]) );
  SDFFRQX1M \Arith_OUT_reg[0]  ( .D(Arith_OUT_comb[0]), .SI(Arith_Flag), .SE(
        test_se), .CK(CLK), .RN(n66), .Q(Arith_OUT[0]) );
  BUFX4M U41 ( .A(n33), .Y(n61) );
  NOR3BX2M U42 ( .AN(Arith_enable), .B(n69), .C(n70), .Y(n33) );
  CLKAND2X4M U43 ( .A(N34), .B(n63), .Y(n28) );
  CLKBUFX8M U44 ( .A(n27), .Y(n62) );
  NAND2X2M U45 ( .A(n45), .B(n46), .Y(Arith_OUT_comb[1]) );
  AOI22X1M U46 ( .A0(N36), .A1(n62), .B0(N27), .B1(n63), .Y(n45) );
  AOI22X1M U47 ( .A0(N52), .A1(n61), .B0(N18), .B1(n64), .Y(n46) );
  NAND2X2M U48 ( .A(n43), .B(n44), .Y(Arith_OUT_comb[2]) );
  AOI22X1M U49 ( .A0(N37), .A1(n62), .B0(N28), .B1(n63), .Y(n43) );
  AOI22X1M U50 ( .A0(N53), .A1(n61), .B0(N19), .B1(n64), .Y(n44) );
  NAND2X2M U51 ( .A(n41), .B(n42), .Y(Arith_OUT_comb[3]) );
  AOI22X1M U52 ( .A0(N38), .A1(n62), .B0(N29), .B1(n63), .Y(n41) );
  AOI22X1M U53 ( .A0(N54), .A1(n61), .B0(N20), .B1(n64), .Y(n42) );
  NAND2X2M U54 ( .A(n39), .B(n40), .Y(Arith_OUT_comb[4]) );
  AOI22X1M U55 ( .A0(N39), .A1(n62), .B0(N30), .B1(n63), .Y(n39) );
  AOI22X1M U56 ( .A0(N55), .A1(n61), .B0(N21), .B1(n64), .Y(n40) );
  AO21XLM U57 ( .A0(N50), .A1(n62), .B0(n28), .Y(Arith_OUT_comb[15]) );
  AO21XLM U58 ( .A0(N49), .A1(n62), .B0(n28), .Y(Arith_OUT_comb[14]) );
  NAND2X2M U59 ( .A(n37), .B(n38), .Y(Arith_OUT_comb[5]) );
  AOI22X1M U60 ( .A0(N40), .A1(n62), .B0(N31), .B1(n63), .Y(n37) );
  AOI22X1M U61 ( .A0(N56), .A1(n61), .B0(N22), .B1(n64), .Y(n38) );
  AO21XLM U62 ( .A0(N48), .A1(n62), .B0(n28), .Y(Arith_OUT_comb[13]) );
  AO21XLM U63 ( .A0(N47), .A1(n62), .B0(n28), .Y(Arith_OUT_comb[12]) );
  NAND2X2M U64 ( .A(n35), .B(n36), .Y(Arith_OUT_comb[6]) );
  AOI22X1M U65 ( .A0(N41), .A1(n62), .B0(N32), .B1(n63), .Y(n35) );
  AOI22X1M U66 ( .A0(N57), .A1(n61), .B0(N23), .B1(n64), .Y(n36) );
  AO21XLM U67 ( .A0(N45), .A1(n62), .B0(n28), .Y(Arith_OUT_comb[10]) );
  AO21XLM U68 ( .A0(N46), .A1(n62), .B0(n28), .Y(Arith_OUT_comb[11]) );
  INVX2M U69 ( .A(n29), .Y(n68) );
  AOI221X2M U70 ( .A0(N43), .A1(n62), .B0(N25), .B1(n64), .C0(n28), .Y(n29) );
  NAND2X2M U71 ( .A(n31), .B(n32), .Y(Arith_OUT_comb[7]) );
  AOI22X1M U72 ( .A0(N58), .A1(n61), .B0(N24), .B1(n64), .Y(n32) );
  AOI22X1M U73 ( .A0(N42), .A1(n62), .B0(N33), .B1(n63), .Y(n31) );
  AO21XLM U74 ( .A0(N44), .A1(n62), .B0(n28), .Y(Arith_OUT_comb[9]) );
  INVX6M U75 ( .A(n67), .Y(n65) );
  INVX4M U76 ( .A(n67), .Y(n66) );
  NAND2X2M U77 ( .A(n47), .B(n48), .Y(Arith_OUT_comb[0]) );
  AOI22X1M U78 ( .A0(N35), .A1(n62), .B0(N26), .B1(n63), .Y(n47) );
  AOI22X1M U79 ( .A0(N51), .A1(n61), .B0(N17), .B1(n64), .Y(n48) );
  INVX2M U80 ( .A(ALU_FUNC[0]), .Y(n70) );
  INVX2M U81 ( .A(ALU_FUNC[1]), .Y(n69) );
  NOR3BX2M U82 ( .AN(Arith_enable), .B(n69), .C(ALU_FUNC[0]), .Y(n27) );
  CLKBUFX6M U83 ( .A(n34), .Y(n63) );
  NOR3BX2M U84 ( .AN(Arith_enable), .B(ALU_FUNC[1]), .C(n70), .Y(n34) );
  CLKBUFX6M U85 ( .A(n30), .Y(n64) );
  NOR3BX2M U86 ( .AN(Arith_enable), .B(ALU_FUNC[0]), .C(ALU_FUNC[1]), .Y(n30)
         );
  INVX2M U87 ( .A(RST), .Y(n67) );
  ARITHMETIC_UNIT_DW_div_uns_0 div_63 ( .a(A), .b(B), .quotient({N58, N57, N56, 
        N55, N54, N53, N52, N51}) );
  ARITHMETIC_UNIT_DW01_sub_0 sub_55 ( .A({1'b0, A}), .B({1'b0, B}), .CI(1'b0), 
        .DIFF({N34, N33, N32, N31, N30, N29, N28, N27, N26}) );
  ARITHMETIC_UNIT_DW01_add_0 add_51 ( .A({1'b0, A}), .B({1'b0, B}), .CI(1'b0), 
        .SUM({N25, N24, N23, N22, N21, N20, N19, N18, N17}) );
  ARITHMETIC_UNIT_DW02_mult_0 mult_59 ( .A(A), .B(B), .TC(1'b0), .PRODUCT({N50, 
        N49, N48, N47, N46, N45, N44, N43, N42, N41, N40, N39, N38, N37, N36, 
        N35}) );
endmodule


module LOGIC_UNIT_test_1 ( A, B, ALU_FUNC, CLK, RST, Logic_enable, Logic_OUT, 
        Logic_Flag, test_si, test_se );
  input [7:0] A;
  input [7:0] B;
  input [1:0] ALU_FUNC;
  output [7:0] Logic_OUT;
  input CLK, RST, Logic_enable, test_si, test_se;
  output Logic_Flag;
  wire   n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38,
         n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52,
         n19, n20, n21, n22, n23, n24, n53, n54, n55, n56, n57, n58, n59, n60,
         n61, n62, n63, n64, n65;
  wire   [7:0] Logic_OUT_comb;

  SDFFRQX1M Logic_Flag_reg ( .D(Logic_enable), .SI(test_si), .SE(test_se), 
        .CK(CLK), .RN(n21), .Q(Logic_Flag) );
  SDFFRQX1M \Logic_OUT_reg[7]  ( .D(Logic_OUT_comb[7]), .SI(Logic_OUT[6]), 
        .SE(test_se), .CK(CLK), .RN(n21), .Q(Logic_OUT[7]) );
  SDFFRQX1M \Logic_OUT_reg[3]  ( .D(Logic_OUT_comb[3]), .SI(Logic_OUT[2]), 
        .SE(test_se), .CK(CLK), .RN(n21), .Q(Logic_OUT[3]) );
  SDFFRQX1M \Logic_OUT_reg[2]  ( .D(Logic_OUT_comb[2]), .SI(Logic_OUT[1]), 
        .SE(test_se), .CK(CLK), .RN(n21), .Q(Logic_OUT[2]) );
  SDFFRQX1M \Logic_OUT_reg[0]  ( .D(Logic_OUT_comb[0]), .SI(Logic_Flag), .SE(
        test_se), .CK(CLK), .RN(n21), .Q(Logic_OUT[0]) );
  SDFFRQX1M \Logic_OUT_reg[5]  ( .D(Logic_OUT_comb[5]), .SI(Logic_OUT[4]), 
        .SE(test_se), .CK(CLK), .RN(n21), .Q(Logic_OUT[5]) );
  SDFFRQX1M \Logic_OUT_reg[4]  ( .D(Logic_OUT_comb[4]), .SI(Logic_OUT[3]), 
        .SE(test_se), .CK(CLK), .RN(n21), .Q(Logic_OUT[4]) );
  SDFFRQX1M \Logic_OUT_reg[1]  ( .D(Logic_OUT_comb[1]), .SI(Logic_OUT[0]), 
        .SE(test_se), .CK(CLK), .RN(n21), .Q(Logic_OUT[1]) );
  SDFFRQX1M \Logic_OUT_reg[6]  ( .D(Logic_OUT_comb[6]), .SI(Logic_OUT[5]), 
        .SE(test_se), .CK(CLK), .RN(n21), .Q(Logic_OUT[6]) );
  CLKBUFX8M U21 ( .A(n28), .Y(n19) );
  CLKBUFX8M U22 ( .A(n29), .Y(n20) );
  NAND2X4M U23 ( .A(Logic_enable), .B(n65), .Y(n33) );
  OAI21X2M U24 ( .A0(n33), .A1(n57), .B0(n20), .Y(n52) );
  OAI21X2M U25 ( .A0(n33), .A1(n56), .B0(n20), .Y(n49) );
  OAI21X2M U26 ( .A0(n33), .A1(n55), .B0(n20), .Y(n46) );
  OAI21X2M U27 ( .A0(n33), .A1(n54), .B0(n20), .Y(n43) );
  OAI21X2M U28 ( .A0(n33), .A1(n53), .B0(n20), .Y(n40) );
  OAI21X2M U29 ( .A0(n33), .A1(n24), .B0(n20), .Y(n37) );
  OAI21X2M U30 ( .A0(n33), .A1(n23), .B0(n20), .Y(n32) );
  NAND2X4M U31 ( .A(Logic_enable), .B(ALU_FUNC[1]), .Y(n34) );
  OAI221X1M U32 ( .A0(A[0]), .A1(n19), .B0(n20), .B1(n57), .C0(n50), .Y(
        Logic_OUT_comb[0]) );
  AOI22X1M U33 ( .A0(n51), .A1(n64), .B0(B[0]), .B1(n52), .Y(n50) );
  INVX2M U34 ( .A(B[0]), .Y(n64) );
  OAI21X2M U35 ( .A0(A[0]), .A1(n34), .B0(n19), .Y(n51) );
  OAI221X1M U36 ( .A0(A[1]), .A1(n19), .B0(n20), .B1(n56), .C0(n47), .Y(
        Logic_OUT_comb[1]) );
  AOI22X1M U37 ( .A0(n48), .A1(n63), .B0(B[1]), .B1(n49), .Y(n47) );
  INVX2M U38 ( .A(B[1]), .Y(n63) );
  OAI21X2M U39 ( .A0(A[1]), .A1(n34), .B0(n19), .Y(n48) );
  OAI221X1M U40 ( .A0(A[2]), .A1(n19), .B0(n20), .B1(n55), .C0(n44), .Y(
        Logic_OUT_comb[2]) );
  AOI22X1M U41 ( .A0(n45), .A1(n62), .B0(B[2]), .B1(n46), .Y(n44) );
  INVX2M U42 ( .A(B[2]), .Y(n62) );
  OAI21X2M U43 ( .A0(A[2]), .A1(n34), .B0(n19), .Y(n45) );
  OAI221X1M U44 ( .A0(A[3]), .A1(n19), .B0(n20), .B1(n54), .C0(n41), .Y(
        Logic_OUT_comb[3]) );
  AOI22X1M U45 ( .A0(n42), .A1(n61), .B0(B[3]), .B1(n43), .Y(n41) );
  INVX2M U46 ( .A(B[3]), .Y(n61) );
  OAI21X2M U47 ( .A0(A[3]), .A1(n34), .B0(n19), .Y(n42) );
  OAI221X1M U48 ( .A0(A[4]), .A1(n19), .B0(n20), .B1(n53), .C0(n38), .Y(
        Logic_OUT_comb[4]) );
  AOI22X1M U49 ( .A0(n39), .A1(n60), .B0(B[4]), .B1(n40), .Y(n38) );
  INVX2M U50 ( .A(B[4]), .Y(n60) );
  OAI21X2M U51 ( .A0(A[4]), .A1(n34), .B0(n19), .Y(n39) );
  OAI221X1M U52 ( .A0(A[5]), .A1(n19), .B0(n20), .B1(n24), .C0(n35), .Y(
        Logic_OUT_comb[5]) );
  AOI22X1M U53 ( .A0(n36), .A1(n59), .B0(B[5]), .B1(n37), .Y(n35) );
  INVX2M U54 ( .A(B[5]), .Y(n59) );
  OAI21X2M U55 ( .A0(A[5]), .A1(n34), .B0(n19), .Y(n36) );
  OAI221X1M U56 ( .A0(A[6]), .A1(n19), .B0(n23), .B1(n20), .C0(n30), .Y(
        Logic_OUT_comb[6]) );
  AOI22X1M U57 ( .A0(n31), .A1(n58), .B0(B[6]), .B1(n32), .Y(n30) );
  INVX2M U58 ( .A(B[6]), .Y(n58) );
  OAI21X2M U59 ( .A0(A[6]), .A1(n34), .B0(n19), .Y(n31) );
  NAND3BX2M U60 ( .AN(ALU_FUNC[0]), .B(ALU_FUNC[1]), .C(Logic_enable), .Y(n28)
         );
  NAND3X2M U61 ( .A(ALU_FUNC[0]), .B(n65), .C(Logic_enable), .Y(n29) );
  INVX2M U62 ( .A(ALU_FUNC[1]), .Y(n65) );
  INVX2M U63 ( .A(A[6]), .Y(n23) );
  INVX2M U64 ( .A(A[1]), .Y(n56) );
  INVX2M U65 ( .A(A[2]), .Y(n55) );
  INVX2M U66 ( .A(A[3]), .Y(n54) );
  INVX2M U67 ( .A(A[4]), .Y(n53) );
  INVX2M U68 ( .A(A[5]), .Y(n24) );
  INVX2M U69 ( .A(A[0]), .Y(n57) );
  NOR2BX2M U70 ( .AN(Logic_enable), .B(n25), .Y(Logic_OUT_comb[7]) );
  XNOR2X2M U71 ( .A(ALU_FUNC[1]), .B(n26), .Y(n25) );
  OAI2BB1XLM U72 ( .A0N(ALU_FUNC[0]), .A1N(A[7]), .B0(n27), .Y(n26) );
  OAI21X2M U73 ( .A0(ALU_FUNC[0]), .A1(A[7]), .B0(B[7]), .Y(n27) );
  INVX6M U74 ( .A(n22), .Y(n21) );
  INVX2M U75 ( .A(RST), .Y(n22) );
endmodule


module SHIFT_UNIT_test_1 ( A, B, ALU_FUNC, CLK, RST, Shift_enable, Shift_OUT, 
        Shift_Flag, test_si, test_se );
  input [7:0] A;
  input [7:0] B;
  input [1:0] ALU_FUNC;
  output [7:0] Shift_OUT;
  input CLK, RST, Shift_enable, test_si, test_se;
  output Shift_Flag;
  wire   n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26,
         n27, n28, n29, n30, n37, n38, n39, n40, n41;
  wire   [7:0] Shift_OUT_comb;

  SDFFRQX1M Shift_Flag_reg ( .D(Shift_enable), .SI(test_si), .SE(test_se), 
        .CK(CLK), .RN(n37), .Q(Shift_Flag) );
  SDFFRQX1M \Shift_OUT_reg[0]  ( .D(Shift_OUT_comb[0]), .SI(Shift_Flag), .SE(
        test_se), .CK(CLK), .RN(n37), .Q(Shift_OUT[0]) );
  SDFFRQX1M \Shift_OUT_reg[7]  ( .D(Shift_OUT_comb[7]), .SI(Shift_OUT[6]), 
        .SE(test_se), .CK(CLK), .RN(n37), .Q(Shift_OUT[7]) );
  SDFFRQX1M \Shift_OUT_reg[1]  ( .D(Shift_OUT_comb[1]), .SI(Shift_OUT[0]), 
        .SE(test_se), .CK(CLK), .RN(n37), .Q(Shift_OUT[1]) );
  SDFFRQX1M \Shift_OUT_reg[2]  ( .D(Shift_OUT_comb[2]), .SI(Shift_OUT[1]), 
        .SE(test_se), .CK(CLK), .RN(n37), .Q(Shift_OUT[2]) );
  SDFFRQX1M \Shift_OUT_reg[6]  ( .D(Shift_OUT_comb[6]), .SI(Shift_OUT[5]), 
        .SE(test_se), .CK(CLK), .RN(n37), .Q(Shift_OUT[6]) );
  SDFFRQX1M \Shift_OUT_reg[3]  ( .D(Shift_OUT_comb[3]), .SI(Shift_OUT[2]), 
        .SE(test_se), .CK(CLK), .RN(n37), .Q(Shift_OUT[3]) );
  SDFFRQX1M \Shift_OUT_reg[5]  ( .D(Shift_OUT_comb[5]), .SI(Shift_OUT[4]), 
        .SE(test_se), .CK(CLK), .RN(n37), .Q(Shift_OUT[5]) );
  SDFFRQX1M \Shift_OUT_reg[4]  ( .D(Shift_OUT_comb[4]), .SI(Shift_OUT[3]), 
        .SE(test_se), .CK(CLK), .RN(n37), .Q(Shift_OUT[4]) );
  INVX4M U21 ( .A(Shift_enable), .Y(n39) );
  NOR2X8M U22 ( .A(n40), .B(n41), .Y(n14) );
  NOR2X8M U23 ( .A(n40), .B(ALU_FUNC[0]), .Y(n18) );
  NOR2X8M U24 ( .A(ALU_FUNC[0]), .B(ALU_FUNC[1]), .Y(n19) );
  NOR2X8M U25 ( .A(n41), .B(ALU_FUNC[1]), .Y(n15) );
  NOR2X2M U26 ( .A(n13), .B(n39), .Y(Shift_OUT_comb[7]) );
  AOI22X1M U27 ( .A0(B[6]), .A1(n14), .B0(A[6]), .B1(n15), .Y(n13) );
  AOI21X2M U28 ( .A0(n28), .A1(n29), .B0(n39), .Y(Shift_OUT_comb[1]) );
  AOI22X1M U29 ( .A0(A[0]), .A1(n15), .B0(A[2]), .B1(n19), .Y(n28) );
  AOI22X1M U30 ( .A0(B[0]), .A1(n14), .B0(B[2]), .B1(n18), .Y(n29) );
  AOI21X2M U31 ( .A0(n26), .A1(n27), .B0(n39), .Y(Shift_OUT_comb[2]) );
  AOI22X1M U32 ( .A0(A[1]), .A1(n15), .B0(A[3]), .B1(n19), .Y(n26) );
  AOI22X1M U33 ( .A0(B[1]), .A1(n14), .B0(B[3]), .B1(n18), .Y(n27) );
  AOI21X2M U34 ( .A0(n24), .A1(n25), .B0(n39), .Y(Shift_OUT_comb[3]) );
  AOI22X1M U35 ( .A0(A[2]), .A1(n15), .B0(A[4]), .B1(n19), .Y(n24) );
  AOI22X1M U36 ( .A0(B[2]), .A1(n14), .B0(B[4]), .B1(n18), .Y(n25) );
  AOI21X2M U37 ( .A0(n22), .A1(n23), .B0(n39), .Y(Shift_OUT_comb[4]) );
  AOI22X1M U38 ( .A0(A[3]), .A1(n15), .B0(n19), .B1(A[5]), .Y(n22) );
  AOI22X1M U39 ( .A0(B[3]), .A1(n14), .B0(n18), .B1(B[5]), .Y(n23) );
  AOI21X2M U40 ( .A0(n20), .A1(n21), .B0(n39), .Y(Shift_OUT_comb[5]) );
  AOI22X1M U41 ( .A0(A[4]), .A1(n15), .B0(n19), .B1(A[6]), .Y(n20) );
  AOI22X1M U42 ( .A0(B[4]), .A1(n14), .B0(n18), .B1(B[6]), .Y(n21) );
  AOI21X2M U43 ( .A0(n16), .A1(n17), .B0(n39), .Y(Shift_OUT_comb[6]) );
  AOI22X1M U44 ( .A0(A[5]), .A1(n15), .B0(A[7]), .B1(n19), .Y(n16) );
  AOI22X1M U45 ( .A0(B[5]), .A1(n14), .B0(B[7]), .B1(n18), .Y(n17) );
  NOR2X2M U46 ( .A(n30), .B(n39), .Y(Shift_OUT_comb[0]) );
  AOI22X1M U47 ( .A0(B[1]), .A1(n18), .B0(A[1]), .B1(n19), .Y(n30) );
  INVX2M U48 ( .A(ALU_FUNC[1]), .Y(n40) );
  INVX2M U49 ( .A(ALU_FUNC[0]), .Y(n41) );
  INVX6M U50 ( .A(n38), .Y(n37) );
  INVX2M U51 ( .A(RST), .Y(n38) );
endmodule


module CMP_UNIT_test_1 ( A, B, ALU_FUNC, CLK, RST, CMP_enable, CMP_OUT, 
        CMP_Flag, test_si, test_se );
  input [7:0] A;
  input [7:0] B;
  input [1:0] ALU_FUNC;
  output [2:0] CMP_OUT;
  input CLK, RST, CMP_enable, test_si, test_se;
  output CMP_Flag;
  wire   N17, N19, n11, n12, n9, n10, n13, n14, n15, n16, n17, n18, n19, n20,
         n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34,
         n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48,
         n49, n50;
  wire   [1:0] CMP_OUT_comb;

  SDFFRQX1M CMP_Flag_reg ( .D(CMP_enable), .SI(test_si), .SE(test_se), .CK(CLK), .RN(n9), .Q(CMP_Flag) );
  SDFFRQX1M \CMP_OUT_reg[1]  ( .D(CMP_OUT_comb[1]), .SI(CMP_OUT[0]), .SE(
        test_se), .CK(CLK), .RN(n9), .Q(CMP_OUT[1]) );
  SDFFRQX1M \CMP_OUT_reg[0]  ( .D(CMP_OUT_comb[0]), .SI(CMP_Flag), .SE(test_se), .CK(CLK), .RN(n9), .Q(CMP_OUT[0]) );
  AOI2B1X1M U9 ( .A1N(n36), .A0(n35), .B0(n34), .Y(n37) );
  INVX2M U10 ( .A(n37), .Y(n47) );
  XNOR2X4M U14 ( .A(A[6]), .B(B[6]), .Y(n31) );
  OAI31X2M U15 ( .A0(n24), .A1(n15), .A2(n14), .B0(n25), .Y(n17) );
  AOI211X2M U16 ( .A0(A[1]), .A1(n42), .B0(n21), .C0(n13), .Y(n14) );
  AOI211X2M U17 ( .A0(n22), .A1(n43), .B0(n21), .C0(n20), .Y(n23) );
  NAND2BX2M U18 ( .AN(n15), .B(n26), .Y(n21) );
  OAI21X4M U19 ( .A0(n34), .A1(n19), .B0(n35), .Y(N19) );
  NOR2X2M U20 ( .A(n39), .B(A[2]), .Y(n15) );
  NOR2X2M U21 ( .A(n38), .B(A[0]), .Y(n10) );
  NOR2X2M U22 ( .A(n40), .B(A[3]), .Y(n24) );
  NOR2X2M U23 ( .A(n46), .B(B[7]), .Y(n34) );
  INVX2M U24 ( .A(CMP_enable), .Y(n48) );
  INVX2M U25 ( .A(A[6]), .Y(n45) );
  INVXLM U26 ( .A(n10), .Y(n42) );
  NOR3X2M U27 ( .A(n48), .B(n12), .C(n50), .Y(CMP_OUT_comb[0]) );
  AOI22X1M U28 ( .A0(N17), .A1(n49), .B0(ALU_FUNC[1]), .B1(N19), .Y(n12) );
  INVX2M U29 ( .A(B[0]), .Y(n38) );
  NOR3X2M U30 ( .A(n48), .B(n11), .C(n49), .Y(CMP_OUT_comb[1]) );
  AOI22X1M U31 ( .A0(n47), .A1(n50), .B0(N19), .B1(ALU_FUNC[0]), .Y(n11) );
  INVX2M U32 ( .A(B[2]), .Y(n39) );
  INVX2M U33 ( .A(B[6]), .Y(n41) );
  INVXLM U34 ( .A(n23), .Y(n44) );
  INVX2M U35 ( .A(A[1]), .Y(n43) );
  INVX2M U36 ( .A(B[3]), .Y(n40) );
  INVX2M U37 ( .A(A[7]), .Y(n46) );
  INVX2M U38 ( .A(ALU_FUNC[1]), .Y(n49) );
  INVX2M U39 ( .A(ALU_FUNC[0]), .Y(n50) );
  BUFX2M U40 ( .A(RST), .Y(n9) );
  NAND2BX1M U41 ( .AN(B[4]), .B(A[4]), .Y(n27) );
  NAND2BX1M U42 ( .AN(A[4]), .B(B[4]), .Y(n16) );
  CLKNAND2X2M U43 ( .A(n27), .B(n16), .Y(n29) );
  CLKNAND2X2M U44 ( .A(A[2]), .B(n39), .Y(n26) );
  AOI21X1M U45 ( .A0(n10), .A1(n43), .B0(B[1]), .Y(n13) );
  CLKNAND2X2M U46 ( .A(A[3]), .B(n40), .Y(n25) );
  NAND2BX1M U47 ( .AN(A[5]), .B(B[5]), .Y(n32) );
  OAI211X1M U48 ( .A0(n29), .A1(n17), .B0(n16), .C0(n32), .Y(n18) );
  NAND2BX1M U49 ( .AN(B[5]), .B(A[5]), .Y(n28) );
  AOI32X1M U50 ( .A0(n18), .A1(n28), .A2(n31), .B0(B[6]), .B1(n45), .Y(n19) );
  CLKNAND2X2M U51 ( .A(B[7]), .B(n46), .Y(n35) );
  CLKNAND2X2M U52 ( .A(A[0]), .B(n38), .Y(n22) );
  OA21X1M U53 ( .A0(n22), .A1(n43), .B0(B[1]), .Y(n20) );
  AOI31X1M U54 ( .A0(n44), .A1(n26), .A2(n25), .B0(n24), .Y(n30) );
  OAI2B11X1M U55 ( .A1N(n30), .A0(n29), .B0(n28), .C0(n27), .Y(n33) );
  AOI32X1M U56 ( .A0(n33), .A1(n32), .A2(n31), .B0(A[6]), .B1(n41), .Y(n36) );
  NOR2X1M U57 ( .A(N19), .B(n47), .Y(N17) );
  INVX2M U3 ( .A(1'b1), .Y(CMP_OUT[2]) );
endmodule


module ALU_TOP ( scan_clk, scan_rst, test_mode, SI, SE, SO, A, B, ALU_FUNC, 
        CLK, RST, Arith_OUT, Carry_OUT, Arith_Flag, Logic_OUT, Logic_Flag, 
        Shift_OUT, Shift_Flag, CMP_OUT, CMP_Flag );
  input [7:0] A;
  input [7:0] B;
  input [3:0] ALU_FUNC;
  output [15:0] Arith_OUT;
  output [7:0] Logic_OUT;
  output [7:0] Shift_OUT;
  output [2:0] CMP_OUT;
  input scan_clk, scan_rst, test_mode, SI, SE, CLK, RST;
  output SO, Carry_OUT, Arith_Flag, Logic_Flag, Shift_Flag, CMP_Flag;
  wire   n105, n106, n107, n108, n109, n110, n111, n112, n113, n114, n115,
         n116, n117, n118, n119, n120, n121, n122, n123, n124, n125, n126,
         n127, n128, n129, n130, n131, n132, n133, n134, n135, n136, n137,
         n138, n139, n140, n142, n143, n144, scan_fun_clk, scan_fun_rst,
         Shift_enable, CMP_enable, Logic_enable, Arith_enable, n3, n4, n5, n7,
         n9, n11, n13, n15, n17, n19, n21, n23, n25, n27, n29, n31, n33, n35,
         n37, n39, n41, n43, n45, n47, n49, n51, n53, n55, n57, n59, n61, n63,
         n65, n67, n69, n71, n73, n75, n77, n79, n81, n83, n84, n85, n86, n87,
         n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100,
         n101, n102, n103, n104;
  wire   SYNOPSYS_UNCONNECTED__0;
  assign SO = n132;

  INVXLM U3 ( .A(n104), .Y(n3) );
  CLKINVX1M U4 ( .A(n104), .Y(n4) );
  BUFX6M U5 ( .A(B[6]), .Y(n93) );
  CLKBUFX6M U6 ( .A(B[4]), .Y(n91) );
  CLKBUFX6M U7 ( .A(B[5]), .Y(n92) );
  CLKBUFX6M U8 ( .A(B[1]), .Y(n88) );
  CLKBUFX6M U9 ( .A(A[7]), .Y(n102) );
  CLKBUFX8M U10 ( .A(A[6]), .Y(n101) );
  BUFX6M U11 ( .A(A[0]), .Y(n95) );
  CLKBUFX8M U12 ( .A(A[1]), .Y(n96) );
  BUFX6M U13 ( .A(ALU_FUNC[1]), .Y(n84) );
  BUFX6M U14 ( .A(ALU_FUNC[0]), .Y(n83) );
  INVX2M U15 ( .A(n104), .Y(n103) );
  CLKBUFX6M U16 ( .A(B[7]), .Y(n94) );
  CLKBUFX6M U17 ( .A(B[0]), .Y(n87) );
  CLKBUFX6M U18 ( .A(B[3]), .Y(n90) );
  CLKBUFX6M U19 ( .A(B[2]), .Y(n89) );
  CLKBUFX8M U20 ( .A(A[5]), .Y(n100) );
  CLKBUFX8M U21 ( .A(A[4]), .Y(n99) );
  CLKBUFX8M U22 ( .A(A[3]), .Y(n98) );
  CLKBUFX8M U23 ( .A(A[2]), .Y(n97) );
  BUFX2M U24 ( .A(ALU_FUNC[3]), .Y(n86) );
  BUFX2M U25 ( .A(ALU_FUNC[2]), .Y(n85) );
  INVX2M U26 ( .A(scan_fun_rst), .Y(n104) );
  CLKINVX1M U27 ( .A(n144), .Y(n5) );
  CLKINVX40M U28 ( .A(n5), .Y(CMP_Flag) );
  CLKINVX1M U29 ( .A(n143), .Y(n7) );
  CLKINVX40M U30 ( .A(n7), .Y(CMP_OUT[0]) );
  CLKINVX1M U31 ( .A(n142), .Y(n9) );
  CLKINVX40M U32 ( .A(n9), .Y(CMP_OUT[1]) );
  CLKINVX1M U33 ( .A(n140), .Y(n11) );
  CLKINVX40M U34 ( .A(n11), .Y(Shift_Flag) );
  CLKINVX1M U35 ( .A(n139), .Y(n13) );
  CLKINVX40M U36 ( .A(n13), .Y(Shift_OUT[0]) );
  CLKINVX1M U37 ( .A(n138), .Y(n15) );
  CLKINVX40M U38 ( .A(n15), .Y(Shift_OUT[1]) );
  CLKINVX1M U39 ( .A(n137), .Y(n17) );
  CLKINVX40M U40 ( .A(n17), .Y(Shift_OUT[2]) );
  CLKINVX1M U41 ( .A(n136), .Y(n19) );
  CLKINVX40M U42 ( .A(n19), .Y(Shift_OUT[3]) );
  CLKINVX1M U43 ( .A(n135), .Y(n21) );
  CLKINVX40M U44 ( .A(n21), .Y(Shift_OUT[4]) );
  CLKINVX1M U45 ( .A(n134), .Y(n23) );
  CLKINVX40M U46 ( .A(n23), .Y(Shift_OUT[5]) );
  CLKINVX1M U47 ( .A(n133), .Y(n25) );
  CLKINVX40M U48 ( .A(n25), .Y(Shift_OUT[6]) );
  CLKINVX1M U49 ( .A(n132), .Y(n27) );
  CLKINVX40M U50 ( .A(n27), .Y(Shift_OUT[7]) );
  CLKINVX1M U51 ( .A(n131), .Y(n29) );
  CLKINVX40M U52 ( .A(n29), .Y(Logic_Flag) );
  CLKINVX1M U53 ( .A(n130), .Y(n31) );
  CLKINVX40M U54 ( .A(n31), .Y(Logic_OUT[0]) );
  CLKINVX1M U55 ( .A(n129), .Y(n33) );
  CLKINVX40M U56 ( .A(n33), .Y(Logic_OUT[1]) );
  CLKINVX1M U57 ( .A(n128), .Y(n35) );
  CLKINVX40M U58 ( .A(n35), .Y(Logic_OUT[2]) );
  CLKINVX1M U59 ( .A(n127), .Y(n37) );
  CLKINVX40M U60 ( .A(n37), .Y(Logic_OUT[3]) );
  CLKINVX1M U61 ( .A(n126), .Y(n39) );
  CLKINVX40M U62 ( .A(n39), .Y(Logic_OUT[4]) );
  CLKINVX1M U63 ( .A(n125), .Y(n41) );
  CLKINVX40M U64 ( .A(n41), .Y(Logic_OUT[5]) );
  CLKINVX1M U65 ( .A(n124), .Y(n43) );
  CLKINVX40M U66 ( .A(n43), .Y(Logic_OUT[6]) );
  CLKINVX1M U67 ( .A(n123), .Y(n45) );
  CLKINVX40M U68 ( .A(n45), .Y(Logic_OUT[7]) );
  CLKINVX1M U69 ( .A(n122), .Y(n47) );
  CLKINVX40M U70 ( .A(n47), .Y(Arith_Flag) );
  CLKINVX1M U71 ( .A(n121), .Y(n49) );
  CLKINVX40M U72 ( .A(n49), .Y(Carry_OUT) );
  CLKINVX1M U73 ( .A(n120), .Y(n51) );
  CLKINVX40M U74 ( .A(n51), .Y(Arith_OUT[0]) );
  CLKINVX1M U75 ( .A(n119), .Y(n53) );
  CLKINVX40M U76 ( .A(n53), .Y(Arith_OUT[1]) );
  CLKINVX1M U77 ( .A(n118), .Y(n55) );
  CLKINVX40M U78 ( .A(n55), .Y(Arith_OUT[2]) );
  CLKINVX1M U79 ( .A(n117), .Y(n57) );
  CLKINVX40M U80 ( .A(n57), .Y(Arith_OUT[3]) );
  CLKINVX1M U81 ( .A(n116), .Y(n59) );
  CLKINVX40M U82 ( .A(n59), .Y(Arith_OUT[4]) );
  CLKINVX1M U83 ( .A(n115), .Y(n61) );
  CLKINVX40M U84 ( .A(n61), .Y(Arith_OUT[5]) );
  CLKINVX1M U85 ( .A(n114), .Y(n63) );
  CLKINVX40M U86 ( .A(n63), .Y(Arith_OUT[6]) );
  CLKINVX1M U87 ( .A(n113), .Y(n65) );
  CLKINVX40M U88 ( .A(n65), .Y(Arith_OUT[7]) );
  CLKINVX1M U89 ( .A(n112), .Y(n67) );
  CLKINVX40M U90 ( .A(n67), .Y(Arith_OUT[8]) );
  CLKINVX1M U91 ( .A(n111), .Y(n69) );
  CLKINVX40M U92 ( .A(n69), .Y(Arith_OUT[9]) );
  CLKINVX1M U93 ( .A(n110), .Y(n71) );
  CLKINVX40M U94 ( .A(n71), .Y(Arith_OUT[10]) );
  CLKINVX1M U95 ( .A(n109), .Y(n73) );
  CLKINVX40M U96 ( .A(n73), .Y(Arith_OUT[11]) );
  CLKINVX1M U97 ( .A(n108), .Y(n75) );
  CLKINVX40M U98 ( .A(n75), .Y(Arith_OUT[12]) );
  CLKINVX1M U99 ( .A(n107), .Y(n77) );
  CLKINVX40M U100 ( .A(n77), .Y(Arith_OUT[13]) );
  CLKINVX1M U101 ( .A(n106), .Y(n79) );
  CLKINVX40M U102 ( .A(n79), .Y(Arith_OUT[14]) );
  CLKINVX1M U103 ( .A(n105), .Y(n81) );
  CLKINVX40M U104 ( .A(n81), .Y(Arith_OUT[15]) );
  mux2X1_1 U0_clk_mux ( .IN_0(CLK), .IN_1(scan_clk), .SEL(test_mode), .OUT(
        scan_fun_clk) );
  mux2X1_0 U0_rst_mux ( .IN_0(RST), .IN_1(scan_rst), .SEL(test_mode), .OUT(
        scan_fun_rst) );
  Decoder U0 ( .IN({n86, n85}), .OUT({Shift_enable, CMP_enable, Logic_enable, 
        Arith_enable}) );
  ARITHMETIC_UNIT_test_1 U0_ARITHMETIC_UNIT ( .A({n102, n101, n100, n99, n98, 
        n97, n96, n95}), .B({n94, n93, n92, n91, n90, n89, n88, n87}), 
        .ALU_FUNC({n84, n83}), .CLK(scan_fun_clk), .RST(n4), .Arith_enable(
        Arith_enable), .Carry_OUT(n121), .Arith_OUT({n105, n106, n107, n108, 
        n109, n110, n111, n112, n113, n114, n115, n116, n117, n118, n119, n120}), .Arith_Flag(n122), .test_si(SI), .test_se(SE) );
  LOGIC_UNIT_test_1 U0_LOGIC_UNIT ( .A({n102, n101, n100, n99, n98, n97, n96, 
        n95}), .B({n94, n93, n92, n91, n90, n89, n88, n87}), .ALU_FUNC({n84, 
        n83}), .CLK(scan_fun_clk), .RST(n103), .Logic_enable(Logic_enable), 
        .Logic_OUT({n123, n124, n125, n126, n127, n128, n129, n130}), 
        .Logic_Flag(n131), .test_si(n142), .test_se(SE) );
  SHIFT_UNIT_test_1 U0_SHIFT_UNIT ( .A({n102, n101, n100, n99, n98, n97, n96, 
        n95}), .B({n94, n93, n92, n91, n90, n89, n88, n87}), .ALU_FUNC({n84, 
        n83}), .CLK(scan_fun_clk), .RST(n3), .Shift_enable(Shift_enable), 
        .Shift_OUT({n132, n133, n134, n135, n136, n137, n138, n139}), 
        .Shift_Flag(n140), .test_si(n123), .test_se(SE) );
  CMP_UNIT_test_1 U0_CMP_UNIT ( .A({n102, n101, n100, n99, n98, n97, n96, n95}), .B({n94, n93, n92, n91, n90, n89, n88, n87}), .ALU_FUNC({n84, n83}), .CLK(
        scan_fun_clk), .RST(n103), .CMP_enable(CMP_enable), .CMP_OUT({
        SYNOPSYS_UNCONNECTED__0, n142, n143}), .CMP_Flag(n144), .test_si(n121), 
        .test_se(SE) );
  CLKINVX40M U1 ( .A(1'b1), .Y(CMP_OUT[2]) );
endmodule

