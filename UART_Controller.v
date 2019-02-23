`ifndef __UART_CONTROLLER_V__
`define __UART_CONTROLLER_V__

`include "UART_Tx.v"
`include "UART_Rx.v"

module UART_Controller # (
	parameter CLK_FREQ = 100000000,
	parameter BAUD_RATE = 115200,
	parameter DATA_BITS = 8,
	parameter STOP_BITS = 1
	)  (
	input wire clk,
	input wire reset,
	output wire tx,
	input wire rx,
	input wire tx_enable,
	input wire rx_enable,
	input wire [31:0] data_uart_send,
	output wire [31:0] data_uart_recv,
	output wire tx_response,
	output wire rx_response
	);

	wire [7:0] tx_data;
	wire [7:0] rx_data;
//	wire tx_response;
//	wire rx_response;

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
		.enable(tx_enable),
		.response(tx_response)
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
		.enable(rx_enable),
		.response(rx_response)
	);

	// setting for loopback
	// assign tx_data = rx_data;
	// assign tx_enable = rx_response;

	assign tx_data = data_uart_send[7:0];
	assign data_uart_recv = { 24'd0, rx_data };

endmodule

`endif /*__UART_CONTROLLER_V__*/
