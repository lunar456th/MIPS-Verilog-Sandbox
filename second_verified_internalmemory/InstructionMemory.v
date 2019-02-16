`ifndef __INSTRUCTIONMEMORY_V__
`define __INSTRUCTIONMEMORY_V__

module InstructionMemory (
	input wire [31:0] Address,
	output wire [31:0] Instruction
	);

	reg [31:0] memory[0:63];
	integer i;
	
	initial
	begin
		memory[0] <= 32'h00001825;
		memory[1] <= 32'h24020001;
		memory[2] <= 32'hAC620000;
		memory[3] <= 32'h24020001;
		memory[4] <= 32'h24030002;
		memory[5] <= 32'hAC430000;
		memory[6] <= 32'h24020002;
		memory[7] <= 32'h24030003;
		memory[8] <= 32'hAC430000;
		memory[9] <= 32'h24020003;
		memory[10] <= 32'h24030004;
		memory[11] <= 32'hAC430000;
		memory[12] <= 32'h24020004;
		memory[13] <= 32'h24030005;
		memory[14] <= 32'hAC430000;
		memory[15] <= 32'h24020005;
		memory[16] <= 32'h24030006;
		memory[17] <= 32'hAC430000;
		memory[18] <= 32'h24020006;
		memory[19] <= 32'h24030007;
		memory[20] <= 32'hAC430000;
		memory[21] <= 32'h24020007;
		memory[22] <= 32'h24030008;
		memory[23] <= 32'hAC430000;
		memory[24] <= 32'h00001025;
		memory[25] <= 32'h8C500000;
		memory[26] <= 32'h24020001;
		memory[27] <= 32'h8C500000;
		memory[28] <= 32'h24020002;
		memory[29] <= 32'h8C500000;
		memory[30] <= 32'h24020003;
		memory[31] <= 32'h8C500000;
		memory[32] <= 32'h24020004;
		memory[33] <= 32'h8C500000;
		memory[34] <= 32'h24020005;
		memory[35] <= 32'h8C500000;
		memory[36] <= 32'h24020006;
		memory[37] <= 32'h8C500000;
		memory[38] <= 32'h24020007;
		memory[39] <= 32'h8C500000;
		memory[40] <= 32'h00001025;
		memory[41] <= 32'h00000000;
		memory[42] <= 32'h00000000;
		memory[43] <= 32'h00000000;
		for (i = 44; i < 64; i = i + 1)
		begin
			memory[i] <= 0;
		end
	end

	assign Instruction = memory[Address];

endmodule

`endif /*__INSTRUCTIONMEMORY_V__*/
