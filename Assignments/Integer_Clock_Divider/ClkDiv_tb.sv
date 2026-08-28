`timescale 1ns/1ps
//=============================================================
// Self-checking testbench for ClkDiv
// Constraints covered:
//   - Counter for total test cases run
//   - Counter for passed test cases
//   - Counter for failed test cases
//   - Summary section reporting total / passed / failed,
//     plus the list of failed ratios
//   - Self-checking: each test compares the DUT's measured
//     output period (in i_ref_clk cycles) against the expected
//     i_div_ratio, no manual waveform inspection needed
//=============================================================
module ClkDiv_tb;

    localparam CLK_PERIOD = 10; // ns

    reg         i_ref_clk;
    reg         i_rst_n;
    reg         i_clk_en;
    reg  [7:0]  i_div_ratio;
    wire        o_div_clk;

    // ---- bookkeeping counters -------------------------------
    integer test_count;
    integer pass_count;
    integer fail_count;
    integer failed_list [0:63];
    integer failed_idx;
    integer k;

    // free running reference-clock cycle counter, used as a
    // "stopwatch" to measure o_div_clk's period
    reg [31:0] cycle_count;

    integer edge1, edge2;

    //---------------------------------------------------------
    // DUT
    //---------------------------------------------------------
    ClkDiv dut (
        .i_ref_clk   (i_ref_clk),
        .i_rst_n     (i_rst_n),
        .i_clk_en    (i_clk_en),
        .i_div_ratio (i_div_ratio),
        .o_div_clk   (o_div_clk)
    );

    //---------------------------------------------------------
    // Reference clock generation
    //---------------------------------------------------------
    initial i_ref_clk = 1'b0;
    always #(CLK_PERIOD/2) i_ref_clk = ~i_ref_clk;

    //---------------------------------------------------------
    // Stopwatch: counts i_ref_clk cycles, cleared on reset
    //---------------------------------------------------------
    always @(posedge i_ref_clk or negedge i_rst_n) begin
        if (!i_rst_n)
            cycle_count <= 32'd0;
        else
            cycle_count <= cycle_count + 32'd1;
    end

    //---------------------------------------------------------
    // Tasks
    //---------------------------------------------------------
    task apply_reset;
        begin
            i_rst_n     = 1'b0;
            i_clk_en    = 1'b0;
            i_div_ratio = 8'd0;
            @(negedge i_ref_clk);
            @(negedge i_ref_clk);
            i_rst_n = 1'b1;
            @(negedge i_ref_clk);
        end
    endtask

    // measures the period of o_div_clk in units of i_ref_clk cycles
    task measure_period(output integer period);
        begin
            @(posedge o_div_clk);
            edge1 = cycle_count;
            @(posedge o_div_clk);
            edge2 = cycle_count;
            period = edge2 - edge1;
        end
    endtask

    task record_result(input integer pass, input [7:0] ratio, input string msg);
        begin
            test_count = test_count + 1;
            if (pass) begin
                pass_count = pass_count + 1;
                $display("[PASS] %0s", msg);
            end else begin
                fail_count = fail_count + 1;
                failed_list[failed_idx] = ratio;
                failed_idx = failed_idx + 1;
                $display("[FAIL] %0s", msg);
            end
        end
    endtask

    // normal divide-by-n check for a valid ratio (>=2)
    task check_divide(input [7:0] ratio);
        integer period;
        string msg;
        begin
            i_div_ratio = ratio;
            i_clk_en    = 1'b1;
            repeat (2) @(posedge o_div_clk); // let it settle a couple periods
            measure_period(period);
            if (period == ratio)
                msg = $sformatf("ratio=%0d (%0s) -> period=%0d cycles as expected",
                             ratio, (ratio % 2 == 0) ? "EVEN" : "ODD", period);
            else
                msg = $sformatf("ratio=%0d (%0s) -> measured period=%0d, expected=%0d",
                             ratio, (ratio % 2 == 0) ? "EVEN" : "ODD", period, ratio);
            record_result((period == ratio), ratio, msg);
        end
    endtask

    // corner-case check: divider must stay disabled (output held low)
    task check_disabled(input [7:0] ratio, input string label);
        integer i;
        reg saw_high;
        string msg;
        begin
            i_div_ratio = ratio;
            i_clk_en    = 1'b1;
            saw_high    = 1'b0;
            for (i = 0; i < 20; i = i + 1) begin
                @(posedge i_ref_clk);
                if (o_div_clk) saw_high = 1'b1;
            end
            if (!saw_high)
                msg = $sformatf("%0s (ratio=%0d) -> o_div_clk correctly held low", label, ratio);
            else
                msg = $sformatf("%0s (ratio=%0d) -> o_div_clk toggled, expected disabled", label, ratio);
            record_result(!saw_high, ratio, msg);
        end
    endtask

    //---------------------------------------------------------
    // Test sequence
    //---------------------------------------------------------
    initial begin
        test_count = 0;
        pass_count = 0;
        fail_count = 0;
        failed_idx = 0;

        apply_reset;

        // ---- Corner cases from the spec: div_ratio 0 and 1 ----
        check_disabled(8'd0, "div_ratio=0 corner case");
        apply_reset;
        check_disabled(8'd1, "div_ratio=1 corner case");
        apply_reset;

        // ---- i_clk_en = 0 must hold output low regardless of ratio ----
        begin : clk_en_test
            string msg;
            i_div_ratio = 8'd4;
            i_clk_en    = 1'b0;
            repeat (10) @(posedge i_ref_clk);
            if (o_div_clk == 1'b0)
                msg = $sformatf("i_clk_en=0 -> o_div_clk correctly held low");
            else
                msg = $sformatf("i_clk_en=0 -> o_div_clk did not hold low");
            record_result((o_div_clk == 1'b0), 8'd4, msg);
        end
        apply_reset;

        // ---- Even ratios ----
        check_divide(8'd2);  apply_reset;
        check_divide(8'd4);  apply_reset;
        check_divide(8'd6);  apply_reset;
        check_divide(8'd8);  apply_reset;
        check_divide(8'd16); apply_reset;
        check_divide(8'd32); apply_reset;

        // ---- Odd ratios ----
        check_divide(8'd3);  apply_reset;
        check_divide(8'd5);  apply_reset;
        check_divide(8'd7);  apply_reset;
        check_divide(8'd9);  apply_reset;
        check_divide(8'd15); apply_reset;
        check_divide(8'd31); apply_reset;

        // ---- Boundary value ----
        check_divide(8'd255); apply_reset;

        //-----------------------------------------------------
        // Summary
        //-----------------------------------------------------
        $display("\n==================== TEST SUMMARY ====================");
        $display("Total test cases : %0d", test_count);
        $display("Passed           : %0d", pass_count);
        $display("Failed           : %0d", fail_count);
        if (fail_count > 0) begin
            $display("Failed test case ratios:");
            for (k = 0; k < failed_idx; k = k + 1)
                $display("  - ratio = %0d", failed_list[k]);
        end
        $display("========================================================\n");

        $finish;
    end

endmodule