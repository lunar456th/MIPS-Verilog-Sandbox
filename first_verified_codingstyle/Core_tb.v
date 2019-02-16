
module Core_tb(
	);

	reg reset;
	reg clk;

	Core _Core (
		.reset(reset),
		.clk(clk)
	);

	initial begin
		reset = 1;
		clk = 1;
		#100 reset = 0;
	end

	always #50 clk = ~clk;

endmodule
