`timescale 1s/1s
module statemachinetb();

reg clk, rst_n, nextButton,back, DC_switch,MD_switch,VA_switch;

reg[1:0] candidate_switch;

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
					  .counter_VA_total(counter_VA_total));
					  
					  
initial
begin
clk = 0;
rst_n = 0;
DC_switch = 0;
MD_switch = 0;
VA_switch = 0;
nextButton = 0;
back = 0;
candidate_switch = 2'b00;
#5
rst_n = ~rst_n;
nextButton = 1;
DC_switch = 1;
#100 $finish;
end

always
begin
clk = ~clk;
end

initial
begin
$shm_open("wave.db");
$shm_probe(test,"AS");
$shm_save;
end
endmodule
