`ifndef __PROCESSOR_V__
`define __PROCESSOR_V__

`include "defines.v"
`include "Core.v"

module Processor # (
	parameter MEM_WIDTH = 32,
	parameter MEM_SIZE = 256
	)	(
	input wire clk,   // E3
	input wire reset  // D9
`ifdef TEST_PROB
	,
	output wire led_synth,  // G6
	output wire led_prob_3, // T10
	output wire led_prob_2, // T9
	output wire led_prob_1, // J5
	output wire led_prob_0  // H5
`endif
	);

	localparam PC_START_1 = 212;
	localparam PC_END_1 = 255;

	// for debug
`ifdef TEST_PROB
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

	// Clock Divider
	reg clk2Hz = 0;
	integer i = 0;

	always @ (posedge clk)
	begin
		if (i >= 24999999)
		begin
			clk2Hz = ~clk2Hz;
			i = 0;
		end
		else
		begin
			i = i + 1;
		end
	end

	Core # (
		.MEM_WIDTH(MEM_WIDTH),
		.MEM_SIZE(MEM_SIZE),
		.PC_START(PC_START_1),
		.PC_END(PC_END_1)
	) _Core (
		.clk(clk2Hz),
		.reset(reset)
`ifdef FOR_SYNTH
		,
		.for_synth(for_synth)
`endif
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

	// LED Output
	assign led_synth = ^(mem_addr ^ mem_write_en ^ mem_read_en ^ mem_write_val ^ mem_read_val);
	assign led_prob_3 = mem_read_val[3];
	assign led_prob_2 = mem_read_val[2];
	assign led_prob_1 = mem_read_val[1];
	assign led_prob_0 = mem_read_val[0];

endmodule

`endif /*__PROCESSOR_V__*/
