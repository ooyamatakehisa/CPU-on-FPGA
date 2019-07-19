module regfile (	
						input				clk,reset,
						input 			regwrite,
						input [2:0] 	rs,rd,writeregW,
						input [15:0] 	result,
						output reg [15:0]	rd1, rd2
						
						);
					
	reg [15:0] rf[7:0] ;  //rf[15:0]->[7:0] change
	

	
	always @ (posedge clk, posedge reset) begin
		if(reset) begin
		rf[0] <= 0;
		rf[1] <= 0;	
		rf[2] <= 0;
		rf[3] <= 0;
		rf[4] <= 0;
		rf[5] <= 0;
		rf[6] <= 0;
		rf[7] <= 0;
	end else if(regwrite) rf[writeregW] <= result;
	end
		
	
	//assign rd1 = (rd != 0) ? rf[rd] :0 ; //if(rd1==0) -> 0 else -> rd
	//assign rd2 = (rs != 0) ? rf[rs] :0 ; //if(rd2==0) -> 0 else -> rs

	always @ (*) begin //~clk kamo
		//rd1 <= rf[rs];
		//rd2 <= rf[rd];
		rd1 <= rf[rd];
		rd2 <= rf[rs];
	end
endmodule
