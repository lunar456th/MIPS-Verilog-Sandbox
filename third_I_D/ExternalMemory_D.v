`ifndef __EXTERNALMEMORY_D_V__
`define __EXTERNALMEMORY_D_V__

module ExternalMemory_D # (
	parameter MEM_WIDTH = 32,
	parameter MEM_SIZE = 256
	)	(
	input wire [$clog2(MEM_SIZE)-1:0] mem_addr,
	input wire mem_read_en,
	input wire mem_write_en,
	output reg [MEM_WIDTH-1:0] mem_read_val,
	input wire [MEM_WIDTH-1:0] mem_write_val
	);

	reg [MEM_WIDTH-1:0] memory[0:MEM_SIZE-1];

	integer i;

	initial
	begin
		memory[0] <= 32'h0000_0001; //0
		memory[1] <= 32'h0000_0000; //1
		memory[2] <= 32'h0000_0000; //2
		memory[3] <= 32'h0000_0000; //3
		memory[4] <= 32'h0000_0001; //4
		memory[5] <= 32'h0000_0000; //5
		memory[6] <= 32'h0000_0000; //6
		memory[7] <= 32'h0000_0000; //7
		memory[8] <= 32'h0000_0001; //8
		memory[9] <= 32'h0000_0000; //9
		memory[10] <= 32'h0000_0000; //10
		memory[11] <= 32'h0000_0001; //11
		memory[12] <= 32'h0000_0000; //12
		memory[13] <= 32'h0000_0000; //13
		memory[14] <= 32'h0000_0000; //14
		memory[15] <= 32'h0000_0001; //15
		for (i = 16; i < 256; i = i + 1)
		begin
			memory[i] <= 32'h0;
		end

		mem_read_val <= 32'b0;
	end

	always @ (mem_addr or mem_read_en or mem_write_en or mem_write_val)
	begin
		if (mem_read_en)
		begin
			mem_read_val <= memory[mem_addr];
		end

		if (mem_write_en)
		begin
			memory[mem_addr] <= mem_write_val;
		end
	end

endmodule

`endif /*__EXTERNALMEMORY_D_V__*/
