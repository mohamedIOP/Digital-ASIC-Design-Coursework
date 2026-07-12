module DigCt(
    input IN1,IN2,IN3,IN4,IN5,
    input CLK,
    output reg OUT1,OUT2,OUT3
);
reg D_OUT1,D_OUT2,D_OUT3;
always @(*) begin
    D_OUT1 = ~(~(IN1 | IN2) & IN3);
end
always @(*) begin
    D_OUT2 = ~(IN2 & IN3);
end
always @(*) begin
    D_OUT3 = (IN3 | ~IN4) | IN5;
end
always @(posedge CLK) begin
    OUT1 <= D_OUT1;
    OUT2 <= D_OUT2;
    OUT3 <= D_OUT3;
end
endmodule
