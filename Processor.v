`ifndef __PROCESSOR_V__
`define __PROCESSOR_V__

`include "defines.v"
`include "Core.v"

module Processor # (
	parameter MEM_WIDTH = 32,
	parameter MEM_SIZE = 256,
	parameter NUM_CORES = 2
	)	(
	input wire clk,   // E3
	input wire reset, // D9
	output wire tx,   // D10
	input wire rx     // A9
`ifdef FOR_SYNTH
	,
	output wire led_synth   // F6
`endif
`ifdef FOR_SIM_LED
	,
	output wire led_prob_3, // T10
	output wire led_prob_2, // T9
	output wire led_prob_1, // J5
	output wire led_prob_0  // H5
`endif
`ifdef FOR_SIM_MEM
	,
	output wire [31:0] prob_PC,
	output wire [31:0] prob_Instruction,
	output wire [31:0] prob_Read_data,
	output wire [31:0] prob_Databus2,
	output wire prob_MemWrite,
	output wire prob_MemRead,
	output wire [31:0] prob_ALU_out,
	output wire [31:0] prob_mem_addr_instr,
	output wire prob_mem_read_en_instr,
	output wire [31:0] prob_mem_read_val_instr,
	output wire [31:0] prob_mem_addr_data,
	output wire prob_mem_read_en_data,
	output wire prob_mem_write_en_data,
	output wire [31:0] prob_mem_read_val_data,
	output wire [31:0] prob_mem_write_val_data
`endif
	);

	localparam PC_START_1 = 212;
	localparam PC_END_1 = 255;

	// for synthesis
`ifdef FOR_SYNTH
	wire for_synth[0:NUM_CORES-1];
`endif

	// for debug
	wire [31:0] prob_PC_core[0:NUM_CORES-1];
	wire [31:0] prob_Instruction_core[0:NUM_CORES-1];
	wire [31:0] prob_Read_data_core[0:NUM_CORES-1];
	wire [31:0] prob_Databus2_core[0:NUM_CORES-1];
	wire prob_MemWrite_core[0:NUM_CORES-1];
	wire prob_MemRead_core[0:NUM_CORES-1];
	wire [31:0] prob_ALU_out_core[0:NUM_CORES-1];
	wire [31:0] prob_mem_addr_instr_core[0:NUM_CORES-1];
	wire prob_mem_read_en_instr_core[0:NUM_CORES-1];
	wire [31:0] prob_mem_read_val_instr_core[0:NUM_CORES-1];
	wire [31:0] prob_mem_addr_data_core[0:NUM_CORES-1];
	wire prob_mem_read_en_data_core[0:NUM_CORES-1];
	wire prob_mem_write_en_data_core[0:NUM_CORES-1];
	wire [31:0] prob_mem_read_val_data_core[0:NUM_CORES-1];
	wire [31:0] prob_mem_write_val_data_core[0:NUM_CORES-1];

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
				.reset(reset),
				.tx(tx),
				.rx(rx)
`ifdef FOR_SYNTH
				,
				.for_synth(for_synth[i])
`endif
`ifdef FOR_SIM_MEM
				,
				.prob_PC(prob_PC_core[i]),
				.prob_Instruction(prob_Instruction_core[i]),
				.prob_Read_data(prob_Read_data_core[i]),
				.prob_Databus2(prob_Databus2_core[i]),
				.prob_MemWrite(prob_MemWrite_core[i]),
				.prob_MemRead(prob_MemRead_core[i]),
				.prob_ALU_out(prob_ALU_out_core[i]),
				.prob_mem_addr_instr(prob_mem_addr_instr_core[i]),
				.prob_mem_read_en_instr(prob_mem_read_en_instr_core[i]),
				.prob_mem_read_val_instr(prob_mem_read_val_instr_core[i]),
				.prob_mem_addr_data(prob_mem_addr_data_core[i]),
				.prob_mem_read_en_data(prob_mem_read_en_data_core[i]),
				.prob_mem_write_en_data(prob_mem_write_en_data_core[i]),
				.prob_mem_read_val_data(prob_mem_read_val_data_core[i]),
				.prob_mem_write_val_data(prob_mem_write_val_data_core[i])
`endif
			);
		end
	endgenerate

	// LED Output
`ifdef FOR_SYNTH
	assign led_synth = for_synth[0];
`endif
`ifdef FOR_SIM_LED
	assign led_prob_3 = prob_mem_read_val_data_core[0][3];
	assign led_prob_2 = prob_mem_read_val_data_core[0][2];
	assign led_prob_1 = prob_mem_read_val_data_core[0][1];
	assign led_prob_0 = prob_mem_read_val_data_core[0][0];
`endif
`ifdef FOR_SIM_MEM
	integer sel = 1;
	assign prob_PC = prob_PC_core[sel];
	assign prob_Instruction = prob_Instruction_core[sel];
	assign prob_Read_data = prob_Read_data_core[sel];
	assign prob_Databus2 = prob_Databus2_core[sel];
	assign prob_MemWrite = prob_MemWrite_core[sel];
	assign prob_MemRead = prob_MemRead_core[sel];
	assign prob_ALU_out = prob_ALU_out_core[sel];
	assign prob_mem_addr_instr = prob_mem_addr_instr_core[sel];
	assign prob_mem_read_en_instr = prob_mem_read_en_instr_core[sel];
	assign prob_mem_read_val_instr = prob_mem_read_val_instr_core[sel];
	assign prob_mem_addr_data = prob_mem_addr_data_core[sel];
	assign prob_mem_read_en_data = prob_mem_read_en_data_core[sel];
	assign prob_mem_write_en_data = prob_mem_write_en_data_core[sel];
	assign prob_mem_read_val_data = prob_mem_read_val_data_core[sel];
	assign prob_mem_write_val_data = prob_mem_write_val_data_core[sel];
`endif

endmodule

`endif /*__PROCESSOR_V__*/
