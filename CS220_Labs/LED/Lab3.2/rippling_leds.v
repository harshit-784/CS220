`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:09:14 01/31/2024 
// Design Name: 
// Module Name:    rippling_leds 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`define SHIFT_TIME 50000000

module rippling_leds(clk, led0, led1, led2, led3, led4, led5, led6, led7);
	input clk;
	output led0, led1, led2, led3, led4, led5, led6, led7;
	reg led0 = 1'b1, led1=1'b0, led2=1'b0, led3=1'b0, led4=1'b0, led5=1'b0, led6=1'b0, led7=1'b0;
	reg [31:0] counter = 0;
	
	always @(posedge clk) begin
		counter <= counter + 1;
		if (counter == `SHIFT_TIME) begin
			counter <= 0;
			led1 <= led0;
			led2 <= led1;
			led3 <= led2;
			led4 <= led3;
			led5 <= led4;
			led6 <= led5;
			led7 <= led6;
			led0 <= led7;
		end
	end
endmodule
