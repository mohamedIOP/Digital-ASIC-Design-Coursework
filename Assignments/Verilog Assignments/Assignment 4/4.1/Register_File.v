module Register_File (
    input [15:0] WrData,
    input [2:0] Address,
    input WrEn,RdEn,
    input CLK,RST,
    output reg [15:0] RdData
);
    reg [15:0] Register_File_MEM [0:7];
    always @(posedge CLK or negedge RST) begin
        if (!RST) begin
            Register_File_MEM[0] <= 0;
            Register_File_MEM[1] <= 0;
            Register_File_MEM[2] <= 0;
            Register_File_MEM[3] <= 0;
            Register_File_MEM[4] <= 0;
            Register_File_MEM[5] <= 0;
            Register_File_MEM[6] <= 0;
            Register_File_MEM[7] <= 0;
        end
        else if (WrEn) begin
            Register_File_MEM[Address] <= WrData;
        end
        else if (RdEn) begin
            RdData <= Register_File_MEM[Address];
        end
    end
endmodule //Register_File