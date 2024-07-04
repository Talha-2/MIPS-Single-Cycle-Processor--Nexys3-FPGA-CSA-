`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:42:38 03/25/2024 
// Design Name: 
// Module Name:    Sign_Extension 
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

module Sign_Extension(constant,extended_constant);

input[15:0] constant;
output [31:0] extended_constant;

assign extended_constant = {{16{constant[15]}}, constant};

endmodule
