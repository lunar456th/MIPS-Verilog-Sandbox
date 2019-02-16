`ifndef __CORE_V__
`define __CORE_V__

`include "ALU.v"
`include "ALUControl.v"
`include "Control.v"
`include "DataMemory.v"
`include "InstructionMemory.v"
`include "Memory.v"
`include "defines.v"
`include "RegisterFile.v"

module Core # (
	parameter MEM_WIDTH = 32,
	parameter MEM_SIZE = 256,
	parameter PC_START = 212,
	parameter PC_END = 255
	)	(
	input wire clk,
	input wire reset
`ifdef TEST_PROB
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

	// PC
	reg [31:0] PC = PC_START;
	wire [31:0] PC_next;
	wire [31:0] PC_plus_1;
	always @ (posedge clk or posedge reset)
	begin
		if (reset)
		begin
			PC <= PC_START;
		end
		else if (PC < PC_END)
		begin
			PC <= PC_next;
		end
	end
	assign PC_plus_1 = PC + 32'd1;

	// Memory
	wire [31:0] mem_addr_instr;
	wire mem_read_en_instr;
	wire [31:0] mem_read_val_instr;
	wire [31:0] mem_addr_data;
	wire mem_read_en_data;
	wire mem_write_en_data;
	wire [31:0] mem_read_val_data;
	wire [31:0] mem_write_val_data;
	Memory # (
		.MEM_WIDTH(MEM_WIDTH),
		.MEM_SIZE(MEM_SIZE)
	) _Memory (
		.reset(reset),
		.mem_addr_instr(mem_addr_instr),
		.mem_read_en_instr(mem_read_en_instr),
		.mem_read_val_instr(mem_read_val_instr),
		.mem_addr_data(mem_addr_data),
		.mem_read_en_data(mem_read_en_data),
		.mem_write_en_data(mem_write_en_data),
		.mem_read_val_data(mem_read_val_data),
		.mem_write_val_data(mem_write_val_data)
	);

	// InstructionMemory
	wire [31:0] Instruction;
	InstructionMemory # (
		.MEM_WIDTH(MEM_WIDTH),
		.MEM_SIZE(MEM_SIZE)
	) _InstructionMemory (
		.Address(PC),
		.Instruction(Instruction),
		.mem_addr(mem_addr_instr),
		.mem_read_en(mem_read_en_instr),
		.mem_read_val(mem_read_val_instr)
	);

	// Control
	wire [1:0] RegDst;
	wire [1:0] PCSrc;
	wire Branch;
	wire MemRead;
	wire [1:0] MemtoReg;
	wire [3:0] ALUOp;
	wire ExtOp;
	wire LuOp;
	wire MemWrite;
	wire ALUSrc1;
	wire ALUSrc2;
	wire RegWrite;
	Control _Control (
		.OpCode(Instruction[31:26]),
		.Funct(Instruction[5:0]),
		.PCSrc(PCSrc),
		.Branch(Branch),
		.RegWrite(RegWrite),
		.RegDst(RegDst),
		.MemRead(MemRead),
		.MemWrite(MemWrite),
		.MemtoReg(MemtoReg),
		.ALUSrc1(ALUSrc1),
		.ALUSrc2(ALUSrc2),
		.ExtOp(ExtOp),
		.LuOp(LuOp),
		.ALUOp(ALUOp)
	);

	// RegisterFile
	wire [31:0] Databus1, Databus2, Databus3;
	wire [4:0] Write_register;
	assign Write_register = (RegDst == 2'b00) ? Instruction[20:16] : (RegDst == 2'b01 ? Instruction[15:11] : 5'b11111);
	RegisterFile _RegisterFile (
		.reset(reset),
		.clk(clk),
		.RegWrite(RegWrite),
		.Read_register1(Instruction[25:21]),
		.Read_register2(Instruction[20:16]),
		.Write_register(Write_register),
		.Write_data(Databus3),
		.Read_data1(Databus1),
		.Read_data2(Databus2)
	);

	// ALUControl
	wire [31:0] Ext_out;
	wire [31:0] LU_out;
	wire [4:0] ALUCtl;
	wire Sign;
	assign Ext_out = {ExtOp ? {16{Instruction[15]}} : 16'h0000, Instruction[15:0]};
	assign LU_out = LuOp ? {Instruction[15:0], 16'h0000} : Ext_out;
	ALUControl _ALUControl (
		.ALUOp(ALUOp),
		.Funct(Instruction[5:0]),
		.ALUCtl(ALUCtl),
		.Sign(Sign)
	);

	// ALU
	wire [31:0] ALU_in1;
	wire [31:0] ALU_in2;
	wire [31:0] ALU_out;
	wire Zero;
	assign ALU_in1 = ALUSrc1 ? {17'h00000, Instruction[10:6]} : Databus1;
	assign ALU_in2 = ALUSrc2 ? LU_out: Databus2;
	ALU _ALU (
		.in1(ALU_in1),
		.in2(ALU_in2),
		.ALUCtl(ALUCtl),
		.Sign(Sign),
		.out(ALU_out),
		.zero(Zero)
	);

	// DataMemory
	wire [31:0] Read_data;
	DataMemory # (
		.MEM_WIDTH(MEM_WIDTH),
		.MEM_SIZE(MEM_SIZE)
	) _DataMemory (
		.Address(ALU_out),
		.Write_data(Databus2),
		.Read_data(Read_data),
		.MemRead(MemRead),
		.MemWrite(MemWrite),
		.mem_addr(mem_addr_data),
		.mem_read_en(mem_read_en_data),
		.mem_write_en(mem_write_en_data),
		.mem_read_val(mem_read_val_data),
		.mem_write_val(mem_write_val_data)
	);

	// Branch
	wire [31:0] Jump_target;
	wire [31:0] Branch_target;
	assign Databus3 = MemtoReg == 2'b00 ? ALU_out : (MemtoReg == 2'b01 ? Read_data : PC_plus_1);
	assign Jump_target = {PC_plus_1[31:28], Instruction[25:0], 2'b00};
	assign Branch_target = Branch & Zero ? PC_plus_1 + {LU_out[29:0], 2'b00} : PC_plus_1;
	assign PC_next = PCSrc == 2'b00 ? Branch_target : (PCSrc == 2'b01 ? Jump_target : Databus1);

`ifdef TEST_PROB
	assign prob_PC = PC;
	assign prob_Instruction = Instruction;
	assign prob_Read_data = Read_data;
	assign prob_Databus2 = Databus2;
	assign prob_MemWrite = MemWrite;
	assign prob_MemRead = MemRead;
	assign prob_ALU_out = ALU_out;
	assign prob_mem_addr_instr = mem_addr_instr;
	assign prob_mem_read_en_instr = mem_read_en_instr;
	assign prob_mem_read_val_instr = mem_read_val_instr;
	assign prob_mem_addr_data = mem_addr_data;
	assign prob_mem_read_en_data = mem_read_en_data;
	assign prob_mem_write_en_data = mem_write_en_data;
	assign prob_mem_read_val_data = mem_read_val_data;
	assign prob_mem_write_val_data = mem_write_val_data;
`endif

endmodule

`endif /*__CORE_V__*/
