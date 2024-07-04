module Data_Memory#(parameter N=32)(clk, reset,write_enable,read_enable,write_data,memory_address,data_out);

input clk,reset,write_enable,read_enable;
input [N-1:0] write_data;
input[N-1:0] memory_address;
output reg [N-1:0] data_out;

reg [N-1:0] memory[0:N-1];


always @(posedge clk)
begin
    
   if(write_enable)
	memory[memory_address]<=write_data;

end

always@ (*)
begin 
if(reset)
	  data_out<=0;
else if(read_enable)
	data_out<=memory[memory_address];

end

endmodule
