`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:00:01 01/31/2024
// Design Name:   rippling_leds
// Module Name:   /media/animeshm/HP USB20FD/CS220Lab/Lab3_2/ripplin_park/rippling_leds_top.v
// Project Name:  ripplin_park
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: rippling_leds
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module rippling_leds_top;

	// Inputs
	reg clk;

	// Outputs
	wire led0;
	wire led1;
	wire led2;
	wire led3;
	wire led4;
	wire led5;
	wire led6;
	wire led7;

	// Instantiate the Unit Under Test (UUT)
	rippling_leds uut (
		.clk(clk), 
		.led0(led0), 
		.led1(led1), 
		.led2(led2), 
		.led3(led3), 
		.led4(led4), 
		.led5(led5), 
		.led6(led6), 
		.led7(led7)
	);

	always @(led0, led1, led2, led3, led4, led5, led6, led7) begin
		$display("time = %d, led config: %d %d %d %d %d %d %d %d",$time, led0, led1, led2, led3, led4, led5, led6, led7);
	end

	initial begin
		forever begin
			clk = 0;
			#2
			clk = 1;
			#2
			clk =0;
		end
	end 
	
	initial begin
		// Wait 1000000 ns for global reset to finish
		#1000000;
        
		// Add stimulus here
		$finish;
	end
      
endmodule

