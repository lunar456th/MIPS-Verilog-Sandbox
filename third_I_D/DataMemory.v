`ifndef __DATAMEMORY_V__
`define __DATAMEMORY_V__

module DataMemory (
	input wire [31:0] Address,
	input wire [31:0] Write_data,
	input wire MemRead,
	input wire MemWrite,
	output wire [31:0] Read_data,

	output wire [7:0] mem_addr,
	output wire mem_read_en,
	output wire mem_write_en,
	input wire [31:0] mem_read_val,
	output wire [31:0] mem_write_val
	);

	assign mem_addr = Address;
	assign mem_read_en = MemRead;
	assign mem_write_en = MemWrite;
	assign mem_write_val = MemWrite ? Write_data : 0;
	assign Read_data = MemRead ? mem_read_val : 0;

endmodule

`endif /*__DATAMEMORY_V__*/
