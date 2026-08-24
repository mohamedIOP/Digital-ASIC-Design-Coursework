module deserializer (
    input deser_en,sampled_bit,
    input CLK,RST,
    input [3:0] bit_cnt,
    output reg [7:0] P_DATA
);
    always @(posedge CLK or negedge RST) begin
        if (!RST) begin
            P_DATA <= 0;
        end
        else if (deser_en) begin
            P_DATA <= {sampled_bit,P_DATA[7:1]};
        end
    end
endmodule //deserializer