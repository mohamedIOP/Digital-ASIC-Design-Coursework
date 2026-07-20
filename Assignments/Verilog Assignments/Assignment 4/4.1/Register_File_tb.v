`timescale 1ns/1ps

module Register_File_tb;

    // Testbench signals
    reg [15:0] WrData;
    reg [2:0] Address;
    reg WrEn, RdEn;
    reg CLK, RST;
    wire [15:0] RdData;

    // Instantiate the Unit Under Test (UUT)
    Register_File uut (
        .WrData(WrData),
        .Address(Address),
        .WrEn(WrEn),
        .RdEn(RdEn),
        .CLK(CLK),
        .RST(RST),
        .RdData(RdData)
    );

    // Clock generation: 10ns period (100MHz)
    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK;
    end

    // Test scenarios
    initial begin
        $display("========================================");
        $display("     Register File Testbench Started");
        $display("========================================");

        // Initialize inputs
        WrData = 16'h0000;
        Address = 3'b000;
        WrEn = 0;
        RdEn = 0;

        //--------------------------------------------------
        // Scenario 1: Reset Test
        //--------------------------------------------------
        $display("\n--- Scenario 1: Asynchronous Reset ---");
        RST = 0;  // Assert reset (active low)
        #20;
        RST = 1;  // Deassert reset
        #10;
        $display("Reset completed. All registers cleared.");

        //--------------------------------------------------
        // Scenario 2: Write to Register 0
        //--------------------------------------------------
        $display("\n--- Scenario 2: Write to Register 0 ---");
        @(posedge CLK);
        Address = 3'b000;      // Register 0
        WrData = 16'hABCD;     // Data to write
        WrEn = 1;              // Enable write
        RdEn = 0;
        
        @(posedge CLK);
        WrEn = 0;              // Disable write
        #10;
        $display("Wrote 0x%h to Register 0", 16'hABCD);

        //--------------------------------------------------
        // Scenario 3: Write to Register 3
        //--------------------------------------------------
        $display("\n--- Scenario 3: Write to Register 3 ---");
        @(posedge CLK);
        Address = 3'b011;      // Register 3
        WrData = 16'h1234;     // Data to write
        WrEn = 1;
        RdEn = 0;
        
        @(posedge CLK);
        WrEn = 0;
        #10;
        $display("Wrote 0x%h to Register 3", 16'h1234);

        //--------------------------------------------------
        // Scenario 4: Read from Register 0
        //--------------------------------------------------
        $display("\n--- Scenario 4: Read from Register 0 ---");
        @(posedge CLK);
        Address = 3'b000;      // Register 0
        WrEn = 0;
        RdEn = 1;              // Enable read
        
        @(posedge CLK);
        #1;  // Small delay to see output
        $display("Read from Register 0: 0x%h (Expected: 0xABCD)", RdData);
        RdEn = 0;

        //--------------------------------------------------
        // Scenario 5: Read from Register 3
        //--------------------------------------------------
        $display("\n--- Scenario 5: Read from Register 3 ---");
        @(posedge CLK);
        Address = 3'b011;      // Register 3
        WrEn = 0;
        RdEn = 1;              // Enable read
        
        @(posedge CLK);
        #1;
        $display("Read from Register 3: 0x%h (Expected: 0x1234)", RdData);
        RdEn = 0;

        //--------------------------------------------------
        // Scenario 6: Verify Reset clears registers
        //--------------------------------------------------
        $display("\n--- Scenario 6: Verify Reset Clears All ---");
        RST = 0;  // Assert reset
        #15;
        RST = 1;  // Deassert
        
        // Try to read register 0 after reset
        @(posedge CLK);
        Address = 3'b000;
        RdEn = 1;
        
        @(posedge CLK);
        #1;
        $display("Read Register 0 after reset: 0x%h (Expected: 0x0000)", RdData);
        RdEn = 0;

        //--------------------------------------------------
        // End Simulation
        //--------------------------------------------------
        #20;
        $display("\n========================================");
        $display("     Register File Testbench Finished");
        $display("========================================");
        $finish;
    end

    // Monitor changes
    initial begin
        $monitor("Time=%0t | RST=%b | WrEn=%b | RdEn=%b | Addr=%d | WrData=0x%h | RdData=0x%h",
                 $time, RST, WrEn, RdEn, Address, WrData, RdData);
    end

    // Generate VCD file for waveform viewing
    initial begin
        $dumpfile("register_file.vcd");
        $dumpvars(0, Register_File_tb);
    end

endmodule