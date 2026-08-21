module strt_Check (
    input strt_chk_en,sampled_bit,
    input CLK,RST,
    output reg strt_glitch
);
    always @(posedge CLK or negedge RST) begin
        if (!RST) begin
            strt_glitch <= 0;
        end
        else if (strt_chk_en) begin
            strt_glitch <= sampled_bit;
        end
    end
endmodule //strt_Check