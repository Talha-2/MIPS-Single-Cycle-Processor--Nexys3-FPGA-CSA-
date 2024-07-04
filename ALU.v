module ALU(
    input clk,reset,
    input [3:0] alu_operation,
    input [31:0] operand_1,
    input [31:0] operand_2,
    output reg [31:0] data_out,
	 output reg overflow,
	 output reg zero_flag
);
	 
// ALU operations
  always @(*) begin
	 overflow = 0; 
	 zero_flag=0;
        case(alu_operation)
            4'b0010: begin 
                data_out = operand_1 + operand_2;
				if(operand_1[31]==1 && operand_2[31])
				begin
				overflow=1;
				end
            end
            4'b0110: begin 
                data_out = operand_1 - operand_2;
					 if(!data_out)
						zero_flag=1;
            end
            4'b0010: begin 
                data_out = operand_1 * operand_2;            
            end
            4'b0011: begin 
                data_out = ~operand_1;
            end
            default: data_out = 32'b0; 
        endcase
		
    end
endmodule