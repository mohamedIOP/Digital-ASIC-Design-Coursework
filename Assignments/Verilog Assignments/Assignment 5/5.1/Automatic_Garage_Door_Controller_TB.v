`timescale 1ns/1ps

module Automatic_Garage_Door_Controller_TB;

    //-------------------------------------------------------------------------
    // Parameters
    //-------------------------------------------------------------------------
    localparam CLK_PERIOD = 20; // 50 MHz -> 20 ns period
    
    // DUT internal state encoding (must match the design)
    localparam [1:0] IDLE_state  = 2'b00;
    localparam [1:0] Mv_Up_state = 2'b01;
    localparam [1:0] Mv_Dn_state = 2'b10;

    //-------------------------------------------------------------------------
    // Signals
    //-------------------------------------------------------------------------
    reg  UP_Max_TB;
    reg  DN_Max_TB;
    reg  Activate_TB;
    reg  CLK_TB;
    reg  RST_TB;
    
    wire UP_M_TB;
    wire DN_M_TB;
    
    // Test tracking counters
    integer test_num = 0;
    integer passed   = 0;
    integer failed   = 0;

    //-------------------------------------------------------------------------
    // DUT Instantiation
    //-------------------------------------------------------------------------
    Automatic_Garage_Door_Controller DUT (
        .UP_Max   (UP_Max_TB),
        .DN_Max   (DN_Max_TB),
        .Activate (Activate_TB),
        .CLK      (CLK_TB),
        .RST      (RST_TB),
        .UP_M     (UP_M_TB),
        .DN_M     (DN_M_TB)
    );

    //-------------------------------------------------------------------------
    // Clock Generation: 50 MHz (20 ns period)
    //-------------------------------------------------------------------------
    initial begin
        CLK_TB = 0;
        forever #(CLK_PERIOD / 2) CLK_TB = ~CLK_TB;
    end

    //-------------------------------------------------------------------------
    // Timeout Watchdog (safety net if DUT hangs)
    //-------------------------------------------------------------------------
    initial begin
        #5000;
        $display("[TIMEOUT] Simulation exceeded limit. Terminating.");
        $finish;
    end

    //-------------------------------------------------------------------------
    // Tasks
    //-------------------------------------------------------------------------
    
    // Apply asynchronous reset (active-low)
    task apply_reset;
        begin
            $display("[INFO] Applying asynchronous reset...");
            RST_TB = 0;
            #(CLK_PERIOD * 2);
            RST_TB = 1;
            #(CLK_PERIOD);
        end
    endtask

    // Drive inputs at negedge (clean setup time before next posedge)
    task drive_inputs;
        input up_max;
        input dn_max;
        input activate;
        begin
            @(negedge CLK_TB);
            UP_Max_TB   = up_max;
            DN_Max_TB   = dn_max;
            Activate_TB = activate;
        end
    endtask

    // Check state and outputs at negedge (stable sampling point)
    // Hierarchical reference DUT.current_state lets us verify the internal state.
    task check_state_outputs;
        input [1:0]    exp_state;
        input          exp_up_m;
        input          exp_dn_m;
        input [8*64:1] test_name;
        begin
            @(negedge CLK_TB);
            test_num = test_num + 1;
            
            if (DUT.current_state !== exp_state) begin
                $error("TEST %0d FAILED: %-45s | Expected state=%b, Got state=%b @ %0t",
                       test_num, test_name, exp_state, DUT.current_state, $time);
                failed = failed + 1;
            end
            else if (UP_M_TB !== exp_up_m) begin
                $error("TEST %0d FAILED: %-45s | Expected UP_M=%b, Got UP_M=%b @ %0t",
                       test_num, test_name, exp_up_m, UP_M_TB, $time);
                failed = failed + 1;
            end
            else if (DN_M_TB !== exp_dn_m) begin
                $error("TEST %0d FAILED: %-45s | Expected DN_M=%b, Got DN_M=%b @ %0t",
                       test_num, test_name, exp_dn_m, DN_M_TB, $time);
                failed = failed + 1;
            end
            else begin
                $display("TEST %0d PASSED: %-45s @ %0t", test_num, test_name, $time);
                passed = passed + 1;
            end
        end
    endtask

    //-------------------------------------------------------------------------
    // Main Test Sequence
    //-------------------------------------------------------------------------
    initial begin
        $display("================================================================================");
        $display("          Automatic Garage Door Controller - Self-Checking Testbench");
        $display("================================================================================");
        $display("[INFO] Clock Period = %0d ns (50 MHz)", CLK_PERIOD);
        $display("");

        // Initialize inputs to safe defaults
        UP_Max_TB   = 0;
        DN_Max_TB   = 0;
        Activate_TB = 0;

        //---------------------------------------------------------------------
        // 1. Power-on / Asynchronous Reset
        //---------------------------------------------------------------------
        apply_reset;
        check_state_outputs(IDLE_state, 1'b0, 1'b0, "Async Reset -> IDLE");

        //---------------------------------------------------------------------
        // 2. IDLE hold when Activate = 0 (door is down)
        //---------------------------------------------------------------------
        drive_inputs(0, 1, 0); // DN_Max=1 (door fully closed), Activate=0
        check_state_outputs(IDLE_state, 1'b0, 1'b0, "IDLE hold (Activate=0)");

        //---------------------------------------------------------------------
        // 3. IDLE -> Mv_Up: Door is down, user presses Activate
        //---------------------------------------------------------------------
        drive_inputs(0, 1, 1); // DN_Max=1, Activate=1
        check_state_outputs(Mv_Up_state, 1'b1, 1'b0, "IDLE -> Mv_Up (open door)");

        //---------------------------------------------------------------------
        // 4. Mv_Up holds while door is moving (UP_Max=0)
        //    In a Moore machine, Activate and DN_Max are don't-cares here.
        //---------------------------------------------------------------------
        drive_inputs(0, 0, 0); // UP_Max=0, DN_Max=0, Activate=0
        check_state_outputs(Mv_Up_state, 1'b1, 1'b0, "Mv_Up hold (UP_Max=0)");

        //---------------------------------------------------------------------
        // 5. Mv_Up -> IDLE: Door fully open (UP_Max=1)
        //---------------------------------------------------------------------
        drive_inputs(1, 0, 0); // UP_Max=1
        check_state_outputs(IDLE_state, 1'b0, 1'b0, "Mv_Up -> IDLE (UP_Max=1)");

        //---------------------------------------------------------------------
        // 6. IDLE -> Mv_Dn: Door is up, user presses Activate
        //---------------------------------------------------------------------
        drive_inputs(1, 0, 1); // UP_Max=1, Activate=1
        check_state_outputs(Mv_Dn_state, 1'b0, 1'b1, "IDLE -> Mv_Dn (close door)");

        //---------------------------------------------------------------------
        // 7. Mv_Dn holds while door is moving (DN_Max=0)
        //    In a Moore machine, Activate and UP_Max are don't-cares here.
        //---------------------------------------------------------------------
        drive_inputs(0, 0, 0); // DN_Max=0, Activate=0
        check_state_outputs(Mv_Dn_state, 1'b0, 1'b1, "Mv_Dn hold (DN_Max=0)");

        //---------------------------------------------------------------------
        // 8. Mv_Dn -> IDLE: Door fully closed (DN_Max=1)
        //---------------------------------------------------------------------
        drive_inputs(0, 1, 0); // DN_Max=1
        check_state_outputs(IDLE_state, 1'b0, 1'b0, "Mv_Dn -> IDLE (DN_Max=1)");

        //---------------------------------------------------------------------
        // 9. Broken sensor: both sensors low, Activate=1 -> must stay IDLE
        //---------------------------------------------------------------------
        drive_inputs(0, 0, 1); // Both 0, Activate=1
        check_state_outputs(IDLE_state, 1'b0, 1'b0, "IDLE hold (both sensors low)");

        //---------------------------------------------------------------------
        // 10. Broken sensor: both sensors high, Activate=1 -> must stay IDLE
        //---------------------------------------------------------------------
        drive_inputs(1, 1, 1); // Both 1, Activate=1
        check_state_outputs(IDLE_state, 1'b0, 1'b0, "IDLE hold (both sensors high)");

        //---------------------------------------------------------------------
        // 11. Mv_Up ignores Activate while moving (Activate=1, UP_Max=0)
        //---------------------------------------------------------------------
        // First enter Mv_Up
        drive_inputs(0, 1, 1); // DN_Max=1, Activate=1 -> next state Mv_Up
        check_state_outputs(Mv_Up_state, 1'b1, 1'b0, "Enter Mv_Up for ignore test");
        // Now keep Activate=1 while door is still moving (UP_Max=0)
        drive_inputs(0, 0, 1); // UP_Max=0, Activate=1
        check_state_outputs(Mv_Up_state, 1'b1, 1'b0, "Mv_Up ignores Activate");

        //---------------------------------------------------------------------
        // 12. Mv_Dn ignores Activate while moving (Activate=1, DN_Max=0)
        //---------------------------------------------------------------------
        // Finish opening first
        drive_inputs(1, 0, 0); // UP_Max=1 -> IDLE
        check_state_outputs(IDLE_state, 1'b0, 1'b0, "Return to IDLE");
        // Enter Mv_Dn
        drive_inputs(1, 0, 1); // UP_Max=1, Activate=1 -> Mv_Dn
        check_state_outputs(Mv_Dn_state, 1'b0, 1'b1, "Enter Mv_Dn for ignore test");
        // Keep Activate=1 while door is still moving (DN_Max=0)
        drive_inputs(0, 0, 1); // DN_Max=0, Activate=1
        check_state_outputs(Mv_Dn_state, 1'b0, 1'b1, "Mv_Dn ignores Activate");

        //---------------------------------------------------------------------
        // 13. Asynchronous reset from Mv_Dn (asserted mid-cycle)
        //---------------------------------------------------------------------
        // Ensure we are in Mv_Dn
        drive_inputs(1, 0, 1); // UP_Max=1, Activate=1 -> next state Mv_Dn
        @(negedge CLK_TB); // Wait for stable state
        #5; // Move to middle of cycle (async reset must work without clock)
        RST_TB = 0;
        #1; // Propagation delay
        test_num = test_num + 1;
        if (DUT.current_state !== IDLE_state || UP_M_TB !== 0 || DN_M_TB !== 0) begin
            $error("TEST %0d FAILED: %-45s | Expected IDLE/00, Got state=%b UP_M=%b DN_M=%b @ %0t",
                   test_num, "Async Reset from Mv_Dn", DUT.current_state, UP_M_TB, DN_M_TB, $time);
            failed = failed + 1;
        end else begin
            $display("TEST %0d PASSED: %-45s @ %0t", test_num, "Async Reset from Mv_Dn", $time);
            passed = passed + 1;
        end
        RST_TB = 1;
        // CRITICAL FIX: After releasing reset, stale inputs (UP_Max=1, Activate=1)
        // would cause IDLE->Mv_Dn on the next clock edge. Drive safe inputs first
        // to establish a known IDLE baseline before the next test.
        drive_inputs(0, 1, 0); // DN_Max=1, Activate=0 -> stay in IDLE
        check_state_outputs(IDLE_state, 1'b0, 1'b0, "IDLE cleanup after async reset");

        //---------------------------------------------------------------------
        // 14. Asynchronous reset from Mv_Up (asserted mid-cycle)
        //---------------------------------------------------------------------
        // Enter Mv_Up from known IDLE (door down)
        drive_inputs(0, 1, 1); // DN_Max=1, Activate=1 -> Mv_Up
        check_state_outputs(Mv_Up_state, 1'b1, 1'b0, "Enter Mv_Up for reset test");
        // Assert reset mid-cycle
        @(negedge CLK_TB);
        #5;
        RST_TB = 0;
        #1;
        test_num = test_num + 1;
        if (DUT.current_state !== IDLE_state || UP_M_TB !== 0 || DN_M_TB !== 0) begin
            $error("TEST %0d FAILED: %-45s | Expected IDLE/00, Got state=%b UP_M=%b DN_M=%b @ %0t",
                   test_num, "Async Reset from Mv_Up", DUT.current_state, UP_M_TB, DN_M_TB, $time);
            failed = failed + 1;
        end else begin
            $display("TEST %0d PASSED: %-45s @ %0t", test_num, "Async Reset from Mv_Up", $time);
            passed = passed + 1;
        end
        RST_TB = 1;

        //---------------------------------------------------------------------
        // Final Summary
        //---------------------------------------------------------------------
        $display("");
        $display("================================================================================");
        $display("                              TEST SUMMARY");
        $display("================================================================================");
        $display(" Total Tests Run : %0d", test_num);
        $display(" Passed          : %0d", passed);
        $display(" Failed          : %0d", failed);
        $display("--------------------------------------------------------------------------------");
        if (failed == 0)
            $display(" RESULT          : ALL TESTS PASSED");
        else
            $display(" RESULT          : %0d TEST(S) FAILED", failed);
        $display("================================================================================");

        $finish;
    end

    //-------------------------------------------------------------------------
    // VCD Dump for waveform debug
    //-------------------------------------------------------------------------
    initial begin
        $dumpfile("Automatic_Garage_Door_Controller_TB.vcd");
        $dumpvars(0, Automatic_Garage_Door_Controller_TB);
    end

endmodule