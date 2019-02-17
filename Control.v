`ifndef __CONTROL_V__
`define __CONTROL_V__

module Control (
	input wire [5:0] OpCode,
	input wire [5:0] Funct,
	output wire [1:0] PCSrc,
	output wire Branch,
	output wire RegWrite,
	output wire [1:0] RegDst,
	output wire MemRead,
	output wire MemWrite,
	output wire [1:0] MemtoReg,
	output wire ALUSrc1,
	output wire ALUSrc2,
	output wire ExtOp,
	output wire LuOp,
	output wire [3:0] ALUOp
	);

	// opcode
	localparam OP_R = 6'h00;
	localparam OP_j = 6'h02;
	localparam OP_jal = 6'h03;
	localparam OP_beq = 6'h04;
	localparam OP_addi = 6'h08;
	localparam OP_addiu = 6'h09;
	localparam OP_slti = 6'h0a;
	localparam OP_sltiu = 6'h0b;
	localparam OP_andi = 6'h0c;
	localparam OP_lui = 6'h0f;
	localparam OP_lw = 6'h23;
	localparam OP_sw = 6'h2b;

	// funct
	localparam FUNCT_sll = 6'b000000;
	localparam FUNCT_srl = 6'b000010;
	localparam FUNCT_sra = 6'b000011;
	localparam FUNCT_jr = 6'b001000;
	localparam FUNCT_jalr = 6'b001001;

	// Your code below
	assign PCSrc[1:0] = (OpCode == OP_j || OpCode == OP_jal) ? 2'b01 :
						((OpCode == OP_R && Funct == FUNCT_jr) || (OpCode == OP_R && Funct == FUNCT_jalr)) ? 2'b10 : 2'b00;

	assign Branch = (OpCode == OP_beq) ? 1'b1 : 1'b0;

	assign RegWrite = (OpCode == OP_sw || OpCode == OP_beq ||
					   OpCode == OP_j ||(OpCode == OP_R && Funct == FUNCT_jr)) ? 1'b0 : 1'b1;

	assign RegDst = (OpCode == OP_lw
					|| OpCode == OP_lui
					|| OpCode == OP_addi
					|| OpCode == OP_addiu
					|| OpCode == OP_andi
					|| OpCode == OP_slti
					|| OpCode == OP_sltiu) ? 2'b00 :
					(OpCode == OP_jal) ? 2'b10 : 2'b01;

	assign MemRead = (OpCode == OP_lw) ? 1'b1 : 1'b0;

	assign MemWrite = (OpCode == OP_sw) ? 1'b1 : 1'b0;

	assign MemtoReg = (OpCode == OP_lw) ? 2'b01 :
					  (OpCode == OP_jal) ? 2'b10 :
					  (OpCode == OP_R && Funct == FUNCT_jalr) ? 2'b10 : 2'b00;

	assign ALUSrc1 = (OpCode == OP_R && Funct == FUNCT_sll) ? 1'b1 :
					 (OpCode == OP_R && Funct == FUNCT_srl) ? 1'b1 :
					 (OpCode == OP_R && Funct == FUNCT_sra) ? 1'b1 : 1'b0;

	assign ALUSrc2 = (OpCode == OP_lw) ? 1'b1 :
					 (OpCode == OP_sw) ? 1'b1 :
					 (OpCode == OP_lui) ? 1'b1 :
					 (OpCode == OP_addi) ? 1'b1 :
					 (OpCode == OP_addiu) ? 1'b1 :
					 (OpCode == OP_andi) ? 1'b1 :
					 (OpCode == OP_slti) ? 1'b1 :
					 (OpCode == OP_sltiu) ? 1'b1 : 1'b0;

	assign ExtOp = (OpCode == OP_andi) ? 1'b0 : 1'b1;

	assign LuOp = (OpCode == OP_lui) ? 1'b1 : 1'b0;

	// Your code above

	assign ALUOp[2:0]  = (OpCode == OP_R) ? 3'b010 :
						 (OpCode == OP_beq) ? 3'b001 :
						 (OpCode == OP_andi) ? 3'b100 :
						 (OpCode == OP_slti || OpCode == OP_sltiu) ? 3'b101 : 3'b000;

	assign ALUOp[3] = OpCode[0];

endmodule

`endif /*__CONTROL_V__*/
