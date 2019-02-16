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

	reg curr = 0;

	always @ (posedge clk)
	begin
		curr = ~curr;
	end

	reg [7:0] mem_addr_data_r = 0;
	reg mem_read_en_data_r = 0;
	reg mem_write_en_data_r = 0;
	reg [31:0] mem_write_val_data_r = 0;
	
	always @ (mem_addr_data)
	begin
		mem_addr_data_r <= mem_addr_data;
	end

	always @ (mem_read_en_data)
	begin
		mem_read_en_data_r <= mem_read_en_data;
	end

	always @ (mem_write_en_data)
	begin
		mem_write_en_data_r <= mem_write_en_data;
	end

	always @ (mem_write_val_data)
	begin
		mem_write_val_data_r <= mem_write_val_data;
	end

	assign mem_addr = (curr == 1) ? mem_addr_instr : mem_addr_data_r;
	assign mem_read_en = (curr == 1) ? mem_read_en_instr : mem_read_en_data_r;
	assign mem_write_en = (curr == 1) ? 0 : mem_write_en_data_r;
	assign mem_write_val = (curr == 1) ? 0 : mem_write_val_data_r;
	assign mem_read_val_instr = (curr == 1) ? mem_read_val : 0;
	assign mem_read_val_data = (curr == 1) ? 0 : mem_read_val;

endmodule

`endif /*__MEMORYSELECTOR_V__*/
