`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:51:20 01/31/2024
// Design Name:   blinking_led
// Module Name:   /media/animeshm/HP USB20FD/CS220Lab/Lab3_1/blinkin_park/blinking_led_top.v
// Project Name:  blinkin_park
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: blinking_led
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module blinking_led_top;

	// Inputs
	reg clk;

	// Outputs
	wire led0;

	// Instantiate the Unit Under Test (UUT)
	blinking_led uut (
		.clk(clk), 
		.led0(led0)
	);
	
	always @(led0) begin
		$display("time = %d, jagmag jagmag! %d",$time, led0);
	end

	initial begin
		forever begin
			clk = 0;
			#2
			clk = 1;
			#2
			clk = 0;
		end
	end 
	
	initial begin
		// Wait 1000000 ns for global reset to finish
		#100000000;
        
		// Add stimulus here
		$finish;
	end
endmodule

