`timescale 1ns/1ns
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


module counter_TB;
    reg [3:0] IN_TB;
    reg latch_TB,dec_TB,clk_TB;
    wire [3:0] counter_TB;
    wire zero_TB;
    Counter DUT_DN_Counter (
        .counter(counter_TB),
        .IN(IN_TB),
        .latch(latch_TB),
        .zero(zero_TB),
        .clk(clk_TB),
        .dec(dec_TB)
    );
    initial begin
        clk_TB = 0;
        forever begin
            #5 clk_TB = ~clk_TB;
        end
    end
    initial begin
        $dumpfile("Counter_TB.vcd");
        $dumpvars;
    end
    initial begin
        $monitor("At t = %0t,Counter = %b,Zero Flag = %b",$time,counter_TB,zero_TB);
    end
    initial begin
        #160 $finish;
    end
    initial fork
        #0 {latch_TB,dec_TB,IN_TB} = 6'b100111;
        #15 {latch_TB,dec_TB} = 2'b01;
        #30 {latch_TB,dec_TB} = 2'b00;
        #50 {latch_TB,dec_TB,IN_TB} = 6'b100011;
        #60 {latch_TB,dec_TB} = 2'b01;
    join
endmodule
