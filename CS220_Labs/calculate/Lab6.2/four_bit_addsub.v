`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:15:13 03/06/2024 
// Design Name: 
// Module Name:    four_bit_addsub 
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
module four_bit_addsub(clk, ROT_A, ROT_B, x, z, overflow);
//cin is 1 for subtraction and 0 for addition
input [3:0] i;
input clk;
input ROT_A,ROT_B;

wire rotation_event;
wire carry;

output overflow;
wire overflow;
output [6:0] z;
wire [6:0] z;

reg [4:0] temp;
wire c0, c1, c2, c3, c4, c5;
reg counter;

initial begin
	a <= 6'b000000;
	b <= 6'b000000;
	counter <= 3'b000;
	rotation <= 1'b0;
	cin <= 0;
end

always@(posedge clk) begin
	if(rotation_event == 1) begin
		
	end
end 

assign overflow = carry^c5;

rotatory_shaft shaft1(clk, ROT_A,ROT_B,rotation_event);
full_adder FA0(a[0], b[0]^cin, cin, z[0], c0);
full_adder FA1(a[1], b[1]^cin, c0, z[1], c1);
full_adder FA2(a[2], b[2]^cin, c1, z[2], c2);
full_adder FA3(a[3], b[3]^cin, c2, z[3], c3);
full_adder FA4(a[4], b[4]^cin, c3, z[4], c4);
full_adder FA5(a[5], b[5]^cin, c4, z[5], c5);
full_adder FA6(a[6], b[6]^cin, c5, z[6], carry);


endmodule
