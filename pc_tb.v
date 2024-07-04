`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:36:47 03/27/2024
// Design Name:   PC
// Module Name:   D:/Processor/Processor/pc_tb.v
// Project Name:  Processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: PC
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module pc_tb;

	// Inputs
	reg clk;
	reg reset;
	reg jump;
	reg pc_src;
	reg [31:0] jump_address;
	reg [31:0] branch_address;

	// Outputs
	wire [31:0] pc_out;

	// Instantiate the Unit Under Test (UUT)
	PC uut (
		.clk(clk), 
		.reset(reset), 
		.jump(jump), 
		.pc_src(pc_src), 
		.jump_address(jump_address), 
		.branch_address(branch_address), 
		.pc_out(pc_out)
	);
	always #100 clk=~clk;
	initial begin
		// Initialize Inputs
		clk = 1;
		reset = 1;
		jump = 0;
		pc_src = 0;
		jump_address = 0;
		branch_address = 0;

		// Wait 100 ns for global reset to finish
		#100;
		reset=0;
		
        
		// Add stimulus here

	end
      
endmodule

