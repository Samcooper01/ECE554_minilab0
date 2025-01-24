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
output [DATA_WIDTH*3-1:0] Cout
);

//Internal Signals
logic [DATA_WIDTH * 2-1: 0] mult_AB;
logic [DATA_WIDTH * 3-1: 0] mult_AB_Zext;

//DATA_WIDTH bit multiplier
assign mult_AB = Ain * Bin;

//DATA_WIDTH * 2 to DATA_WIDTH * 3 zero extender
assign mult_AB_Zext = {1'b0{DATA_WIDTH}, mult_AB};

//Accumulator
always_ff @(posedge clk, negedge rst_n ) begin 
    if(!rst_n) begin
        Cout <= Clr;
    end
    else if (En) begin
        Cout <= Cout + mult_AB_Zext;
    end
end

endmodule