module DigCt (IN1,IN2,IN3,IN4,IN5,CLK,OUT1,OUT2,OUT3);
    input IN1,IN2,IN3,IN4,IN5;
    input CLK;
    output OUT1,OUT2,OUT3;
    reg IN1_NOR_IN2_W1,IN3_NAND_W1,IN2_NAND_IN3,IN3_OR_IN4_Complement_W2,IN5_OR_W2;
    // Intermediate Signals
    reg OUT1,OUT2,OUT3;
    always @(IN1,IN2) begin
        IN1_NOR_IN2_W1 = ~(IN1|IN2);
    end
    always @(IN1_NOR_IN2_W1,IN3) begin
        IN3_NAND_W1 = ~(IN1_NOR_IN2_W1 & IN3);
    end
    always @(IN2,IN3) begin
        IN2_NAND_IN3 = ~(IN2 & IN3);
    end
    always @(IN3,IN4) begin
        IN3_OR_IN4_Complement_W2 = IN3 | (~IN4);
    end
    always @(IN5,IN3_OR_IN4_Complement_W2) begin
        IN5_OR_W2 = IN5 | IN3_OR_IN4_Complement_W2;
    end
    always @(posedge CLK) begin
        OUT1 <= IN3_NAND_W1;
    end
    always @(posedge CLK) begin
        OUT2 <= IN2_NAND_IN3;
    end
    always @(posedge CLK) begin
        OUT3 <= IN5_OR_W2;
    end
endmodule