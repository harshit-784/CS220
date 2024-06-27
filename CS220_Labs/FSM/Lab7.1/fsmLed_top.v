`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:16:59 03/06/2024 
// Design Name: 
// Module Name:    fsmLed_top 
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
`define EXEC_TIME 100000000
module fsmLed_top(clk, y, ROT_A, ROT_B, next_state);

reg [31:0] counter;
input [1:0] y;
input clk;
input ROT_A, ROT_B;
output [3:0] next_state;
wire [3:0] next_state;
reg [3:0] current_state;
reg [1:0] inp;

reg rotation;
wire rotation_event;

initial begin
	counter <= 0;
	rotation <= 0;
	current_state <= 0;
end

rotatory_shaft shaft(clk, ROT_A,ROT_B, rotation_event);
fsmLed uut(clk, current_state, next_state, inp);


always @(posedge clk) begin
	counter <= counter + 1;
	if (rotation_event == 1 && rotation == 0) begin
		current_state <= next_state;
		inp <= y;
		counter <= 0;
	end
	else if (counter == `EXEC_TIME) begin
		counter <= 0;
		current_state <= next_state;
	end
	rotation <= rotation_event;
end
endmodule
