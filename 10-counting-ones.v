/*
  10. Counting Ones
  Prompt
  Given an input binary value, output the number of bits that are equal to 1.

  Input and output signals
  din - Input value
  dout - Number of 1's in the input value

*/

module model #(parameter
  DATA_WIDTH = 16
) (
  input [DATA_WIDTH-1:0] din,
  output logic [$clog2(DATA_WIDTH):0] dout
);

logic [DATA_WIDTH-1:0] din_copy;
logic [$clog2(DATA_WIDTH):0] result;

always @(din) begin
  din_copy = din;
  result = 0;

  for(integer i = 0; i < DATA_WIDTH; i = i + 1) begin
    result = result + din_copy[0];
    din_copy = din_copy >> 1;
  end

  dout = result;
end

endmodule