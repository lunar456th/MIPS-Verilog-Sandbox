`ifndef __UART_CONTROLLER_V__
`define __UART_CONTROLLER_V__

`include "UART_Tx.v"
`include "UART_Rx.v"

module UART_Controller # (
	parameter CLK_FREQ = 100000000,
	parameter BAUD_RATE = 115200,
	parameter DATA_BITS = 8,
	parameter STOP_BITS = 1
`ifdef FOR_SIM_UART
	,
	parameter CLKS_FOR_SEND = CLK_FREQ / BAUD_RATE,
	parameter CLKS_FOR_RECV = CLKS_FOR_SEND / 2
`endif
	)  (
	input wire clk,
	input wire reset,
	output wire tx,
	input wire rx,
	input wire tx_en,
	input wire rx_en,
	input wire [31:0] uart_data_send,
	output wire [31:0] uart_data_recv,
	output wire tx_res,
	output wire rx_res
`ifdef FOR_SIM_UART
	// controller
	,
	output wire [7:0] prob_tx_data,
	output wire [7:0] prob_rx_data
	// tx
	,
	output wire [DATA_BITS-1:0] prob_tx_buf,
	output wire [$clog2(DATA_BITS):0] prob_tx_bit_count,
	output wire [$clog2(CLKS_FOR_SEND)-1:0] prob_tx_clk_count,
	output wire prob_tx_bit
	// rx
	,
	output wire [DATA_BITS-1:0] prob_rx_buf,
	output wire [$clog2(DATA_BITS):0] prob_rx_bit_count,
	output wire [$clog2(CLKS_FOR_SEND)-1:0] prob_rx_clk_count,
	output wire prob_rx_state
`endif
	);

	wire [7:0] tx_data;
	wire [7:0] rx_data;
//	wire tx_res;
//	wire rx_res;

	UART_Tx # (
		.CLK_FREQ(CLK_FREQ),
		.BAUD_RATE(BAUD_RATE),
		.DATA_BITS(DATA_BITS),
		.STOP_BITS(STOP_BITS)
	) _UART_Tx (
		.clk(clk),
		.reset(reset),
		.tx(tx),
		.tx_data(tx_data),
		.tx_en(tx_en),
		.tx_res(tx_res)
`ifdef FOR_SIM_UART
	,
		.prob_tx_buf(prob_tx_buf),
		.prob_tx_bit_count(prob_tx_bit_count),
		.prob_tx_clk_count(prob_tx_clk_count),
		.prob_tx_bit(prob_tx_bit)
`endif
	);

	UART_Rx # (
		.CLK_FREQ(CLK_FREQ),
		.BAUD_RATE(BAUD_RATE),
		.DATA_BITS(DATA_BITS),
		.STOP_BITS(STOP_BITS)
	) _UART_Rx (
		.clk(clk),
		.reset(reset),
		.rx(rx),
		.rx_data(rx_data),
		.rx_en(rx_en),
		.rx_res(rx_res)
`ifdef FOR_SIM_UART
		,
		.prob_rx_buf(prob_rx_buf),
		.prob_rx_bit_count(prob_rx_bit_count),
		.prob_rx_clk_count(prob_rx_clk_count),
		.prob_rx_state(prob_rx_state)
`endif
	);

	// setting for loopback
	// assign tx_data = rx_data;
	// assign tx_en = rx_res;

	assign tx_data = uart_data_send[7:0];
	assign uart_data_recv = { 24'd0, rx_data };

`ifdef FOR_SIM_UART
	assign prob_tx_data = tx_data;
	assign prob_rx_data = rx_data;
`endif

endmodule

`endif /*__UART_CONTROLLER_V__*/
