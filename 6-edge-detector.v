/*
  6. Edge Detector
  Prompt
  Build a circuit that pulses the output (dout) on every rising edge of the input (din). A pulse on the output is defined as making the output a 1 for a single clock cycle, and resetting it back to 0 after that single clock cycle.
  
  Input and output signals
  clk - Clock signal
  resetn - Synchronous reset-low signal
  din - Input signal
  dout - Output signal
  Output signals during reset
  dout - 0 when resetn is active
*/

module model (
  input clk,
  input resetn,
  input din,
  output dout
);

logic q1, q2, result;

always @(negedge clk) begin
  q2 = q1;
end

always @(posedge clk) begin
  q1 = din;

  if(!resetn) begin
    result = 0;
    
    // a bug in the code (mentioned on the discord) mentions that the
    // expected model treats Din as 0 when resetn is asserted which
    // conflicts with the question description.
    q1 = 0;
  end else begin
    result = !q2 & din;
  end
end

assign dout = result;

endmodule