`timescale 1ns/1ns

`include "defines.v"
`include "Processor.v"

module Processor_tb (
	);

	parameter NUM_CORES = 2;

	reg clk;
	reg reset;
`ifdef FOR_SYNTH
	wire led_synth;
`endif
`ifdef FOR_SIM_LED
	wire led_prob_3;
	wire led_prob_2;
	wire led_prob_1;
	wire led_prob_0;
`endif
`ifdef FOR_SIM_PROB
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
`endif

	Processor # (
		.MEM_WIDTH(32),
		.MEM_SIZE(256),
		.NUM_CORES(NUM_CORES)
	) _Processor (
		.clk(clk),
		.reset(reset)
`ifdef FOR_SYNTH
		,
		.led_synth(led_synth)
`endif
`ifdef FOR_SIM_LED
		,
		.led_prob_3(led_prob_3),
		.led_prob_2(led_prob_2),
		.led_prob_1(led_prob_1),
		.led_prob_0(led_prob_0)
`endif
`ifdef FOR_SIM_PROB
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
		reset <= 1'b0;
		clk <= 1'b0;
		forever
		begin
			#10 clk = ~clk;
		end
	end

endmodule
