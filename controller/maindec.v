module maindec(
					input [1:0] op1,
					input [2:0] op2,
					input [2:0] cond,
					input [3:0] op3,
					output	shift,
					output	in,out,
					output	addi,
					output	memtoreg, memwrite,
					output	be, alusrc,
					output	regwrite,
					output	jump,
					output	blt,ble,
					output	bne,
					output   li,br,
					output [1:0] aluop
					);
					
	reg[16:0] controls;

	assign { shift,in,out,addi,regwrite, alusrc, li, br , be, blt, ble, bne, memwrite, memtoreg, jump, aluop } = controls; //regdst delete

	always @ (*)//when any input
		case(op1)
			2'b00: controls <= 17'b00001100000001000; // lw(rs),alusrc,memtoreg 
			2'b01: controls <= 17'b00000100000010000; //arusrc,memwrite
			2'b11:
			case(op3)
				4'b0101: controls <= 17'b00000000000000010; //cmp aLUop(10)
				4'b1101: controls <= 17'b00100000000000010; //out aluop(10)
				4'b1100: controls <= 17'b01001000000000010; //in regwrite aluop(10)
				4'b1000: controls <= 17'b10001100000000010; //sll shift regwrite alusrc aluop(10)
				4'b1001: controls <= 17'b10001100000000010; //SLR
				4'b1010: controls <= 17'b10001100000000010; //SRL
				4'b1011: controls <= 17'b10001100000000010; //SRA
				default:	controls <= 17'b00001000000000010; //regwrite aluop(10)
			endcase
			default: case(op2)
						3'b000: controls <= 17'b00001010000000001; //regwrite, li aluop(01)
						3'b100: controls <= 17'b00000001000000001;//br aluop(01)
						3'b010: controls <= 17'b00011100000000000;//addi,regwrite,alusrc
						3'b011: controls <= 17'b00000000000000100; //jump
						3'b101: controls <= 17'b00010100000000001; //cmpi addi,alusrc,aluop(01)
						3'b111: case(cond)
									3'b000: controls <= 17'b00000000100000001 ; //be aluop(01)
									3'b001: controls <= 17'b00000000010000001 ; //blt aluop(01)
									3'b010: controls <= 17'b00000000001000001 ; //ble aluop(01)
									3'b011: controls <= 17'b00000000000100001 ; //bne aluop(01)
									default: controls <= 17'b00000000000000000;
									endcase
						default: controls <= 17'b00000000000000000;
						endcase
		endcase
endmodule