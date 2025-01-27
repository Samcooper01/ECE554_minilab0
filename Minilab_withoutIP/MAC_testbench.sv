module MAC_testbench();
    // TESTBENCH SIGNALS
    logic clk;
    logic rst_n;
    parameter DATA_WIDTH = 8;
    logic [DATA_WIDTH*3-1:0] sum;


    // DUT SIGNALS
    logic En;
    logic Clr;
    logic [DATA_WIDTH-1:0] Ain;
    logic [DATA_WIDTH-1:0] Bin;
    logic [DATA_WIDTH*3-1:0] Cout;

    // Instantiate DUT
    MAC MAC_DUT(.clk(clk), .rst_n(rst_n), .En(En), .Clr(Clr), .Ain(Ain), .Bin(Bin), .Cout(Cout));

    initial 
    begin
        // Reset the DUT
        clk = 0;
        rst_n = 0;
        En = 0;
        Clr = 0;
        Ain = 8'b0;
        Bin = 8'b0;

        @(negedge clk)
        begin
            Ain = 8'b00001000;  // 8
            Bin = 8'b00001000;  // 8
            rst_n = 1;
            En = 1;
        end

        // Check that 8 * 8 = 64
        @(negedge clk)
        begin
            En = 0;
            if (Cout !== 64)
            begin
                $display("FAIL! Ain(%d) * Bin(%d) = Expected: 64; Actual: %d", Ain, Bin, Cout);
                $stop;
            end
        end

        @(negedge clk)
        begin
            Ain = 8'b00000010;
            Bin = 8'b00000010;
            En = 1;
        end

        // Check that upon multiplying 2 * 2, that's added to 64
        @(negedge clk)
        begin 
            En = 0;
            if (Cout !== (64 + 4))
            begin
                $display("FAIL! Ain(%d) * Bin(%d) = Expected: 68; Actual: %d", Ain, Bin, Cout);
                $stop;
            end
        end

        @(negedge clk)
            rst_n = 0;
        
        @(negedge clk)
        begin
            rst_n = 1;
            En = 1;
        end

        // After clearing accumulator, 2 * 2 + 0 = 4
        @(negedge clk)
        begin
            En = 0;
            if (Cout !== 4)
            begin
                $display("FAIL! Ain(%d) * Bin(%d) = Expected: 4; Actual: %d", Ain, Bin, Cout);
                $stop;
            end
        end

        // Accumulate the max multiplied value
        @(negedge clk)
        begin
            Ain = 8'b11111111;
            Bin = 8'b11111111;
            En = 1;
        end

        // Expected accumulation is 4 + 255*255 = 65029
        @(negedge clk)
        begin
            En = 0;
            if (Cout !== (65029))
            begin
                $display("FAIL! Ain(%d) * Bin(%d) = Expected: 65029; Actual: %d", Ain, Bin, Cout);
                $stop;
            end 
        end


        // Begin self checking test_bench
        $display("Beginning self-checking portion...");
        @(negedge clk)
            rst_n = 0;
        @(negedge clk)
            rst_n = 1;

        sum = 0;
        for (int i = 0; i < 256; i++)
        begin
            for (int j = 0; j < 256; j++)
            begin
                @(negedge clk)
                begin
                    Ain = i;
                    Bin = i;
                    En = 1;
                end
                @(negedge clk)
                begin
                    En = 0;
                    sum = sum + i * i;
                    if (Cout !== (sum))
                    begin
                        $display("FAIL! Ain(%d) * Bin(%d) = Expected: %d; Actual: %d", Ain, Bin, sum, Cout);
                        $stop;
                    end                   
                end
            end
        end

        $display("Yahoo!!! All tests passed.");
        $stop;
    end

    always
        #1 clk = ~clk;
endmodule