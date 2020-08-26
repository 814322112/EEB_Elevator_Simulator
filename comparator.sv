module comparator(in1, in2, out);
 input logic [9:0] in1, in2;
 output logic out;
 logic [10:0] in1_10, in2_10, result;
 
 always_comb begin
  in1_10[10] = 0; // Make both of the input 11 bits and subtract the two inputs.
  in1_10[9:0] = in1[9:0];
  in2_10[10] = 0;
  in2_10[9:0] = in2[9:0];
  result = in1_10 - in2_10;
  if (result[10] == 0 & result != 11'b00000000000) // If the first digit of the result is one, the result 
   out = 1;            // is then a negative number, which indicates in1 is smaller than in2. If in1 > in2,
  else                 // outputs a one, otherwise outputs a zero. To make sure the the out the zero when  
   out = 0;            // in1 == in2 additional logic is used.
 end
endmodule 

module comparator_testbench();
 logic [9:0] in1, in2;
 logic out;
 
 comparator dut (.in1, .in2, .out);
 
 integer i;
 initial begin
	for (i = 0; i < 2**10; i++) begin
	in1 = i; in2 = 2**10 - in1; #10;
	end
  end
 endmodule 