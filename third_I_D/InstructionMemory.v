`ifndef __INSTRUCTIONMEMORY_V__
`define __INSTRUCTIONMEMORY_V__

module InstructionMemory (
	input wire [31:0] Address,
	output wire [31:0] Instruction,

	output wire [7:0] mem_addr,
	output wire mem_read_en,
	input wire [31:0] mem_read_val
	);

	assign mem_addr = Address;
	assign mem_read_en = 1'b1;
	assign Instruction = mem_read_val;

endmodule

`endif /*__INSTRUCTIONMEMORY_V__*/
