module model #(parameter
  DIV_LOG2=3,
  OUT_WIDTH=32,
  IN_WIDTH=OUT_WIDTH+DIV_LOG2
) (
  input [IN_WIDTH-1:0] din,
  output logic [OUT_WIDTH-1:0] dout
);

// right shift din DIV_LOG2 number of times. This is the 
// keep track of the bits shifted out off the right side
//    use this to figure out whether to round up or down ie. whether to add 1 or not

logic [IN_WIDTH] quotient;
logic [DIV_LOG2] remainder;
logic [IN_WIDTH+DIV_LOG2-1:0] temp  = '0;

always @(DIV_LOG2, OUT_WIDTH, IN_WIDTH, din) begin
  temp [IN_WIDTH+DIV_LOG2-1:DIV_LOG2] = din;
  temp = temp >> DIV_LOG2;
  
  quotient = temp [IN_WIDTH+DIV_LOG2-1:DIV_LOG2];
  remainder = temp [DIV_LOG2-1:0];
  // remainder = remainder >> DIV_LOG2;
  if(remainder >= 2**(DIV_LOG2-1))
    remainder = 1;
  else
    remainder = 0;

  // I think Verilog handles mismatched width arithmetic in this case by zero padding the left side of remainder and then adding
  if(quotient + remainder > (2**DIV_LOG2)-1)
    dout <= (2**DIV_LOG2)-1;  // output is saturated
  else
    dout <= quotient + remainder;
end

endmodule