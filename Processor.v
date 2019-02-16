`ifndef __PROCESSOR_V__
`define __PROCESSOR_V__

`include "defines.v"
`include "Core.v"

module Processor # (
	parameter MEM_WIDTH = 32,
	parameter MEM_SIZE = 256,
	parameter NUM_CORES = 1
	)	(
	input wire clk,   // E3
	input wire reset  // D9
`ifdef FOR_SYNTH
	,
	output wire led_synth   // F6
`endif
`ifdef TEST_PROB
	,
	output wire led_prob_3, // T10
	output wire led_prob_2, // T9
	output wire led_prob_1, // J5
	output wire led_prob_0  // H5
`endif
	);

	localparam PC_START_1 = 212;
	localparam PC_END_1 = 255;

	// for synthesis
`ifdef FOR_SYNTH
	wire for_synth[0:NUM_CORES-1];
`endif

	// for debug
`ifdef TEST_PROB
	wire [31:0] prob_PC[0:NUM_CORES-1];
	wire [31:0] prob_Instruction[0:NUM_CORES-1];
	wire [31:0] prob_Read_data[0:NUM_CORES-1];
	wire [31:0] prob_Databus2[0:NUM_CORES-1];
	wire prob_MemWrite[0:NUM_CORES-1];
	wire prob_MemRead[0:NUM_CORES-1];
	wire [31:0] prob_ALU_out[0:NUM_CORES-1];
	wire [31:0] prob_mem_addr_instr[0:NUM_CORES-1];
	wire prob_mem_read_en_instr[0:NUM_CORES-1];
	wire [31:0] prob_mem_read_val_instr[0:NUM_CORES-1];
	wire [31:0] prob_mem_addr_data[0:NUM_CORES-1];
	wire prob_mem_read_en_data[0:NUM_CORES-1];
	wire prob_mem_write_en_data[0:NUM_CORES-1];
	wire [31:0] prob_mem_read_val_data[0:NUM_CORES-1];
	wire [31:0] prob_mem_write_val_data[0:NUM_CORES-1];
`endif

	// Clock Divider
`ifdef FOR_SYNTH_CLK2HZ
	reg clk2Hz = 0;
	integer count = 0;

	always @ (posedge clk)
    begin
		if (count >= 24999999)
		begin
			clk2Hz = ~clk2Hz;
			count = 0;
		end
		else
		begin
			count = count + 1;
		end
	end
`endif

	genvar i;
	generate
		for (i = 0; i < NUM_CORES; i = i + 1)
		begin
			Core # (
				.MEM_WIDTH(MEM_WIDTH),
				.MEM_SIZE(MEM_SIZE),
				.PC_START(PC_START_1),
				.PC_END(PC_END_1)
			) _Core (
`ifdef FOR_SYNTH_CLK2HZ
				.clk(clk2Hz),
`else
				.clk(clk),
`endif
				.reset(reset)
`ifdef FOR_SYNTH
				,
				.for_synth(for_synth[i])
`endif
`ifdef TEST_PROB
				,
				.prob_PC(prob_PC[i]),
				.prob_Instruction(prob_Instruction[i]),
				.prob_Read_data(prob_Read_data[i]),
				.prob_Databus2(prob_Databus2[i]),
				.prob_MemWrite(prob_MemWrite[i]),
				.prob_MemRead(prob_MemRead[i]),
				.prob_ALU_out(prob_ALU_out[i]),
				.prob_mem_addr_instr(prob_mem_addr_instr[i]),
				.prob_mem_read_en_instr(prob_mem_read_en_instr[i]),
				.prob_mem_read_val_instr(prob_mem_read_val_instr[i]),
				.prob_mem_addr_data(prob_mem_addr_data[i]),
				.prob_mem_read_en_data(prob_mem_read_en_data[i]),
				.prob_mem_write_en_data(prob_mem_write_en_data[i]),
				.prob_mem_read_val_data(prob_mem_read_val_data[i]),
				.prob_mem_write_val_data(prob_mem_write_val_data[i])
`endif
			);
		end
	endgenerate

	// LED Output
`ifdef FOR_SYNTH
	assign led_synth = for_synth[0];
`endif
`ifdef TEST_PROB
	assign led_prob_3 = prob_mem_read_val_data[0][3];
	assign led_prob_2 = prob_mem_read_val_data[0][2];
	assign led_prob_1 = prob_mem_read_val_data[0][1];
	assign led_prob_0 = prob_mem_read_val_data[0][0];
`endif

endmodule

`endif /*__PROCESSOR_V__*/
