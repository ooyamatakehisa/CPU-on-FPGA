module ALU (input wire [15:0] a, b,
				input wire [3:0] control,
				output reg [15:0] result, 
				output reg S, Z, C, V);
			
	always@(*)	begin
		result <= 0;
		C <= 0;
		
		
			case (control)
				4'b0000:
					{ C, result } <= a + b;
				4'b0001, 4'b0101:
					{ C, result } <= a - b;
				4'b0010:
					result <= a & b;
				4'b0011:
					result <= a | b;
				4'b0100:
					result <= a ^ b;
				4'b0110:
					result <=  b;
				4'b1000:
					{ C, result } <= a << b;
				4'b1001:
					result <= { a, a } >> (16-b[3:0]);
				4'b1010:
					{ result, C } <= { a , 1'b0 } >> b;
				4'b1011:
					{ result, C } <= { a , 1'b0 } >>> b;
				4'b1100:
					result <= a + b;
				4'b1101:
					result <= b; //OUT result <= rs
				default:
					result <= a + b;
			endcase 
		end
		
	always@(*)	begin
		S <= result[15];
		Z = (result == 0);
		
		
			case (control)
				4'b0000:
					V <= (a[15] == b[15]) & (a[15] != result[15]);
				4'b0001, 4'b0101:
					V <= (a[15] != b[15]) & (a[15] != result[15]);
				default:
					V <= 0;
			endcase
		
	end
		
endmodule