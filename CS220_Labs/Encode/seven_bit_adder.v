`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:35:31 04/01/2024 
// Design Name: 
// Module Name:    seven_bit_adder 
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
module eight_bit_adder(x, y, z);
input [7:0] x;
input [7:0] y;
output [7:0] z;
wire [7:0] z;

wire c0, c1, c2, c3, c4, c5, c6, carry;

full_adder FA0(x[0], y[0], 0, z[0], c0);
full_adder FA1(x[1], y[1], c0, z[1], c1);
full_adder FA2(x[2], y[2], c1, z[2], c2);
full_adder FA3(x[3], y[3], c2, z[3], c3);
full_adder FA4(x[4], y[4], c3, z[4], c4);
full_adder FA5(x[5], y[5], c4, z[5], c5);
full_adder FA6(x[6], y[6], c5, z[6], c6);
full_adder FA6(x[7], y[7], c6, z[7], carry);

endmodule
