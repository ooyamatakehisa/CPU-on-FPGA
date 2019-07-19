module flopr #(parameter WIDTH=8)
				(	input regp,
					input clk, reset,
					input [WIDTH-1:0] d,
					output reg [WIDTH-1:0] q );
					
always @ (posedge clk, posedge reset) begin
		if (reset) q <= 0;
		else	if (regp) begin
		 q <= d;
	end
	end
	endmodule