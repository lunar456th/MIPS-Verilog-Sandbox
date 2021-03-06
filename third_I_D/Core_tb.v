`timescale 1ns/1ns

`include "Core.v"

`define TEST_PROB

module Core_tb(
	);

	reg clk;
	reg reset;
	wire [31:0] prob_PC;
	wire [31:0] prob_Instruction;
	wire [31:0] prob_Read_data;
	wire [31:0] prob_Databus2;
	wire prob_MemWrite;
	wire prob_MemRead;
	wire [31:0] prob_ALU_out;
	// wire [31:0] prob_mem_addr;
	// wire prob_mem_read_en;
	// wire prob_mem_write_en;
	// wire [31:0] prob_mem_read_val;
	// wire [31:0] prob_mem_write_val;

	Core _Core (
		.clk(clk),
		.reset(reset)
`ifdef TEST_PROB
		,
		.prob_PC(prob_PC),
		.prob_Instruction(prob_Instruction),
		.prob_Read_data(prob_Read_data),
		.prob_Databus2(prob_Databus2),
		.prob_MemWrite(prob_MemWrite),
		.prob_MemRead(prob_MemRead),
		.prob_ALU_out(prob_ALU_out)//,
		// .prob_mem_addr(prob_mem_addr),
		// .prob_mem_read_en(prob_mem_read_en),
		// .prob_mem_write_en(prob_mem_write_en),
		// .prob_mem_read_val(prob_mem_read_val),
		// .prob_mem_write_val(prob_mem_write_val)
`endif
	);

	initial
	begin
		reset = 1; #1 reset = 0;
		clk = 0;
		forever
		begin
			#1 clk = ~clk;
		end
	end

endmodule
