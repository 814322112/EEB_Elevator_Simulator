module destination(clk, reset, SW, direction, current, sel);
 input logic [9:0] SW;
 input logic reset;
 input logic [2:0] current;
 input logic clk;
 output logic direction;
 output logic [2:0] sel;
 
 always_ff @(posedge clk)begin
  if(reset) begin
	direction <= 1'b0; // if reset the elevator starts at rest on the first floor, 
   sel <= 3'b000;     // and its default direction is going up.
  end
 else if(direction == 1'b0) //when the elevator is going up.
 begin
	if (SW[9:0] == 10'b0000000000) sel <= 3'b111; //3'b111 corresponds to the case when no floor selected.
	else if (current == 3'b000) begin // when the elevator is on first floor
	if(SW[9]) sel <= 3'b000;
	else if (SW[8]) sel <= 3'b001;
	else if (SW[7]) sel <= 3'b010;
	else if (SW[6]) sel <= 3'b011;
	else if (SW[5]) sel <= 3'b100;
	else if (SW[4]) sel <= 3'b101;
	else if (SW[3]) sel <= 3'b110;
	else sel <= 3'b111;
	end 
 else if (current == 3'b001) begin //when the elevator is on second floor
   if (SW[8]) sel <= 3'b001;
   else if (SW[7]) sel <= 3'b010;
   else if (SW[6]) sel <= 3'b011;
   else if (SW[5]) sel <= 3'b100;
   else if (SW[4]) sel <= 3'b101;
   else if (SW[3]) sel <= 3'b110;
   else direction <= 1'b1;  //reverse the direction when lower floors selected.
 end 
 else if  (current == 3'b010) begin //when the elevator is on 2M.
    if (SW[7]) sel <= 3'b010;
   else if (SW[6]) sel <= 3'b011;
   else if (SW[5]) sel <= 3'b100;
   else if (SW[4]) sel <= 3'b101;
   else if (SW[3]) sel <= 3'b110;
   else direction <= 1'b1;  //reverse the direction when lower floors selected.   
  end
  else if (current == 3'b011) begin //when the elevator is on third floor.
   if (SW[6]) sel <= 3'b011;
   else if (SW[5]) sel <= 3'b100;
   else if (SW[4]) sel <= 3'b101;
   else if (SW[3]) sel <= 3'b110;
   else if (SW != 0)
    direction <= 1'b1; //reverse the direction when lower floors selected.
  end
  else if (current == 3'b100) begin //when the elevator is on 3M.
   if (SW[5]) sel <= 3'b100;
   else if (SW[4]) sel <= 3'b101;
   else if (SW[3]) sel <= 3'b110;
   else
    direction <= 1'b1; //reverse the direction when lower floors selected.
  end
  else if (current == 3'b101) begin //when the elevator is on fourth floor
   if (SW[4]) sel <= 3'b101;
   else if (SW[3]) sel <= 3'b110;
   else 
    direction <= 1'b1; //reverse the direction when lower floors selected.
  end
  else if (current == 3'b110) // when the elevator is on the top.
   direction <= 1'b1; //reverse the direction when lower floors selected.
end

else if (direction == 1'b1) begin // same pattern as the code as above, only difference is the direction.
 if (SW[9:0] == 10'b0000000000) sel <= 3'b111;
 else if (current == 3'b000)
  direction <= 1'b0;
 else if (current == 3'b001) begin
   if(SW[8]) sel <= 3'b001; 
   else if(SW[9]) sel <= 3'b000;
   else
	 direction <= 1'b0;
 end
 else if (current == 3'b010) begin
  if(SW[7]) sel <= 3'b010;
  else if(SW[8]) sel <= 3'b001; 
  else if(SW[9]) sel <= 3'b000;
  else
   direction <= 1'b0;
 end
 else if (current == 3'b011) begin
  if(SW[6]) sel <= 3'b011;
  else if(SW[7]) sel <= 3'b010;
  else if(SW[8]) sel <= 3'b001; 
  else if(SW[9]) sel <= 3'b000;
  else
   direction <= 1'b0;
 end
 else if (current == 3'b100) begin
  if(SW[5]) sel <= 3'b100;
  else if(SW[6]) sel <= 3'b011;
  else if(SW[7]) sel <= 3'b010;
  else if(SW[8]) sel <= 3'b001; 
  else if(SW[9]) sel <= 3'b000;
  else
   direction <= 1'b0;
 end
 else if (current == 3'b101) begin
  if(SW[4]) sel <= 3'b101;
  else if(SW[5]) sel <= 3'b100;
  else if(SW[6]) sel <= 3'b011;
  else if(SW[7]) sel <= 3'b010;
  else if(SW[8]) sel <= 3'b001; 
  else if(SW[9]) sel <= 3'b000;
  else
   direction <= 1'b0;
 end
 else if(current == 3'b110) begin
  if(SW[3]) sel <= 3'b110;
  else  if(SW[4]) sel <= 3'b101;
  else if(SW[5]) sel <= 3'b100;
  else if(SW[6]) sel <= 3'b011;
  else if(SW[7]) sel <= 3'b010;
  else if(SW[8]) sel <= 3'b001; 
  else if(SW[9]) sel <= 3'b000;
  else sel <= 3'b111;
 end
end
end
endmodule

module destination_testbench();
 logic [9:0] SW;
 logic clk;
 logic reset;
 logic [2:0] current;
 logic direction;
 logic [2:0]sel;
 
 destination dut (.clk,.reset, .SW, .direction, .current, .sel);
 
 parameter CLOCK_PERIOD=100;
	initial begin
	   clk<= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
		
 initial begin
  reset <= 1;                                           @(posedge clk);
  reset <= 0;                                           @(posedge clk);
                    SW[9:0] <= 0;                       @(posedge clk);
  current <= 3'b000;                                    @(posedge clk);//Start at floor one.
	                 SW[9] <= 1; SW[8:0] <= 0;           @(posedge clk);//Go to first floor.
						                                      @(posedge clk);
	                 SW[8] <= 1; SW[9] <= 0;             @(posedge clk);//Go to floor 2.
						                                      @(posedge clk);
  current <= 3'b100;SW[7] <= 1; SW[8] <= 0;             @(posedge clk);//Go to floor 2M.
						                                      @(posedge clk);
						  SW[8] <= 1; SW[7] <= 0;             @(posedge clk);//Back to floor 2.
						                                      @(posedge clk);
  current <= 3'b001;SW[9] <= 1; SW[7] <= 1; SW[8] <= 0; @(posedge clk);//Select conflicting floors simultaneously.
						                                      @(posedge clk);
																		  @(posedge clk);
  current <= 3'b100;SW[9] <= 0; SW[6] <= 1; SW[4] <= 1;SW[7] <=0; @(posedge clk);
                                                        @(posedge clk); 
																		  @(posedge clk);
																		  @(posedge clk);
						  SW[6] <= 0; SW[4] <= 0;SW[5] <= 1;  @(posedge clk);//Select 3M.
						                                      @(posedge clk);
						  SW[5] <= 0;                         @(posedge clk);
																		  @(posedge clk);
						  SW[5] <= 1;                         @(posedge clk);//When arrived, select the current
						                                                     //floor multiple times to find out bugs.
						                                      @(posedge clk);
						  SW[5] <= 0;                         @(posedge clk);
						                                      @(posedge clk);
																		  @(posedge clk);
	$stop;
  end
endmodule 