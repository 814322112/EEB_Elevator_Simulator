module displayFloor(currentFl,HEX0,HEX1);
 input logic [2:0] currentFl;
 output logic [6:0] HEX0,HEX1;
 
 always_comb begin
  case(currentFl)
   3'b000: begin
	         HEX0 = 7'b1111001; //Floor 1.
	         HEX1 = 7'b1111111;
			  end
	3'b001: begin
	         HEX0 = 7'b0100100; //Floor 2.
	         HEX1 = 7'b1111111;
			  end
	3'b010: begin
	         HEX0 = 7'b0001000; //Floor 2M (denoted 2A on HEX)
	         HEX1 = 7'b0100100;
			  end
   3'b011: begin
			   HEX0 = 7'b0110000; //Floor 3
	         HEX1 = 7'b1111111;
			  end
	3'b100: begin
				HEX0 = 7'b0001000; //Floor 3M (denoted 3A)
	         HEX1 = 7'b0110000;
			  end
	3'b101: begin
				HEX0 = 7'b0011001; //Floor 4
	         HEX1 = 7'b1111111;
			  end
	3'b110: begin
				HEX0 = 7'b0001000; //Floor 4M (denoted 4A)
	         HEX1 = 7'b0011001;
			  end
	default: begin
				 HEX0 = 7'b1111111;
	          HEX1 = 7'b1111111;
				end
	endcase 
 end
endmodule 

module displayFloor_testbench();
 logic [2:0] currentFl;
 logic [6:0] HEX0,HEX1;
 
 displayFloor dut (.currentFl,.HEX0,.HEX1);
 
 integer i;
 initial begin
  for (i=0;i<8;i++) begin
   currentFl = i; #10;
  end
 end
endmodule 