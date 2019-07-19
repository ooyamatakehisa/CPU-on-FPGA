module signext ( //sign extent
						input [7:0] a,
						input shiftD,
						output [15:0] y );
	function [15:0] signex;
		input	[7:0] eightbit;
		input shift;
		begin
		if(shift) signex ={ {12{eightbit[3]}}, eightbit[3:0]};
		else signex = { {8{eightbit[7]}}, eightbit} ;
		end
	endfunction
assign y = signex(a,shiftD) ;
endmodule