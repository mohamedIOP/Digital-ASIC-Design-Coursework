// Port Declaration of CRC Module
module CRC (
    input DATA, ACTIVE,
    input CLK, RST,
    // Serial CRC Output
    output reg CRC,
    // Check The Output is Valid to See or No
    output reg Valid
);
    localparam [3:0] No_Registers = 8; // Set The Number of the registers
    localparam [No_Registers - 1:0] SEED = 'hD8; // RST Default Value for the Register
    localparam [No_Registers - 1:0] XOR_Bits = 'b0100_0100; // Set the XOR Gates Places

    reg [No_Registers - 1:0] LFSR;  // Registers for the algorithm and shift register
    reg [3:0] Counter;              // Counts output bits shifted so far
    integer i;
    
    wire DATA_XOR_R0_W1;  // Feedback signal
    wire Counter_Max;     // Finished shifting out all CRC bits

    assign Counter_Max = (Counter == No_Registers);
    assign DATA_XOR_R0_W1 = DATA ^ LFSR[0];

    // Outputs and registers setting
    always @(posedge CLK or negedge RST) begin
        if (!RST) begin
            LFSR  <= SEED;
            Valid <= 0;
        end
        else if (ACTIVE) begin
            Valid <= 0;
            LFSR[No_Registers - 1] <= DATA_XOR_R0_W1;
            for (i = 0; i < No_Registers - 1; i = i + 1) begin
                if (XOR_Bits[i])
                    LFSR[i] <= LFSR[i + 1] ^ DATA_XOR_R0_W1;
                else
                    LFSR[i] <= LFSR[i + 1];
            end
        end
        else if (!Counter_Max) begin
            Valid <= 1;
            CRC   <= LFSR[0];
            LFSR[No_Registers - 1] <= 0;
            for (i = 0; i < No_Registers - 1; i = i + 1) begin
                LFSR[i] <= LFSR[i + 1];
            end
        end
        else begin
            Valid <= 0;
            CRC   <= 0;
        end
    end

    // Setting the Counter
    always @(posedge CLK or negedge RST) begin
        if (!RST) begin
            Counter <= No_Registers;
        end
        else if (ACTIVE) begin
            Counter <= 0;
        end
        else if (!Counter_Max) begin
            Counter <= Counter + 1;
        end
    end
endmodule //CRC