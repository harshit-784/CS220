`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:42:09 03/20/2024 
// Design Name: 
// Module Name:    lcd 
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
module lcd(first_line, second_line, display_start, clk, LCD_RS, LCD_W, LCD_E, data0, data1, data2, data3, display_end
    );

   input display_start, clk;
   input [0:127] first_line;
	input [0:127] second_line;
	output reg LCD_RS, LCD_W, LCD_E, data0, data1, data2, data3, display_end;

	reg [7:0] index1;
	reg [7:0] index2;
	reg [1:0] state1;
	reg [1:0] state2;
	reg [2:0] next_state;
	reg [2:0] line_break_state;
	reg [31:0] counter;
	reg [5:0] ROM [0:13];
	reg [3:0] ROM_index;
	 
	// Initialization code
	initial begin
	   index1 = 0;
		index2 = 0;
		state1 = 3;
		state2 = 3;
		counter = 1000000;
		next_state = 0;
		line_break_state = 7;
		display_end = 0;
	end
	initial begin
		ROM_index = 0;
		ROM[0] = 6'h03;
		ROM[1] = 6'h03;
		ROM[2] = 6'h03;
		ROM[3] = 6'h02;
		ROM[4] = 6'h02;
		ROM[5] = 6'h08;
		ROM[6] = 6'h00;
		ROM[7] = 6'h06;
		ROM[8] = 6'h00;
		ROM[9] = 6'h0c;
		ROM[10] = 6'h00;
		ROM[11] = 6'h01;
		ROM[12] = 6'h08;
		ROM[13] = 6'h00;
	end
	
	always @(posedge clk) begin
	   if (display_start == 0) begin
			index1 <= 0;
			index2 <= 0;
			state1 <= 3;
			state2 <= 3;
			counter <= 1000000;
			next_state <= 0;
			line_break_state <= 7;
			display_end <= 0;
			ROM_index <= 0;
		end
		
		else if (display_start == 1) begin
			if (counter == 0) begin
				counter <= 1000000;
	
				// Initialization
				if (ROM_index == 14) begin
					next_state <= 4;
					ROM_index <= 0;
					state1 <= 0;
				end
					
				if ((next_state != 4) && (ROM_index != 14)) begin
					case (next_state)
						0: begin
							LCD_E <= 0;
							next_state <= 1;
							end
				
						1: begin
							{LCD_RS, LCD_W, data3, data2, data1, data0} <= ROM[ROM_index];
							next_state <= 2;
							end
				
						2: begin
							LCD_E <= 1;
							next_state <= 3;
							end
						
						3: begin
							LCD_E <= 0;
							next_state <= 1;
							ROM_index <= ROM_index + 1;
							end
					endcase
				end
	
				// First line
				if (index1 == 128) begin
					state1 <= 3;
					index1 <= 0;
					line_break_state <= 0;
				end
				if ((state1 != 3) && (index1 != 128)) begin
					case (state1)
					0: begin
						{LCD_RS, LCD_W} <= 2'h2;
						data3 <= first_line[index1];
 						data2 <= first_line[index1+1];
						data1 <= first_line[index1+2];
						data0 <= first_line[index1+3];
						state1 <= 1;
						end
				
					1: begin
						LCD_E <= 1;
						state1 <= 2;
						end
			
					2: begin
						LCD_E <= 0;
						state1 <= 0;
						index1 <= index1+4;
						end
					endcase
				end
			
				// Line break 
				if (line_break_state != 7) begin
					case (line_break_state)
					0: begin
						{LCD_RS, LCD_W, data3, data2, data1, data0} <= 6'h0c;
						line_break_state <= 1;
						end
					
					1: begin
						LCD_E <= 1;
						line_break_state <= 2;
						end
					
					2: begin
						LCD_E <= 0;
						line_break_state <= 3;
						end
					
					3: begin
						{LCD_RS, LCD_W, data3, data2, data1, data0} <= 6'h00;
						line_break_state <= 4;
						end
					
					4: begin
						LCD_E <= 1;
						line_break_state <= 5;
						end
					
					5: begin
						LCD_E <= 0;
						line_break_state <= 7;
						state2 <= 0;
						end
					endcase
				end
	
		      // Second line 
				if (index2 == 128) begin
					state2 <= 3;
					index2 <= 0;
					display_end <= 1;
				end
				if ((state2 != 3) && (index2 != 128)) begin
					case (state2)
					0: begin
						{LCD_RS, LCD_W} <= 2'h2;
						data3 <= second_line[index2];
 						data2 <= second_line[index2+1];
						data1 <= second_line[index2+2];
						data0 <= second_line[index2+3];
						state2 <= 1;
						end
			
					1: begin
						LCD_E <= 1;
						state2 <= 2;
						end
			
					2: begin
						LCD_E <= 0;
						state2 <= 0;
						index2 <= index2+4;
						end
					endcase
				end
			end
			else begin 
				counter <= counter - 1;
			end
		end
	end

endmodule