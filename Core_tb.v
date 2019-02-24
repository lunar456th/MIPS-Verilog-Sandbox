`timescale 1ns/1ns

`include "defines.v"
`include "Core.v"

module Core_tb (
	);

	reg clk;
	reg reset;
	reg rx;
	wire tx;

`ifdef FOR_SIM_MEM
	parameter MEM_WIDTH = 32;
	parameter MEM_SIZE = 256;
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

`ifdef FOR_SIM_UART
	parameter MEM_WIDTH = 32;
	parameter MEM_SIZE = 256;
	parameter CLK_FREQ = 100000000;
	parameter BAUD_RATE = 115200;
	parameter DATA_BITS = 8;
	parameter STOP_BITS = 1;
	parameter CLKS_FOR_SEND = CLK_FREQ / BAUD_RATE;
	parameter CLKS_FOR_RECV = CLKS_FOR_SEND / 2;
	wire [31:0] prob_PC;
	wire [31:0] prob_Instruction;
	wire [31:0] prob_Databus1;
	wire [1:0] prob_MemtoReg;
	wire prob_RegWrite;
	wire [31:0] prob_Databus3;
	wire [31:0] prob_uart_data_send;
	wire [31:0] prob_uart_data_recv;
	wire prob_uart_stall;
	wire prob_stall;
	wire prob_uart_tx_en;
	wire prob_uart_rx_en;
	wire prob_uart_tx_res;
	wire prob_uart_rx_res;
	wire [4:0] prob_Write_register;
	wire [7:0] prob_tx_data;
	wire [7:0] prob_rx_data;
	wire [DATA_BITS-1:0] prob_tx_buf;
	wire [$clog2(DATA_BITS):0] prob_tx_bit_count;
	wire [$clog2(CLKS_FOR_SEND)-1:0] prob_tx_clk_count;
	wire prob_tx_bit;
	wire [DATA_BITS-1:0] prob_rx_buf;
	wire [$clog2(DATA_BITS):0] prob_rx_bit_count;
	wire [$clog2(CLKS_FOR_SEND)-1:0] prob_rx_clk_count;
	wire prob_rx_state;
`endif

	Core # (
		.MEM_WIDTH(MEM_WIDTH),
		.MEM_SIZE(MEM_SIZE),
		.PC_START(124),
		.PC_END(255),
		.CLK_FREQ(CLK_FREQ),
		.BAUD_RATE(BAUD_RATE),
		.DATA_BITS(DATA_BITS),
		.STOP_BITS(STOP_BITS)
`ifdef FOR_SIM_UART
		,
		.CLKS_FOR_SEND(CLKS_FOR_SEND),
		.CLKS_FOR_RECV(CLKS_FOR_RECV)
`endif
	) _Core (
		.clk(clk),
		.reset(reset),
		.tx(tx),
		.rx(rx)
`ifdef FOR_SYNTH
		,
		.for_synth(for_synth)
`endif
`ifdef FOR_SIM_MEM
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
`ifdef FOR_SIM_UART
		,
		.prob_PC(prob_PC),
		.prob_Instruction(prob_Instruction),
		.prob_Databus1(prob_Databus1),
		.prob_MemtoReg(prob_MemtoReg),
		.prob_RegWrite(prob_RegWrite),
		.prob_Databus3(prob_Databus3),
		.prob_uart_data_send(prob_uart_data_send),
		.prob_uart_data_recv(prob_uart_data_recv),
		.prob_uart_stall(prob_uart_stall),
		.prob_stall(prob_stall),
		.prob_uart_tx_en(prob_uart_tx_en),
		.prob_uart_rx_en(prob_uart_rx_en),
		.prob_uart_tx_res(prob_uart_tx_res),
		.prob_uart_rx_res(prob_uart_rx_res),
		.prob_Write_register(prob_Write_register),
		.prob_tx_data(prob_tx_data),
		.prob_rx_data(prob_rx_data),
		.prob_tx_buf(prob_tx_buf),
		.prob_tx_bit_count(prob_tx_bit_count),
		.prob_tx_clk_count(prob_tx_clk_count),
		.prob_tx_bit(prob_tx_bit),
		.prob_rx_buf(prob_rx_buf),
		.prob_rx_bit_count(prob_rx_bit_count),
		.prob_rx_clk_count(prob_rx_clk_count),
		.prob_rx_state(prob_rx_state)
`endif
	);

	initial
	begin
		reset <= 1'b0;
		clk <= 1'b0;
		rx <= 1'b0;
		forever
		begin
			#1 clk = ~clk;
		end
	end

	initial
	begin
		rx <= 1'b1; #868;
		rx <= 1'b0; #868;
		rx <= 1'b0; #868;
		rx <= 1'b1; #868;
		rx <= 1'b0; #868;
		rx <= 1'b1; #868;
		rx <= 1'b0; #868;
		rx <= 1'b0; #868;
		rx <= 1'b0; #868;
		rx <= 1'b0; #868;
		rx <= 1'b1; #868;
		#10000;
		$finish;
	end

endmodule
