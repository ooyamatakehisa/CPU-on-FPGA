module pcbranch(
					 input [4:0] branchD,
					 input ZE, SE, VE,jumpD,
					 output reg pcsrcD
);
		reg branchsrc;

		always @(*)begin
			if(branchD[0] ||(branchD[4] & ZE ) || (branchD[3] & (SE ^ VE)) || (branchD[2] & (ZE || (SE ^ VE)))|| (branchD[1] & ~ZE)) begin
					branchsrc <= 1;
					end else begin
					branchsrc <= 0;
					end
			pcsrcD <= branchsrc | jumpD;
		end
		
		
		
endmodule