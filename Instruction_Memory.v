module Instruction_memory #(parameter N=32)(reset,memory_address,instruction_out);
input reset;
input[N-1:0] memory_address;
output reg [N-1:0] instruction_out;

reg [N-1:0] instruction_memory [0:N-1];

 (* RAM_STYLE="BLOCK " *)
initial
begin
     // $readmemb("Instruction_mem.txt", instruction_memory);
		instruction_memory[0]=32'b000000_01001_01010_01000_00000_100000;    //ADD $t0, $t1, $t2
		instruction_memory[1]=32'b000000_01011_01100_01101_00000_100010;    //SUB $t3, $t4, $t5
		instruction_memory[2]=32'b000000_01111_10000_01110_00000_100100;   //MUL $t6, $t7, $t8
		instruction_memory[3]=32'b001000_01001_01000_00000_00000_001010;   //addi $t0, $t1, 10
		instruction_memory[4]=32'b000000_01001_01010_01000_00000_101010;   //slt $rd, $rs, $rt
		instruction_memory[5]=32'b000000_10001_10010_10000_00000_100100;    //AND $s0, $s1, $s2
		instruction_memory[6]=32'b000000_10011_10100_10101_00000_100101;    //OR $s3, $s4, $s5
		instruction_memory[7]=32'b001000_01001_01000_00000_00000_000010;   //addi $t0, $t1, 10
		instruction_memory[8]=32'b100011_01001_01000_00000_00000_000000;    //LW $t0, 0($t1)
		instruction_memory[9]=32'b101011_01101_01010_00000_00000_000100;    //SW $t2, 4($t3)end	instruction_memory[4]=32'b
		instruction_memory[10]=32'b000100_01110_01111_00000_00000_000000;    //BEQ $t4, $t5, label 
		instruction_memory[11]=32'b000010_00000_00000_00000_00000_000010;    //J target
end
always @(*) begin
    if (reset)
        instruction_out <= 0;
    else
        instruction_out <= instruction_memory[memory_address];
end

endmodule