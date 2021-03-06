`ifndef __MEMORYCONTROLLER_I_V__
`define __MEMORYCONTROLLER_I_V__

`include "ExternalMemory_I.v"

module MemoryController_I # (
	parameter MEM_WIDTH = 32,
	parameter MEM_SIZE = 256
	)	(
	input wire [$clog2(MEM_SIZE)-1:0] mem_addr,
	input wire mem_read_en,
	input wire mem_write_en,
	output wire [MEM_WIDTH-1:0] mem_read_val,
	input wire [MEM_WIDTH-1:0] mem_write_val
	);

	ExternalMemory_I # (
		.MEM_WIDTH(MEM_WIDTH),
		.MEM_SIZE(MEM_SIZE)
	) _ExternalMemory_I (
		.mem_addr(mem_addr),
		.mem_read_en(mem_read_en),
		.mem_write_en(mem_write_en),
		.mem_read_val(mem_read_val),
		.mem_write_val(mem_write_val)
	);

endmodule

`endif /*__MEMORYCONTROLLER_I_V__*/