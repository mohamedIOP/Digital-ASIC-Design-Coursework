`timescale 1ns/1ps

module tb_RST_SYNC;

    // ------------------------------------------------------------
    // Parameters
    // ------------------------------------------------------------
    parameter NUM_STAGES  = 2;
    parameter CLK_PERIOD  = 10;
    parameter NUM_RANDOM_ITER = 10;

    // ------------------------------------------------------------
    // DUT signals
    // ------------------------------------------------------------
    reg  CLK;
    reg  RST;
    wire SYNC_RST;

    integer errors = 0;
    integer i;

    time last_posedge_clk_time;
    time last_negedge_rst_time;

    // ------------------------------------------------------------
    // DUT instantiation
    // ------------------------------------------------------------
    RST_SYNC #(
        .NUM_STAGES(NUM_STAGES)
    ) DUT (
        .CLK      (CLK),
        .RST      (RST),
        .SYNC_RST (SYNC_RST)
    );

    // ------------------------------------------------------------
    // Clock generation
    // ------------------------------------------------------------
    initial CLK = 1'b0;
    always #(CLK_PERIOD/2) CLK = ~CLK;

    // ------------------------------------------------------------
    // Track reference edges for alignment checks
    // ------------------------------------------------------------
    always @(posedge CLK) last_posedge_clk_time <= $time;
    always @(negedge RST) last_negedge_rst_time <= $time;

    // ------------------------------------------------------------
    // Checker 1: SYNC_RST must fall the instant RST falls (async assert)
    // ------------------------------------------------------------
    always @(negedge SYNC_RST) begin
        if ($time !== last_negedge_rst_time) begin
            $display("[%0t] ERROR: SYNC_RST fell at a time not aligned with RST negedge (RST negedge was at %0t)",
                       $time, last_negedge_rst_time);
            errors = errors + 1;
        end else begin
            $display("[%0t] PASS: SYNC_RST asserted immediately/asynchronously with RST", $time);
        end
    end

    // ------------------------------------------------------------
    // Checker 2: SYNC_RST must only rise on a posedge CLK (sync de-assert)
    // ------------------------------------------------------------
    always @(posedge SYNC_RST) begin
        if ($time !== last_posedge_clk_time) begin
            $display("[%0t] ERROR: SYNC_RST rose at a time not aligned with a CLK posedge (last posedge was at %0t)",
                       $time, last_posedge_clk_time);
            errors = errors + 1;
        end else begin
            $display("[%0t] PASS: SYNC_RST de-asserted synchronously with CLK posedge", $time);
        end
    end

    // ------------------------------------------------------------
    // Task: apply an async reset pulse, de-assert at a non clock-aligned
    // time, then measure the de-assertion latency in clock edges
    // ------------------------------------------------------------
    task run_reset_pulse;
        input [31:0] assert_offset;   // async offset before asserting (ns)
        input [31:0] hold_time;       // how long to hold reset low (ns)
        integer cyc_count;
        begin
            #assert_offset;
            RST = 1'b0;
            $display("[%0t] RST asserted (async)", $time);

            #hold_time;
            if (SYNC_RST !== 1'b0) begin
                $display("[%0t] ERROR: SYNC_RST is not 0 while RST is held low", $time);
                errors = errors + 1;
            end

            RST = 1'b1;
            $display("[%0t] RST de-asserted (async, mid-cycle)", $time);

            cyc_count = 0;
            while (SYNC_RST !== 1'b1) begin
                @(posedge CLK);
                #1; // let the DUT's nonblocking update settle before sampling
                cyc_count = cyc_count + 1;
            end

            $display("[%0t] Measured de-assertion latency = %0d clock edge(s) (expected %0d)",
                       $time, cyc_count, NUM_STAGES);

            if (cyc_count !== NUM_STAGES) begin
                $display("[%0t] ERROR: Latency mismatch! Expected %0d, got %0d",
                           $time, NUM_STAGES, cyc_count);
                errors = errors + 1;
            end else begin
                $display("[%0t] PASS: Latency matches NUM_STAGES", $time);
            end
        end
    endtask

    // ------------------------------------------------------------
    // Stimulus
    // ------------------------------------------------------------
    initial begin
        $dumpfile("tb_RST_SYNC.vcd");
        $dumpvars(0, tb_RST_SYNC);

        $display("========================================================");
        $display(" RST_SYNC Testbench Start (NUM_STAGES = %0d)", NUM_STAGES);
        $display("========================================================");

        RST = 1'b1;
        #3; // start mid-cycle, not aligned to a clock edge

        // Directed test 1: simple reset pulse
        run_reset_pulse(4, 23);
        #(CLK_PERIOD*4);

        // Directed test 2: reset asserted again while chain is mid-fill
        run_reset_pulse(7, 3);   // very short hold, well inside a clock period
        #(CLK_PERIOD*4);

        // Directed test 3: reset held for many cycles, then released
        run_reset_pulse(2, CLK_PERIOD*6 + 3);
        #(CLK_PERIOD*4);

        // Randomized async assert/de-assert timing sweep
        for (i = 0; i < NUM_RANDOM_ITER; i = i + 1) begin
            run_reset_pulse(($unsigned($random) % 20) + 1, ($unsigned($random) % 30) + 1);
            #(CLK_PERIOD*3);
        end

        // ------------------------------------------------------------
        // Summary
        // ------------------------------------------------------------
        $display("========================================================");
        if (errors == 0)
            $display("*** ALL TESTS PASSED ***");
        else
            $display("*** %0d TEST(S) FAILED ***", errors);
        $display("========================================================");

        $finish;
    end

    // ------------------------------------------------------------
    // Safety timeout
    // ------------------------------------------------------------
    initial begin
        #(CLK_PERIOD * 1000);
        $display("[%0t] ERROR: Testbench timeout - simulation did not finish", $time);
        $finish;
    end

endmodule
