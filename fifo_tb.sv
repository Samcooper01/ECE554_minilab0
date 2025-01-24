module fifo_tb ();

logic clk;
logic rst_n;
logic rden, wren;
logic [7:0] datain, dataout;
logic full, empty;

FIFO
#(
.DEPTH(8),
.DATA_WIDTH(8)
) input_fifo
(
.clk(clk),
.rst_n(rst_n),
.rden(rden),
.wren(wren),
.i_data(datain),
.o_data(dataout),
.full(full),
.empty(empty)
);

initial begin
    clk = 0;
    rst_n = 0;
    rden = 0;
    wren = 0;
    datain = '0;

    @(posedge clk);
    @(posedge clk);

    rst_n = 1;

    @(posedge clk);
    @(posedge clk);

    //Insert data 0x68 into FIFO
    wren = 1;
    datain = 8'h68;
    @(posedge clk);
    wren = 0;
    @(posedge clk);

    //Read data 0x68 from FIFO
    rden = 1;
    @(posedge clk);
    rden = 0;
    @(posedge clk);

    //Insert 3 data into FIFO
    wren = 1;
    datain = 8'h45;
    @(posedge clk);
    datain = 8'h35;
    @(posedge clk);
    datain = 8'h25;
    @(posedge clk);
    wren = 0;

    //Read data 0x45 from FIFO
    @(posedge clk);
    rden = 1;
    @(posedge clk);
    rden = 0;

    //Read data 0x35 from FIFO
    @(posedge clk);
    rden = 1;
    @(posedge clk);
    rden = 0;

    //Write data 0x65 to FIFO
    @(posedge clk);
    wren = 1;
    datain = 8'h65;
    @(posedge clk);
    wren = 0;
    @(posedge clk);

    //Read data 0x25 from FIFO
    rden = 0;
    @(posedge clk);
    rden = 1;
    @(posedge clk);
    rden = 0;

    //Make FIFO full
    wren = 1;
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    wren = 0;
    @(posedge clk);

    //Read until empty
    rden = 1;
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    rden = 0;
    @(posedge clk);
    
    #50
    $stop;
end

always
  #5 clk = ~clk;


endmodule