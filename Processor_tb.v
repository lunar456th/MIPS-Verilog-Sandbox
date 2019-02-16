`timescale 1ns/1ns

`include "defines.v"
`include "Processor.v"

module Processor_tb (
	);

	reg clk;
	reg reset;
`ifdef FOR_SYNTH
	wire led_synth;
`endif
	wire led_prob_3;
	wire led_prob_2;
	wire led_prob_1;
	wire led_prob_0;

	Processor # (
		.MEM_WIDTH(32),
		.MEM_SIZE(256)
	) _Processor (
		.clk(clk),
		.reset(reset)
`ifdef FOR_SYNTH
		,
		.led_synth(led_synth)
`endif
`ifdef TEST_PROB
		,
		.led_prob_3(led_prob_3),
		.led_prob_2(led_prob_2),
		.led_prob_1(led_prob_1),
		.led_prob_0(led_prob_0)
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
