module move(CLOCK_50,reset,sel,LEDR,KEY,current,direction,ovld);
 input logic CLOCK_50;
 input logic [2:0] sel;
 input logic reset;
 input logic KEY;
 input logic direction;
 input logic ovld;
 output logic [2:0] current;
 output logic [3:0] LEDR;
 logic [1:0] LED;
 logic [31:0] clk;
 enum {on,off} ps,ns;
 parameter whichClock = 25;
 
 clock_divider cdiv (CLOCK_50, clk);
 
 always_ff @(posedge clk[whichClock]) begin //Move the elevator and the velocity of approximately 1 floor/sec.
  if(reset)
   current <= 3'b000;
  else if ((sel != 3'b111) & (ovld == 1'b0)) begin // when there is at least one floor selected,
                                                   // the elevator is not overloaded,     
   if((current != sel) & (LEDR[3:2] == 2'b00)) begin // and when the current floor
                                                     // is not the destination and the doors are closed.	
	 if(direction == 1'b0) // Then the elevator is safe to go.
	  current <= current + 3'b001; // Move the elevator up by one floor.
    else
	  current <= current - 3'b001; // Move the elevator down by one floor.
   end
  end
 end
 
 always_comb begin
  case(ps)
   on: if(~KEY)           ns = on; // ON: door open, the corresponding LEDR lit.
	    else               ns = off; //OFF: door closed, corresponding LEDR off.
   off:if(current == sel & ~KEY) ns = on;
	    else               ns = off;
   endcase
  end
 assign LEDR[1] = (direction == 1'b0); // Going up.
 assign LEDR[0] = (direction == 1'b1); // Going down.
 
 always_comb begin
  case(current)
   3'b000: LED = 2'b11; // First digit implies the west door, second implies the east.
	3'b001: LED = 2'b11;
	3'b010: LED = 2'b01;
	3'b011: LED = 2'b10;
	3'b100: LED = 2'b01;
	3'b101: LED = 2'b11;
	3'b110: LED = 2'b01;
	default: LED = 2'b00;
  endcase
  if (ps == on)
   LEDR[3:2] = LED;
  else 
   LEDR[3:2] = 2'b00;
 end
 
 always_ff @(posedge CLOCK_50) begin
  if (reset)
   ps <= on;
  else
   ps <= ns;
 end 
endmodule

module move_testbench();
 logic clk;
 logic [2:0] sel;
 logic reset;
 logic KEY;
 logic direction;
 logic [2:0] current;
 logic LEDR;
 
 move dut (.CLOCK_50(clk),.reset,.sel,.LEDR,.KEY,.current,.direction);
 
 parameter CLOCK_PERIOD=100;
	initial begin
	   clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
 
 initial begin
 reset <= 1;                                      @(posedge clk);//Start at first floor, going up.
 reset <= 0;                                      @(posedge clk);
            direction <= 0;sel <= 3'b000;KEY <= 0;@(posedge clk);//Select the first floor.
				                                      @(posedge clk);
				                             KEY <= 1;@(posedge clk);//Close the door.
								                          @(posedge clk);
								                 KEY <= 0;@(posedge clk);
				              sel <= 3'b110;          @(posedge clk);//Select 4M.
				                                      @(posedge clk);
											                 @(posedge clk);
											                 @(posedge clk);
											                 @(posedge clk);
											                 @(posedge clk);
											                 @(posedge clk);
								                 KEY <= 1;@(posedge clk);//Close the door.
																  @(posedge clk);
													  KEY <= 0;@(posedge clk);
			   direction <= 1;sel <= 3'b100;         @(posedge clk);//Select 3M.
																  @(posedge clk);
																  @(posedge clk);
																  @(posedge clk);
				direction <= 1;sel <= 3'b001;         @(posedge clk);//Select second floor.
													           @(posedge clk);
																  @(posedge clk);
													           @(posedge clk);
																  @(posedge clk);
                                         KEY <= 1;@(posedge clk);//Close the door.
																  @(posedge clk);
													  KEY <= 0;@(posedge clk);
													           @(posedge clk); 
																  @(posedge clk); 
																  @(posedge clk);
																  @(posedge clk); 
																  @(posedge clk); 
																  @(posedge clk); 
																  @(posedge clk); 
 $stop;
 end							  
endmodule

module clock_divider (clock, divided_clocks);
 input logic clock;
 output logic [31:0] divided_clocks = 0;

 always_ff @(posedge clock) begin
 divided_clocks <= divided_clocks + 1;
 end

endmodule
