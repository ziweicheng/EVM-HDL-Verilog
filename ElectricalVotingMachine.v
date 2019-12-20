module ElectricalVotingMachine(clk,rst_n, button, back, DC_switch, MD_switch, VA_switch, candidate_switch, status_switch,
			result,LED_out0,LED_out1,LED_out2,LED_out3,LED_out4,LED_out5,LED_out6,LED_out7,
					CLOCK_50, 
					  LCD_ON,                            //    LCD Power ON/OFF
                 LCD_BLON,                        //    LCD Back Light ON/OFF
                 LCD_RW,                            //    LCD Read/Write Select, 0 = Write, 1 = Read
                 LCD_EN,                            //    LCD Enable
                 LCD_RS,                            //    LCD Command/Data Select, 0 = Command, 1 = Data
                 LCD_DATA,
					  rstlcd);

input rstlcd;
input clk;
input rst_n;
input button;
input back;
input DC_switch;
input MD_switch;
input VA_switch;
input status_switch;
input[1:0] candidate_switch;

wire clk_1;
wire nextButton;
wire[3:0] currentState;
wire[28:0] counter_A;
wire[28:0] counter_B;
wire[28:0] counter_DC_A;
wire[28:0] counter_DC_B;
wire[28:0] counter_MD_A;
wire[28:0] counter_MD_B;
wire[28:0] counter_VA_A;
wire[28:0] counter_VA_B;
wire[28:0] counter_total;
wire[28:0] counter_DC_total;
wire[28:0] counter_MD_total;
wire[28:0] counter_VA_total;



output[3:0] result;
output[6:0] LED_out0;
output[6:0] LED_out1;
output[6:0] LED_out2;
output[6:0] LED_out3;
output[6:0] LED_out4;
output[6:0] LED_out5;
output[6:0] LED_out6;
output[6:0] LED_out7;

input  CLOCK_50;
inout    [7:0]    LCD_DATA;                //    LCD Data bus 8 bits
output            LCD_ON;                    //    LCD Power ON/OFF
output            LCD_BLON;                //    LCD Back Light ON/OFF
output            LCD_RW;                    //    LCD Read/Write Select, 0 = Write, 1 = Read
output            LCD_EN;                    //    LCD Enable
output            LCD_RS;                    //    LCD Command/Data Select, 0 = Command, 1 = Data




Clk bk0(.clk_50m(clk),
		  .rst_n(rst_n),
		  .clk_1(clk_1));

		  
debounce bk1(.clk(clk_1),
				 .rst_n(rst_n),
				 .nextButton(button),
				 .buttonOut(nextButton));
		  
		  
		  
statemachine bk2(.clk(clk_1),
					  .rst_n(rst_n),
					  .nextButton(nextButton),
					  .back(back),
					  .DC_switch(DC_switch),
					  .MD_switch(MD_switch), 
					  .VA_switch(VA_switch), 
					  .candidate_switch(candidate_switch),
					  .counter_A(counter_A),
					  .counter_B(counter_B), 
					  .counter_DC_A(counter_DC_A), 
					  .counter_DC_B(counter_DC_B), 
					  .counter_MD_A(counter_MD_A), 
					  .counter_MD_B(counter_MD_B), 
					  .counter_VA_A(counter_VA_A), 
					  .counter_VA_B(counter_VA_B), 
					  .counter_total(counter_total), 
					  .counter_DC_total(counter_DC_total), 
					  .counter_MD_total(counter_MD_total), 
					  .counter_VA_total(counter_VA_total),
					  .CLOCK_50(CLOCK_50));
				
				
				
				
countvote bk3(.clk(clk_1),
				  .status_switch(status_switch),
				  .counter_A(counter_A),
				  .counter_B(counter_B), 
				  .counter_DC_A(counter_DC_A), 
				  .counter_DC_B(counter_DC_B), 
				  .counter_MD_A(counter_MD_A), 
				  .counter_MD_B(counter_MD_B), 
				  .counter_VA_A(counter_VA_A), 
				  .counter_VA_B(counter_VA_B),
				  .result(result));
				  
				  
segmentdisplay bk4(.clk(clk_1),
					  .rst_n(rst_n),
					  .DC_switch(DC_switch),
					  .MD_switch(MD_switch), 
					  .VA_switch(VA_switch), 
					  .counter_A(counter_A),
					  .counter_B(counter_B), 
					  .counter_DC_A(counter_DC_A), 
					  .counter_DC_B(counter_DC_B), 
					  .counter_MD_A(counter_MD_A), 
					  .counter_MD_B(counter_MD_B), 
					  .counter_VA_A(counter_VA_A), 
					  .counter_VA_B(counter_VA_B), 
					  .counter_total(counter_total), 
					  .counter_DC_total(counter_DC_total), 
					  .counter_MD_total(counter_MD_total), 
					  .counter_VA_total(counter_VA_total),
					  .LED_out0(LED_out0),
					  .LED_out1(LED_out1),
					  .LED_out2(LED_out2),
					  .LED_out3(LED_out3),
					  .LED_out4(LED_out4),
					  .LED_out5(LED_out5),
					  .LED_out6(LED_out6),
					  .LED_out7(LED_out7));
				  
lcdvhdl		bk5(	.reset(rstlcd),
						.clock_50(CLOCK_50),
						.lcd_on(LCD_ON),
						.lcd_blon(LCD_BLON),
						.lcd_rw(LCD_RW),
						.lcd_e(LCD_EN),
						.lcd_rs(LCD_RS),
						.data_bus_0(LCD_DATA[0]),
						.data_bus_1(LCD_DATA[1]),
						.data_bus_2(LCD_DATA[2]),
						.data_bus_3(LCD_DATA[3]),
						.data_bus_4(LCD_DATA[4]),
						.data_bus_5(LCD_DATA[5]),
						.data_bus_6(LCD_DATA[6]),
						.data_bus_7(LCD_DATA[7]),
						.LCD_CHAR_ARRAY_0(button),
						.LCD_CHAR_ARRAY_1(VA_switch),
						.LCD_CHAR_ARRAY_2(MD_switch),
						.LCD_CHAR_ARRAY_3(DC_switch),
						.LCD_CHAR_ARRAY_4(candidate_switch[0]),
						.LCD_CHAR_ARRAY_5(candidate_switch[1])
						);




endmodule

