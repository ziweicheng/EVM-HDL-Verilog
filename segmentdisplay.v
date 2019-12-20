module segmentdisplay(clk, rst_n, DC_switch, MD_switch, VA_switch, 
						  counter_A, counter_B, counter_DC_A, counter_DC_B, counter_MD_A, counter_MD_B, 
						  counter_VA_A, counter_VA_B, counter_total, counter_DC_total, counter_MD_total, counter_VA_total,
						  LED_out0, LED_out1, LED_out2, LED_out3, LED_out4, LED_out5, LED_out6, LED_out7);

						  
						  
parameter total_showvote = 2'b00, DC_showvote = 2'b01, MD_showvote = 2'b10, VA_showvote = 2'b11;

input clk;
input rst_n;
input DC_switch;
input MD_switch;
input VA_switch;

input[28:0] counter_A;
input[28:0] counter_B;
input[28:0] counter_DC_A;
input[28:0] counter_DC_B;
input[28:0] counter_MD_A;
input[28:0] counter_MD_B;
input[28:0] counter_VA_A;
input[28:0] counter_VA_B;
input[28:0] counter_total;
input[28:0] counter_DC_total;
input[28:0] counter_MD_total;
input[28:0] counter_VA_total;


output reg [6:0] LED_out0;
output reg [6:0] LED_out1;
output reg [6:0] LED_out2;
output reg [6:0] LED_out3;
output reg [6:0] LED_out4;
output reg [6:0] LED_out5;
output reg [6:0] LED_out6;
output reg [6:0] LED_out7;


reg[28:0] showvote;
reg[2:0] currentState;
reg[2:0] nextState;
reg[10:0] timer;
reg[1:0] votestag;


wire[28:0] LED_BCD0;
wire[28:0] LED_BCD1;
wire[28:0] LED_BCD2;
wire[28:0] LED_BCD3;
wire[28:0] LED_BCD4;
wire[28:0] LED_BCD5;
wire[28:0] LED_BCD6;




always @ (posedge clk or negedge rst_n)
	begin
		if (!rst_n)
			timer <= 0;
		else
			begin
			if (timer == 24)
				timer <= 0;
			else
				timer <= timer + 1;
			end
	end

	
	
always @ (posedge clk or negedge rst_n)
	begin
	if (!rst_n)
		currentState <= total_showvote;
	else
		currentState <= nextState;		
	end

	
	
	
always @ (negedge clk)
	begin
		case(currentState)
		total_showvote: begin
							 if (DC_switch && !MD_switch && !VA_switch)
								nextState <= DC_showvote;
							 else if (MD_switch && !VA_switch && !DC_switch)
								nextState <= MD_showvote;
							 else if (VA_switch && !MD_switch && !DC_switch)
								nextState <= VA_showvote;
							 else
								nextState <= total_showvote;
							 end
		DC_showvote: begin
						 if (DC_switch && !MD_switch && !VA_switch)
							   nextState <= DC_showvote;
						 else if (MD_switch && !VA_switch && !DC_switch)
								nextState <= MD_showvote;
						 else if (VA_switch && !MD_switch && !DC_switch)
								nextState <= VA_showvote;
						 else
								nextState <= total_showvote;
						 end
		MD_showvote: begin
						 if (DC_switch && !MD_switch && !VA_switch)
							   nextState <= DC_showvote;
						 else if (MD_switch && !VA_switch && !DC_switch)
								nextState <= MD_showvote;
						 else if (VA_switch && !MD_switch && !DC_switch)
								nextState <= VA_showvote;
						 else
								nextState <= total_showvote;
						 end
		VA_showvote: begin
						 if (DC_switch && !MD_switch && !VA_switch)
							   nextState <= DC_showvote;
						 else if (MD_switch && !VA_switch && !DC_switch)
								nextState <= MD_showvote;
						 else if (VA_switch && !MD_switch && !DC_switch)
								nextState <= VA_showvote;
						 else
								nextState <= total_showvote;
						 end
		default: nextState <= total_showvote;
		endcase	
	end
	
	
always @ (negedge clk)
	begin
		case(nextState)
		total_showvote: begin
							 if (timer < 8)
							 begin
								showvote <= counter_A;
								votestag <= 0;
							 end
							 else if (timer < 16)
							 begin
								showvote <= counter_B;
								votestag <= 1;
							 end
							 else
							 begin
								showvote <= counter_total; 
								votestag <= 2;
							 end
							 end
		DC_showvote: begin
						 if (timer < 8)
						 begin
							showvote <= counter_DC_A;
							votestag <= 0;
						 end
						 else if (timer < 16)
						 begin
							showvote <= counter_DC_B;
							votestag <= 1;
						 end
						 else
						 begin
							showvote <= counter_DC_total;
							votestag <= 2;
						 end
						 end
		MD_showvote: begin
						 if (timer < 8)
						 begin
							showvote <= counter_MD_A;
							votestag <= 0;
						 end
						 else if (timer < 16)
						 begin
							showvote <= counter_MD_B;
							votestag <= 1;
						 end
						 else
						 begin
							showvote <= counter_MD_total;
							votestag <= 2;
						 end
						 end
		VA_showvote: begin
						 if (timer < 8)
						 begin
							showvote <= counter_VA_A;
							votestag <= 0;
						 end
						 else if (timer < 16)
						 begin
							showvote <= counter_VA_B;
							votestag <= 1;
						 end
						 else
						 begin
							showvote <= counter_VA_total;
							votestag <= 2;
						 end
						 end
		endcase
	end
	
	

   
	assign LED_BCD6 = (showvote%10000000)/1000000;
	assign LED_BCD5 = ((showvote%10000000)%1000000)/100000;
	assign LED_BCD4 = (((showvote%10000000)%1000000)%100000)/10000;
   assign LED_BCD3 = ((((showvote%10000000)%1000000)%100000)%10000)/1000;
	assign LED_BCD2 = (((((showvote%10000000)%1000000)%100000)%10000)%1000)/100;
	assign LED_BCD1 = ((((((showvote%10000000)%1000000)%100000)%10000)%1000)%100)/10;
	assign LED_BCD0 = ((((((showvote%10000000)%1000000)%100000)%10000)%1000)%100)%10;
    // Cathode patterns of the 7-segment LED display 
always @(*)
    begin
        case(LED_BCD0)
		  //                    6543210
        4'b0000: LED_out0 = 7'b1000000; // "0"     
        4'b0001: LED_out0 = 7'b1111001; // "1" 
        4'b0010: LED_out0 = 7'b0100100; // "2" 
        4'b0011: LED_out0 = 7'b0110000; // "3" 
        4'b0100: LED_out0 = 7'b0011001; // "4" 
        4'b0101: LED_out0 = 7'b0010010; // "5" 
        4'b0110: LED_out0 = 7'b0000010; // "6" 
        4'b0111: LED_out0 = 7'b1111000; // "7" 
        4'b1000: LED_out0 = 7'b0000000; // "8"     
        4'b1001: LED_out0 = 7'b0011000; // "9" 
        default: LED_out0 = 7'b1000000; // "0"
        endcase
    end
	 
always @(*)
    begin
        case(LED_BCD1)
		  //                    6543210
        4'b0000: LED_out1 = 7'b1000000; // "0"     
        4'b0001: LED_out1 = 7'b1111001; // "1" 
        4'b0010: LED_out1 = 7'b0100100; // "2" 
        4'b0011: LED_out1 = 7'b0110000; // "3" 
        4'b0100: LED_out1 = 7'b0011001; // "4" 
        4'b0101: LED_out1 = 7'b0010010; // "5" 
        4'b0110: LED_out1 = 7'b0000010; // "6" 
        4'b0111: LED_out1 = 7'b1111000; // "7" 
        4'b1000: LED_out1 = 7'b0000000; // "8"     
        4'b1001: LED_out1 = 7'b0011000; // "9" 
        default: LED_out1 = 7'b1000000; // "0"
        endcase
    end

always @(*)
    begin
        case(LED_BCD2)
		  //                    6543210
        4'b0000: LED_out2 = 7'b1000000; // "0"     
        4'b0001: LED_out2 = 7'b1111001; // "1" 
        4'b0010: LED_out2 = 7'b0100100; // "2" 
        4'b0011: LED_out2 = 7'b0110000; // "3" 
        4'b0100: LED_out2 = 7'b0011001; // "4" 
        4'b0101: LED_out2 = 7'b0010010; // "5" 
        4'b0110: LED_out2 = 7'b0000010; // "6" 
        4'b0111: LED_out2 = 7'b1111000; // "7" 
        4'b1000: LED_out2 = 7'b0000000; // "8"     
        4'b1001: LED_out2 = 7'b0011000; // "9" 
        default: LED_out2 = 7'b1000000; // "0"
        endcase
    end
always @(*)
    begin
        case(LED_BCD3)
		  //                    6543210
        4'b0000: LED_out3 = 7'b1000000; // "0"     
        4'b0001: LED_out3 = 7'b1111001; // "1" 
        4'b0010: LED_out3 = 7'b0100100; // "2" 
        4'b0011: LED_out3 = 7'b0110000; // "3" 
        4'b0100: LED_out3 = 7'b0011001; // "4" 
        4'b0101: LED_out3 = 7'b0010010; // "5" 
        4'b0110: LED_out3 = 7'b0000010; // "6" 
        4'b0111: LED_out3 = 7'b1111000; // "7" 
        4'b1000: LED_out3 = 7'b0000000; // "8"     
        4'b1001: LED_out3 = 7'b0011000; // "9" 
        default: LED_out3 = 7'b1000000; // "0"
        endcase
    end
always @(*)
    begin
        case(LED_BCD4)
		  //                    6543210
        4'b0000: LED_out4 = 7'b1000000; // "0"     
        4'b0001: LED_out4 = 7'b1111001; // "1" 
        4'b0010: LED_out4 = 7'b0100100; // "2" 
        4'b0011: LED_out4 = 7'b0110000; // "3" 
        4'b0100: LED_out4 = 7'b0011001; // "4" 
        4'b0101: LED_out4 = 7'b0010010; // "5" 
        4'b0110: LED_out4 = 7'b0000010; // "6" 
        4'b0111: LED_out4 = 7'b1111000; // "7" 
        4'b1000: LED_out4 = 7'b0000000; // "8"     
        4'b1001: LED_out4 = 7'b0011000; // "9" 
        default: LED_out4 = 7'b1000000; // "0"
        endcase
    end
	 
always @(*)
    begin
        case(LED_BCD5)
		  //                    6543210
        4'b0000: LED_out5 = 7'b1000000; // "0"     
        4'b0001: LED_out5 = 7'b1111001; // "1" 
        4'b0010: LED_out5 = 7'b0100100; // "2" 
        4'b0011: LED_out5 = 7'b0110000; // "3" 
        4'b0100: LED_out5 = 7'b0011001; // "4" 
        4'b0101: LED_out5 = 7'b0010010; // "5" 
        4'b0110: LED_out5 = 7'b0000010; // "6" 
        4'b0111: LED_out5 = 7'b1111000; // "7" 
        4'b1000: LED_out5 = 7'b0000000; // "8"     
        4'b1001: LED_out5 = 7'b0011000; // "9" 
        default: LED_out5 = 7'b1000000; // "0"
        endcase
    end

always @(*)
    begin
        case(LED_BCD6)
		  //                    6543210
        4'b0000: LED_out6 = 7'b1000000; // "0"     
        4'b0001: LED_out6 = 7'b1111001; // "1" 
        4'b0010: LED_out6 = 7'b0100100; // "2" 
        4'b0011: LED_out6 = 7'b0110000; // "3" 
        4'b0100: LED_out6 = 7'b0011001; // "4" 
        4'b0101: LED_out6 = 7'b0010010; // "5" 
        4'b0110: LED_out6 = 7'b0000010; // "6" 
        4'b0111: LED_out6 = 7'b1111000; // "7" 
        4'b1000: LED_out6 = 7'b0000000; // "8"     
        4'b1001: LED_out6 = 7'b0011000; // "9" 
        default: LED_out6 = 7'b1000000; // "0"
        endcase
    end

always @(*)
    begin
        case(votestag)
		  //                     6543210
        0: LED_out7 = 7'b0001000; // "A"     
        1: LED_out7 = 7'b0000011; // "b" 
        2: LED_out7 = 7'b1000110; // "C" 
		  default;
        endcase
    end


endmodule 