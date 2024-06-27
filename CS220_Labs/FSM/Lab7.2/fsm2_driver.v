`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:29:30 03/13/2024 
// Design Name: 
// Module Name:    fsm2_driver 
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

module fsmdriver2(clk, x, buttons, lcd_rs, lcd_rw, lcd_e, lcd4, lcd5, lcd6, lcd7);
input clk;
input [2:0] x;
input [3:0] buttons;
output lcd_rs, lcd_rw, lcd_e, lcd4, lcd5, lcd6, lcd7;
wire lcd_rs, lcd_rw, lcd_e, lcd4, lcd5, lcd6, lcd7;
reg [2:0] a, b, c, d;
wire [1:0] min_pos;

reg [7:0] code[7:0]; 
initial begin
	code[0] = 8'd48;
	code[1] = 8'd49;
	code[2] = 8'd50;
	code[3] = 8'd51;
	code[4] = 8'd52;
	code[5] = 8'd53;
	code[6] = 8'd54;
	code[7] = 8'd55;
end
reg [0:127] first_line;
reg [0:127] second_line;

always@(posedge buttons[0]) begin
	a <= x;
end
always@(posedge buttons[1]) begin
	b <= x;
end
always@(posedge buttons[2]) begin
	c <= x;
end
always@(posedge buttons[3]) begin
	d <= x;
end
output_processor proc(a, b, c, d, min_pos);

always@(posedge clk) begin
	first_line <= {code[a], 8'd44, 8'd32, code[b], 8'd44, 8'd32, code[c], 8'd44, 8'd32, code[d], 48'd0};
	if(min_pos == 0) begin
		second_line <= {code[0], 120'd0};
	end
	else if(min_pos == 1) begin
		second_line <= {code[1], 120'd0};
	end
	else if(min_pos == 2) begin
		second_line <= {code[2], 120'd0};
	end
	else begin
		second_line <= {code[3], 120'd0};
	end
end

fsm_lcd LCD(clk, first_line, second_line, lcd_rs, lcd_rw, lcd_e, lcd4, lcd5, lcd6, lcd7);

endmodule