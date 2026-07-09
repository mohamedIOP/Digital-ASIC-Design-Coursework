module Counter(
    input [3:0] IN,
    input latch,dec,clk,
    output reg [3:0] counter,
    output zero
);
    assign zero = (counter == 0);
    always @(posedge clk) begin
        if(latch)
            begin
                counter <= IN;
            end
        else if (dec && !zero)
            begin
                counter <= counter - 1;
            end
        else
            counter <= counter;
    end
endmodule
