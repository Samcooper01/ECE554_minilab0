module MAC #
(
parameter DATA_WIDTH = 8
)
(
input clk,
input rst_n,
input En,
input Clr,
input [DATA_WIDTH-1:0] Ain,
input [DATA_WIDTH-1:0] Bin,
output logic [DATA_WIDTH*3-1:0] Cout
);

    // Dot product of two arrays
    // Result of the dot product is stored in the output register that is displayed in hex format on the 7-segment display
    // when SW0 is turned on(en)
    // LED1 should also turn on indicating that the logic is in the DONE state

    // Output of the multiplier unit is DATA_WIDTH*2
    logic [DATA_WIDTH*2-1:0] mult_AB;
    assign mult_AB = Ain * Bin;

    // Output of the accumulator is DATA_WIDTH*3, so pad with 0's 
    logic [DATA_WIDTH*3-1:0] mult_AB_zeroExt;
    assign mult_AB_zeroExt ={{{DATA_WIDTH-1}{1'b0}}, mult_AB};

    always_ff @(posedge clk, negedge rst_n)
    begin
        if (!rst_n)
            Cout <= Clr;
        else if (En)
            Cout <= Cout + mult_AB_zeroExt;
    end
endmodule