module Top_Module(
    input seven_seg_clk,
    input clk,
    input reset,
    input [2:0] switches,
    output wire [6:0] seven_segment,
    output wire [3:0] anode
);

// Program Counter wires
wire [31:0] pc_out, branch_address, jump_address;
wire jump, pc_src;

// Instruction Fetch wire
wire [31:0] instruction;

// Control Signals wires
wire reg_dst, branch, mem_read, mem_to_reg, alu_src, reg_write, mem_write;
wire [1:0] alu_op;

// Sign Extension wire
wire [31:0] extended_constant;

// ALU wires
wire [31:0] alu_result;
wire [3:0] alu_operation;
wire overflow, zero_flag;

// Register File wires
wire [4:0] write_reg;
wire [31:0] read_data_1, read_data_2, write_data;

// Memory wire
wire [31:0] memory_data;

// ALU Control wire
wire [5:0] function_bits;

// Seven segments register
reg [15:0] seg_in;

// Display selection based on switches
always @(*) begin 
    case(switches)
        3'b000: seg_in = instruction[15:0];
        3'b001: seg_in = instruction[31:16];
        3'b010: seg_in = pc_out[15:0];
        3'b011: seg_in = pc_out[31:16];
        3'b100: seg_in = read_data_1[15:0];
        3'b101: seg_in = read_data_2[15:0];
        3'b111: seg_in = alu_result[15:0];
        default: seg_in = 16'h0000; // Default case to handle undefined switches state
    endcase
end 

// Instantiate Seven Segment Display module
SevenSegmentDisplay uut_seven_seg(
    .clk(seven_seg_clk),
    .reset(reset),
    .data_in(seg_in), 
    .seven_segment(seven_segment),
    .anode(anode)
);

// pc_src MUX
assign pc_src = branch & zero_flag;

// branch address
assign branch_address = extended_constant;

// jump address
assign jump_address = {6'b0, instruction[25:0]};

// Instantiate Program Counter module
PC uut_PC(
    .clk(clk),
    .reset(reset),
    .jump(jump),
    .pc_src(pc_src),
    .jump_address(jump_address),
    .branch_address(branch_address), 
    .pc_out(pc_out)
);

// Instantiate Instruction Memory module
Instruction_memory uut_IM(
    .reset(reset),
    .memory_address(pc_out),
    .instruction_out(instruction)
);

// Instantiate Control Unit module
Control_unit uut_CU(
    .instruction_nibble(instruction[31:26]), // Assuming opcode is at the top 6 bits
    .reg_dst(reg_dst),
    .branch(branch),
    .mem_read(mem_read),
    .mem_to_reg(mem_to_reg),
    .alu_src(alu_src),
    .reg_write(reg_write),
    .mem_write(mem_write),
    .alu_op(alu_op),
    .jump(jump)
);

// Instantiate Sign Extension module
Sign_Extension uut_SE(
    .constant(instruction[15:0]),
    .extended_constant(extended_constant)
);

// Determine write register using reg_dst signal
assign write_reg = reg_dst ? instruction[15:11] : instruction[20:16]; 

// Instantiate Register File module
Register_File uut_RF(
    .clk(clk),
    .write(reg_write),
    .reset(reset),
    .rs_address(instruction[25:21]),
    .rt_address(instruction[20:16]),
    .rd_address(write_reg), 
    .read_data_1(read_data_1),
    .read_data_2(read_data_2),
    .write_data(write_data)
);

// Extract function bits
assign function_bits = instruction[5:0];

// Instantiate ALU Control module
ALU_Control uut_ALUC(
    .ALUOp(alu_op),
    .function_bits(function_bits), 
    .ALUOperation(alu_operation)
);

// Instantiate ALU module
ALU uut_ALU(
    .alu_operation(alu_operation),
    .operand_1(read_data_1),
    .operand_2(alu_src ? extended_constant : read_data_2), // MUX for ALUSrc
    .data_out(alu_result),
    .overflow(overflow),
    .zero_flag(zero_flag)
);
// Instantiate Data Memory module
Data_Memory uut_DM(
    .clk(clk),
    .reset(reset),
    .write_enable(mem_write),
    .read_enable(mem_read),
    .write_data(read_data_2),
    .memory_address(alu_result),
    .data_out(memory_data)
);

// Determine write data using MemtoReg signal
assign write_data = mem_to_reg ? memory_data : alu_result; // MUX for MemtoReg

endmodule
