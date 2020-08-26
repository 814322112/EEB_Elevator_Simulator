module doors(currentFl,LEDR);
 input logic [2:0] currentFl;
 output logic [1:0] LEDR;
 
 always_comb begin
  case(currentFl)
   3'b000: LEDR = 2'b11;
	3'b001: LEDR = 2'b11;
	3'b010: LEDR = 2'b01;
	3'b011: LEDR = 2'b11;
	3'b100: LEDR = 2'b01;
	3'b101: LEDR = 2'b11;
	3'b110: LEDR = 2'b01;
	default: LEDR = 2'b00;
  endcase
 end
endmodule 

module doors_testbench();

 logic [2:0] currentFl;
 logic [1:0] LEDR;
 
 doors dut (.currentFl,.LEDR);
 
 integer i;
 initial begin
  for (i=0;i<8;i++) begin
   currentFl = i; #10;
  end
 end
endmodule 