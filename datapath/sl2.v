module sl2(//shift left 2bit
				input [15:0] a,
				output [15:0] y) ;
				
assign y = {a[13:0]+2'b00};
endmodule