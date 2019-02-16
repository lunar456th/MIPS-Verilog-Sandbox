`ifndef __INSTRUCTIONMEMORY_V__
`define __INSTRUCTIONMEMORY_V__

module InstructionMemory # (
	parameter MEM_WIDTH = 32,
	parameter MEM_SIZE = 256
	)	(
	input wire [31:0] Address,
	output wire [31:0] Instruction,

	output wire [$clog2(MEM_SIZE)-1:0] mem_addr,
	output wire mem_read_en,
	input wire [MEM_WIDTH-1:0] mem_read_val
	);

	assign mem_addr = Address;
	assign mem_read_en = 1'b1;
	assign Instruction = mem_read_val;

endmodule

`endif /*__INSTRUCTIONMEMORY_V__*/
