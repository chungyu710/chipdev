/*
  4. Gray Code Counter

  Prompt
  Build a circuit that generates a Gray code sequence starting from 0 on the output (dout).
  
  Gray code is an ordering of binary numbers such that two successive values only have one bit difference between them. For example, a Gray code sequence for a two bit value could be:
  
  b00
  b01
  b11
  b10
  
  The Gray code sequence should use the standard encoding. In the standard encoding the least significant bit follows a repetitive pattern of 2 on, 2 off ( ... 11001100 ... ); the next digit a pattern of 4 on, 4 off ( ... 1111000011110000 ... ); the nth least significant bit a pattern of 2n on 2n off.
  
  When the reset-low signal (resetn) goes to 0, the Gray code sequence should restart from 0.
  
  Input and output signals
  clk - Clock signal
  resetn - Synchronous reset-low signal
  out - Gray code counter value
  Output signals during reset
  out - 0 when resetn is active
  Example (Click to Expand)
  The first four expected outputs starting from and 0 are b0000, b0001, b0011, b0010, and b0110. Even though b0000, b0010, b0110, b0100, and b0101 is also a sequence that only changes a single bit each time, it is not the sequence that follows the standard encoding in the problem statement.
  
  When resetn goes active again, the Gray code restarts from 0. Note that when out is x it means out can be any value and will not be checked by the code judge. You should not explicitly drive out to x.
  
  The Gray code transition will be more clear if you change the waveform to display values in binary format.
*/

module model #(parameter
  DATA_WIDTH = 4
) (
  input clk,
  input resetn,
  output logic [DATA_WIDTH-1:0] out
);

reg [DATA_WIDTH-1:0] result;
reg [DATA_WIDTH:0] overall_counter = 0;
bit flag = 0;   // need flag because overall_counter cannot be read in the generate part

always @(posedge clk) begin
  if(overall_counter == 2**(DATA_WIDTH)-1) begin
    flag = 1;
  end

  overall_counter = overall_counter + 1;
end

generate
  genvar n;
  for(n = 0; n < DATA_WIDTH; n = n + 1) begin    
    reg val = 0;
    reg [(DATA_WIDTH+1):0] counter;
    always @(posedge clk) begin
      if(!resetn || flag == 1) begin
        val = 0;
        counter = 2**n;
        overall_counter = 0;
        flag = 0;
      end else if(counter == 0) begin
        counter = 2**(n+1);
        val = ~val;
      end
      counter = counter - 1;
    end

    always @(posedge clk, negedge clk) begin
      result[n] = val;
    end
  end
endgenerate

assign out = result;

endmodule
