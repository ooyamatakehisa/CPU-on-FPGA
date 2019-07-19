module chat(
	input clock,reset,in,
	output reg out
	);
	reg buffer;
	reg [4:0] counter;
	always @(posedge clock or negedge reset) begin
		if(reset == 0) begin
			counter <= 0;
			end else begin
				counter <= counter + 1;
		end
	end
	
//		function button;
//		input touch;
//		input [26:0] count;
//			begin		
//			if(count==0) button = touch;
//			end
//			endfunction
//		assign out = button(in,counter);
	
	always @(posedge clock) begin
		if(counter==0) begin
			out <= in ;
		end
	end
	
	endmodule