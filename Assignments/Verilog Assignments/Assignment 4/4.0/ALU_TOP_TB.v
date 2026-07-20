`timescale 1ns/1ps

module ALU_TOP_TB;

    // Parameters
    parameter inputWidth = 16;
    parameter outputWidth = 16;

    // Clock period for 100KHz = 10us (10000ns)
    // Duty cycle: 40% low = 4000ns, 60% high = 6000ns
    parameter CLK_LOW = 4000;
    parameter CLK_HIGH = 6000;
    parameter CLK_PERIOD = CLK_LOW + CLK_HIGH;

    // Testbench Signals
    reg [inputWidth-1:0] A_TB, B_TB;
    reg [3:0] ALU_FUN_TB;
    reg CLK_TB, RST_TB;

    wire [outputWidth*2-1:0] Arith_OUT_TB;
    wire [outputWidth-1:0] Logic_OUT_TB, Cmp_OUT_TB, Shift_OUT_TB;
    wire Arith_Flag_TB, Logic_Flag_TB, Cmp_Flag_TB, Shift_Flag_TB;

    // Flags concatenation for easy checking
    wire [3:0] Flags_TB;
    assign Flags_TB = {Shift_Flag_TB, Cmp_Flag_TB, Logic_Flag_TB, Arith_Flag_TB};

    // Expected values
    reg signed [outputWidth*2-1:0] exp_Arith_OUT;
    reg [outputWidth-1:0] exp_Logic_OUT, exp_Cmp_OUT, exp_Shift_OUT;
    reg [3:0] exp_Flags;

    // Test counters
    integer passed = 0;
    integer failed = 0;
    integer test_num = 0;

    // DUT Instantiation
    ALU_TOP #(.inputWidth(inputWidth), .outputWidth(outputWidth)) DUT (
        .A(A_TB),
        .B(B_TB),
        .ALU_FUN(ALU_FUN_TB),
        .CLK(CLK_TB),
        .RST(RST_TB),
        .Arith_OUT(Arith_OUT_TB),
        .Logic_OUT(Logic_OUT_TB),
        .Cmp_OUT(Cmp_OUT_TB),
        .Shift_OUT(Shift_OUT_TB),
        .Arith_Flag(Arith_Flag_TB),
        .Logic_Flag(Logic_Flag_TB),
        .Cmp_Flag(Cmp_Flag_TB),
        .Shift_Flag(Shift_Flag_TB)
    );

    // Clock Generation: 100KHz, 40% low (4us), 60% high (6us)
    initial begin
        CLK_TB = 0;
        forever begin
            #(CLK_LOW)  CLK_TB = ~CLK_TB;  // low for 4us
            #(CLK_HIGH) CLK_TB = ~CLK_TB;  // high for 6us
        end
    end

    // Task: Apply Reset
    task apply_reset;
        begin
            RST_TB = 0;
            #(CLK_PERIOD * 2);
            RST_TB = 1;
            #(CLK_PERIOD);
        end
    endtask

    // Task: Apply inputs and wait one clock
    task apply_inputs;
        input [inputWidth-1:0] a_val;
        input [inputWidth-1:0] b_val;
        input [3:0] alu_fun;
        begin
            @(posedge CLK_TB);
            A_TB = a_val;
            B_TB = b_val;
            ALU_FUN_TB = alu_fun;
            @(posedge CLK_TB);  // Wait for registered output
            #(CLK_PERIOD/4);   // Small delay to sample stable output
        end
    endtask

    // Task: Check Arithmetic Result
    task check_arith;
        input signed [outputWidth*2-1:0] expected;
        input [3:0] exp_flags;
        input [255:0] test_name;  // String
        begin
            test_num = test_num + 1;
            if (Arith_OUT_TB === expected && Flags_TB === exp_flags) begin
                $display("TEST %0d PASSED: %0s | Arith_OUT = %0d (0x%h), Flags = %04b", 
                         test_num, test_name, Arith_OUT_TB, Arith_OUT_TB, Flags_TB);
                passed = passed + 1;
            end
            else begin
                $display("TEST %0d FAILED: %0s | Expected Arith_OUT = %0d (0x%h), Flags = %04b | Got Arith_OUT = %0d (0x%h), Flags = %04b", 
                         test_num, test_name, expected, expected, exp_flags,
                         Arith_OUT_TB, Arith_OUT_TB, Flags_TB);
                failed = failed + 1;
            end
        end
    endtask

    // Task: Check Logic Result
    task check_logic;
        input [outputWidth-1:0] expected;
        input [3:0] exp_flags;
        input [255:0] test_name;
        begin
            test_num = test_num + 1;
            if (Logic_OUT_TB === expected && Flags_TB === exp_flags) begin
                $display("TEST %0d PASSED: %0s | Logic_OUT = 0x%h, Flags = %04b", 
                         test_num, test_name, Logic_OUT_TB, Flags_TB);
                passed = passed + 1;
            end
            else begin
                $display("TEST %0d FAILED: %0s | Expected Logic_OUT = 0x%h, Flags = %04b | Got Logic_OUT = 0x%h, Flags = %04b", 
                         test_num, test_name, expected, exp_flags,
                         Logic_OUT_TB, Flags_TB);
                failed = failed + 1;
            end
        end
    endtask

    // Task: Check Compare Result
    task check_cmp;
        input [outputWidth-1:0] expected;
        input [3:0] exp_flags;
        input [255:0] test_name;
        begin
            test_num = test_num + 1;
            if (Cmp_OUT_TB === expected && Flags_TB === exp_flags) begin
                $display("TEST %0d PASSED: %0s | Cmp_OUT = %0d, Flags = %04b", 
                         test_num, test_name, Cmp_OUT_TB, Flags_TB);
                passed = passed + 1;
            end
            else begin
                $display("TEST %0d FAILED: %0s | Expected Cmp_OUT = %0d, Flags = %04b | Got Cmp_OUT = %0d, Flags = %04b", 
                         test_num, test_name, expected, exp_flags,
                         Cmp_OUT_TB, Flags_TB);
                failed = failed + 1;
            end
        end
    endtask

    // Task: Check Shift Result
    task check_shift;
        input [outputWidth-1:0] expected;
        input [3:0] exp_flags;
        input [255:0] test_name;
        begin
            test_num = test_num + 1;
            if (Shift_OUT_TB === expected && Flags_TB === exp_flags) begin
                $display("TEST %0d PASSED: %0s | Shift_OUT = 0x%h, Flags = %04b", 
                         test_num, test_name, Shift_OUT_TB, Flags_TB);
                passed = passed + 1;
            end
            else begin
                $display("TEST %0d FAILED: %0s | Expected Shift_OUT = 0x%h, Flags = %04b | Got Shift_OUT = 0x%h, Flags = %04b", 
                         test_num, test_name, expected, exp_flags,
                         Shift_OUT_TB, Flags_TB);
                failed = failed + 1;
            end
        end
    endtask

    // Main Test Sequence
    initial begin
        $display("========================================");
        $display("     ALU_TOP Testbench Started");
        $display("     Clock: 100KHz (40%% low, 60%% high)");
        $display("========================================");

        // Initialize
        A_TB = 0;
        B_TB = 0;
        ALU_FUN_TB = 0;

        // Apply reset
        apply_reset;

        //============================================================
        // ARITHMETIC OPERATIONS (ALU_FUN[3:2] = 00)
        // Flags: Arith_Flag=1, others=0 -> Flags = 0001
        //============================================================
        $display("\n--- Signed Arithmetic: Addition (ALU_FUN=0000) ---");

        // 1. A negative, B negative
        apply_inputs(16'hFFFC, 16'hFFF6, 4'b0000);  // -4 + -10 = -14
        check_arith(-14, 4'b0001, "ADD: NEG + NEG");

        // 2. A positive, B negative
        apply_inputs(16'd20, 16'hFFF6, 4'b0000);    // 20 + -10 = 10
        check_arith(10, 4'b0001, "ADD: POS + NEG");

        // 3. A negative, B positive
        apply_inputs(16'hFFFC, 16'd15, 4'b0000);    // -4 + 15 = 11
        check_arith(11, 4'b0001, "ADD: NEG + POS");

        // 4. A positive, B positive
        apply_inputs(16'd25, 16'd30, 4'b0000);      // 25 + 30 = 55
        check_arith(55, 4'b0001, "ADD: POS + POS");

        $display("\n--- Signed Arithmetic: Subtraction (ALU_FUN=0001) ---");

        // 5. A negative, B negative
        apply_inputs(16'hFFFC, 16'hFFF6, 4'b0001);  // -4 - -10 = 6
        check_arith(6, 4'b0001, "SUB: NEG - NEG");

        // 6. A positive, B negative
        apply_inputs(16'd20, 16'hFFF6, 4'b0001);    // 20 - -10 = 30
        check_arith(30, 4'b0001, "SUB: POS - NEG");

        // 7. A negative, B positive
        apply_inputs(16'hFFFC, 16'd15, 4'b0001);    // -4 - 15 = -19
        check_arith(-19, 4'b0001, "SUB: NEG - POS");

        // 8. A positive, B positive
        apply_inputs(16'd50, 16'd20, 4'b0001);      // 50 - 20 = 30
        check_arith(30, 4'b0001, "SUB: POS - POS");

        $display("\n--- Signed Arithmetic: Multiplication (ALU_FUN=0010) ---");

        // 9. A negative, B negative
        apply_inputs(16'hFFFC, 16'hFFF6, 4'b0010);  // -4 * -10 = 40
        check_arith(40, 4'b0001, "MUL: NEG * NEG");

        // 10. A positive, B negative
        apply_inputs(16'd5, 16'hFFFE, 4'b0010);     // 5 * -2 = -10
        check_arith(-10, 4'b0001, "MUL: POS * NEG");

        // 11. A negative, B positive
        apply_inputs(16'hFFFE, 16'd7, 4'b0010);     // -2 * 7 = -14
        check_arith(-14, 4'b0001, "MUL: NEG * POS");

        // 12. A positive, B positive
        apply_inputs(16'd6, 16'd8, 4'b0010);        // 6 * 8 = 48
        check_arith(48, 4'b0001, "MUL: POS * POS");

        $display("\n--- Signed Arithmetic: Division (ALU_FUN=0011) ---");

        // 13. A negative, B negative
        apply_inputs(16'hFFEC, 16'hFFF6, 4'b0011);  // -20 / -10 = 2
        check_arith(2, 4'b0001, "DIV: NEG / NEG");

        // 14. A positive, B negative
        apply_inputs(16'd30, 16'hFFFE, 4'b0011);    // 30 / -2 = -15
        check_arith(-15, 4'b0001, "DIV: POS / NEG");

        // 15. A negative, B positive
        apply_inputs(16'hFFEC, 16'd5, 4'b0011);     // -20 / 5 = -4
        check_arith(-4, 4'b0001, "DIV: NEG / POS");

        // 16. A positive, B positive
        apply_inputs(16'd100, 16'd4, 4'b0011);      // 100 / 4 = 25
        check_arith(25, 4'b0001, "DIV: POS / POS");

        //============================================================
        // LOGIC OPERATIONS (ALU_FUN[3:2] = 01)
        // Flags: Logic_Flag=1, others=0 -> Flags = 0010
        //============================================================
        $display("\n--- Logic Operations (ALU_FUN=01xx) ---");

        // 17. AND
        apply_inputs(16'hFF00, 16'h0F0F, 4'b0100);
        check_logic(16'h0F00, 4'b0010, "LOGIC: AND");

        // 18. OR
        apply_inputs(16'hFF00, 16'h0F0F, 4'b0101);
        check_logic(16'hFF0F, 4'b0010, "LOGIC: OR");

        // 19. NAND
        apply_inputs(16'hFF00, 16'h0F0F, 4'b0110);
        check_logic(16'hF0FF, 4'b0010, "LOGIC: NAND");

        // 20. NOR
        apply_inputs(16'hFF00, 16'h0F0F, 4'b0111);
        check_logic(16'h00F0, 4'b0010, "LOGIC: NOR");

        //============================================================
        // COMPARE OPERATIONS (ALU_FUN[3:2] = 10)
        // Flags: Cmp_Flag=1, others=0 -> Flags = 0100
        //============================================================
        $display("\n--- Compare Operations (ALU_FUN=10xx) ---");

        // 21. NOP (ALU_FUN=1000)
        apply_inputs(16'd100, 16'd200, 4'b1000);
        check_cmp(0, 4'b0100, "CMP: NOP");

        // 22. A == B - True (ALU_FUN=1001)
        apply_inputs(16'd50, 16'd50, 4'b1001);
        check_cmp(1, 4'b0100, "CMP: A == B (True)");

        // 23. A == B - False (ALU_FUN=1001)
        apply_inputs(16'd50, 16'd60, 4'b1001);
        check_cmp(0, 4'b0100, "CMP: A == B (False)");

        // 24. A > B - True (ALU_FUN=1010)
        apply_inputs(16'd100, 16'd50, 4'b1010);
        check_cmp(2, 4'b0100, "CMP: A > B (True)");

        // 25. A > B - False (ALU_FUN=1010)
        apply_inputs(16'd30, 16'd50, 4'b1010);
        check_cmp(0, 4'b0100, "CMP: A > B (False)");

        // 26. A < B - True (ALU_FUN=1011)
        apply_inputs(16'd20, 16'd80, 4'b1011);
        check_cmp(3, 4'b0100, "CMP: A < B (True)");

        // 27. A < B - False (ALU_FUN=1011)
        apply_inputs(16'd90, 16'd40, 4'b1011);
        check_cmp(0, 4'b0100, "CMP: A < B (False)");

        //============================================================
        // SHIFT OPERATIONS (ALU_FUN[3:2] = 11)
        // Flags: Shift_Flag=1, others=0 -> Flags = 1000
        //============================================================
        $display("\n--- Shift Operations (ALU_FUN=11xx) ---");

        // 28. A >> 1
        apply_inputs(16'hFF00, 16'h00FF, 4'b1100);
        check_shift(16'h7F80, 4'b1000, "SHIFT: A >> 1");

        // 29. A << 1
        apply_inputs(16'h00FF, 16'hFF00, 4'b1101);
        check_shift(16'h01FE, 4'b1000, "SHIFT: A << 1");

        // 30. B >> 1
        apply_inputs(16'hFF00, 16'h00FF, 4'b1110);
        check_shift(16'h007F, 4'b1000, "SHIFT: B >> 1");

        // 31. B << 1
        apply_inputs(16'h00FF, 16'hFF00, 4'b1111);
        check_shift(16'hFE00, 4'b1000, "SHIFT: B << 1");

        //============================================================
        // Summary
        //============================================================
        $display("\n========================================");
        $display("     Testbench Complete");
        $display("     Total Tests: %0d", test_num);
        $display("     Passed: %0d", passed);
        $display("     Failed: %0d", failed);
        $display("========================================");

        if (failed == 0)
            $display("ALL TESTS PASSED!");
        else
            $display("SOME TESTS FAILED!");

        $finish;
    end
    initial begin
        $dumpfile("ALU_TOP.vcd");
        $dumpvars(0, ALU_TOP_TB);
    end

endmodule
