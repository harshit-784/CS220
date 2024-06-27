`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:47:39 01/29/2024 
// Design Name: 
// Module Name:    blinking_led 
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
`define OFF_TIME 25
`define ON_TIME (`OFF_TIME*2)

module blinking_led(clk, led0);
	input clk;
	output led0;
	reg led0 = 1'b1;
	reg [31:0] counter = 0;
	
	
	always@(posedge clk) begin
		if(counter == `OFF_TIME) begin
			led0 <=1'b0;
			counter <= counter + 1;

		end
		else if( counter == `ON_TIME) begin
			led0 <= 1'b1;
			counter <= 0;
		end 
		else begin
			led0 <= led0;
			counter <= counter + 1;

		end
		//led0 = ~led0;
	end

endmodule
