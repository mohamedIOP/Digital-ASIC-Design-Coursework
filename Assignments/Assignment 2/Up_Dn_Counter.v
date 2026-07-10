module Up_Dn_Counter(
    input [4:0] IN,
    input Load,Up,Down,CLK,
    output reg [4:0] Counter,
    output High,Low
);
    assign High = (Counter == 5'd31); 
    assign Low = (Counter == 5'd0);
    always @(posedge CLK) begin
        if(Load) begin
            Counter <= IN;
        end
        else if (Down && !Low) begin
            Counter <= Counter - 1;
        end
        else if (Up && !High) begin
            Counter <= Counter + 1;
        end
        else Counter <= Counter;
    end
endmodule
