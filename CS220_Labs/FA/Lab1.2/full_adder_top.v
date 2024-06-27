// Verilog test fixture created from schematic /media/arush/HP USB20FD/CS220Lab/Lab1_2/full_adder_schematic/full_adder_sch.sch - Wed Jan 17 16:23:45 2024

`timescale 1ns / 1ps

module myxor(x,y,z);
	input x;
	input y;
	output z;
	wire z;
	
	assign z = (x & ~y) | (~x & y);

endmodule

module full_adder_sch_full_adder_sch_sch_tb();

// Inputs
   reg a;
   reg cin;
   reg b;

// Output
   wire sum;
   wire cout;

// Bidirs

// Instantiate the UUT
   full_adder_sch UUT (
		.sum(sum), 
		.cout(cout), 
		.a(a), 
		.cin(cin), 
		.b(b)
   );
// Initialize Inputs
   always @(sum or cout) begin
$display("time=%d: %b + %b + %b = %b, cout = %b\n", $time, a, b, cin, sum, cout);
end
initial begin
a = 0; b = 0; cin = 0;
#5
a = 0; b = 1; cin = 0;
#5
a = 1; b = 0; cin = 1;
#5
a = 1; b = 1; cin = 1;
#5
$finish;
end
endmodule
