`ifndef __REGISTERFILE_V__
`define __REGISTERFILE_V__

module RegisterFile (
	input wire clk,
	input wire reset,
	input wire RegWrite,
	input wire [4:0] Read_register1,
	input wire [4:0] Read_register2,
	input wire [4:0] Write_register,
	input wire [31:0] Write_data,
	output wire [31:0] Read_data1,
	output wire [31:0] Read_data2
	);

	reg [31:0] register[1:31];

	assign Read_data1 = Read_register1 == 5'b00000 ? 32'h0 : register[Read_register1];
	assign Read_data2 = Read_register2 == 5'b00000 ? 32'h0 : register[Read_register2];

	integer i;
	always @ (posedge clk or posedge reset)
	begin
		if (reset)
		begin
			for (i = 1; i < 32; i = i + 1)
			begin
				register[i] <= 32'h0;
			end
		end
		else if (RegWrite && (Write_register != 5'b0))
		begin
			register[Write_register] <= Write_data;
		end
	end

endmodule

`endif /*__REGISTERFILE_V__*/
