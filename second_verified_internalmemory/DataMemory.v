`ifndef __DATAMEMORY_V__
`define __DATAMEMORY_V__

module DataMemory # (
	parameter MEM_SIZE = 256,
	parameter MEM_SIZE_BIT = 8
	)	(
	input wire clk,
	input wire reset,
	input wire [31:0] Address,
	input wire [31:0] Write_data,
	input wire MemRead,
	input wire MemWrite,
	output wire [31:0] Read_data
	);

	reg [31:0] memory[0:MEM_SIZE-1];
	assign Read_data = MemRead ? memory[Address] : 32'h0;

	integer i;
	always @ (posedge reset or posedge clk)
	begin
		if (reset)
		begin
			for (i = 0; i < MEM_SIZE; i = i + 1)
			begin
				memory[i] <= 32'h0;
			end
		end
		else if (MemWrite)
		begin
			memory[Address] <= Write_data;
		end
	end

endmodule

`endif /*__DATAMEMORY_V__*/
