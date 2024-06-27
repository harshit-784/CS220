`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:47:54 03/06/2024 
// Design Name: 
// Module Name:    fsmLed 
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
module fsmLed(enable, current_state, next_state, y);
input enable;
input [1:0] y;
input [3:0] current_state;
output [3:0] next_state;
reg [3:0] next_state;

reg [2:0] microcode [0:12];
reg [3:0] drom3 [0:3];
reg [3:0] drom10 [0:3];

initial begin
	microcode[0] <= 3'b000;
	microcode[1] <= 3'b000;
	microcode[2] <= 3'b000;
	microcode[3] <= 3'b001;//S3 DROM
	microcode[4] <= 3'b011;//S7
	microcode[5] <= 3'b011;//S7
	microcode[6] <= 3'b000;
	microcode[7] <= 3'b000;
	microcode[8] <= 3'b000;
	microcode[9] <= 3'b000;
	microcode[10] <= 3'b010;//S10 ROM
	microcode[11] <= 3'b100;//S0
	microcode[12] <= 3'b100;//S0
	
	
	drom3[0] <= 4'b0100;
	drom3[1] <= 4'b0101;
	drom3[2] <= 4'b0110;
	drom3[3] <= 4'b0110;
	
	
	drom10[0] <= 4'b1011;
	drom10[1] <= 4'b1100;
	drom10[2] <= 4'b1100;
	drom10[3] <= 4'b1100;
end

always @(posedge enable) begin
	case(microcode[current_state])
		3'b000: next_state <= current_state + 1;
		3'b001: next_state <= drom3[y];
		3'b010: next_state <= drom10[y];
		3'b011: next_state <= 4'b0111;
		3'b100: next_state <= 4'b0000;
	endcase
end

endmodule
