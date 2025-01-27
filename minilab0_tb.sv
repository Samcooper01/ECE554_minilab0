`timescale 1 ps / 1 ps
module minilab0_tb ();

	logic 		          		CLOCK_50;

	//////////// SEG7 //////////
	logic	     [6:0]		HEX0;
	logic	     [6:0]		HEX1;
	logic	     [6:0]		HEX2;
	logic	     [6:0]		HEX3;
	logic	     [6:0]		HEX4;
	logic	     [6:0]		HEX5;
	
	//////////// LED //////////
	logic		     [9:0]		LEDR;

	//////////// KEY //////////
	logic 		     [3:0]		KEY;

	//////////// SW //////////
	logic 		     [9:0]		SW;

Minilab0 iDUT(.CLOCK_50(CLOCK_50), .HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2), .HEX3(HEX3),
                .HEX4(HEX4), .HEX5(HEX5), .LEDR(LEDR), .KEY(KEY), .SW(SW));

initial begin
    CLOCK_50 = 0;
    #100
    $stop;
end

always 
    #5 CLOCK_50 = ~CLOCK_50;

endmodule