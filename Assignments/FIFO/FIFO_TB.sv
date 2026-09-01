`timescale 1ns/1ps

module tb_ASYNC_FIFO;

    //=====================================================================
    // Parameters
    //=====================================================================
    parameter DATA_WIDTH  = 8;
    parameter WCLK_PERIOD = 10;   // 100 MHz write clock
    parameter RCLK_PERIOD = 25;   // 40  MHz read  clock
    parameter FIFO_DEPTH  = 8;    // depth fixed at 8 (3-bit address) per spec

    //=====================================================================
    // DUT signals
    //=====================================================================
    reg                   W_CLK, W_RST, W_INC;
    reg                   R_CLK, R_RST, R_INC;
    reg  [DATA_WIDTH-1:0] WR_DATA;
    wire                  FULL, EMPTY;
    wire [DATA_WIDTH-1:0] RD_DATA;

    ASYNC_FIFO #(.DATA_WIDTH(DATA_WIDTH)) dut (
        .W_CLK   (W_CLK),
        .W_RST   (W_RST),
        .W_INC   (W_INC),
        .R_CLK   (R_CLK),
        .R_RST   (R_RST),
        .R_INC   (R_INC),
        .WR_DATA (WR_DATA),
        .FULL    (FULL),
        .EMPTY   (EMPTY),
        .RD_DATA (RD_DATA)
    );

    //=====================================================================
    // Clock generation
    //=====================================================================
    initial W_CLK = 1'b0;
    always #(WCLK_PERIOD/2) W_CLK = ~W_CLK;

    initial R_CLK = 1'b0;
    always #(RCLK_PERIOD/2) R_CLK = ~R_CLK;

    //=====================================================================
    // Reference model (scoreboard) -- FIFO order queue of expected bytes
    //=====================================================================
    bit [DATA_WIDTH-1:0] sb_queue [$];

    //=====================================================================
    // Bookkeeping
    //=====================================================================
    integer total_checks   = 0;
    integer passed_checks  = 0;
    integer failed_checks  = 0;
    integer failed_ids [$];

    integer total_scenarios = 11;
    integer scenario_num    = 0;
    time    scenario_start_t;
    time    sim_start_t;

    // 2-party barrier: keeps the write-domain and read-domain initial
    // blocks lined up at scenario boundaries. Within a scenario, each
    // domain runs freely off the DUT's own FULL/EMPTY flags.
    integer barrier_cnt = 0;
    event   barrier_ev;

    task automatic sync_barrier();
        barrier_cnt = barrier_cnt + 1;
        if (barrier_cnt == 2) begin
            barrier_cnt = 0;
            -> barrier_ev;
        end
        else begin
            @(barrier_ev);
        end
    endtask

    task automatic start_scenario(input string label);
        scenario_num     = scenario_num + 1;
        scenario_start_t = $time;
        $display("\n--------------------------------------------------------------------------------");
        $display("TESTCASE %0d/%0d : %s", scenario_num, total_scenarios, label);
        $display("  start time = %0t", scenario_start_t);
        $display("--------------------------------------------------------------------------------");
    endtask

    task automatic end_scenario();
        $display("  end time   = %0t   (duration = %0t)", $time, $time - scenario_start_t);
    endtask

    task automatic show_inner_signals(input string tag);
        $display("    [inner:%s] wptr=%b rptr=%b wq2_rptr=%b rq2_wptr=%b waddr=%0d raddr=%0d",
                   tag, dut.wptr_inner, dut.rptr_inner,
                   dut.wq2_rptr_inner, dut.rq2_wptr_inner,
                   dut.waddr_inner, dut.raddr_inner);
    endtask

    task automatic check_bit(input string label, input logic actual, input logic expected);
        total_checks = total_checks + 1;
        if (actual === expected) begin
            passed_checks = passed_checks + 1;
            $display("  [PASS] %-58s expected=%b actual=%b @%0t", label, expected, actual, $time);
        end else begin
            failed_checks = failed_checks + 1;
            failed_ids.push_back(total_checks);
            $display("  [FAIL] %-58s expected=%b actual=%b @%0t", label, expected, actual, $time);
        end
    endtask

    task automatic check_byte(input string label, input logic [DATA_WIDTH-1:0] actual, input logic [DATA_WIDTH-1:0] expected);
        total_checks = total_checks + 1;
        if (actual === expected) begin
            passed_checks = passed_checks + 1;
            $display("  [PASS] %-58s expected=%0h actual=%0h @%0t", label, expected, actual, $time);
        end else begin
            failed_checks = failed_checks + 1;
            failed_ids.push_back(total_checks);
            $display("  [FAIL] %-58s expected=%0h actual=%0h @%0t", label, expected, actual, $time);
        end
    endtask

    task automatic print_summary();
        integer k;
        $display("\n====================================================================================");
        $display("SIMULATION SUMMARY");
        $display("  sim start time     = %0t", sim_start_t);
        $display("  sim end   time     = %0t", $time);
        $display("  total testcases    = %0d", total_scenarios);
        $display("  total checks       = %0d", total_checks);
        $display("  passed checks      = %0d", passed_checks);
        $display("  failed checks      = %0d", failed_checks);
        if (failed_checks == 0) begin
            $display("  RESULT             = ALL CHECKS PASSED");
        end else begin
            $display("  RESULT             = %0d CHECK(S) FAILED, ids:", failed_checks);
            for (k = 0; k < failed_ids.size(); k = k + 1)
                $display("     - failed check #%0d", failed_ids[k]);
        end
        $display("====================================================================================\n");
    endtask

    //=====================================================================
    // Low level single-cycle write / read tasks
    // Each samples FULL/EMPTY right before the clock edge that would
    // perform the operation -- exactly the way real control logic gates
    // a write/read, and exactly what the RTL itself samples.
    //=====================================================================
    task automatic wr_pulse(input [DATA_WIDTH-1:0] data, output bit did_write);
        @(negedge W_CLK);
        WR_DATA   = data;
        W_INC     = 1'b1;
        did_write = !FULL;
        @(posedge W_CLK);
        #1;
        W_INC     = 1'b0;
    endtask

    task automatic rd_pulse(output bit did_read, output logic [DATA_WIDTH-1:0] data_out);
        @(negedge R_CLK);
        R_INC     = 1'b1;
        did_read  = !EMPTY;
        data_out  = RD_DATA;
        @(posedge R_CLK);
        #1;
        R_INC     = 1'b0;
    endtask

    //=====================================================================
    // Continuous output monitor (required: display FULL/EMPTY/RD_DATA)
    //=====================================================================
    initial begin
        $display("TIME\t\tW_RST R_RST W_INC R_INC WR_DATA FULL EMPTY RD_DATA");
        $monitor("%0t\t\t  %b     %b     %b     %b     %0h      %b    %b     %0h",
                  $time, W_RST, R_RST, W_INC, R_INC, WR_DATA, FULL, EMPTY, RD_DATA);
    end

    initial sim_start_t = $time;

    //=====================================================================
    // WRITE-DOMAIN STIMULUS  (initial block #1)
    //=====================================================================
    initial begin
        bit did_w;
        integer i;

        W_RST   = 1'b0;
        W_INC   = 1'b0;
        WR_DATA = {DATA_WIDTH{1'b0}};

        // ---------------- TC1 : Reset in Beginning ----------------------
        start_scenario("Reset in Beginning");
            repeat (3) @(posedge W_CLK);
            check_bit("FULL low while in reset", FULL, 1'b0);
            @(negedge W_CLK); W_RST = 1'b1;
            repeat (2) @(posedge W_CLK);
            check_bit("FULL low after reset release", FULL, 1'b0);
        end_scenario();
        sync_barrier();                                             // #1

        // ---------------- TC2 : Write only till full ---------------------
        start_scenario("Write only till full (depth = 8)");
            for (i = 0; i < FIFO_DEPTH; i = i + 1) begin
                wr_pulse(8'hA0 + i[7:0], did_w);
                check_bit($sformatf("write #%0d accepted", i), did_w, 1'b1);
                if (did_w) sb_queue.push_back(8'hA0 + i[7:0]);
            end
            show_inner_signals("after 8 writes");
            check_bit("FULL asserted after 8 writes", FULL, 1'b1);
        end_scenario();
        sync_barrier();                                             // #2

        // ---------------- TC3 : Writing while FULL is high ---------------
        start_scenario("Writing while FULL flag is high");
            wr_pulse(8'hFF, did_w);
            check_bit("write attempt rejected while FULL", did_w, 1'b0);
            check_bit("FULL still high", FULL, 1'b1);
        end_scenario();
        sync_barrier();                                             // #3

        // ---------------- TC4 : Reset when FULL ---------------------------
        start_scenario("Reset when FULL");
            check_bit("precondition: FULL is high", FULL, 1'b1);
            @(negedge W_CLK); W_RST = 1'b0;
            repeat (3) @(posedge W_CLK);
            @(negedge W_CLK); W_RST = 1'b1;
            repeat (2) @(posedge W_CLK);
            sb_queue.delete();
            check_bit("FULL low after reset", FULL, 1'b0);
        end_scenario();
        sync_barrier();                                             // #4

        // ---------------- TC5 : Read only till empty (write refills) -----
        start_scenario("Read only till empty");
            for (i = 0; i < FIFO_DEPTH; i = i + 1) begin
                wr_pulse(8'hB0 + i[7:0], did_w);
                check_bit($sformatf("refill write #%0d accepted", i), did_w, 1'b1);
                if (did_w) sb_queue.push_back(8'hB0 + i[7:0]);
            end
        end_scenario();
        sync_barrier();                                             // #5  (refill done)
        sync_barrier();                                             // #6  (wait for read side to finish draining)

        // ---------------- TC6 : Reading while EMPTY is high ---------------
        start_scenario("Read side probes EMPTY-high rejection");
        end_scenario();
        sync_barrier();                                             // #7

        // ---------------- TC7 : Reset when EMPTY --------------------------
        start_scenario("Reset when EMPTY");
            check_bit("precondition: EMPTY is high", EMPTY, 1'b1);
            @(negedge W_CLK); W_RST = 1'b0;
            repeat (3) @(posedge W_CLK);
            @(negedge W_CLK); W_RST = 1'b1;
            repeat (2) @(posedge W_CLK);
            sb_queue.delete();
            check_bit("FULL low after reset", FULL, 1'b0);
        end_scenario();
        sync_barrier();                                             // #8

        // ---------------- TC8 : Reset during writing ----------------------
        start_scenario("Reset during writing");
            fork
                begin : wburst
                    for (i = 0; i < 5; i = i + 1) begin
                        wr_pulse(8'hC0 + i[7:0], did_w);
                        if (did_w) sb_queue.push_back(8'hC0 + i[7:0]);
                    end
                end
                begin : wrst_mid
                    repeat (2) @(posedge W_CLK);
                    @(negedge W_CLK); W_RST = 1'b0;
                    repeat (2) @(posedge W_CLK);
                    @(negedge W_CLK); W_RST = 1'b1;
                end
            join
            repeat (2) @(posedge W_CLK);
            check_bit("FULL low after mid-write reset", FULL, 1'b0);
            sb_queue.delete();
        end_scenario();
        sync_barrier();                                             // #9

        // ---------------- TC9 : Reset during reading ----------------------
        start_scenario("Reset during reading (write refills first)");
            for (i = 0; i < FIFO_DEPTH; i = i + 1) begin
                wr_pulse(8'hD0 + i[7:0], did_w);
                if (did_w) sb_queue.push_back(8'hD0 + i[7:0]);
            end
        end_scenario();
        sync_barrier();                                             // #10 (refill done)
        sync_barrier();                                             // #11 (wait for read-side mid-reset burst)

        // ---------------- TC10 : Reset during read & write simultaneously
        start_scenario("Reset during simultaneous read & write");
            sb_queue.delete();
            fork
                begin : wburst2
                    for (i = 0; i < 3; i = i + 1) begin
                        wr_pulse(8'hE0 + i[7:0], did_w);
                    end
                end
                begin : wrst_mid2
                    repeat (2) @(posedge W_CLK);
                    @(negedge W_CLK); W_RST = 1'b0;
                    repeat (3) @(posedge W_CLK);
                    @(negedge W_CLK); W_RST = 1'b1;
                end
            join
            repeat (2) @(posedge W_CLK);
            check_bit("FULL low after simultaneous reset", FULL, 1'b0);
            sb_queue.delete();
        end_scenario();
        sync_barrier();                                             // #12

        // ---------------- TC11 : Concurrent write+read, stall on FULL -----
        start_scenario("Concurrent R/W, 9-byte burst @ 100/40MHz (stall on FULL)");
            for (i = 0; i < 9; i = i + 1) begin
                wr_pulse(8'h10 + i[7:0], did_w);
                while (!did_w) wr_pulse(8'h10 + i[7:0], did_w);
                sb_queue.push_back(8'h10 + i[7:0]);
                check_bit($sformatf("byte #%0d eventually written", i), did_w, 1'b1);
            end
        end_scenario();
        sync_barrier();                                             // #13

        repeat (10) @(posedge W_CLK);
        print_summary();
        $finish;
    end

    //=====================================================================
    // READ-DOMAIN STIMULUS  (initial block #2)
    //=====================================================================
    initial begin
        bit did_r;
        logic [DATA_WIDTH-1:0] rdata_seen, rdata_exp;
        integer i;

        R_RST = 1'b0;
        R_INC = 1'b0;

        // ---------------- TC1 : Reset in Beginning ----------------------
        repeat (3) @(posedge R_CLK);
        check_bit("EMPTY high while in reset", EMPTY, 1'b1);
        @(negedge R_CLK); R_RST = 1'b1;
        repeat (2) @(posedge R_CLK);
        check_bit("EMPTY high after reset release", EMPTY, 1'b1);
        sync_barrier();                                             // #1

        // ---------------- TC2 : Write only till full ---------------------
        repeat (4) @(posedge R_CLK);
        check_bit("EMPTY deasserted once synchronizer propagates", EMPTY, 1'b0);
        sync_barrier();                                             // #2

        // ---------------- TC3 : idle --------------------------------------
        sync_barrier();                                             // #3

        // ---------------- TC4 : Reset when FULL ---------------------------
        @(negedge R_CLK); R_RST = 1'b0;
        repeat (3) @(posedge R_CLK);
        @(negedge R_CLK); R_RST = 1'b1;
        repeat (2) @(posedge R_CLK);
        check_bit("EMPTY high after reset (read domain)", EMPTY, 1'b1);
        sync_barrier();                                             // #4

        // ---------------- TC5 : Read only till empty ----------------------
        sync_barrier();                                             // #5  (wait for write side's refill)
        while (!EMPTY) begin
            rd_pulse(did_r, rdata_seen);
            if (did_r) begin
                rdata_exp = sb_queue.pop_front();
                check_byte("drained data matches scoreboard (FIFO order)", rdata_seen, rdata_exp);
            end
        end
        check_bit("EMPTY high after draining all entries", EMPTY, 1'b1);
        sync_barrier();                                             // #6

        // ---------------- TC6 : Reading while EMPTY -----------------------
        rd_pulse(did_r, rdata_seen);
        check_bit("read attempt rejected while EMPTY", did_r, 1'b0);
        check_bit("EMPTY still high", EMPTY, 1'b1);
        sync_barrier();                                             // #7

        // ---------------- TC7 : Reset when EMPTY --------------------------
        @(negedge R_CLK); R_RST = 1'b0;
        repeat (3) @(posedge R_CLK);
        @(negedge R_CLK); R_RST = 1'b1;
        repeat (2) @(posedge R_CLK);
        check_bit("EMPTY high after reset (read domain)", EMPTY, 1'b1);
        sync_barrier();                                             // #8

        // ---------------- TC8 : Reset during writing (read idle) ---------
        sync_barrier();                                             // #9

        // ---------------- TC9 : Reset during reading ----------------------
        sync_barrier();                                             // #10 (wait for write's refill)
        fork
            begin : rburst
                for (i = 0; i < FIFO_DEPTH; i = i + 1) begin
                    rd_pulse(did_r, rdata_seen);
                end
            end
            begin : rrst_mid
                repeat (2) @(posedge R_CLK);
                @(negedge R_CLK); R_RST = 1'b0;
                repeat (2) @(posedge R_CLK);
                @(negedge R_CLK); R_RST = 1'b1;
                #1;
                check_bit("EMPTY high immediately at reset release", EMPTY, 1'b1);
            end
        join
        repeat (3) @(posedge R_CLK);
        check_bit("EMPTY recovers low once rptr resyncs to write side's real data", EMPTY, 1'b0);
        sync_barrier();                                             // #11

        // ---------------- TC10 : simultaneous reset -----------------------
        fork
            begin : rburst2
                for (i = 0; i < 3; i = i + 1) begin
                    rd_pulse(did_r, rdata_seen);
                end
            end
            begin : rrst_mid2
                repeat (2) @(posedge R_CLK);
                @(negedge R_CLK); R_RST = 1'b0;
                repeat (3) @(posedge R_CLK);
                @(negedge R_CLK); R_RST = 1'b1;
            end
        join
        repeat (2) @(posedge R_CLK);
        check_bit("EMPTY high after simultaneous reset (read domain)", EMPTY, 1'b1);
        sync_barrier();                                             // #12

        // ---------------- TC11 : Concurrent write+read --------------------
        for (i = 0; i < 9; i = i + 1) begin
            wait (!EMPTY);
            rd_pulse(did_r, rdata_seen);
            if (did_r) begin
                rdata_exp = sb_queue.pop_front();
                check_byte($sformatf("concurrent read #%0d matches scoreboard", i), rdata_seen, rdata_exp);
            end else begin
                i = i - 1; // retry -- nothing available yet, try again
            end
        end
        sync_barrier();                                             // #13
    end

endmodule
