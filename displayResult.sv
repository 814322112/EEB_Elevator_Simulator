// Display the ID of the winning player on the HEX display.
module displayResult(Clock, reset, light, KEY, HEX);
 input logic Clock, reset, light, KEY;
 output logic [6:0] HEX;
 logic [2:0] point;
 
 always_ff @(posedge Clock) begin
   if(reset)
	 point <= 0;
	else if (point == 3'b111) // If the score reaches 7 pts, remain at 7 pts.
	 point <= 3'b111;
	else if (light & KEY) // Otherwise when one of the players wins, update the score.
	 point <= point + 3'b001;
 end

 always_comb begin
  case(point)
   3'b000: HEX = 7'b1000000; //0
   3'b001: HEX = 7'b1111001; //1
   3'b010: HEX = 7'b0100100; //2
   3'b011: HEX = 7'b0110000; //3
   3'b100: HEX = 7'b0011001; //4
   3'b101: HEX = 7'b0010010; //5
   3'b110: HEX = 7'b0000010; //6
   3'b111: HEX = 7'b1111000; //7
	default: HEX = 7'b1111111;
  endcase
 end
endmodule

module displayResult_testbench();
 logic Clock, reset, light, KEY;
 logic [6:0] HEX;
 
 displayResult dut(.Clock, .reset, .light, .KEY, .HEX);
 
 parameter CLOCK_PERIOD=100;
	initial begin
	   Clock<= 0;
		forever #(CLOCK_PERIOD/2) Clock <= ~Clock;
	end
	initial begin
   reset <= 1; light <= 0; KEY <= 0; repeat(2)@(posedge Clock);
												 repeat(2)@(posedge Clock);
	reset <= 0;                       repeat(2)@(posedge Clock);
											    repeat(2)@(posedge Clock);
			      light <= 1; KEY <= 0; repeat(2)@(posedge Clock);
												 repeat(2)@(posedge Clock);
			      light <= 0; KEY <= 1; repeat(2)@(posedge Clock);
				  								 repeat(2)@(posedge Clock);
				   light <= 1; KEY <= 1; repeat(2)@(posedge Clock);
												 repeat(2)@(posedge Clock);
												 repeat(2)@(posedge Clock);
												 repeat(2)@(posedge Clock);
												 repeat(2)@(posedge Clock);
												 repeat(2)@(posedge Clock);
												 repeat(2)@(posedge Clock);
												 repeat(2)@(posedge Clock);
												 repeat(2)@(posedge Clock);
												 repeat(2)@(posedge Clock);
												 repeat(2)@(posedge Clock);
												 repeat(2)@(posedge Clock);
												 repeat(2)@(posedge Clock);
												 repeat(2)@(posedge Clock);
$stop; // End the simulation.
   end
endmodule 