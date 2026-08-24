`timescale 1ns/1ps
/*
    UART_TX_TOP Self-Checking Testbench
    ------------------------------------
    Constraints implemented:
    - Clock Frequency 200MHz          (CLK_PERIOD = 5ns)
    - Display time before/after each test case
    - Display Busy and TX_OUT continuously
    - Check FSM is working fine        (via hierarchical currentState probing)
    - Check Serializer ser_en/ser_done follow intent
    - parEn/parTyp held constant during any single frame (TB discipline)
    - Check registered pData (pDataReg) doesn't change despite pData/dataValid
      changing mid-frame
    - Self-checked PASS/FAIL per test case, printed to the transcript
    - Test case counter + final summary

    Scenario map (1 scenario = 1 reported test case):
    1) RST try
    2) Frame, no parity
    3) Frame, even parity
    4) Frame, odd parity
    5) RST during a frame transition (no parity)
    6) pData changes on the bus during frame transition
    7) dataValid glitch during transmission of a data frame
    8) Idle state TX_OUT high check
    9) stop -> start directly (no idle) via back-to-back dataValid
*/

module UART_TX_TOP_tb;

    // ---------------------------------------------------------------
    // Clock / reset / stimulus
    // ---------------------------------------------------------------
    localparam CLK_PERIOD = 5; // ns -> 200MHz

    reg CLK;
    reg RST;
    reg dataValid;
    reg parEn;
    reg parTyp;
    reg [7:0] pData;

    wire txOut;
    wire busy;

    integer testCount;
    integer passCount;
    integer failCount;

    // ---------------------------------------------------------------
    // DUT
    // ---------------------------------------------------------------
    UART_TX_TOP dut (
        .pData     (pData),
        .dataValid (dataValid),
        .parEn     (parEn),
        .parTyp    (parTyp),
        .CLK       (CLK),
        .RST       (RST),
        .txOut     (txOut),
        .busy      (busy)
    );

    // ---------------------------------------------------------------
    // Clock generation - 200MHz
    // ---------------------------------------------------------------
    initial CLK = 1'b0;
    always #(CLK_PERIOD/2) CLK = ~CLK;

    // ---------------------------------------------------------------
    // Continuous visibility into Busy / TX_OUT (per requirement)
    // ---------------------------------------------------------------
    always @(busy or txOut) begin
        $display("[%0t] MONITOR: busy=%0b  txOut=%0b", $time, busy, txOut);
    end

    // ---------------------------------------------------------------
    // Reference parity model (independent of the RTL, from the spec:
    // PAR_TYP=0 -> even parity, PAR_TYP=1 -> odd parity)
    // ---------------------------------------------------------------
    function automatic bit calc_parity(input [7:0] data, input bit parType);
        calc_parity = parType ? ~(^data) : (^data);
    endfunction

    // Expected FSM state name at a given bit index within a frame
    function automatic string expected_state_name(input int idx, input bit parEnable);
        if (idx == 0)
            expected_state_name = "start";
        else if (idx >= 1 && idx <= 8)
            expected_state_name = "data";
        else if (parEnable && idx == 9)
            expected_state_name = "parity";
        else if (parEnable && idx == 10)
            expected_state_name = "stop";
        else if (!parEnable && idx == 9)
            expected_state_name = "stop";
        else
            expected_state_name = "unknown";
    endfunction

    // ---------------------------------------------------------------
    // Scoreboard
    // ---------------------------------------------------------------
    task automatic report_result(input string testName, input bit passed);
        begin
            testCount = testCount + 1;
            if (passed) begin
                passCount = passCount + 1;
                $display("[%0t] TEST %0d - %s : PASSED", $time, testCount, testName);
            end else begin
                failCount = failCount + 1;
                $display("[%0t] TEST %0d - %s : FAILED", $time, testCount, testName);
            end
        end
    endtask

    // ---------------------------------------------------------------
    // Core task: send one byte, sample TX_OUT/FSM/Serializer every
    // cycle of the frame and self-check against the expected sequence.
    // ---------------------------------------------------------------
    task automatic send_and_check_frame(
        input [7:0] data,
        input bit   parEnable,
        input bit   parType,
        input string testName
    );
        integer i;
        integer frameLen;
        bit expected [0:10];
        bit frameOk;
        bit expectedSerEn;
        bit expectedSerDone;
        begin
            frameOk = 1;

            expected[0] = 1'b0;                       // start bit
            for (i = 0; i < 8; i = i + 1)
                expected[i+1] = data[i];               // data, LSB first

            if (parEnable) begin
                expected[9]  = calc_parity(data, parType);
                expected[10] = 1'b1;                   // stop bit
                frameLen = 11;
            end else begin
                expected[9] = 1'b1;                    // stop bit
                frameLen = 10;
            end

            $display("[%0t] --- %s START (pData=8'h%0h parEn=%0b parTyp=%0b) ---",
                       $time, testName, data, parEnable, parType);

            wait (busy == 1'b0);
            @(negedge CLK);
            pData     = data;
            parEn     = parEnable;   // held constant for the whole frame
            parTyp    = parType;     // held constant for the whole frame
            dataValid = 1'b1;
            @(negedge CLK);
            dataValid = 1'b0;

            for (i = 0; i < frameLen; i = i + 1) begin
                expectedSerEn   = (i >= 1 && i <= 8);
                expectedSerDone = (i == 8);

                if (busy !== 1'b1) begin
                    $display("  [%0t] ERROR bit %0d: busy not asserted", $time, i);
                    frameOk = 0;
                end
                if (txOut !== expected[i]) begin
                    $display("  [%0t] MISMATCH bit %0d: expected=%0b actual=%0b",
                               $time, i, expected[i], txOut);
                    frameOk = 0;
                end
                if (dut.FSM_Block.currentState.name() != expected_state_name(i, parEnable)) begin
                    $display("  [%0t] FSM STATE MISMATCH bit %0d: expected=%s actual=%s",
                               $time, i, expected_state_name(i, parEnable),
                               dut.FSM_Block.currentState.name());
                    frameOk = 0;
                end
                if (dut.serEnInternal !== expectedSerEn) begin
                    $display("  [%0t] serEn MISMATCH bit %0d: expected=%0b actual=%0b",
                               $time, i, expectedSerEn, dut.serEnInternal);
                    frameOk = 0;
                end
                if (dut.serDoneInternal !== expectedSerDone) begin
                    $display("  [%0t] serDone MISMATCH bit %0d: expected=%0b actual=%0b",
                               $time, i, expectedSerDone, dut.serDoneInternal);
                    frameOk = 0;
                end
                if (i < frameLen-1) @(negedge CLK);
            end

            @(negedge CLK);
            if (busy !== 1'b0 || txOut !== 1'b1) begin
                $display("  [%0t] ERROR: did not return to idle cleanly after frame", $time);
                frameOk = 0;
            end

            $display("[%0t] --- %s END ---", $time, testName);
            report_result(testName, frameOk);
        end
    endtask

    // ---------------------------------------------------------------
    // Scenario 1 : RST try
    // ---------------------------------------------------------------
    task automatic test_reset;
        bit ok;
        begin
            $display("[%0t] --- Scenario1_Reset START ---", $time);
            ok = 1;
            RST       = 1'b0;
            dataValid = 1'b0;
            pData     = 8'h00;
            parEn     = 1'b0;
            parTyp    = 1'b0;
            repeat (3) @(negedge CLK);
            RST = 1'b1;
            @(negedge CLK);

            if (busy !== 1'b0)               ok = 0;
            if (txOut !== 1'b1)              ok = 0;
            if (dut.FSM_Block.currentState.name() != "idle") ok = 0;

            $display("[%0t] --- Scenario1_Reset END ---", $time);
            report_result("Scenario1_Reset", ok);
        end
    endtask

    // ---------------------------------------------------------------
    // Scenario 5 : RST asserted mid-frame (no parity)
    // ---------------------------------------------------------------
    task automatic test_reset_during_frame;
        bit ok;
        begin
            $display("[%0t] --- Scenario5_ResetDuringFrame START ---", $time);
            ok = 1;
            wait (busy == 1'b0);
            @(negedge CLK);
            pData = 8'hC3; parEn = 1'b0; parTyp = 1'b0; dataValid = 1'b1;
            @(negedge CLK);
            dataValid = 1'b0;
            repeat (3) @(negedge CLK); // now somewhere inside the data bits

            RST = 1'b0; // asynchronous reset asserted mid-frame
            #1;         // let the async reset propagate this delta
            if (busy !== 1'b0)  ok = 0;
            if (txOut !== 1'b1) ok = 0;
            if (dut.FSM_Block.currentState.name() != "idle") ok = 0;

            @(negedge CLK);
            RST = 1'b1; // release reset
            @(negedge CLK);

            $display("[%0t] --- Scenario5_ResetDuringFrame END ---", $time);
            report_result("Scenario5_ResetDuringFrame", ok);
        end
    endtask

    // ---------------------------------------------------------------
    // Scenario 6 : pData glitches on the bus mid-frame (no dataValid
    // pulse) - registered pDataReg / TX_OUT must not be disturbed.
    // ---------------------------------------------------------------
    task automatic test_pdata_glitch;
        integer i;
        bit [7:0] origData, glitchData;
        bit expected [0:9];
        bit frameOk;
        begin
            origData   = 8'h55;
            glitchData = 8'hAA;
            frameOk    = 1;
            expected[0] = 1'b0;
            for (i = 0; i < 8; i = i + 1) expected[i+1] = origData[i];
            expected[9] = 1'b1;

            $display("[%0t] --- Scenario6_PDataGlitch START ---", $time);
            wait (busy == 1'b0);
            @(negedge CLK);
            pData = origData; parEn = 1'b0; parTyp = 1'b0; dataValid = 1'b1;
            @(negedge CLK);
            dataValid = 1'b0;

            for (i = 0; i < 10; i = i + 1) begin
                if (i == 4) pData = glitchData; // glitch the bus, no dataValid pulse

                if (dut.Serializer_Block.pDataReg !== origData) begin
                    $display("  [%0t] ERROR: pDataReg changed to 8'h%0h unexpectedly",
                               $time, dut.Serializer_Block.pDataReg);
                    frameOk = 0;
                end
                if (txOut !== expected[i]) begin
                    $display("  [%0t] MISMATCH bit %0d: expected=%0b actual=%0b",
                               $time, i, expected[i], txOut);
                    frameOk = 0;
                end
                if (i < 9) @(negedge CLK);
            end
            pData = origData;
            @(negedge CLK);

            $display("[%0t] --- Scenario6_PDataGlitch END ---", $time);
            report_result("Scenario6_PDataGlitch", frameOk);
        end
    endtask

    // ---------------------------------------------------------------
    // Scenario 7 : dataValid glitches during transmission of a data
    // frame (busy, not idle/stop) - must be ignored entirely.
    // ---------------------------------------------------------------
    task automatic test_datavalid_glitch_during_frame;
        integer i;
        bit [7:0] origData, glitchData;
        bit expected [0:10];
        bit frameOk;
        begin
            origData   = 8'h3C;
            glitchData = 8'h99;
            frameOk    = 1;
            expected[0] = 1'b0;
            for (i = 0; i < 8; i = i + 1) expected[i+1] = origData[i];
            expected[9]  = calc_parity(origData, 1'b0); // even parity
            expected[10] = 1'b1;

            $display("[%0t] --- Scenario7_DataValidGlitchDuringFrame START ---", $time);
            wait (busy == 1'b0);
            @(negedge CLK);
            pData = origData; parEn = 1'b1; parTyp = 1'b0; dataValid = 1'b1;
            @(negedge CLK);
            dataValid = 1'b0;

            for (i = 0; i < 11; i = i + 1) begin
                if (i == 3) begin
                    // inject a spurious dataValid pulse mid-frame with different data staged
                    pData     = glitchData;
                    dataValid = 1'b1;
                end
                if (i == 4) begin
                    dataValid = 1'b0;
                    pData     = origData;
                end

                if (dut.Serializer_Block.pDataReg !== origData) begin
                    $display("  [%0t] ERROR: pDataReg changed to 8'h%0h unexpectedly",
                               $time, dut.Serializer_Block.pDataReg);
                    frameOk = 0;
                end
                if (txOut !== expected[i]) begin
                    $display("  [%0t] MISMATCH bit %0d: expected=%0b actual=%0b",
                               $time, i, expected[i], txOut);
                    frameOk = 0;
                end
                if (i < 10) @(negedge CLK);
            end
            @(negedge CLK);
            if (busy !== 1'b0) begin
                $display("  [%0t] ERROR: frame did not end cleanly (busy stuck)", $time);
                frameOk = 0;
            end

            $display("[%0t] --- Scenario7_DataValidGlitchDuringFrame END ---", $time);
            report_result("Scenario7_DataValidGlitchDuringFrame", frameOk);
        end
    endtask

    // ---------------------------------------------------------------
    // Scenario 8 : Idle state TX_OUT high check
    // ---------------------------------------------------------------
    task automatic test_idle_txout_high;
        bit ok;
        begin
            $display("[%0t] --- Scenario8_IdleTxOutHigh START ---", $time);
            ok = 1;
            wait (busy == 1'b0);
            dataValid = 1'b0;
            repeat (5) @(negedge CLK);
            if (txOut !== 1'b1) ok = 0;
            if (busy  !== 1'b0) ok = 0;
            $display("[%0t] --- Scenario8_IdleTxOutHigh END ---", $time);
            report_result("Scenario8_IdleTxOutHigh", ok);
        end
    endtask

    // ---------------------------------------------------------------
    // Scenario 9 : stop -> start directly (no idle gap) by pulsing
    // dataValid while the FSM is in the stop state.
    // ---------------------------------------------------------------
    task automatic test_back_to_back_no_idle;
        integer i;
        bit [7:0] data1, data2;
        bit expected1 [0:9];
        bit expected2 [0:9];
        bit frameOk;
        begin
            data1 = 8'h11;
            data2 = 8'h22;
            frameOk = 1;
            expected1[0] = 1'b0; for (i=0;i<8;i=i+1) expected1[i+1]=data1[i]; expected1[9]=1'b1;
            expected2[0] = 1'b0; for (i=0;i<8;i=i+1) expected2[i+1]=data2[i]; expected2[9]=1'b1;

            $display("[%0t] --- Scenario9_BackToBackNoIdle START ---", $time);
            wait (busy == 1'b0);
            @(negedge CLK);
            pData = data1; parEn = 1'b0; parTyp = 1'b0; dataValid = 1'b1;
            @(negedge CLK);
            dataValid = 1'b0;

            // start bit + 8 data bits of frame1 (indices 0..8)
            for (i = 0; i < 9; i = i + 1) begin
                if (txOut !== expected1[i]) begin
                    $display("  [%0t] MISMATCH frame1 bit %0d: expected=%0b actual=%0b",
                               $time, i, expected1[i], txOut);
                    frameOk = 0;
                end
                @(negedge CLK);
            end

            // now sitting in frame1's stop-bit cycle
            if (txOut !== expected1[9]) begin
                $display("  [%0t] MISMATCH frame1 stop bit: expected=%0b actual=%0b",
                           $time, expected1[9], txOut);
                frameOk = 0;
            end
            if (dut.FSM_Block.currentState.name() != "stop") begin
                $display("  [%0t] ERROR: expected FSM in 'stop', got '%s'",
                           $time, dut.FSM_Block.currentState.name());
                frameOk = 0;
            end

            // pulse dataValid for the new frame while still in 'stop'
            pData     = data2;
            dataValid = 1'b1;
            if (busy !== 1'b1) begin
                $display("  [%0t] ERROR: busy dropped before frame boundary (idle gap)", $time);
                frameOk = 0;
            end
            @(negedge CLK);
            dataValid = 1'b0;

            if (busy !== 1'b1) begin
                $display("  [%0t] ERROR: busy dropped at frame2 start - idle gap detected", $time);
                frameOk = 0;
            end
            if (dut.FSM_Block.currentState.name() != "start") begin
                $display("  [%0t] ERROR: expected FSM to move directly to 'start', got '%s'",
                           $time, dut.FSM_Block.currentState.name());
                frameOk = 0;
            end
            if (txOut !== expected2[0]) begin
                $display("  [%0t] MISMATCH: expected frame2 start bit, got %0b", $time, txOut);
                frameOk = 0;
            end

            for (i = 1; i < 10; i = i + 1) begin
                @(negedge CLK);
                if (txOut !== expected2[i]) begin
                    $display("  [%0t] MISMATCH frame2 bit %0d: expected=%0b actual=%0b",
                               $time, i, expected2[i], txOut);
                    frameOk = 0;
                end
            end

            @(negedge CLK);
            if (busy !== 1'b0 || txOut !== 1'b1) begin
                $display("  [%0t] ERROR: did not return to idle cleanly after frame2", $time);
                frameOk = 0;
            end

            $display("[%0t] --- Scenario9_BackToBackNoIdle END ---", $time);
            report_result("Scenario9_BackToBackNoIdle", frameOk);
        end
    endtask

    // ---------------------------------------------------------------
    // Test sequence
    // ---------------------------------------------------------------
    initial begin
        $dumpfile("UART_TX_TOP_tb.vcd");
        $dumpvars(0, UART_TX_TOP_tb);

        RST       = 1'b1;
        dataValid = 1'b0;
        parEn     = 1'b0;
        parTyp    = 1'b0;
        pData     = 8'h00;
        testCount = 0;
        passCount = 0;
        failCount = 0;

        $display("========================================================");
        $display(" UART_TX_TOP Self-Checking Testbench");
        $display(" Clock: 200MHz  (Period = %0d ns)", CLK_PERIOD);
        $display("========================================================");

        test_reset();                                                 // Scenario 1
        send_and_check_frame(8'hA5, 1'b0, 1'b0, "Scenario2_NoParity"); // Scenario 2
        send_and_check_frame(8'hF3, 1'b1, 1'b0, "Scenario3_EvenParity"); // Scenario 3
        send_and_check_frame(8'h5A, 1'b1, 1'b1, "Scenario4_OddParity");  // Scenario 4
        test_reset_during_frame();                                    // Scenario 5
        test_pdata_glitch();                                          // Scenario 6
        test_datavalid_glitch_during_frame();                         // Scenario 7
        test_idle_txout_high();                                       // Scenario 8
        test_back_to_back_no_idle();                                  // Scenario 9

        $display("========================================================");
        $display(" TEST SUMMARY: %0d run, %0d PASSED, %0d FAILED",
                   testCount, passCount, failCount);
        $display("========================================================");

        $finish;
    end

endmodule
