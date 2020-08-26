module overload (reset,SW,ovld,LEDR);
 input logic reset;
 input logic [9:0] SW;
 output logic ovld;
 output logic LEDR;
 integer i,sum;
 
 always_comb begin
  sum = 0; // the sum of the number of switches turned on.
  for(i=3; i<10;i++)begin
   sum = sum + SW[i];
  end
  if (reset)
   ovld = 1'b0;
  else if(sum >= 4) // If there are at least four floors selected, consider this as overload.
   ovld = 1'b1;
  else ovld = 1'b0;
 end
 
 assign LEDR = (ovld);
endmodule

module overload_testbench();
 logic reset;
 logic [9:0] SW;
 logic ovld;
 logic LEDR;
 integer j;
 
 overload dut (.reset,.SW,.ovld,.LEDR);
 
 initial begin
  reset = 1;#10;
  reset = 0;#10;
  for(j=0;j<2**9;j++) begin
	SW = j;#10;
  end
 end
endmodule