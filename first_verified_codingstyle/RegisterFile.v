`ifndef __REGISTERFILE_V__
`define __REGISTERFILE_V__

module RegisterFile (
	input wire reset,
	input wire clk,
	input wire RegWrite,
	input wire [4:0] Read_register1,
	input wire [4:0] Read_register2,
	input wire [4:0] Write_register,
	input wire [31:0] Write_data,
	output wire [31:0] Read_data1,
	output wire [31:0] Read_data2
	);

	reg [31:0] RF_data[31:1];

	assign Read_data1 = Read_register1 == 5'b00000 ? 32'h00000000 : RF_data[Read_register1];
	assign Read_data2 = Read_register2 == 5'b00000 ? 32'h00000000 : RF_data[Read_register2];

	integer i;
	always @ (posedge reset or posedge clk)
	begin
		if (reset)
		begin
			for (i = 1; i < 32; i = i + 1)
			begin
				RF_data[i] <= 32'h00000000;
			end
		end
		else if (RegWrite && (Write_register != 5'b00000))
		begin
			RF_data[Write_register] <= Write_data;
		end
	end

endmodule

`endif /*__REGISTERFILE_V__*/
