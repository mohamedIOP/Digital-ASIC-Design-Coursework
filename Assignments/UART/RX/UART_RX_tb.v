/*
================================================================================
 Module Name  : UART_RX_tb
 Description  : Self-Checking Testbench for UART_RX Peripheral Module
 Fix Applied  : Continuous pulse latching for timing-agnostic flag verification
================================================================================
*/

`timescale 1ns / 1ps

module UART_RX_tb;

    // -------------------------------------------------------------------------
    // 1. Clock, Reset, and Config Declarations
    // -------------------------------------------------------------------------
    reg        CLK;
    reg        RST;
    reg        RX_IN;
    reg  [5:0] Prescale;
    reg        PAR_EN;
    reg        PAR_TYP;

    wire [7:0] P_DATA;
    wire       parity_Error;
    wire       Stop_Error;
    wire       data_valid;

    real CLK_PERIOD = 1085.069; // Default for Prescale 8

    always #(CLK_PERIOD / 2.0) CLK = ~CLK;

    // -------------------------------------------------------------------------
    // 2. DUT Instantiation
    // -------------------------------------------------------------------------
    UART_RX_TOP DUT (
        .RX_IN        (RX_IN),
        .Prescale     (Prescale),
        .PAR_EN       (PAR_EN),
        .PAR_TYP      (PAR_TYP),
        .CLK          (CLK),
        .RST          (RST),
        .P_DATA       (P_DATA),
        .parity_Error (parity_Error),
        .Stop_Error   (Stop_Error),
        .data_valid   (data_valid)
    );

    // -------------------------------------------------------------------------
    // 3. Flag Latching & Pulse Monitor Block
    // -------------------------------------------------------------------------
    reg       captured_valid;
    reg       captured_parity_err;
    reg       captured_stop_err;
    reg [7:0] captured_p_data;

    always @(posedge CLK or negedge RST) begin
        if (!RST) begin
            captured_valid      <= 1'b0;
            captured_parity_err <= 1'b0;
            captured_stop_err   <= 1'b0;
            captured_p_data     <= 8'h00;
        end else begin
            if (data_valid) begin
                captured_valid  <= 1'b1;
                captured_p_data <= P_DATA;
            end
            if (parity_Error) begin
                captured_parity_err <= 1'b1;
            end
            if (Stop_Error) begin
                captured_stop_err <= 1'b1;
            end
        end
    end

    task clear_captured_flags;
        begin
            captured_valid      = 1'b0;
            captured_parity_err = 1'b0;
            captured_stop_err   = 1'b0;
            captured_p_data     = 8'h00;
        end
    endtask

    // -------------------------------------------------------------------------
    // 4. Testbench Variables & Statistics Tracking
    // -------------------------------------------------------------------------
    integer total_cases  = 0;
    integer passed_cases = 0;
    integer failed_cases = 0;
    integer failed_case_ids[0:199];

    time test_start_time;
    time test_end_time;

    // -------------------------------------------------------------------------
    // 5. Helper Tasks & Verification Logic
    // -------------------------------------------------------------------------
    task set_prescale_clk(input [5:0] prescale_val);
        begin
            Prescale = prescale_val;
            case (prescale_val)
                6'd8:  CLK_PERIOD = 1085.069;
                6'd16: CLK_PERIOD = 542.535;
                6'd32: CLK_PERIOD = 271.267;
                default: CLK_PERIOD = 1085.069;
            endcase
            #100;
        end
    endtask

    task send_bit(input bit_val);
        integer i;
        begin
            for (i = 0; i < Prescale; i = i + 1) begin
                RX_IN = bit_val;
                @(posedge CLK);
            end
        end
    endtask

    function calc_parity(input [7:0] data, input par_typ);
        begin
            if (par_typ == 0) // Even Parity
                calc_parity = ^data;
            else              // Odd Parity
                calc_parity = ~^data;
        end
    endfunction

    task send_uart_frame(
        input [7:0] frame_data,
        input       par_en,
        input       par_typ,
        input       corrupt_par,
        input       corrupt_stop
    );
        integer b;
        reg actual_par_bit;
        begin
            actual_par_bit = calc_parity(frame_data, par_typ);
            if (corrupt_par) actual_par_bit = ~actual_par_bit;

            $display("[TX DRIVE] Frame: Data=0x%02h, PAR_EN=%0b, PAR_TYP=%0b, ParBit=%0b, CorruptStop=%0b",
                     frame_data, par_en, par_typ, actual_par_bit, corrupt_stop);

            // Start Bit
            send_bit(1'b0);

            // Data Bits (LSB First)
            for (b = 0; b < 8; b = b + 1) begin
                send_bit(frame_data[b]);
                $display("  [DATA BIT %0d] TX=%0b | P_DATA=0x%02h | Valid=%0b Err(P/S)=%0b/%0b",
                         b, frame_data[b], P_DATA, data_valid, parity_Error, Stop_Error);
            end

            // Parity Bit
            if (par_en) begin
                send_bit(actual_par_bit);
                $display("  [PARITY BIT] TX=%0b | Valid=%0b Err(P/S)=%0b/%0b",
                         actual_par_bit, data_valid, parity_Error, Stop_Error);
            end

            // Stop Bit
            send_bit(!corrupt_stop);
            $display("  [STOP BIT] TX=%0b | Valid=%0b Err(P/S)=%0b/%0b",
                     !corrupt_stop, data_valid, parity_Error, Stop_Error);
        end
    endtask

    task check_result(
        input [8*80-1:0] scenario_label,
        input [7:0]     expected_data,
        input           exp_parity_err,
        input           exp_stop_err,
        input           exp_valid
    );
        reg match;
        reg [7:0] final_data;
        begin
            total_cases = total_cases + 1;
            test_end_time = $time;

            final_data = captured_valid ? captured_p_data : P_DATA;

            match = (final_data          === expected_data)  &&
                    (captured_parity_err === exp_parity_err) &&
                    (captured_stop_err   === exp_stop_err)   &&
                    (captured_valid      === exp_valid);

            $display("--------------------------------------------------------------------------------");
            $display("TESTCASE #%0d : %0s", total_cases, scenario_label);
            $display("Start Time    : %0t ns | End Time : %0t ns", test_start_time, test_end_time);
            $display("Expected      : P_DATA=0x%02h, Parity_Err=%0b, Stop_Err=%0b, Valid=%0b",
                     expected_data, exp_parity_err, exp_stop_err, exp_valid);
            $display("Observed      : P_DATA=0x%02h, Parity_Err=%0b, Stop_Err=%0b, Valid=%0b",
                     final_data, captured_parity_err, captured_stop_err, captured_valid);

            if (match) begin
                $display("STATUS        : [PASSED]");
                passed_cases = passed_cases + 1;
            end else begin
                $display("STATUS        : [FAILED] *** MISMATCH DETECTED ***");
                failed_case_ids[failed_cases] = total_cases;
                failed_cases = failed_cases + 1;
            end
            $display("--------------------------------------------------------------------------------\n");
        end
    endtask

    // -------------------------------------------------------------------------
    // 6. Main Test Sequence
    // -------------------------------------------------------------------------
    reg [5:0] prescales [0:2];
    integer p_idx;

    initial begin
        prescales[0] = 6'd8;
        prescales[1] = 6'd16;
        prescales[2] = 6'd32;

        CLK      = 0;
        RST      = 1;
        RX_IN    = 1;
        Prescale = 8;
        PAR_EN   = 0;
        PAR_TYP  = 0;

        #20 RST = 0;
        #100 RST = 1;
        #100;

        for (p_idx = 0; p_idx < 3; p_idx = p_idx + 1) begin
            $display("\n==========================================================================");
            $display("            RUNNING SCENARIOS FOR PRESCALE = %0d                          ", prescales[p_idx]);
            $display("==========================================================================\n");

            set_prescale_clk(prescales[p_idx]);

            // Scenario 1: Reset in IDLE Mode
            clear_captured_flags();
            test_start_time = $time;
            PAR_EN  = 0;
            PAR_TYP = 0;
            RX_IN   = 1;
            RST     = 0;
            #(CLK_PERIOD * 5);
            RST     = 1;
            #(CLK_PERIOD * 5);
            check_result("S1: Reset in IDLE Mode", 8'h00, 1'b0, 1'b0, 1'b0);

            // Scenario 2: No Parity Mode
            clear_captured_flags();
            test_start_time = $time;
            PAR_EN  = 0;
            PAR_TYP = 0;
            send_uart_frame(8'hA5, PAR_EN, PAR_TYP, 0, 0);
            #(CLK_PERIOD * 2);
            check_result("S2: No Parity Frame (0xA5)", 8'hA5, 1'b0, 1'b0, 1'b1);
            #(CLK_PERIOD * Prescale);

            // Scenario 3: Parity Enabled & Even Type
            clear_captured_flags();
            test_start_time = $time;
            PAR_EN  = 1;
            PAR_TYP = 0;
            send_uart_frame(8'h3B, PAR_EN, PAR_TYP, 0, 0);
            #(CLK_PERIOD * 2);
            check_result("S3: Even Parity Frame (0x3B)", 8'h3B, 1'b0, 1'b0, 1'b1);
            #(CLK_PERIOD * Prescale);

            // Scenario 4: Parity Enabled & Odd Type
            clear_captured_flags();
            test_start_time = $time;
            PAR_EN  = 1;
            PAR_TYP = 1;
            send_uart_frame(8'hC4, PAR_EN, PAR_TYP, 0, 0);
            #(CLK_PERIOD * 2);
            check_result("S4: Odd Parity Frame (0xC4)", 8'hC4, 1'b0, 1'b0, 1'b1);
            #(CLK_PERIOD * Prescale);

            // Scenario 5: Two Consecutive Frames (Back-to-Back)
            clear_captured_flags();
            test_start_time = $time;
            PAR_EN  = 1;
            PAR_TYP = 0;
            send_uart_frame(8'h12, PAR_EN, PAR_TYP, 0, 0);
            #(CLK_PERIOD * 2);
            check_result("S5a: Back-To-Back Frame 1 (0x12)", 8'h12, 1'b0, 1'b0, 1'b1);
            
            clear_captured_flags();
            test_start_time = $time;
            send_uart_frame(8'h89, PAR_EN, PAR_TYP, 0, 0);
            #(CLK_PERIOD * 2);
            check_result("S5b: Back-To-Back Frame 2 (0x89)", 8'h89, 1'b0, 1'b0, 1'b1);
            #(CLK_PERIOD * Prescale);

            // Scenario 6: Two Non-Consecutive Frames
            clear_captured_flags();
            test_start_time = $time;
            PAR_EN  = 0;
            send_uart_frame(8'h55, PAR_EN, PAR_TYP, 0, 0);
            #(CLK_PERIOD * 2);
            check_result("S6a: Non-Consecutive Frame 1 (0x55)", 8'h55, 1'b0, 1'b0, 1'b1);
            
            RX_IN = 1;
            #(CLK_PERIOD * Prescale * 10);

            clear_captured_flags();
            test_start_time = $time;
            send_uart_frame(8'hAA, PAR_EN, PAR_TYP, 0, 0);
            #(CLK_PERIOD * 2);
            check_result("S6b: Non-Consecutive Frame 2 (0xAA)", 8'hAA, 1'b0, 1'b0, 1'b1);
            #(CLK_PERIOD * Prescale);

            // Scenario 7: Reset Mid-Frame
            clear_captured_flags();
            test_start_time = $time;
            PAR_EN = 1;
            PAR_TYP = 0;
            send_bit(1'b0);
            send_bit(1'b1);
            send_bit(1'b0);
            send_bit(1'b1);
            RST = 0;
            #(CLK_PERIOD * 4);
            RST = 1;
            RX_IN = 1;
            #(CLK_PERIOD * Prescale * 2);
            check_result("S7: Asynchronous Reset Mid-Frame", 8'h00, 1'b0, 1'b0, 1'b0);

            // Scenario 8: Start Glitch
            clear_captured_flags();
            test_start_time = $time;
            RX_IN = 0;
            #(CLK_PERIOD);
            RX_IN = 1;
            #(CLK_PERIOD * Prescale * 2);
            check_result("S8: Start Bit Glitch -> Abort to IDLE", 8'h00, 1'b0, 1'b0, 1'b0);

            // Scenario 9: Glitch + New Start
            clear_captured_flags();
            test_start_time = $time;
            RX_IN = 0;
            #(CLK_PERIOD);
            RX_IN = 1;
            #(CLK_PERIOD * Prescale);
            send_uart_frame(8'h7E, PAR_EN, PAR_TYP, 0, 0);
            #(CLK_PERIOD * 2);
            check_result("S9: Start Glitch Followed by New Start (0x7E)", 8'h7E, 1'b0, 1'b0, 1'b1);
            #(CLK_PERIOD * Prescale);

            // Scenario 10: Stop Bit Error
            clear_captured_flags();
            test_start_time = $time;
            PAR_EN  = 0;
            send_uart_frame(8'hF0, PAR_EN, PAR_TYP, 0, 1);
            #(CLK_PERIOD * 2);
            check_result("S10: Stop Bit Glitch Error", 8'hF0, 1'b0, 1'b1, 1'b0);
            RX_IN = 1;
            #(CLK_PERIOD * Prescale);

            // Scenario 11: Parity Error Mismatch
            clear_captured_flags();
            test_start_time = $time;
            PAR_EN  = 1;
            PAR_TYP = 0;
            send_uart_frame(8'h0F, PAR_EN, PAR_TYP, 1, 0);
            #(CLK_PERIOD * 2);
            check_result("S11: Parity Error Mismatch", 8'h0F, 1'b1, 1'b0, 1'b0);
            #(CLK_PERIOD * Prescale);

            // Scenario 12: Stop Error with Valid Data/Parity
            clear_captured_flags();
            test_start_time = $time;
            PAR_EN  = 1;
            PAR_TYP = 1;
            send_uart_frame(8'h33, PAR_EN, PAR_TYP, 0, 1);
            #(CLK_PERIOD * 2);
            check_result("S12: Stop Error with Valid Data/Parity", 8'h33, 1'b0, 1'b1, 1'b0);
            RX_IN = 1;
            #(CLK_PERIOD * Prescale);

        end

        // -------------------------------------------------------------------------
        // Summary Report
        // -------------------------------------------------------------------------
        $display("\n================================================================================");
        $display("                            TEST SUITE SUMMARY                                  ");
        $display("================================================================================");
        $display(" Total Test Cases Run : %0d", total_cases);
        $display(" Passed Test Cases    : %0d", passed_cases);
        $display(" Failed Test Cases    : %0d", failed_cases);

        if (failed_cases > 0) begin
            $display(" Failed Test Case IDs : ");
            for (p_idx = 0; p_idx < failed_cases; p_idx = p_idx + 1) begin
                $display("   -> Case #%0d", failed_case_ids[p_idx]);
            end
            $display("\n RESULT: *** TEST SUITE FAILED ***");
        end else begin
            $display("\n RESULT: *** ALL TEST CASES PASSED SUCCESSFULLY! ***");
        end
        $display("================================================================================");

        $finish;
    end

endmodule