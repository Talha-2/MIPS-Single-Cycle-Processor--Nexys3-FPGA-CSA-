`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:12:40 03/19/2024 
// Design Name: 
// Module Name:    seven_segment 
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
module SevenSegmentDisplay(
    input wire clk,
    input wire reset,
    input wire [15:0] data_in,
    output reg [6:0] seven_segment,
    output reg [3:0] anode
);
parameter zero = 7'b0000001, one = 7'b1001111, two = 7'b0010010,
          three = 7'b0000110, four = 7'b1001100, five = 7'b0100100,
          six = 7'b0100000, seven = 7'b0001111, eight = 7'b0000000,
          nine = 7'b0000100, A = 7'b0001000, B = 7'b1100000,
          C = 7'b0110001, D = 7'b1000010, E = 7'b0110000, F = 7'b0111000;
			 
parameter N = 19;
reg [N-1:0] q_reg = 0; // Time multiplexing counter

always @(posedge clk or posedge reset) begin
    if (reset)
        q_reg <= 0;
    else 
        q_reg <= q_reg + 1;
end

always @(posedge clk) begin
    case(q_reg[N-1:N-2])
        2'b00: begin
            seven_segment = decode(data_in[3:0]);
            anode = 4'b1110;
        end
        2'b01: begin
            seven_segment = decode(data_in[7:4]);
            anode = 4'b1101;
        end
        2'b10: begin
            seven_segment = decode(data_in[11:8]);
            anode = 4'b1011;
        end
        2'b11: begin
            seven_segment = decode(data_in[15:12]);
            anode = 4'b0111;
        end
    endcase
end

function [6:0] decode(input [3:0] nibble);
    case (nibble)
        4'h0: decode = zero;
        4'h1: decode = one;
        4'h2: decode = two;
        4'h3: decode = three;
        4'h4: decode = four;
        4'h5: decode = five;
        4'h6: decode = six;
        4'h7: decode = seven;
        4'h8: decode = eight;
        4'h9: decode = nine;
        4'hA: decode = A;
        4'hB: decode = B;
        4'hC: decode = C;
        4'hD: decode = D;
        4'hE: decode = E;
        4'hF: decode = F;
        default: decode = 7'b1111111; // Off state for undefined values
    endcase
endfunction

endmodule
