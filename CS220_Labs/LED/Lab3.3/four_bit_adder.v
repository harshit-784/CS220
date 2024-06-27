`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:16:15 01/31/2024 
// Design Name: 
// Module Name:    four_bit_adder 
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
module four_bit_adder(x, y, z);
	input [3:0] y;
	input [3:0] x;
	output [4:0] z;
	wire [4:0] z;
	wire c0, c1, c2;

	full_adder FA0(x[0], y[0], 0, z[0], c0);
	full_adder FA1(x[1], y[1], c0, z[1], c1);
	full_adder FA2(x[2], y[2], c1, z[2], c2);
	full_adder FA3(x[3], y[3], c2, z[3], z[4]);

endmodule
