`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:02:10 04/01/2024 
// Design Name: 
// Module Name:    topi 
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
module topi(leds,clk,pb);

input clk,pb;
output [7:0] leds;
reg [7:0] leds;
reg [15:0] memory [0:7];
reg [2:0] counter;
wire [7:0] value;
reg flag;
reg disp_flag;
reg parity;
reg [7:0] sum;
reg [15:0] tempu;

initial begin
	disp_flag <= 0;
	sum <= 8'b00000000;
	flag <= 0;
	tempu <= 16'b0000000000000000;
	counter <= 3'b000;
	memory[0] <= 16'b0000000000000000;
	memory[1] <= 16'b1000100000000000;
	memory[2] <= 16'b0000000100000000;
	memory[3] <= 16'b1000000000000000;
	memory[4] <= 16'b0000000000000001;
	memory[5] <= 16'b0000100000000000;
	memory[6] <= 16'b1000000100010000;
	memory[7] <= 16'b0000000010000000;
end

always@(posedge clk) begin
	if (flag == 0) begin
		if (counter == 3'b111) begin
			flag = 1;
		end
		else begin
			tempu = memory[counter];
			counter = counter + 1;
		end
	end
	sum = sum + value
end

always@(posedge pb) begin
	if(disp_flag == 1) begin
		parity <= sum[0]^sum[1]^sum[2]^sum[3]^sum[4]^sum[5]^sum[6]^sum[7];
		leds[0] <= parity;
		leds[1] <= 0;
		leds[2] <= 0;
		leds[3] <= 0;
		leds[4] <= 0;
		leds[5] <= 0;
		leds[6] <= 0;
		leds[7] <= 0;
		disp_flag <= 0;
	end
	else begin
		leds <= sum;
		disp_flag <= 1;
	end
end


//eight_bit_adder add(sum, value, temp);
encoder uut(clk, tempu, value);
endmodule
