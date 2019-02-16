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
	output reg [31:0] Read_data1,
	output reg [31:0] Read_data2
	);

	reg [31:0] register[1:31]; /// as $0 keeps the value 0.
	integer i;

	initial
	begin
		for (i = 0; i < 32; i = i + 1)
		begin
			register[i] <= 32'h0;
		end
	end

	always @ (Read_register1)
	begin
		if (Read_register1 != 5'b00000)
		begin
			Read_data1 <= register[Read_register1];
		end
		else
		begin
			Read_data1 <= 32'h0;
		end
	end

	always @ (Read_register2)
	begin
		if (Read_register2 != 5'b00000)
		begin
			Read_data2 <= register[Read_register2];
		end
		else
		begin
			Read_data2 <= 32'h0;
		end
	end

	always @ (posedge reset or posedge clk)
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
