module mux3 #(parameter  WIDTH= 8)
		(input [WIDTH-1:0]	a, b, c,
		 input [1:0] s,
		 output [WIDTH-1:0] out
		  );
		  
		 function [WIDTH-1:0] mux ;
		 input [1:0] s1;
			case(s1)
				2'b00: mux = a;
				2'b01: mux = b;
				2'b10: mux = c;
			endcase
			endfunction
			assign out = mux(s);
endmodule
				
				