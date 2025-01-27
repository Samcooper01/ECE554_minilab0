module FIFO
#(
  parameter DEPTH=8,
  parameter DATA_WIDTH=8
)
(
  input  clk,
  input  rst_n,
  input  rden,
  input  wren,
  input  [DATA_WIDTH-1:0] i_data,
  output [DATA_WIDTH-1:0] o_data,
  output full,
  output empty
);

//Internal wires
logic [DEPTH -1: 0] fifo_list [DATA_WIDTH-1: 0];
logic [DEPTH-1:0] read_ptr;

//FULL if read_ptr == DEPTH
assign full = (read_ptr == DEPTH) ? 1'b1 : 1'b0;

//EMPTY if read_ptr == 0
assign empty = (read_ptr == 0) ? 1'b1 : 1'b0;

//handle write shift
always_ff @(posedge clk, negedge rst_n) begin
  if(!rst_n) begin
    //clear FIFO
    for(integer i = 0; i < DEPTH; i++) begin
      fifo_list[i] <= '0;
    end
  end
  else if(wren & !full) begin
    //Perform the shift
    for(integer i = DEPTH - 1; i > 0; i--) begin
      fifo_list[i - 1] <= fifo_list[i];
    end
    fifo_list[DEPTH - 1] <= i_data;
  end
  else if(rden & !empty) begin
    fifo_list[DEPTH - read_ptr] = '0;
  end
end

always_ff @(posedge clk, negedge rst_n) begin
  if (!rst_n) begin
    read_ptr <= '0;
  end
  else if(wren & !full) begin
    //INC read_ptr
    read_ptr <= read_ptr + 1;
  end
  else if(rden & !empty) begin
    read_ptr <= read_ptr - 1;
  end
end

assign o_data = (rden & !empty) ? fifo_list[DEPTH - read_ptr] : '0;

endmodule