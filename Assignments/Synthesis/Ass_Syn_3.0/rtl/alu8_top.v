module alu8_top (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        mode,      // 0 = add, 1 = multiply
    input  wire        add_en,    
    input  wire        mul_en,  
    input  wire [7:0]  a,
    input  wire [7:0]  b,

    output wire [15:0] result,
    output wire        valid
);

    //---------------- Adder -----------------
    wire [7:0] add_sum;
    wire       add_cout;
    wire       add_valid;

    add_unit #(
        .DATA_WIDTH(8)
    ) u_add (
        .clk   (clk),
        .rst_n (rst_n),
        .en    (add_en),
        .a     (a),
        .b     (b),
        .sum   (add_sum),
        .cout  (add_cout),
        .valid (add_valid)
    );

    //---------------- Multiplier -----------------
    wire [15:0] mul_product;
    wire        mul_valid;

    mult_unit u_mul (
        .clk     (clk),
        .rst_n   (rst_n),
        .en      (mul_en),
        .a       (a),
        .b       (b),
        .product (mul_product),
        .valid   (mul_valid)
    );

    //---------------- Output -----------------

    assign result = (mode) ? mul_product:
                             {7'd0, add_cout, add_sum};

    assign valid  = (mode) ? mul_valid :
                             add_valid;

endmodule
