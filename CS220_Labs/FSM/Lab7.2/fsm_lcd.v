`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:25:23 03/13/2024 
// Design Name: 
// Module Name:    fsm_lcd 
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
`define EXEC_TIME 1000000000

module fsm_lcd(clk, stringA, stringB, LCD_RS, LCD_W, LCD_E,lcd0, lcd1, lcd2, lcd3);

	input [0:127] stringA;
	input [0:127] stringB;
	input clk;
	output LCD_RS, LCD_W, LCD_E, lcd0, lcd1, lcd2, lcd3;
	reg LCD_RS, LCD_W, LCD_E, lcd0, lcd1, lcd2, lcd3;

	reg [7:0] stringA_index = 0;
	reg [1:0] stringA_state = 3;
	 
	reg [7:0] stringB_index = 0;
	reg [1:0] stringB_state = 3;
	 
	reg [19:0] counter = 0;
	reg [2:0] global_state = 0;
	 
	reg [2:0] line_break_state = 7;
	 
	reg [5:0] configu [0:13];
	reg [3:0] configu_index = 0;
	 
	// Initialization code
	initial begin
		configu[0] = 6'h03;
		configu[1] = 6'h03;
		configu[2] = 6'h03;
		configu[3] = 6'h02;
		configu[4] = 6'h02;
		configu[5] = 6'h08;
		configu[6] = 6'h00;
		configu[7] = 6'h06;
		configu[8] = 6'h00;
		configu[9] = 6'h0c;
		configu[10] = 6'h00;
		configu[11] = 6'h01;
		configu[12] = 6'h08;
		configu[13] = 6'h00;
	end
	
	always @ (posedge clk) begin
	   	if (counter == `EXEC_TIME) begin
		   	counter <= 0;
			if (configu_index == 14) begin
				global_state <= 4;
				configu_index <= 0;
				stringA_state <= 0;
			end
					
			if ((global_state != 4) && (configu_index != 14)) begin
			  	case (global_state)
			    		0: begin
						LCD_E <= 0;
						global_state <= 1;
               		    		end
					
                            		1: begin
						{LCD_RS, LCD_W, lcd3, lcd2, lcd1, lcd0} <= configu[configu_index];
						global_state <= 2;
			    		end
					
			    		2: begin
						LCD_E <= 1;
						global_state <= 3;
			    		end
					
			    		3: begin
						LCD_E <= 0;
						global_state <= 1;
						configu_index <= configu_index + 1;
			    		end
			  	endcase
			end
	
			if (stringA_index == 128) begin
				stringA_state <= 3;
				stringA_index <= 0;
				line_break_state <= 0;
			end
			if ((stringA_state != 3) && (stringA_index != 128)) begin
				case (stringA_state)
					0: begin
						{LCD_RS, LCD_W, lcd3, lcd2, lcd1, lcd0} <= {2'h2,stringA[stringA_index],stringA[stringA_index+1],stringA[stringA_index+2],stringA[stringA_index+3]};
						stringA_state <= 1;
					end
						
					1: begin
						LCD_E <= 1;
						stringA_state <= 2;
					end
					
					2: begin
						LCD_E <= 0;
						stringA_state <= 0;
						stringA_index <= stringA_index+4;
					end
				endcase
			end
			
			if (line_break_state != 7) begin
				case (line_break_state)
					0: begin
						{LCD_RS, LCD_W, lcd3, lcd2, lcd1, lcd0} <= 6'h0c;
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
						{LCD_RS, LCD_W, lcd3, lcd2, lcd1, lcd0} <= 6'h00;
						line_break_state <= 4;
					end
						
					4: begin
						LCD_E <= 1;
						line_break_state <= 5;
					end
						
					5: begin
						LCD_E <= 0;
						line_break_state <= 7;
						stringB_state <= 0;
					end
				endcase
			end
			
			if (stringB_index == 128) begin
				stringB_state <= 3;
				stringB_index <= 0;
			end
			if ((stringB_state != 3) && (stringB_index != 128)) begin
				case (stringB_state)
					0: begin
						{LCD_RS, LCD_W, lcd3, lcd2, lcd1, lcd0} <= {2'h2,stringB[stringB_index],stringB[stringB_index+1],stringB[stringB_index+2],stringB[stringB_index+3]};
						stringB_state <= 1;
					end
						
					1: begin
						LCD_E <= 1;
						stringB_state <= 2;
					end
					
					2: begin
						LCD_E <= 0;
						stringB_state <= 0;
						stringB_index <= stringB_index+4;
					end
				endcase
			end
		end
		else 
		begin 
		   	counter <= counter + 1;
		end
	end
endmodule


