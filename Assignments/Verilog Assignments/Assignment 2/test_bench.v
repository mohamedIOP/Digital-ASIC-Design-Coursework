module Up_Dn_Counter_TB;
    reg [4:0] IN_TB;
    reg Load_TB,Up_TB,Down_TB,CLK_TB;
    wire [4:0] Counter_TB;
    wire High_TB,Low_TB;
    Up_Dn_Counter DUT_Up_Dn_Counter (
        .IN(IN_TB),
        .Load(Load_TB),
        .Up(Up_TB),
        .Down(Down_TB),
        .CLK(CLK_TB),
        .Counter(Counter_TB),
        .High(High_TB),
        .Low(Low_TB)
    );
    initial begin
        CLK_TB = 0;
        forever begin
            #5 CLK_TB = ~CLK_TB;
        end
    end
    initial begin
        $dumpfile("Up_Dn_Counter_TB.vcd");
        $dumpvars;
    end
    initial begin
        $monitor("At Time: %0t,Counter: %0b,High Flag: %0b,Low Flag: %0b",$time,Counter_TB,High_TB,Load_TB);
    end
    initial fork 
        #0 {Load_TB,IN_TB} = 6'b110101;
        #10 {Load_TB,Down_TB,Up_TB} = 3'b111;
        #20 {Load_TB,Down_TB,Up_TB} = 3'b010;
        #30 {Load_TB,Down_TB,Up_TB} = 3'b011;
        #40 {Load_TB,Down_TB,Up_TB} = 3'b001;
        #50 {Load_TB,Down_TB,Up_TB} = 3'b000;
        #60 {Load_TB,IN_TB} = 6'b100001;
        #70 {Load_TB,Down_TB,Up_TB} = 3'b010;
        #110 {Load_TB,IN_TB} = 6'b111110;
        #130 {Load_TB,Down_TB,Up_TB} = 3'b001;
        #200 $finish;
    join
endmodule
