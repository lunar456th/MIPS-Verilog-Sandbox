`ifndef __DATAMEMORY_V__
`define __DATAMEMORY_V__

module DataMemory # (
	parameter RAM_SIZE = 256,
	parameter RAM_SIZE_BIT = 8
	)	(
	input wire reset,
	input wire clk,
	input wire [31:0] Address,
	input wire [31:0] Write_data,
	input wire MemRead,
	input wire MemWrite,
	output wire [31:0] Read_data
	);

	reg [31:0] RAM_data[RAM_SIZE - 1: 0];
	assign Read_data = MemRead? RAM_data[Address[RAM_SIZE_BIT + 1:2]]: 32'h00000000;

	integer i;
	always @(posedge reset or posedge clk)
	begin
		if (reset)
		begin
			for (i = 0; i < RAM_SIZE; i = i + 1)
			begin
				RAM_data[i] <= 32'h00000000;
			end
		end
		else if (MemWrite)
		begin
			RAM_data[Address[RAM_SIZE_BIT + 1:2]] <= Write_data;
		end
	end

endmodule

`endif /*__DATAMEMORY_V__*/
