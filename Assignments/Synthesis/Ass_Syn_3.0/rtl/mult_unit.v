module mult_unit (
    input         clk,
    input         rst_n,
    input         en,
    input  [7:0]  a,
    input  [7:0]  b,
    output reg [15:0] product,
    output reg        valid
);

    // ------------------------------------------------------------
    // Input register stage
    // ------------------------------------------------------------
    reg [7:0] a_reg;
    reg [7:0] b_reg;
    reg        en_reg;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            a_reg  <= 8'd0;
            b_reg  <= 8'd0;
            en_reg <= 1'b0;
        end
        else begin
            a_reg  <= a;
            b_reg  <= b;
            en_reg <= en;
        end
    end

    // ------------------------------------------------------------
    // Partial Product Generation (unrolled)
    // ------------------------------------------------------------
    wire [7:0] pp [0:7];

    // ---- Row 0: partial product from b_reg[0] (weight = 2^0) ----
    assign pp[0][0] = a_reg[0] & b_reg[0];
    assign pp[0][1] = a_reg[1] & b_reg[0];
    assign pp[0][2] = a_reg[2] & b_reg[0];
    assign pp[0][3] = a_reg[3] & b_reg[0];
    assign pp[0][4] = a_reg[4] & b_reg[0];
    assign pp[0][5] = a_reg[5] & b_reg[0];
    assign pp[0][6] = a_reg[6] & b_reg[0];
    assign pp[0][7] = a_reg[7] & b_reg[0];

    // ---- Row 1: partial product from b_reg[1] (weight = 2^1) ----
    assign pp[1][0] = a_reg[0] & b_reg[1];
    assign pp[1][1] = a_reg[1] & b_reg[1];
    assign pp[1][2] = a_reg[2] & b_reg[1];
    assign pp[1][3] = a_reg[3] & b_reg[1];
    assign pp[1][4] = a_reg[4] & b_reg[1];
    assign pp[1][5] = a_reg[5] & b_reg[1];
    assign pp[1][6] = a_reg[6] & b_reg[1];
    assign pp[1][7] = a_reg[7] & b_reg[1];

    // ---- Row 2: partial product from b_reg[2] (weight = 2^2) ----
    assign pp[2][0] = a_reg[0] & b_reg[2];
    assign pp[2][1] = a_reg[1] & b_reg[2];
    assign pp[2][2] = a_reg[2] & b_reg[2];
    assign pp[2][3] = a_reg[3] & b_reg[2];
    assign pp[2][4] = a_reg[4] & b_reg[2];
    assign pp[2][5] = a_reg[5] & b_reg[2];
    assign pp[2][6] = a_reg[6] & b_reg[2];
    assign pp[2][7] = a_reg[7] & b_reg[2];

    // ---- Row 3: partial product from b_reg[3] (weight = 2^3) ----
    assign pp[3][0] = a_reg[0] & b_reg[3];
    assign pp[3][1] = a_reg[1] & b_reg[3];
    assign pp[3][2] = a_reg[2] & b_reg[3];
    assign pp[3][3] = a_reg[3] & b_reg[3];
    assign pp[3][4] = a_reg[4] & b_reg[3];
    assign pp[3][5] = a_reg[5] & b_reg[3];
    assign pp[3][6] = a_reg[6] & b_reg[3];
    assign pp[3][7] = a_reg[7] & b_reg[3];

    // ---- Row 4: partial product from b_reg[4] (weight = 2^4) ----
    assign pp[4][0] = a_reg[0] & b_reg[4];
    assign pp[4][1] = a_reg[1] & b_reg[4];
    assign pp[4][2] = a_reg[2] & b_reg[4];
    assign pp[4][3] = a_reg[3] & b_reg[4];
    assign pp[4][4] = a_reg[4] & b_reg[4];
    assign pp[4][5] = a_reg[5] & b_reg[4];
    assign pp[4][6] = a_reg[6] & b_reg[4];
    assign pp[4][7] = a_reg[7] & b_reg[4];

    // ---- Row 5: partial product from b_reg[5] (weight = 2^5) ----
    assign pp[5][0] = a_reg[0] & b_reg[5];
    assign pp[5][1] = a_reg[1] & b_reg[5];
    assign pp[5][2] = a_reg[2] & b_reg[5];
    assign pp[5][3] = a_reg[3] & b_reg[5];
    assign pp[5][4] = a_reg[4] & b_reg[5];
    assign pp[5][5] = a_reg[5] & b_reg[5];
    assign pp[5][6] = a_reg[6] & b_reg[5];
    assign pp[5][7] = a_reg[7] & b_reg[5];

    // ---- Row 6: partial product from b_reg[6] (weight = 2^6) ----
    assign pp[6][0] = a_reg[0] & b_reg[6];
    assign pp[6][1] = a_reg[1] & b_reg[6];
    assign pp[6][2] = a_reg[2] & b_reg[6];
    assign pp[6][3] = a_reg[3] & b_reg[6];
    assign pp[6][4] = a_reg[4] & b_reg[6];
    assign pp[6][5] = a_reg[5] & b_reg[6];
    assign pp[6][6] = a_reg[6] & b_reg[6];
    assign pp[6][7] = a_reg[7] & b_reg[6];

    // ---- Row 7: partial product from b_reg[7] (weight = 2^7) ----
    assign pp[7][0] = a_reg[0] & b_reg[7];
    assign pp[7][1] = a_reg[1] & b_reg[7];
    assign pp[7][2] = a_reg[2] & b_reg[7];
    assign pp[7][3] = a_reg[3] & b_reg[7];
    assign pp[7][4] = a_reg[4] & b_reg[7];
    assign pp[7][5] = a_reg[5] & b_reg[7];
    assign pp[7][6] = a_reg[6] & b_reg[7];
    assign pp[7][7] = a_reg[7] & b_reg[7];

    // ------------------------------------------------------------
    // First half of accumulation (combinational)
    // ------------------------------------------------------------
    wire [15:0] level0;
    wire [15:0] level1;
    wire [15:0] level2;
    wire [15:0] level3;
    wire [15:0] level4;
    wire [15:0] level5;
    wire [15:0] level6;
    wire [15:0] level7;

    assign level0 = {pp[0]};                   
    assign level1 = level0 + (pp[1] << 1);   
    assign level2 = level1 + (pp[2] << 2);    
    assign level3 = level2 + (pp[3] << 3);  
    assign level4 = level3 + (pp[4] << 4);  
    assign level5 = level4 + (pp[5] << 5); 
    assign level6 = level5 + (pp[6] << 6); 
    assign level7 = level6 + (pp[7] << 7); 

    // ------------------------------------------------------------
    // Output register
    // ------------------------------------------------------------
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            product <= 16'd0;
            valid   <= 1'b0;
        end
        else if (en_reg) begin
            product <= level7;
            valid   <= 1'b1;
        end
        else begin
            valid <= 1'b0;
        end
    end

endmodule