// This module prevents the player to win by longpressing the key.
module userInput(Clock, Reset, in, out);
 input logic Clock, Reset, in;
 output logic out;
 enum {A, B} ps, ns; // When key is pressed, state change from A to B and will stay in B unless
                     // the key is released.
 
 always_comb begin
  case(ps)
   A: if (in) ns = B;
	   else    ns = A;
	B: if (in) ns = B;
	   else    ns = A;
  endcase
 end
 
 assign out = (ps == A & in); // Change the LEDR pattern each time the key the pressed.
                              // Holding the key won't change the pattern.
 
 always_ff @(posedge Clock) begin
  if (Reset)
   ps <= A;
  else
   ps <= ns;
 end
endmodule

module userInput_testbench();
 logic Clock, reset, in, out;
 
 userInput dut (Clock, reset, in, out);
 
 parameter CLOCK_PERIOD=100;
	initial begin
	   Clock<= 0;
		forever #(CLOCK_PERIOD/2) Clock <= ~Clock;
	end
 initial begin
 reset <= 1; in <= 0; @(posedge Clock);
                      @(posedge Clock);
							 @(posedge Clock);
 reset <= 0;          @(posedge Clock);
                      @(posedge Clock);
							 @(posedge Clock);
				 in <= 1; @(posedge Clock);
				          @(posedge Clock);
							 @(posedge Clock);
				 in <= 0; @(posedge Clock);
				 in <= 1; @(posedge Clock);
				 in <= 0; @(posedge Clock);
 $stop;
 end
endmodule 