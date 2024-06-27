`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:15:08 01/29/2024 
// Design Name: 
// Module Name:    comparator 
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
module comparator(a, b, lin, ein, gin, lout, eout, gout);
input a, b, lin, ein, gin;
output lout, eout, gout;
wire lout, eout, gout;

assign gout = gin | (ein & (~lin) & a & (~b) & (~gin));
assign lout = lin | (ein & (~gin) & (~a) & b & (~lin));
assign eout = ein & (~gin) & (~lin) & (((~a) & (~b)) | (a & b));

endmodule