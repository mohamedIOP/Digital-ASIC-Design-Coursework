`timescale 1ns / 1ps

module DATA_SYNC_tb;

    // Parameters
    parameter NUM_STAGES = 2;
    parameter BUS_WIDTH  = 8;
    parameter CLK_PERIOD = 10; // 100 MHz clock

    // DUT Signals
    reg                   CLK;
    reg                   RST;
    reg  [BUS_WIDTH-1:0]  unsync_bus;
    reg                   bus_enable;
    wire [BUS_WIDTH-1:0]  sync_bus;
    wire                  enable_pulse;

    // Constraints & Tracking Counters
    integer test_case_cnt = 0;
    integer pass_cnt      = 0;
    integer fail_cnt      = 0;
    integer failed_cases [0:99];
    integer i;

    // DUT Instantiation
    DATA_SYNC #(
        .NUM_STAGES(NUM_STAGES),
        .BUS_WIDTH(BUS_WIDTH)
    ) dut (
        .unsync_bus(unsync_bus),
        .bus_enable(bus_enable),
        .CLK(CLK),
        .RST(RST),
        .sync_bus(sync_bus),
        .enable_pulse(enable_pulse)
    );

    // Clock Generation
    always #(CLK_PERIOD / 2) CLK = ~CLK;

    // Self-Checking Verification Task
    task check_outputs;
        input [BUS_WIDTH-1:0] exp_sync_bus;
        input                 exp_enable_pulse;
        begin
            test_case_cnt = test_case_cnt + 1;
            if ((sync_bus === exp_sync_bus) && (enable_pulse === exp_enable_pulse)) begin
                $display("  [PASS] Test Case %0d: sync_bus = 0x%0h, enable_pulse = %b", test_case_cnt, sync_bus, enable_pulse);
                pass_cnt = pass_cnt + 1;
            end else begin
                $display("  [FAIL] Test Case %0d: Expected (sync_bus=0x%0h, pulse=%b), Got (sync_bus=0x%0h, pulse=%b)", 
                         test_case_cnt, exp_sync_bus, exp_enable_pulse, sync_bus, enable_pulse);
                failed_cases[fail_cnt] = test_case_cnt;
                fail_cnt = fail_cnt + 1;
            end
        end
    endtask

    // Main Test Sequence
    initial begin
        // Initialize Inputs
        CLK        = 0;
        RST        = 1;
        unsync_bus = 8'h00;
        bus_enable = 0;

        $display("==================================================");
        $display("         Starting DATA_SYNC Verification          ");
        $display("==================================================");

        // Test Case 1: Active-Low Reset Verification
        $display("\n1. Test Case 1: Active-Low Reset Check");
        #(CLK_PERIOD * 0.2);
        RST = 0;
        #(CLK_PERIOD * 2);
        check_outputs(8'h00, 1'b0);
        RST = 1;
        #(CLK_PERIOD);

        // Test Case 2: Multi-Cycle Enable Data Transfer (0xA5)
        $display("\n2. Test Case 2: Synchronize Data Vector 0xA5");
        unsync_bus = 8'hA5;
        bus_enable = 1;
        #(CLK_PERIOD * 3); // Wait for synchronization propagation
        check_outputs(8'hA5, 1'b1);

        // Test Case 3: Enable Pulse Deassertion Check
        $display("\n3. Test Case 3: Pulse Deassertion Verification");
        bus_enable = 0;
        #(CLK_PERIOD);
        check_outputs(8'hA5, 1'b0);

        // Test Case 4: Single-Cycle Enable Pulse Data Transfer (0x3C)
        $display("\n4. Test Case 4: Single-Cycle Enable with Data 0x3C");
        unsync_bus = 8'h3C;
        bus_enable = 1;
        #(CLK_PERIOD);
        bus_enable = 0;
        #(CLK_PERIOD * 2);
        check_outputs(8'h3C, 1'b1);

        // Test Case 5: Bus Value Stability (Hold Value when bus_enable is LOW)
        $display("\n5. Test Case 5: Bus Value Hold Check without Enable");
        unsync_bus = 8'hFF; // Change unsync_bus without bus_enable
        #(CLK_PERIOD * 3);
        check_outputs(8'h3C, 1'b0);

        // Test Case Summary Display
        $display("\n==================================================");
        $display("                TESTBENCH SUMMARY                 ");
        $display("==================================================");
        $display("Total Executed Test Cases : %0d", test_case_cnt);
        $display("Passed Test Cases         : %0d", pass_cnt);
        $display("Failed Test Cases         : %0d", fail_cnt);

        if (fail_cnt > 0) begin
            $write("Failed Test Case Numbers  : ");
            for (i = 0; i < fail_cnt; i = i + 1) begin
                $write("%0d ", failed_cases[i]);
            end
            $display("");
        end else begin
            $display("Status                    : ALL TESTS PASSED");
        end
        $display("==================================================");

        $finish;
    end

endmodule