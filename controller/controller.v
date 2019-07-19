module controller(
						input [1:0] op1, //inst[15:14]
						input [2:0] op2, //inst[13:11]
						input [2:0] cond, //[10:8]
						input [3:0] op3, //[7:4]
						output shiftD,
						output inD,
						output addi, memtoregD, memwriteD, alusrcD, regwriteD, jumpD, liD, //delete regdst
						output [3:0] alucontrolD,
						output haltD,
						output [4:0] branchD 
						);

	wire [1:0] aluop;
	wire be,blt,ble,bne,br,outD;
		
	maindec md(op1, op2, cond,op3,shiftD,inD,outD, addi, memtoregD, memwriteD, be, alusrcD, regwriteD, jumpD, blt, ble, bne, liD, br, aluop);
	aludec ad(op3, aluop, alucontrolD,haltD);

	
	assign branchD = {be,blt,ble,bne,br};
	
	
	//function pcbranch;
	//	input be, blt, ble, bne, br, Z, S, V ;
	//	begin
	//		if(br ||(be & Z ) || (blt & (S ^ V)) || (ble & (Z || (S ^ V))) || (bne & !Z) ) begin
	//			pcbranch = 1;
	//			end else pcbranch = 0;
//		end
//	endfunction
	
	//assign pcsrc = pcbranch (be, blt, ble, bne, br, Z, S, V) ;

endmodule