module DigCt (IN1,IN2,IN3,IN4,CLK,OUT1,OUT2,OUT3);
    input IN1,IN2,IN3,IN4;
    input CLK;
    output OUT1,OUT2,OUT3;
    reg OUT1,OUT2,OUT3;
    reg NOR_Output,NAND_Output,OR_Output;
    always @(IN1 or IN2) begin
        NOR_Output = !(IN1|IN2);
    end
    always @(IN2 or IN3) begin 
        NAND_Output = !(IN2 & IN3);
    end
    always @(IN4 or IN3) begin
        OR_Output = IN4 | IN3;
    end
    always @(posedge CLK) begin
        OUT1 <= NOR_Output;
    end
    always @(posedge CLK) begin
        OUT2 <= NAND_Output;
    end
    always @(posedge CLK) begin
        OUT3 <= OR_Output;
    end
endmodule