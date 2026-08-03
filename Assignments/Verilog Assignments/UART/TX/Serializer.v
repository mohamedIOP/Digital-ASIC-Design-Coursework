module Serializer (
    input [7:0] pData,
    input serEn,regData
    input CLK,RST,
    output reg serData,serDone
);
    wire [8:0] pDataReg;
    reg [3:0] counter;
    wire counterMax;
    assign counterMax = counter == 9;
    always @(*) begin
        serDone = counterMax;
        serData = pDataReg[counter];
    end
    always @(*) begin
        pDataReg = 0;
        if (regData) begin
            pDataReg = {pData,1'b0};
        end
        else begin
            pDataReg = 0;
        end
    end
    always @(posedge CLK) begin
        if (!RST) begin
            counter <= 0;
        end
        else if (regData) begin
            counter <= 0;
        end
        else if (serEn) begin
            counter <= counter + 1;
        end
    end
endmodule //Serializer