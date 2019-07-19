module processor (						
						input regclock,clk, reset,
						input [15:0] externalinput,
						output[15:0] pcF,
						input [15:0] instrF,
						output[15:0] instrD,
						output memwriteM,
						output [15:0] regdminM,writedataM,
						input [15:0] readdataM,
						output [15:0] aluaE,alubE,
						output haltW,stallF,pcsrcD,memtoregE,
						output [2:0] rsD,rdD,writeregE,
						output [15:0] srcaD,srcbD,
						output inM,outW,
						output [15:0] resultW
												);
						
	//IF etc
	wire [15:0] pcplus1F,pcplus1D,pcplus1E;
	wire [15:0] pcnext;
	wire [15:0] pcbrnext;
	
	//ID
	wire [15:0] signimmD;
	wire shiftD,inD,outD,addiD,memtoregD, alusrcD, regwriteD, jumpD, memwriteD, liD, haltD,stallD;
	wire [3:0] alucontrolD;
	wire [4:0] branchD;
	wire [65:0] IDEXin,IDEXout;
	wire [15:0] pcbranchD;
	wire [2:0] rsin;
	//EX
	wire inE,outE,alusrcE, regwriteE, jumpE, memwriteE, liE, haltE,flushE;
	wire ZE,SE,CE,VE;
	wire [3:0] alucontrolE;
	
	wire [15:0] aluoutE,pcbranchE,srcaE,srcbE; //srcaE,srcbE -> output
	wire [56:0] EXMEMin,EXMEMout;
	wire [1:0] forwardAE,forwardBE;
	//MEM
	wire [4:0] branchM;
	wire [15:0] pcbranchM,aluoutM,signimmM,writeregM;
	wire liM;
	wire [15:0] limuxout;
	wire outM,regwriteM, memtoregM, haltM;
	wire [35:0] MEMWBin1, MEMWBout1;
	wire [2:0] MEMWBin2, MEMWBout2;
	//WB
	wire inW,regwriteW, memtoregW ;
	wire [15:0] readdataW,regdminW,aluoutW,resultWin;
	wire [2:0] writeregW;
	wire [15:0] writedataD,writedataE, signimmE;
	wire [2:0] rsE, rdE;
	
	
	
	controller c(instrD[15:14], instrD[13:11], instrD[10:8], instrD[7:4],shiftD,inD,addiD, memtoregD, memwriteD, alusrcD, regwriteD, jumpD, liD, alucontrolD, haltD, branchD[4:0] ); // 
	//datapath dp(clk, reset, memtoregW, alusrcE, regwriteW, jumpE, alucontrolE, SE, ZE, VE, CE, pc, instrD, aluoutE, writedataE, signimmE);

	
	
	
	//next pc
	
	
	flopenablepc pcreg(~stallF, clk, reset, pcnext, pcF );
	adder pcadd1(pcF, 16'b1, pcplus1F);

	mux2 #(16) pcbrmux(pcplus1F, pcbranchD, pcsrcD,pcbrnext ); //pcnextbr after j instruction
	mux2 #(16) pcjumpmux(pcbrnext,signimmD,jumpD,pcnext);
	
	flopenable #(32) IFID (~stallD, clk, reset,pcsrcD, {instrF,pcplus1F}, {instrD,pcplus1D});


	
	
	//register
	mux2 #(3) rsmux(instrD[13:11],instrD[10:8],addiD,rsin);
	regfile re(regclock,reset, regwriteW, rsin, instrD[10:8],writeregW,resultW,srcaD,srcbD);
	signext se(instrD[7:0],shiftD, signimmD); 
	
	
	//ID/EX

	assign IDEXin = { inD,memtoregD, memwriteD, alusrcD, regwriteD, jumpD, liD, alucontrolD[3:0], haltD,srcaD[15:0], srcbD[15:0], rsin, instrD[10:8],signimmD[15:0]};
   flopenableEX #(66)  IDEX (clk, reset,flushE, IDEXin, IDEXout);
	assign { inE,memtoregE, memwriteE, alusrcE, regwriteE, jumpE, liE, alucontrolE[3:0], haltE,srcaE[15:0], srcbE[15:0], rsE[2:0],rdE[2:0], signimmE[15:0]} = IDEXout;
	
	//EX
	mux3 #(16) aemux (srcaE, resultW, regdminM, forwardAE, aluaE );
	mux3 #(16) bemux (srcbE, resultW, regdminM, forwardBE, writedataE );
	
	
	
   //ALU unit
	mux2 #(16) srcbmux(writedataE, signimmE, alusrcE, alubE);
	ALU alu(aluaE, alubE, alucontrolE, aluoutE, SE,ZE,CE,VE);

	//writereg destination mux2
	mux2 #(3) writeregdestination (rdE, rsE, memtoregE, writeregE);
	
	adder pcadd2(pcplus1D,signimmD,pcbranchD);
	
	//EX/MEM
	assign EXMEMin = {inE,memtoregE, memwriteE, regwriteE, liE, haltE,aluoutE[15:0], writedataE[15:0], signimmE[15:0], writeregE[2:0] };
	assign {inM,memtoregM, memwriteM, regwriteM, liM, haltM,aluoutM[15:0], writedataM[15:0], signimmM[15:0], writeregM[2:0]} = EXMEMout;
	flopr  #(57) EXMEM(clk,reset,EXMEMin,EXMEMout);
	
	
	
	//MEM
	
	pcbranch pcbr(branchD[4:0],ZE,SE,VE,jumpD,pcsrcD);
		//pcsrcM
	//	function pcbranch(input [4:0]branch,
	//							input Z, S, V );
	//		begin
	//			if(branch[4] ||(branch[0] & Z ) || (branch[1] & (S ^ V)) || (branch[2] & (Z || (S ^ V)))|| (branch[3] & ~Z)) begin
	//				pcbranch = 1;
	//				end else pcbranch = 0;
	//		end
	//	endfunction
//		assign pcsrcM = pcbranch (branchM[4:0], ZM, SM, VM) ;
	//pcsrcM end
	mux2 #(16) limux(aluoutM[15:0],signimmM[15:0],liM, limuxout[15:0]);
	mux2 #(16) exinput(limuxout,externalinput[15:0],inM,regdminM);
	
	
	//MEM/WB
	assign MEMWBin1 = {regwriteM,regdminM[15:0], readdataM[15:0], writeregM[2:0]};
	assign MEMWBin2 = {inM,memtoregM, haltM};
	assign {regwriteW,regdminW[15:0], readdataW[15:0],writeregW[2:0]} = MEMWBout1;
	assign {inW,memtoregW,haltW} = MEMWBout2;
	flopr #(36) MEMWB1 (clk, reset, MEMWBin1, MEMWBout1);
	flopr #(3) MEMWB2 (clk, reset, MEMWBin2, MEMWBout2);
	
	//WB
	mux2 #(16) regwritemux(regdminW[15:0], readdataW[15:0], memtoregW, resultW[15:0]);
	//mux2 #(16) externalinputmux(resultWin[15:0],externalinput[15:0],inW,resultW[15:0]);
	
	//hazard
	hazard haz(rsD, rdD, rsE, rdE,writeregE,writeregM,writeregW,pcsrcD,regwriteM,regwriteW,memtoregE,liE,inE,forwardAE, forwardBE,stallF,stallD);

	assign flushE = stallD;
	assign rsD = instrD[13:11];
	assign rdD = instrD[10:8];

endmodule