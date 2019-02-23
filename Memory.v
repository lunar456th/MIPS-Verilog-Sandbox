`ifndef __MEMORY_V__
`define __MEMORY_V__

module Memory # (
	parameter MEM_WIDTH = 32,
	parameter MEM_SIZE = 256
	)	(
//	input reset,

	input wire [$clog2(MEM_SIZE)-1:0] mem_addr_instr,
	input wire mem_read_en_instr,
	output wire [MEM_WIDTH-1:0] mem_read_val_instr,

	input wire [$clog2(MEM_SIZE)-1:0] mem_addr_data,
	input wire mem_read_en_data,
	input wire mem_write_en_data,
	output reg [MEM_WIDTH-1:0] mem_read_val_data,
	input wire [MEM_WIDTH-1:0] mem_write_val_data
	);

	reg [MEM_WIDTH-1:0] memory[0:MEM_SIZE-1];

	integer i;

	initial
	begin
		for (i = 0; i < 124; i = i + 1)
		begin
			memory[i] <= 32'h0;
		end
		// Instruction
		memory[124] = 32'h27BDFFD8;
		memory[125] = 32'hAFBF0024;
		memory[126] = 32'hAFBE0020;
		memory[127] = 32'h03A0F025;
		memory[128] = 32'h3C1C0042;
		memory[129] = 32'h279C8330;
		memory[130] = 32'hAFBC0010;
		memory[131] = 32'h8F828018;
		memory[132] = 32'h0040C825;
		memory[133] = 32'h04110026;
		memory[134] = 32'h00000000;
		memory[135] = 32'h8FDC0010;
		memory[136] = 32'hAFC20018;
		memory[137] = 32'h8FC40018;
		memory[138] = 32'h8F82801C;
		memory[139] = 32'h0040C825;
		memory[140] = 32'h04110051;
		memory[141] = 32'h00000000;
		memory[142] = 32'h8FDC0010;
		memory[143] = 32'h1000FFF3;
		memory[144] = 32'h00000000;
		memory[145] = 32'h00000000;
		memory[146] = 32'h00000000;
		memory[147] = 32'h00000000;
		memory[148] = 32'h27BDFFF8;
		memory[149] = 32'hAFBE0004;
		memory[150] = 32'h03A0F025;
		memory[151] = 32'h00801025;
		memory[152] = 32'hA3C20008;
		memory[153] = 32'h00800039;
		memory[154] = 32'hA3C20008;
		memory[155] = 32'h00000000;
		memory[156] = 32'h03C0E825;
		memory[157] = 32'h8FBE0004;
		memory[158] = 32'h27BD0008;
		memory[159] = 32'h03E00008;
		memory[160] = 32'h00000000;
		memory[161] = 32'h27BDFFE8;
		memory[162] = 32'hAFBE0014;
		memory[163] = 32'h03A0F025;
		memory[164] = 32'h0100003D;
		memory[165] = 32'hA3C20008;
		memory[166] = 32'h83C20008;
		memory[167] = 32'h03C0E825;
		memory[168] = 32'h8FBE0014;
		memory[169] = 32'h27BD0018;
		memory[170] = 32'h03E00008;
		memory[171] = 32'h00000000;
		memory[172] = 32'h27BDFFD8;
		memory[173] = 32'hAFBF0024;
		memory[174] = 32'hAFBE0020;
		memory[175] = 32'h03A0F025;
		memory[176] = 32'hAFC00018;
		memory[177] = 32'hAFC00018;
		memory[178] = 32'h10000009;
		memory[179] = 32'h00000000;
		memory[180] = 32'h3C020041;
		memory[181] = 32'h24430350;
		memory[182] = 32'h8FC20018;
		memory[183] = 32'h00621021;
		memory[184] = 32'hA0400000;
		memory[185] = 32'h8FC20018;
		memory[186] = 32'h24420001;
		memory[187] = 32'hAFC20018;
		memory[188] = 32'h8FC20018;
		memory[189] = 32'h28420064;
		memory[190] = 32'h1440FFF5;
		memory[191] = 32'h00000000;
		memory[192] = 32'h0C100071;
		memory[193] = 32'h00000000;
		memory[194] = 32'hA3C2001C;
		memory[195] = 32'h3C020041;
		memory[196] = 32'h24430350;
		memory[197] = 32'h8FC20018;
		memory[198] = 32'h00621021;
		memory[199] = 32'h93C3001C;
		memory[200] = 32'hA0430000;
		memory[201] = 32'h8FC20018;
		memory[202] = 32'h24420001;
		memory[203] = 32'hAFC20018;
		memory[204] = 32'h83C3001C;
		memory[205] = 32'h2402000A;
		memory[206] = 32'h1462FFF1;
		memory[207] = 32'h00000000;
		memory[208] = 32'h8FC20018;
		memory[209] = 32'h2443FFFF;
		memory[210] = 32'h3C020041;
		memory[211] = 32'h24420350;
		memory[212] = 32'h00621021;
		memory[213] = 32'hA0400000;
		memory[214] = 32'h3C020041;
		memory[215] = 32'h24420350;
		memory[216] = 32'h03C0E825;
		memory[217] = 32'h8FBF0024;
		memory[218] = 32'h8FBE0020;
		memory[219] = 32'h27BD0028;
		memory[220] = 32'h03E00008;
		memory[221] = 32'h00000000;
		memory[222] = 32'h27BDFFD8;
		memory[223] = 32'hAFBF0024;
		memory[224] = 32'hAFBE0020;
		memory[225] = 32'h03A0F025;
		memory[226] = 32'hAFC40028;
		memory[227] = 32'hAFC00018;
		memory[228] = 32'h1000000B;
		memory[229] = 32'h00000000;
		memory[230] = 32'h8FC20018;
		memory[231] = 32'h8FC30028;
		memory[232] = 32'h00621021;
		memory[233] = 32'h80420000;
		memory[234] = 32'h00402025;
		memory[235] = 32'h0C100064;
		memory[236] = 32'h00000000;
		memory[237] = 32'h8FC20018;
		memory[238] = 32'h24420001;
		memory[239] = 32'hAFC20018;
		memory[240] = 32'h8FC20018;
		memory[241] = 32'h8FC30028;
		memory[242] = 32'h00621021;
		memory[243] = 32'h80420000;
		memory[244] = 32'h1440FFF1;
		memory[245] = 32'h00000000;
		memory[246] = 32'h00001025;
		memory[247] = 32'h03C0E825;
		memory[248] = 32'h8FBF0024;
		memory[249] = 32'h8FBE0020;
		memory[250] = 32'h27BD0028;
		memory[251] = 32'h03E00008;
		memory[252] = 32'h00000000;
		memory[253] = 32'h00000000;
		memory[254] = 32'h00000000;
		memory[255] = 32'h00000000;
	end

//	always @ (posedge reset)
//	begin
//		if (reset)
//		begin
//			//
//		end
//	end

	assign mem_read_val_instr = mem_read_en_instr ? memory[mem_addr_instr] : 0;

	always @ (mem_addr_data or mem_read_en_data or mem_write_en_data or mem_write_val_data)
	begin
		if (mem_read_en_data)
		begin
			mem_read_val_data <= memory[mem_addr_data];
		end

		if (mem_write_en_data)
		begin
			memory[mem_addr_data] <= mem_write_val_data;
		end
	end

endmodule

`endif /*__MEMORY_V__*/

		// UART Test Code
		// for (i = 16; i < 124; i = i + 1)
		// begin
		// memory[i] <= 32'h0;
		// end
		// memory[124] = 32'h27BDFFD8;
		// memory[125] = 32'hAFBF0024;
		// memory[126] = 32'hAFBE0020;
		// memory[127] = 32'h03A0F025;
		// memory[128] = 32'h3C1C0042;
		// memory[129] = 32'h279C8330;
		// memory[130] = 32'hAFBC0010;
		// memory[131] = 32'h8F828018;
		// memory[132] = 32'h0040C825;
		// memory[133] = 32'h04110026;
		// memory[134] = 32'h00000000;
		// memory[135] = 32'h8FDC0010;
		// memory[136] = 32'hAFC20018;
		// memory[137] = 32'h8FC40018;
		// memory[138] = 32'h8F82801C;
		// memory[139] = 32'h0040C825;
		// memory[140] = 32'h04110051;
		// memory[141] = 32'h00000000;
		// memory[142] = 32'h8FDC0010;
		// memory[143] = 32'h1000FFF3;
		// memory[144] = 32'h00000000;
		// memory[145] = 32'h00000000;
		// memory[146] = 32'h00000000;
		// memory[147] = 32'h00000000;
		// memory[148] = 32'h27BDFFF8;
		// memory[149] = 32'hAFBE0004;
		// memory[150] = 32'h03A0F025;
		// memory[151] = 32'h00801025;
		// memory[152] = 32'hA3C20008;
		// memory[153] = 32'h00800039;
		// memory[154] = 32'hA3C20008;
		// memory[155] = 32'h00000000;
		// memory[156] = 32'h03C0E825;
		// memory[157] = 32'h8FBE0004;
		// memory[158] = 32'h27BD0008;
		// memory[159] = 32'h03E00008;
		// memory[160] = 32'h00000000;
		// memory[161] = 32'h27BDFFE8;
		// memory[162] = 32'hAFBE0014;
		// memory[163] = 32'h03A0F025;
		// memory[164] = 32'h0100003D;
		// memory[165] = 32'hA3C20008;
		// memory[166] = 32'h83C20008;
		// memory[167] = 32'h03C0E825;
		// memory[168] = 32'h8FBE0014;
		// memory[169] = 32'h27BD0018;
		// memory[170] = 32'h03E00008;
		// memory[171] = 32'h00000000;
		// memory[172] = 32'h27BDFFD8;
		// memory[173] = 32'hAFBF0024;
		// memory[174] = 32'hAFBE0020;
		// memory[175] = 32'h03A0F025;
		// memory[176] = 32'hAFC00018;
		// memory[177] = 32'hAFC00018;
		// memory[178] = 32'h10000009;
		// memory[179] = 32'h00000000;
		// memory[180] = 32'h3C020041;
		// memory[181] = 32'h24430350;
		// memory[182] = 32'h8FC20018;
		// memory[183] = 32'h00621021;
		// memory[184] = 32'hA0400000;
		// memory[185] = 32'h8FC20018;
		// memory[186] = 32'h24420001;
		// memory[187] = 32'hAFC20018;
		// memory[188] = 32'h8FC20018;
		// memory[189] = 32'h28420064;
		// memory[190] = 32'h1440FFF5;
		// memory[191] = 32'h00000000;
		// memory[192] = 32'h0C100071;
		// memory[193] = 32'h00000000;
		// memory[194] = 32'hA3C2001C;
		// memory[195] = 32'h3C020041;
		// memory[196] = 32'h24430350;
		// memory[197] = 32'h8FC20018;
		// memory[198] = 32'h00621021;
		// memory[199] = 32'h93C3001C;
		// memory[200] = 32'hA0430000;
		// memory[201] = 32'h8FC20018;
		// memory[202] = 32'h24420001;
		// memory[203] = 32'hAFC20018;
		// memory[204] = 32'h83C3001C;
		// memory[205] = 32'h2402000A;
		// memory[206] = 32'h1462FFF1;
		// memory[207] = 32'h00000000;
		// memory[208] = 32'h8FC20018;
		// memory[209] = 32'h2443FFFF;
		// memory[210] = 32'h3C020041;
		// memory[211] = 32'h24420350;
		// memory[212] = 32'h00621021;
		// memory[213] = 32'hA0400000;
		// memory[214] = 32'h3C020041;
		// memory[215] = 32'h24420350;
		// memory[216] = 32'h03C0E825;
		// memory[217] = 32'h8FBF0024;
		// memory[218] = 32'h8FBE0020;
		// memory[219] = 32'h27BD0028;
		// memory[220] = 32'h03E00008;
		// memory[221] = 32'h00000000;
		// memory[222] = 32'h27BDFFD8;
		// memory[223] = 32'hAFBF0024;
		// memory[224] = 32'hAFBE0020;
		// memory[225] = 32'h03A0F025;
		// memory[226] = 32'hAFC40028;
		// memory[227] = 32'hAFC00018;
		// memory[228] = 32'h1000000B;
		// memory[229] = 32'h00000000;
		// memory[230] = 32'h8FC20018;
		// memory[231] = 32'h8FC30028;
		// memory[232] = 32'h00621021;
		// memory[233] = 32'h80420000;
		// memory[234] = 32'h00402025;
		// memory[235] = 32'h0C100064;
		// memory[236] = 32'h00000000;
		// memory[237] = 32'h8FC20018;
		// memory[238] = 32'h24420001;
		// memory[239] = 32'hAFC20018;
		// memory[240] = 32'h8FC20018;
		// memory[241] = 32'h8FC30028;
		// memory[242] = 32'h00621021;
		// memory[243] = 32'h80420000;
		// memory[244] = 32'h1440FFF1;
		// memory[245] = 32'h00000000;
		// memory[246] = 32'h00001025;
		// memory[247] = 32'h03C0E825;
		// memory[248] = 32'h8FBF0024;
		// memory[249] = 32'h8FBE0020;
		// memory[250] = 32'h27BD0028;
		// memory[251] = 32'h03E00008;
		// memory[252] = 32'h00000000;
		// memory[253] = 32'h00000000;
		// memory[254] = 32'h00000000;
		// memory[255] = 32'h00000000;


		// Memory Read/Write Test Code
		// memory[0] <= 32'h0000_0001; //0
		// memory[1] <= 32'h0000_0000; //1
		// memory[2] <= 32'h0000_0000; //2
		// memory[3] <= 32'h0000_0000; //3
		// memory[4] <= 32'h0000_0001; //4
		// memory[5] <= 32'h0000_0000; //5
		// memory[6] <= 32'h0000_0000; //6
		// memory[7] <= 32'h0000_0000; //7
		// memory[8] <= 32'h0000_0001; //8
		// memory[9] <= 32'h0000_0000; //9
		// memory[10] <= 32'h0000_0000; //10
		// memory[11] <= 32'h0000_0001; //11
		// memory[12] <= 32'h0000_0000; //12
		// memory[13] <= 32'h0000_0000; //13
		// memory[14] <= 32'h0000_0000; //14
		// memory[15] <= 32'h0000_0001; //15
		// for (i = 16; i < 212; i = i + 1)
		// begin
			// memory[i] <= 32'h0;
		// end
		// // Instruction
		// memory[212] <= 32'h00001825;
		// memory[213] <= 32'h24020001;
		// memory[214] <= 32'hAC620000;
		// memory[215] <= 32'h24020001;
		// memory[216] <= 32'h24030002;
		// memory[217] <= 32'hAC430000;
		// memory[218] <= 32'h24020002;
		// memory[219] <= 32'h24030003;
		// memory[220] <= 32'hAC430000;
		// memory[221] <= 32'h24020003;
		// memory[222] <= 32'h24030004;
		// memory[223] <= 32'hAC430000;
		// memory[224] <= 32'h24020004;
		// memory[225] <= 32'h24030005;
		// memory[226] <= 32'hAC430000;
		// memory[227] <= 32'h24020005;
		// memory[228] <= 32'h24030006;
		// memory[229] <= 32'hAC430000;
		// memory[230] <= 32'h24020006;
		// memory[231] <= 32'h24030007;
		// memory[232] <= 32'hAC430000;
		// memory[233] <= 32'h24020007;
		// memory[234] <= 32'h24030008;
		// memory[235] <= 32'hAC430000;
		// memory[236] <= 32'h00001025;
		// memory[237] <= 32'h8C500000;
		// memory[238] <= 32'h24020001;
		// memory[239] <= 32'h8C500000;
		// memory[240] <= 32'h24020002;
		// memory[241] <= 32'h8C500000;
		// memory[242] <= 32'h24020003;
		// memory[243] <= 32'h8C500000;
		// memory[244] <= 32'h24020004;
		// memory[245] <= 32'h8C500000;
		// memory[246] <= 32'h24020005;
		// memory[247] <= 32'h8C500000;
		// memory[248] <= 32'h24020006;
		// memory[249] <= 32'h8C500000;
		// memory[250] <= 32'h24020007;
		// memory[251] <= 32'h8C500000;
		// memory[252] <= 32'h00001025;
		// memory[253] <= 32'h00000000;
		// memory[254] <= 32'h00000000;
		// memory[255] <= 32'h00000000;