`ifndef __DATAMEMORY_V__
`define __DATAMEMORY_V__

module DataMemory (
	input wire [31:0] Address,
	input wire [31:0] Write_data,
	input wire MemRead,
	input wire MemWrite,
	output reg [31:0] Read_data,

	output reg [7:0] mem_addr,
	output reg mem_read_en,
	output reg mem_write_en,
	input wire [31:0] mem_read_val,
	output reg [31:0] mem_write_val
	);

	always @ (Address or MemRead or MemWrite or Write_data)
	begin
		if (MemRead)
		begin
			mem_addr <= Address;
			mem_read_en <= 1'b1;
		end

		if (MemWrite)
		begin
			mem_addr <= Address;
			mem_write_en <= 1'b1;
			mem_write_val <= Write_data;
		end
	end

	always @ (mem_read_val)
	begin
		Read_data <= mem_read_val;
	end

endmodule

`endif /*__DATAMEMORY_V__*/
