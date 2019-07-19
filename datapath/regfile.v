module regfile (	
						input				clk,
						input 			regwrite,
						input [2:0] 	rs,rd,writeregW,
						input [15:0] 	result,
						output reg [15:0]	rd1, rd2
						);
					
	reg [15:0] rf[7:0] ;  //rf[15:0]->[7:0] change

	always @ (posedge clk) begin
		if(regwrite) rf[writeregW] <= result;
		
	end
		
	//assign rd1 = (rd != 0) ? rf[rd] :0 ; //if(rd1==0) -> 0 else -> rd
	//assign rd2 = (rs != 0) ? rf[rs] :0 ; //if(rd2==0) -> 0 else -> rs

	always @ (posedge ~clk) begin //~clk kamo
		rd1 <= rf[rs];
		rd2 <= rf[rd];
	end
endmodule
