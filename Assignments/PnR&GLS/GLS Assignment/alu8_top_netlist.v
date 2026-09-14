/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : O-2018.06-SP1
// Date      : Sun Sep 13 19:44:21 2026
/////////////////////////////////////////////////////////////


module add_unit_DW01_add_0 ( A, B, CI, SUM, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [8:1] carry;

  ADDFX2M U1_1 ( .A(A[1]), .B(B[1]), .CI(n1), .CO(carry[2]), .S(SUM[1]) );
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
  ADDFX2M U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(SUM[8]), .S(SUM[7]) );
  AND2X2M U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  CLKXOR2X2M U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module add_unit ( clk, rst_n, en, a, b, sum, cout, valid );
  input [7:0] a;
  input [7:0] b;
  output [7:0] sum;
  input clk, rst_n, en;
  output cout, valid;
  wire   en_reg, n2, n3, n4, n5, n6, n7, n8, n9, n10, n1, n12;
  wire   [8:0] add_result;

  add_unit_DW01_add_0 add_34 ( .A({1'b0, a}), .B({1'b0, b}), .CI(1'b0), .SUM(
        add_result) );
  DFFRQX2M en_reg_reg ( .D(en), .CK(clk), .RN(rst_n), .Q(en_reg) );
  DFFRHQX8M \sum_reg[0]  ( .D(n2), .CK(clk), .RN(rst_n), .Q(sum[0]) );
  DFFRHQX8M \sum_reg[1]  ( .D(n3), .CK(clk), .RN(rst_n), .Q(sum[1]) );
  DFFRHQX8M \sum_reg[2]  ( .D(n4), .CK(clk), .RN(rst_n), .Q(sum[2]) );
  DFFRHQX8M \sum_reg[3]  ( .D(n5), .CK(clk), .RN(rst_n), .Q(sum[3]) );
  DFFRHQX8M \sum_reg[4]  ( .D(n6), .CK(clk), .RN(rst_n), .Q(sum[4]) );
  DFFRHQX8M \sum_reg[5]  ( .D(n7), .CK(clk), .RN(rst_n), .Q(sum[5]) );
  DFFRHQX8M \sum_reg[6]  ( .D(n8), .CK(clk), .RN(rst_n), .Q(sum[6]) );
  DFFRHQX8M cout_reg ( .D(n10), .CK(clk), .RN(rst_n), .Q(cout) );
  DFFRHQX8M \sum_reg[7]  ( .D(n9), .CK(clk), .RN(rst_n), .Q(sum[7]) );
  DFFRHQX8M valid_reg ( .D(en_reg), .CK(clk), .RN(rst_n), .Q(valid) );
  CLKBUFX6M U3 ( .A(en_reg), .Y(n1) );
  INVX4M U4 ( .A(n1), .Y(n12) );
  AO22X1M U5 ( .A0(sum[6]), .A1(n12), .B0(add_result[6]), .B1(n1), .Y(n8) );
  AO22X1M U6 ( .A0(sum[7]), .A1(n12), .B0(add_result[7]), .B1(n1), .Y(n9) );
  AO22X1M U7 ( .A0(cout), .A1(n12), .B0(add_result[8]), .B1(n1), .Y(n10) );
  AO22X1M U8 ( .A0(sum[2]), .A1(n12), .B0(add_result[2]), .B1(n1), .Y(n4) );
  AO22X1M U9 ( .A0(sum[3]), .A1(n12), .B0(add_result[3]), .B1(n1), .Y(n5) );
  AO22X1M U10 ( .A0(sum[4]), .A1(n12), .B0(add_result[4]), .B1(n1), .Y(n6) );
  AO22X1M U11 ( .A0(sum[5]), .A1(n12), .B0(add_result[5]), .B1(n1), .Y(n7) );
  AO22X1M U12 ( .A0(sum[0]), .A1(n12), .B0(n1), .B1(add_result[0]), .Y(n2) );
  AO22X1M U14 ( .A0(sum[1]), .A1(n12), .B0(add_result[1]), .B1(n1), .Y(n3) );
endmodule


module alu8_top ( clk, rst_n, en, a, b, result, valid );
  input [7:0] a;
  input [7:0] b;
  output [15:0] result;
  input clk, rst_n, en;
  output valid;

  assign result[9] = 1'b0;
  assign result[10] = 1'b0;
  assign result[11] = 1'b0;
  assign result[12] = 1'b0;
  assign result[13] = 1'b0;
  assign result[14] = 1'b0;
  assign result[15] = 1'b0;

  add_unit \genblk1.u_add  ( .clk(clk), .rst_n(rst_n), .en(en), .a(a), .b(b), 
        .sum(result[7:0]), .cout(result[8]), .valid(valid) );
endmodule

