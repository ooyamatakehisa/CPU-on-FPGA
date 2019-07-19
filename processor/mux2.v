module mux2 # (parameter WIDTH= 8)

					(//2 in multiplex
					input	[WIDTH-1:0] d0,d1,
					input s,
					output [WIDTH-1:0] y);
					
assign y =s ? d1 : d0 ; // s==1 -> d1 s==0 -> d0
endmodule