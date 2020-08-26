// This module eliminates metastability by putting 2 DFFs in series.
module doubleDFFs(clock, userinput, out);
 input logic clock, userinput;
 output logic out;
 logic firstDFFout;
 
 always_ff @(posedge clock) begin
  firstDFFout <= userinput; // First DFF
  out <= firstDFFout; // Second DFF
 end
endmodule 

module doubleDFFs_testbench();
   logic clk, in;
	logic out;
	
	doubleDFFs dut (clk, in, out);
	
	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
	   clk<= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	// Set up the inputs to the design.  Each line is a clock cycle.
	initial begin
	                       @(posedge clk);
                          @(posedge clk);
		            in <= 0;@(posedge clk);
		                    @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
					   in <= 1;@(posedge clk);
						        @(posedge clk);
						in <= 0;@(posedge clk);
						        @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
					   in <= 1;@(posedge clk);
						        @(posedge clk);
      $stop; // End the simulation.
   end
endmodule 