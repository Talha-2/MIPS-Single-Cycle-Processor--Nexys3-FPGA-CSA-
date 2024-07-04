
module Control_unit(instruction_nibble,reg_dst, branch, mem_read, mem_to_reg, alu_src, reg_write,mem_write,alu_op,jump,pc_src);

input [5:0] instruction_nibble;
output reg reg_dst, branch, mem_read, mem_to_reg, alu_src, reg_write,mem_write,jump,pc_src;
output reg [1:0] alu_op;
 
 
always @(*) begin
    reg_dst = 0;
    branch = 0;
    mem_read = 0;
    mem_to_reg = 0;
    alu_src = 0;
    reg_write = 0;
	 mem_write=0;
    alu_op = 2'b00; 
	 jump=0;
	 pc_src=0;

    case (instruction_nibble)
        6'd0: begin ///R type add , sub ,mul,slt
            reg_dst = 1;
            alu_src = 0;
            mem_to_reg = 0;
            reg_write = 1;
            alu_op = 2'b10; 
        end
        6'd8:begin /// Immediate  addi,subi,muli
			reg_dst=0;
			reg_write=1;
			mem_to_reg=0;
			alu_src=1;
			alu_op = 2'b00; 
		end
		6'd35:begin ///// for lw
			reg_dst=0;
			alu_src=1;
			mem_to_reg=1;
			reg_write=1;
			alu_op = 2'b00; 
		end
		6'd43:begin ////for sw
			alu_src=1;
			mem_write=1;
			alu_op = 2'b00; 
		end  
		6'd4: begin //// for branch
			pc_src=1;
			branch=1;
			alu_op = 2'b01; 
		end
		6'd2: begin //// for jump
			jump=1;
		end
    endcase
end

endmodule