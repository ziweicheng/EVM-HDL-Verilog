module countvote(clk,result,status_switch,counter_A, counter_B, counter_DC_A, counter_DC_B, counter_MD_A, counter_MD_B, 
						  counter_VA_A, counter_VA_B);
input clk;
input status_switch;

input[28:0] counter_A;
input[28:0] counter_B;
input[28:0] counter_DC_A;
input[28:0] counter_DC_B;
input[28:0] counter_MD_A;
input[28:0] counter_MD_B;
input[28:0] counter_VA_A;
input[28:0] counter_VA_B;



output[3:0] result;


reg[3:0] result;



always @ (posedge clk)
begin
	if (status_switch)
	begin
		result[3] <= 1;
		if (counter_DC_A > counter_DC_B)
			result[2] <= 1;
		else
			result[2] <= 0;
		if (counter_MD_A > counter_MD_B)
			result[1] <= 1;
		else
			result[1] <= 0;
		if (counter_VA_A > counter_VA_B)
			result[0] <= 1;
		else
			result[0] <= 0;
	end
	else
	begin
		result[3] <= 0; 
		if (counter_A > counter_B)
			result[2:0] <= 3'b111;
		else
			result[2:0] <= 3'b011;
			
	end
end					  						  
endmodule