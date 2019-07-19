module aludec( input [3:0] op3,
					input [1:0] aluop,
					output [3:0] alucontrol,
					output  halt);
				
//	always @ (*) begin
//		halt <= 0;
//		
//		case(aluop)
//			2'b00: alucontrol <= 4'b0000; //lw add
//			2'b01: alucontrol <= 4'b0001; //branch sub
//			default: 
//				case(op3) 
//					4'b0000: alucontrol <= 4'b0000; //add
//					4'b0001: alucontrol <= 4'b0001; //sub
//					4'b0010: alucontrol <= 4'b0010; //and
//					4'b0011: alucontrol <= 4'b0011; //or
//					4'b0100: alucontrol <= 4'b0100; //xor
//					4'b0101: alucontrol <= 4'b0101; //cmp
//					4'b0110: alucontrol <= 4'b0110; //mov
//					4'b0111: alucontrol <= 4'bxxxx; //reserved
//					4'b1000: alucontrol <= 4'b1000; //sll shift left logical
//					4'b1001: alucontrol <= 4'b1001; //slr shift left rotate
//					4'b1010: alucontrol <= 4'b1010; //srl shift right logical
//					4'b1011: alucontrol <= 4'b1011; //sra shift right arithmetic
//					4'b1100: alucontrol <= 4'b1100; //IN rd
//					4'b1101: alucontrol <= 4'b1101; //OUT rs
//					4'b1110: alucontrol <= 4'bxxxx; //reserved
//					4'b1111:  halt<= 1; //halt() stop meirei
//					default: alucontrol <= 4'bxxxx; //change
//				endcase
//		endcase
//	end
	
	function [3:0] aludecoder;
		input	[3:0] opcode3;
		input [1:0] aluopcode;
	begin
		case(aluopcode)
			2'b00: aludecoder = 4'b0000; //lw add
			2'b01: aludecoder = 4'b0001; //branch sub
			default:
				case(opcode3)
					4'b0000: aludecoder = 4'b0000; //add
					4'b0001: aludecoder = 4'b0001; //sub
					4'b0010: aludecoder = 4'b0010; //and
					4'b0011: aludecoder = 4'b0011; //or
					4'b0100: aludecoder = 4'b0100; //xor
					4'b0101: aludecoder = 4'b0101; //cmp
					4'b0110: aludecoder = 4'b0110; //mov
					4'b0111: aludecoder = 4'bxxxx; //reserved
					4'b1000: aludecoder = 4'b1000; //sll shift left logical
					4'b1001: aludecoder = 4'b1001; //slr shift left rotate
					4'b1010: aludecoder = 4'b1010; //srl shift right logical
					4'b1011: aludecoder = 4'b1011; //sra shift right arithmetic
					4'b1100: aludecoder = 4'b1100; //IN rd
					4'b1101: aludecoder = 4'b1101; //OUT rs
					4'b1110: aludecoder = 4'bxxxx; //reserved
					default: aludecoder = 4'bxxxx; //change
				endcase
		endcase
	end
	endfunction
	
	function haltdecoder;
		input	[3:0] haltopcode3;
		input [1:0] haltaluopcode;
	begin
		case(haltaluopcode)
			2'b10: 
				case(haltopcode3)
					4'b1111: haltdecoder = 1;
					default: haltdecoder = 0;
				endcase
			default: haltdecoder = 0;
		endcase
	end
	endfunction
	
	assign alucontrol = aludecoder(op3, aluop);
	assign halt = haltdecoder(op3, aluop);
	
	
	
	
	
	
	
	
endmodule