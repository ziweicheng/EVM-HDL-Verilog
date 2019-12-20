module debounce(clk,rst_n,nextButton,buttonOut);

input clk;
input rst_n;
input nextButton;

output buttonOut;

reg buttonOut;

reg [1:0]button_pressed, button_not_pressed;
reg button_state;


initial begin
button_state <= 1'b1;
button_pressed <= 2'b00;
button_not_pressed <= 2'b00;
end


always @ (posedge clk or negedge rst_n)
begin
	if(!rst_n)//If the reset is negative (reset button pressed) we reset the valeus
		begin
		button_pressed<= 2'b00;
		button_not_pressed<= 2'b00;
		buttonOut <= 0;
		end
	
	else
		begin
		//If button is negative (button pressed) and status is low we start counting	
		if(!nextButton & !button_state)
			begin
			button_pressed <= button_pressed + 1'b1;		//Counting
			end

		else
			begin
			button_pressed <= 2'b00; //If not, reset the counter
			end

		if(button_pressed == 2'b01  )//When 2M pulses are reached, we increase the push counter by one and reset the others
			begin
			buttonOut <= 1;
			button_state <= 1'b1;
			button_pressed <= 2'b00;
			end





		//Do the same for the positive part of button (button not pressed)
		if(nextButton & button_state)
			begin
			button_not_pressed <= button_not_pressed + 1'b1;
			buttonOut <= 0;
			end

		else
			begin
			button_not_pressed <= 2'b0;
			end

		if(button_not_pressed == 2'b01)
			begin
			button_not_pressed <= 2'b0;
			button_state <= 1'b0;
			end
		end//end of else of negative reset
end//end of always
endmodule