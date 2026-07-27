`timescale 1ns/1ps
module CRC_TB;
    //-------------------------------------------------------------------------
    // Parameters
    //-------------------------------------------------------------------------
    localparam CLK_PERIOD   = 100; // 10 MHz -> 100 ns period
    localparam No_Registers = 8;   // No of registers in the algorithm
    localparam No_Tests     = 10;  // no of test cases

    reg [No_Registers - 1:0] DATA_input       [0:No_Tests - 1];
    reg [No_Registers - 1:0] Expected_Out_CRC [0:No_Tests - 1];

    //-------------------------------------------------------------------------
    // Signals
    //-------------------------------------------------------------------------
    reg  DATA_TB, ACTIVE_TB, CLK_TB, RST_TB;
    wire CRC_TB, Valid_TB;

    integer test_num = 0;
    integer passed   = 0;
    integer failed   = 0;

    //-------------------------------------------------------------------------
    // DUT Instantiation
    //-------------------------------------------------------------------------
    CRC DUT_CRC (
        .DATA(DATA_TB), .ACTIVE(ACTIVE_TB),
        .CLK(CLK_TB), .RST(RST_TB),
        .CRC(CRC_TB), .Valid(Valid_TB)
    );

    //-------------------------------------------------------------------------
    // Clock Generation: 10 MHz (100 ns period)
    //-------------------------------------------------------------------------
    initial begin
        CLK_TB = 0;
        forever #(CLK_PERIOD / 2) CLK_TB = ~CLK_TB;
    end

    //-------------------------------------------------------------------------
    // Timeout Watchdog
    //-------------------------------------------------------------------------
    initial begin
        #100000;
        $display("[TIMEOUT] Simulation exceeded limit. Terminating.");
        $finish;
    end

    //-------------------------------------------------------------------------
    // Tasks
    //-------------------------------------------------------------------------
    task do_reset;
        begin
            RST_TB    = 1'b0;
            ACTIVE_TB = 1'b0;
            DATA_TB   = 1'b0;
            @(negedge CLK_TB);
            @(negedge CLK_TB);
            RST_TB = 1'b1;
            @(negedge CLK_TB);
        end
    endtask

    task drive_byte;
        input [No_Registers-1:0] byte_in;
        integer i;
        begin
            ACTIVE_TB = 1'b1;
            for (i = 0; i < No_Registers; i = i + 1) begin
                DATA_TB = byte_in[i];      // LSB first
                @(negedge CLK_TB);
            end
            ACTIVE_TB = 1'b0;
        end
    endtask

    task capture_and_check;
        input [No_Registers-1:0] expected;
        input integer idx;
        reg   [No_Registers-1:0] received;
        integer i;
        begin
            @(posedge Valid_TB);
            for (i = 0; i < No_Registers; i = i + 1) begin
                @(negedge CLK_TB);
                received[i] = CRC_TB;      // R0 first -> LSB, R7 last -> MSB
            end

            if (received === expected) begin
                $display("Test %0d PASSED  (expected=%h, got=%h)", idx, expected, received);
                passed = passed + 1;
            end else begin
                $display("Test %0d FAILED  (expected=%h, got=%h)", idx, expected, received);
                failed = failed + 1;
            end
        end
    endtask

    //-------------------------------------------------------------------------
    // Main stimulus
    //-------------------------------------------------------------------------
    initial begin
        $dumpfile("CRC_DUMP.vcd");
        $dumpvars;

        $readmemh("DATA_h.txt", DATA_input);
        $readmemh("Expec_Out_h.txt", Expected_Out_CRC);

        for (test_num = 0; test_num < No_Tests; test_num = test_num + 1) begin
            do_reset;
            drive_byte(DATA_input[test_num]);
            capture_and_check(Expected_Out_CRC[test_num], test_num);
        end

        $display("---------------------------------------");
        $display("TOTAL: %0d passed, %0d failed out of %0d", passed, failed, No_Tests);
        $display("---------------------------------------");
        #(CLK_PERIOD);
        $finish;
    end

endmodule //CRC_TB