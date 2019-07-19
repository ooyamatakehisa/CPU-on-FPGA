module flopenable #(parameter WIDTH=8)
				(	
					input enable,clk, reset,pcsrcD,
					input [WIDTH-1:0] d,
					output reg [WIDTH-1:0] q );
					
	always @ (posedge clk, posedge reset) begin
		if (reset) q <= 32'b10111100000000000000000000000000;
		else if(pcsrcD) q <= 32'b10111100000000000000000000000000;
		else if (enable) begin
			q <= d;
		
		end
	end
endmodule