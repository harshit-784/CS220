`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:42:31 01/31/2024 
// Design Name: 
// Module Name:    adder_pro_max 
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
module adder_pro_max(pb0, pb1, pb2, pb3, pb4, y, z);
	input pb0, pb1, pb2, pb3, pb4;
	input [3:0] y;
	output [6:0] z;
	wire [6:0] z;
	
	reg [3:0] a;
	reg [3:0] b;
	reg [3:0] c;
	reg [3:0] d;
	reg [3:0] e;
	wire [4:0] f;
	wire [4:0] g;
	wire [5:0] h;
	always @(posedge pb0) begin
		a <= y;
	end
	always @(posedge pb1) begin
		b <= y;
	end
	always @(posedge pb2) begin
		c <= y;
	end
	always @(posedge pb3) begin
		d <= y;
	end
	always @(posedge pb4) begin
		e <= y;
	end
	four_bit_adder FOUR1(a, b, f);
	four_bit_adder FOUR2(c, d, g);
	five_bit_adder FIVE(f, g, h);
	six_bit_adder SIX(h, e, z);
endmodule
