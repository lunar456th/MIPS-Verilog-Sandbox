`ifndef __MEMORYSELECTOR_V__
`define __MEMORYSELECTOR_V__

module MemorySelector (
	input wire clk,

	input wire [7:0] mem_addr_instr,
	input wire mem_read_en_instr,
	output wire [31:0] mem_read_val_instr,

	input wire [7:0] mem_addr_data,
	input wire mem_read_en_data,
	input wire mem_write_en_data,
	output wire [31:0] mem_read_val_data,
	input wire [31:0] mem_write_val_data,

	output wire [7:0] mem_addr,
	output wire mem_read_en,
	output wire mem_write_en,
	input wire [31:0] mem_read_val,
	output wire [31:0] mem_write_val
	);

	assign mem_addr = clk ? mem_addr_instr : mem_addr_data;
	assign mem_read_en = clk ? mem_read_en_instr : mem_read_en_data;
	assign mem_write_en = mem_write_en_data;
	assign mem_write_val = mem_write_val_data;
	assign mem_read_val_instr = clk ? mem_read_val : 0;
	assign mem_read_val_data = !clk ? mem_read_val : 0;

endmodule

`endif /*__MEMORYSELECTOR_V__*/
