/*
  2. Second Largest
  Prompt
  
  Given a clocked sequence of unsigned values, output the second-largest value seen so far in the sequence.
  If only one value is seen, then the output (dout) should equal 0. Note that repeated values are treated as separate
  candidates for being the second largest value.
  
  When the reset-low signal (resetn) goes low, all previous values seen in the input sequence should no longer be
  considered for the calculation of the second largest value, and the output dout should restart from 0 on the next cycle.
  
  Input and output signals
  - clk     - Clock signal
  - resetn  - Synchronous reset-low signal
  - din     - Input data sequence
  - dout    - Second-largest value seen so far
  
  Output signals during reset
  - dout - when resetn is active
*/

module model #(parameter
  DATA_WIDTH = 32
) (
  input  clk,
  input  resetn,
  input  [DATA_WIDTH-1:0] din,
  output logic [DATA_WIDTH-1:0] dout
);

reg [DATA_WIDTH-1:0] largest = 0;
reg [DATA_WIDTH-1:0] second_largest = 0;

assign dout = second_largest;

always @(posedge clk) begin
  if(~resetn) begin
    largest <= 0;
    second_largest <= 0;
  end else begin
    if(din > largest) begin
      second_largest <= largest;
      largest <= din;
    end else if(din > second_largest) begin
      second_largest <= din;
    end
  end

  // Having this statement here instead of the assign at the top doesn't work
  // because dout will get the value of second_largest before the active clk edge.
  // Thus, dout will be one clock cycle late from the expected dout value. 
  // dout <= second_largest;
end

endmodule
