/*
  5. Reversing Bits
  Prompt
  Reverse the bits of an input value's binary representation.
  
  Input and output signals
  din - Input value
  dout - Bitwise reversed value
  Example (Click to Expand)
  In the first input value, the reversed binary representation of xd is xb because b1101 is reversed to b1011.
  
  In the second input value, if we assume DATA_WIDTH = 4 then the reversed binary representation of x4 is x2 because b0100 is reversed to b0010. Notice how DATA_WIDTH determines how many trailing and leading 0's there are in the reversed result.
  
  The binary reversal will be more clear if you change the waveform to display values in binary format.
*/

module model #(parameter
  DATA_WIDTH=32
) (
  input  [DATA_WIDTH-1:0] din,
  output logic [DATA_WIDTH-1:0] dout
);

always @(din) begin
  for(int i = 0; i < DATA_WIDTH; i++) begin
    dout[i] = din[DATA_WIDTH-1-i];
  end // for
end // always

endmodule