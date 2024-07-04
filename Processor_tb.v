`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:13:19 03/25/2024
// Design Name:   Top_Module
// Module Name:   D:/NUST/SEMESTER-4/CSA Lecture/Single Cycle Proceesor/signle_cycle_processor/Processor_tb.v
// Project Name:  signle_cycle_processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Top_Module
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Processor_tb;

	// Inputs
	reg seven_seg_clk;
	reg clk;
	reg reset;
	reg [2:0] switches;

	// Outputs
	wire [6:0] seven_segment;
	wire [3:0] anode;

	// Instantiate the Unit Under Test (UUT)
	Top_Module uut (
		.seven_seg_clk(seven_seg_clk), 
		.clk(clk), 
		.reset(reset), 
		.switches(switches), 
		.seven_segment(seven_segment), 
		.anode(anode)
	);
	always #100 clk=~clk;
	always #100 seven_seg_clk=~seven_seg_clk;

	initial begin
		// Initialize Inputs
		seven_seg_clk = 0;
		clk = 1;
		reset = 1;
		switches = 0;

		// Wait 100 ns for global reset to finish
		#100;
      reset=0; 
		// Add stimulus here

	end
      
endmodule

