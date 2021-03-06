`timescale 1ns/1ns

`include "Core.v"

`define TEST_PROB

module Core_tb (
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
	wire [31:0] prob_mem_addr_instr;
	wire prob_mem_read_en_instr;
	wire [31:0] prob_mem_read_val_instr;
	wire [31:0] prob_mem_addr_data;
	wire prob_mem_read_en_data;
	wire prob_mem_write_en_data;
	wire [31:0] prob_mem_read_val_data;
	wire [31:0] prob_mem_write_val_data;

	Core # (
		.MEM_WIDTH(32),
		.MEM_SIZE(256)
	) _Core (
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
		.prob_ALU_out(prob_ALU_out),
		.prob_mem_addr_instr(prob_mem_addr_instr),
		.prob_mem_read_en_instr(prob_mem_read_en_instr),
		.prob_mem_read_val_instr(prob_mem_read_val_instr),
		.prob_mem_addr_data(prob_mem_addr_data),
		.prob_mem_read_en_data(prob_mem_read_en_data),
		.prob_mem_write_en_data(prob_mem_write_en_data),
		.prob_mem_read_val_data(prob_mem_read_val_data),
		.prob_mem_write_val_data(prob_mem_write_val_data)
`endif
	);

	initial
	begin
		reset = 0;
		clk = 0;
		forever
		begin
			#10 clk = ~clk;
		end
	end

endmodule
