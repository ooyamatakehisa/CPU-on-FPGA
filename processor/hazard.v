module hazard(	
					input [2:0] rsD, rdD,
					input [2:0] rsE, rdE,writeregE,writeregM,writeregW,
					input pcsrcD,regwriteM,regwriteW,memtoregE,liE,inE,
					output reg [1:0]forwardAE, forwardBE,
					output stallF,
					output stallD
);
		
		wire lwstall, branchstall;
		

		always @(*) begin
		//rs
		if((rsE == writeregM) & regwriteM)
			forwardBE = 2'b10;
			else if ((rsE == writeregW) & regwriteW)//ldhazard
				forwardBE = 2'b01;
				else
				forwardBE = 2'b00;
		
		//rd
		if((rdE == writeregM) & regwriteM)
			forwardAE = 2'b10;
			else if ((rdE == writeregW) & regwriteW)//ldhazard
				forwardAE = 2'b01;
				else
				forwardAE = 2'b00;
				
		end
		
		
		assign lwstall = ((rsD==writeregE)|(rdD==writeregE)) & (memtoregE | liE | inE);
		
		assign branchstall = pcsrcD;
		assign stallF = lwstall;
		assign stallD = pcsrcD | lwstall;
		
		
	endmodule