module Clk (clk_50m,rst_n, clk_1);

input clk_50m;
input rst_n;


output reg clk_1;
reg[28:0] cnt;


always@(posedge clk_50m)
begin
	if(!rst_n)  
		begin  
			clk_1<= 0;  
			cnt<= 0;  
		end
	   else  
        if(cnt<6799999)  
            cnt<=cnt+1;  
        else  
            begin  
                cnt<=0;            
                clk_1=~clk_1;  
            end  
end
endmodule
