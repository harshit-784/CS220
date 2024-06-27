`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:22:27 01/29/2024
// Design Name:   eight_bit_comparator
// Module Name:   /media/sankalpm22/HP USB20FD/CS220Lab/Lab2_3/eight_bit_comparator/eight_bit_comparator_top.v
// Project Name:  eight_bit_comparator
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: eight_bit_comparator
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module eight_bit_comparator_top;

	// Inputs
	reg pb1;
	reg pb2;
	reg pb3;
	reg pb4;
	reg [3:0] y;

	// Outputs
	wire lout;
	wire gout;
	wire eout;

	// Instantiate the Unit Under Test (UUT)
	eight_bit_comparator uut (
		.pb1(pb1), 
		.pb2(pb2), 
		.pb3(pb3), 
		.pb4(pb4), 
		.y(y), 
		.lout(lout), 
		.gout(gout), 
		.eout(eout)
	);

	always@(lout, eout, gout) begin
		$display("time = %d, lout = %b, eout = %b, gout = %b\n", $time, lout, eout, gout);
	end
	
	initial begin
		pb1 = 0; pb2 = 0; pb3 = 0; pb4 = 0;
		#5
		y = 4'b1101;
		#1
		pb1 = 1;
		#5
		y = 4'b0000;
		#1
		pb2 = 1;
		#5
		y = 4'b1101;
		#1
		pb3 = 1;
		#5
		y = 4'b0000;
		#1
		pb4 = 1;
		#5
		$finish;
	end
      
      
endmodule

