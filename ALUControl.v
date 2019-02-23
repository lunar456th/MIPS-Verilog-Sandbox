`ifndef __ALUCONTROL_V__
`define __ALUCONTROL_V__

module ALUControl (
	input wire [3:0] ALUOp,
	input wire [5:0] Funct,
	output reg [4:0] ALUCtl,
	output wire Sign
	);

	localparam aluSLL = 5'b10000;
	localparam aluSRL = 5'b11000;
	localparam aluSRA = 5'b11001;
	localparam aluADD = 5'b00010;
	localparam aluSUB = 5'b00110;
	localparam aluAND = 5'b00000;
	localparam aluOR  = 5'b00001;
	localparam aluXOR = 5'b01101;
	localparam aluNOR = 5'b01100;
	localparam aluSLT = 5'b00111;
	localparam aluUART = 5'b11111; // to invalidate uart operations from ALU

	assign Sign = (ALUOp[2:0] == 3'b010) ? ~Funct[0] : ~ALUOp[3];

	reg [4:0] aluFunct;

	always @ (*)
	begin
		case (Funct)
			6'b00_0000: aluFunct <= aluSLL;
			6'b00_0010: aluFunct <= aluSRL;
			6'b00_0011: aluFunct <= aluSRA;
			6'b10_0000: aluFunct <= aluADD;
			6'b10_0001: aluFunct <= aluADD;
			6'b10_0010: aluFunct <= aluSUB;
			6'b10_0011: aluFunct <= aluSUB;
			6'b10_0100: aluFunct <= aluAND;
			6'b10_0101: aluFunct <= aluOR;
			6'b10_0110: aluFunct <= aluXOR;
			6'b10_0111: aluFunct <= aluNOR;
			6'b10_1010: aluFunct <= aluSLT;
			6'b10_1011: aluFunct <= aluSLT;
			6'b11_1001: aluFunct <= aluSLT;
			6'b10_1011: aluFunct <= aluSLT;
			6'b11_1001: aluFunct <= aluUART;
			6'b11_1101: aluFunct <= aluUART;
			default: aluFunct <= aluADD;
		endcase
	end

	always @ (*)
	begin
		case (ALUOp[2:0])
			3'b000: ALUCtl <= aluADD;
			3'b001: ALUCtl <= aluSUB;
			3'b100: ALUCtl <= aluAND;
			3'b101: ALUCtl <= aluSLT;
			3'b010: ALUCtl <= aluFunct;
			default: ALUCtl <= aluADD;
		endcase
	end

endmodule

`endif /*__ALUCONTROL_V__*/
