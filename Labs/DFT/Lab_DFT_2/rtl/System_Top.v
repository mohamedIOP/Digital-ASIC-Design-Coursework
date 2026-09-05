
module System_Top #(parameter WIDTH = 8, ADDR = 4 , ALU_FUN_WD = 4) (

input  wire                       SI,
input  wire                       SE,
input  wire                       scan_clk,
input  wire                       scan_rst,
input  wire                       test_mode,
output wire                       SO,
input    wire                     CLKDIV_EN,
input    wire                     CLKG_EN,
input    wire                     CLK,
input    wire                     RST,
input    wire   [ALU_FUN_WD-1:0]  ALU_FUN, 
input    wire                     ALU_Enable,
input    wire                     WrEn,
input    wire                     RdEn,
input    wire   [ADDR-1:0]        Address,
input    wire   [WIDTH-1:0]       WrData,
output   wire   [WIDTH-1:0]       RdData,
output  wire                      ALU_VLD ,
output  wire    [WIDTH-1:0]       ALU_OUT 
);

wire    [WIDTH-1:0]      ALU_A,
                         ALU_B,
			 CLKDIV_Config;
wire                     ALU_CLK ;						 												 
wire 	                 REG_CLK ;
						 

wire                     CLK_M,
                         RST_M ;

// Muxing primary clock
mux2X1 U0_mux2X1 (
.IN_0(CLK),
.IN_1(scan_clk),
.SEL(test_mode),
.OUT(CLK_M)
); 


// Muxing resets
mux2X1 U2_mux2X1 (
.IN_0(RST),
.IN_1(scan_rst),
.SEL(test_mode),
.OUT(RST_M)
); 


ALU U0_ALU (
.CLK(ALU_CLK),
.RST(RST_M),
.A(ALU_A), 
.B(ALU_B),
.Enable(ALU_Enable),
.ALU_FUN(ALU_FUN),
.ALU_OUT(ALU_OUT),
.OUT_VALID(ALU_VLD)
);						 

RegFile U0_RegFile (
.CLK(REG_CLK),
.RST(RST_M),
.WrEn(WrEn),
.RdEn(RdEn),
.Address(Address),
.WrData(WrData),
.RdData(RdData),
.REG0(ALU_A),
.REG1(ALU_B),
.REG2(CLKDIV_Config)
);


CLK_GATE U0_CLK_GATE(
.CLK_EN(CLKG_EN),
.CLK(CLK_M),
.test_en(test_mode),
.GATED_CLK(ALU_CLK)
);

ClkDiv U0_ClkDiv (
.i_ref_clk(CLK_M),             
.i_rst(RST_M),               
.i_clk_en(CLKDIV_EN),               
.i_div_ratio(CLKDIV_Config),            
.o_div_clk(REG_CLK)             
);


endmodule
