module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR,
SW);
 input logic CLOCK_50; // 50MHz clock.
 output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
 output logic [9:0] LEDR;
 input logic [3:0] KEY;
 input logic [9:0] SW;
 logic Reset, leftInput, rightInput;
 logic k3, dr, o; // k3 - user input, dr - direction, o -overload.
 logic [2:0] s,c;// s - selected floor, c - current floor.
 logic [31:0] clk;
 logic [9:0] SW1;
 assign Reset = SW[0]; // Reset when SW[0] is pressed.
 assign HEX5 = 7'b1111111;
 assign HEX4 = 7'b1111111;
 assign HEX3 = 7'b1111111;
 assign HEX2 = 7'b1111111;

 //2 DFFs in series used to eliminate metastability.
 doubleDFFs l (.clock(CLOCK_50), .userinput(~KEY[3]), .out(k3));
 
 doubleDFFs l9 (.clock(CLOCK_50), .userinput(SW[9]), .out(SW1[9]));
 doubleDFFs l8 (.clock(CLOCK_50), .userinput(SW[8]), .out(SW1[8])); 
 doubleDFFs l7 (.clock(CLOCK_50), .userinput(SW[7]), .out(SW1[7]));
 doubleDFFs l6 (.clock(CLOCK_50), .userinput(SW[6]), .out(SW1[6]));
 doubleDFFs l5 (.clock(CLOCK_50), .userinput(SW[5]), .out(SW1[5]));
 doubleDFFs l4 (.clock(CLOCK_50), .userinput(SW[4]), .out(SW1[4]));
 doubleDFFs l3 (.clock(CLOCK_50), .userinput(SW[3]), .out(SW1[3]));
 doubleDFFs l2 (.clock(CLOCK_50), .userinput(SW[2]), .out(SW1[2]));
 doubleDFFs l1 (.clock(CLOCK_50), .userinput(SW[1]), .out(SW1[1]));
 doubleDFFs l0 (.clock(CLOCK_50), .userinput(SW[0]), .out(SW1[0]));
 
 // Make sure longpressing the key will only output a true once.
 userInput in3 (.Clock(CLOCK_50), .Reset, .in(k3), .out(leftInput));  
 // Determine which floor to go according to current floor and direction of operation.
 destination d (.clk(CLOCK_50),.reset(Reset), .SW(SW1), .direction(dr), .current(c), .sel(s)); 
 // Move the elevator.
 move m (.CLOCK_50,.reset(Reset),.sel(s),.LEDR(LEDR[9:6]),.KEY(leftInput),.current(c),.direction(dr),.ovld(o));
 // Display on current floor on the HEX display.
 displayFloor df (.currentFl(c),.HEX0,.HEX1);
 // Determine if the elevator is overloaded.
 overload ov (.reset(Reset),.SW(SW1),.ovld(o),.LEDR(LEDR[0]));
endmodule

module DE1_SoC_testbench();
 logic Clock;
 logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
 logic [9:0] LEDR;
 logic [3:0] KEY;
 logic [9:0] SW;

 DE1_SoC dut (.CLOCK_50(Clock), .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR,
.SW);
 
 parameter CLOCK_PERIOD=100;
	initial begin
	   Clock<= 0;
		forever #(CLOCK_PERIOD/2) Clock <= ~Clock;
	end
 
 initial begin
  SW[0] <= 1;              @(posedge Clock);
  SW[9:0] <= 0;            @(posedge Clock);
				               @(posedge Clock);
  SW[3] <= 1; KEY[3] <= 1; @(posedge Clock);
                           @(posedge Clock);
				  KEY[3] <= 0; @(posedge Clock);
				               @(posedge Clock);
				               @(posedge Clock);
				               @(posedge Clock);
									@(posedge Clock);
				               @(posedge Clock);
				               @(posedge Clock);
				               @(posedge Clock);
  SW[3] <= 0; KEY[3] <= 1; @(posedge Clock);
				               @(posedge Clock);
				  KEY[3] <= 0; @(posedge Clock);
                           @(posedge Clock);
  SW[6] <= 1;              @(posedge Clock);
				               @(posedge Clock);
				               @(posedge Clock);
				               @(posedge Clock);
				               @(posedge Clock);	
  SW[6] <= 0;SW[7] <= 1; SW[5] <= 1;@(posedge Clock);
                           @(posedge Clock);
				 KEY[3] <= 1;  @(posedge Clock);
			                  @(posedge Clock);
				 KEY[3] <= 0;  @(posedge Clock);
			                  @(posedge Clock);
							      @(posedge Clock);		
	$stop; // End the simulation.
   end
endmodule