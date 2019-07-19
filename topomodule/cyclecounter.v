module cyclecounter(	input clock,reset,
							output reg [31:0] cycle);
				
	always @(posedge clock or posedge reset) begin
		if(reset == 1) begin
			cycle <= 0;
		end else begin 
			cycle <= cycle + 32'b0000_0000_0000_0000_0000_0000_0000_0001;
			end
	end
endmodule