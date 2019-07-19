module claptonver1 (
							input clkin, reset,
							input exec,
							input [15:0] externalinput,
							output [15:0] writedataM, readdataM, regdminM,
							output [15:0] pc, instrF,instrD,
							output memwrite,
							output reg haltW,
							output stallF,pcsrcD,memtoregE,
							output [2:0] rsD,rdD,writeregE,
							output selecter1,
							output [15:0] resultW,
							output inM,outW,
							output [31:0] cycle
						   );
							
	
	wire clk,NXOROUT,switchout,switchout2,switchout3,execout,execout2,execout3,OROUT,OROUT2,OROUT3,inMDFF;
	assign instrex = instrF;
	assign selecter1 = 1;
	wire [15:0] srcaD,srcbD,srcaex,srcbex;
	wire regclock,clock,invclock,regclk,invclk;
	
	cyclecounter cyclecount(clk,~reset,cycle);
	
	chat chatremove(clkin,~reset,~exec,execout);
	//chat chatremove2(regclock,~reset,~exec,execout2);
	//chat chatremove3(invclock,~reset,~exec,execout3);
	
	
	switch sw(execout,switchout);
	//switch sw2(execout2,switchout2);
	//switch sw3(execout3,switchout3);
	
	
	//flopr #(1) inmdff(~clkin,~reset,inM,inMDFF);
	
	
	
	assign OROUT = haltW | switchout ;
	//assign OROUT2 = haltW | switchout2 ;
	//assign OROUT3 = haltW | switchout3 ;
	
		function clkstop;
	input d0,d1,s;
		begin		
			clkstop =s ? d1 : d0 ; // s==1 -> d1 s==0 -> d0
		end
	endfunction
	
	assign clk = clkstop(clock,0,OROUT);
	assign regclk = clkstop(regclock,0,OROUT);
	assign invclk = clkstop(invclock,0,OROUT);
	
	pllclk	pllclk_inst (
	.inclk0 ( clkin ),
	.c0 ( clock ),
	.c1 ( regclock ),
	.c2 (	invclock )
	);

	
	processor proc(regclk, clk, ~reset,~externalinput, pc ,instrF,instrD, memwrite, regdminM, writedataM, readdataM,srcaex,srcbex,haltW,stallF,pcsrcD,memtoregE,rsD,rdD,writeregE,srcaD,srcbD,inM,outW, resultW);
	IM im(pc,invclk,16'bxxxxxxxxxxxxxxxx,0,instrF);
	DM dm(regdminM[11:0],invclk, writedataM,memwrite,readdataM);
	
	//flopr #(16) INIF (clk, reset, instr0, instr1);
	//flopr #(16) readDM (clk, reset, readdata2, readdataM );
	//flopr #(16) writeDM (clk, reset, writedata1, writedata2);

	
	
	
	
endmodule