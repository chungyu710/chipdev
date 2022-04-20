/*
  8. Serial-in, Parallel-out Shift Register
  Prompt
  Build a circuit that reads a sequence of bits (one bit per clock cycle) from the input (din), and shifts the bits into the least significant bit of the output (dout). Assume all bits of the output are 0 to begin with.

  Once the number of input bits received is larger than DATA_WIDTH, only the DATA_WIDTH most recent bits are kept in the output.

  Input and output signals
  clk - Clock signal
  resetn - Synchronous reset-low signal
  din - Input signal
  dout - Output signal
  Output signals during reset
  dout - 0 when resetn is active

*/

module model #(parameter
  DATA_WIDTH = 16
) (
  input clk,
  input resetn,
  input din,
  output logic [DATA_WIDTH-1:0] dout
);

reg [DATA_WIDTH-1:0] result;

always @(posedge clk) begin
  if(!resetn) begin
    result = 0;
  end else begin
    result = result << 1;
    result[0] = din;
  end
end

assign dout = result;

endmodule