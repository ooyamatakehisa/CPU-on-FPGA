module mux3 #(parameter  WIDTH= 8)
		(input [WIDTH-1:0] d0,d1,d2,
		 input [1:0] s,
		 output reg [WIDTH-1:0] y
		  );
		  
		  always @ (*)
		  case(s)
		  2'b00:y <= d0;
		  2'b01:y <= d1;
		  2'b10:y <= d2;
		  default: y <= 16'bxxxxxxxxxxxxxxxx;
		  endcase
		  
		  
		  
		  
//		 function [WIDTH-1:0] mux ;
//		 input [1:0] s1;
//			case(s1)
//				2'b00: mux = a;
//				2'b01: mux = b;
//				2'b10: mux = c;
//			endcase
//			endfunction
//			assign out = mux(s);
endmodule
				
				