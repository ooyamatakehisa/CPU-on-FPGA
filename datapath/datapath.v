module datapath(	
						input clk,reset,
						input memtoregW,
						input alusrcE,
						input regwriteW, jumpE,
						input [3:0] 	alucontrolE,
						output 			SE,ZE,VE,CE,
						output [15:0] 	pc,
						input [15:0] 	instrD,
					   input [15:0]	writedataE,
						output[15:0]	aluoutE, writedataD, srcaD,
						
						input pcsrcM
						);
						

wire [15:0] pcnext, pcplus1E, pcbranchE; //pcnextbr
wire [15:0] signimmE,resultW; 
wire [15:0] srcaE,srcbE;

//next pc
flopr #(16) pcreg(clk, reset, pcnext, pc );
adder pcadd1(pc, 15'b1, pcplus1E);

adder pcadd2(pcplus1E,signimmE,pcbranchE);
mux2 #(16) pcbrmux(pcplus1E, pcbranchE, pcsrcM, pcnext); //pcnextbr after j instruction
//mux #(16) pcmux (pcnextbr,])

//register
regfile re(clk,regwriteW, instrD[10:8], instrD[13:11],resultW ,srcaD,writedataD,memtoregW);
//mux2 #(16) resmux (aluregpath, readdata, memtoregW, result);
signext se(instrD[7:0], signimmE); 

//ALU unit
mux2 #(16) srcbmux(writedataE, signimmE, alusrcE, srcbE);
ALU alu(srcaE, srcbE, alucontrolE, aluoutE, SE,ZE,CE,VE);



//mux2 #(16) limux(aluregpath,signimm,li,regdmin);
//mux2 #(16) liresultin(result,regdmin,li,resultW;

//flopr #(16) alureg(regp2,clk, reset, aluout, aluregpath);
//flopr #(1) regS(regp2,clk,reset,aluS,S);
//flopr #(1) regZ(regp2,clk,reset,aluZ,Z);
//flopr #(1) regV(regp2,clk,reset,aluV,V);
//flopr #(1) regC(regp2,clk,reset,aluC,C);


endmodule