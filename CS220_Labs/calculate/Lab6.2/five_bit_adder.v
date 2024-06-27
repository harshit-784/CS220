`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:27:38 03/06/2024 
// Design Name: 
// Module Name:    five_bit_adder 
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
module five_bit_adder(clk, ROT_A, ROT_B, i, x, y);

input [3:0] i;
input clk;
input ROT_A,ROT_B;

wire rotation_event;
reg rotation;

output [3:0] x;
output [3:0] y;

reg [3:0] x;
reg [3:0] y;

wire [4:0] tempx;
wire [4:0] tempy;
wire c0, c1, c2, c3, c4;
wire d0, d1, d2, d3, d4;

initial begin
	x <= 4'b0000;
	y <= 4'b0000;
	rotation <= 0;
end

always@(posedge clk) begin
	if(rotation_event == 1 && rotation == 0) begin
		if (tempx[4] == 1 && i[2] == 0) begin
			x[0] <= 1;
			x[1] <= 1;
			x[2] <= 1;
			x[3] <= 1;
		end
		else if (tempx[4] == 1 && i[2] == 1) begin
			x[0] <= 0;
			x[1] <= 0;
			x[2] <= 0;
			x[3] <= 0;
		end
		else begin
			x[0] <= tempx[0];
			x[1] <= tempx[1];
			x[2] <= tempx[2];
			x[3] <= tempx[3];
		end
		
		if (tempy[4] == 1 && i[2] == 0) begin
			y[0] <= 1;
			y[1] <= 1;
			y[2] <= 1;
			y[3] <= 1;
		end
		else if (tempy[4] == 1 && i[2] == 1) begin
			y[0] <= 0;
			y[1] <= 0;
			y[2] <= 0;
			y[3] <= 0;
		end
		else begin
			y[0] <= tempy[0];
			y[1] <= tempy[1];
			y[2] <= tempy[2];
			y[3] <= tempy[3];
		end
	end
	rotation <= rotation_event;
end 


rotatory_shaft shaft1(clk, ROT_A,ROT_B,rotation_event);
full_adder FAx0(x[0], (i[0]&~i[3])^i[2], i[2], tempx[0], c0);
full_adder FAx1(x[1], (i[1]&~i[3])^i[2], c0, tempx[1], c1);
full_adder FAx2(x[2], 0^i[2], c1, tempx[2], c2);
full_adder FAx3(x[3], 0^i[2], c2, tempx[3], c3);
full_adder FAx4(0, 0^i[2], c3, tempx[4], c4);

full_adder FAy0(y[0], (i[0]&i[3])^i[2], i[2], tempy[0], d0);
full_adder FAy1(y[1], (i[1]&i[3])^i[2], d0, tempy[1], d1);
full_adder FAy2(y[2], 0^i[2], d1, tempy[2], d2);
full_adder FAy3(y[3], 0^i[2], d2, tempy[3], d3);
full_adder FAy4(0, 0^i[2], d3, tempy[4], d4);

endmodule
