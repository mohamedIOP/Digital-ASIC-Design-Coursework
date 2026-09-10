module add_unit #(
    parameter DATA_WIDTH = 8
) (
    input  wire                  clk,
    input  wire                  rst_n,
    input  wire                  en,
    input  wire [DATA_WIDTH-1:0] a,
    input  wire [DATA_WIDTH-1:0] b,

    output reg  [DATA_WIDTH-1:0] sum,
    output reg                   cout,
    output reg                   valid
);

    // -----------------------------------------------------
    reg  [DATA_WIDTH-1:0] a_reg, b_reg;
    reg  en_reg;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            a_reg   <= 'b0;
            b_reg   <= 'b0;
            en_reg  <= 1'b0;
        end
        else begin
            a_reg   <= a;
            b_reg   <= b;
            en_reg  <= en;
        end
    end

    // -----------------------------------------------------
    wire [DATA_WIDTH:0] add_result;
    assign add_result = a + b;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sum   <= {DATA_WIDTH{1'b0}};
            cout  <= 1'b0;
            valid <= 1'b0;
        end
        else if (en_reg) begin
            sum   <= add_result[DATA_WIDTH-1:0];
            cout  <= add_result[DATA_WIDTH];
            valid <= 1'b1;
        end
        else begin
            valid <= 1'b0;
        end
    end

endmodule
