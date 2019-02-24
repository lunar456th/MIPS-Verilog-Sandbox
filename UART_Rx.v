`ifndef __UART_RX_V__
`define __UART_RX_V__

module UART_Rx # (
	parameter CLK_FREQ = 100000000,
	parameter BAUD_RATE = 115200,
	parameter DATA_BITS = 8,
	parameter STOP_BITS = 1
	)   (
	input wire clk,
	input wire reset,
	input wire rx,
	output wire [DATA_BITS-1:0] rx_data,
	input wire rx_en,
	output reg rx_res
`ifdef FOR_SIM_UART
	,
	output wire [DATA_BITS-1:0] prob_rx_buf,
	output wire [$clog2(DATA_BITS):0] prob_rx_bit_count,
	output wire [$clog2(CLKS_FOR_SEND)-1:0] prob_rx_clk_count,
	output wire prob_rx_state
`endif
	);

	localparam CLKS_FOR_SEND = CLK_FREQ / BAUD_RATE;
	localparam CLKS_FOR_RECV = CLKS_FOR_SEND / 2;

	reg [DATA_BITS-1:0] data;
	reg [DATA_BITS-1:0] rx_buf;
	reg [$clog2(DATA_BITS):0] rx_bit_count;
	reg [$clog2(CLKS_FOR_SEND)-1:0] rx_clk_count;
	reg rx_state;

	initial
	begin
		data <= 0;
		rx_buf <= 0;
		rx_bit_count <= 0;
		rx_clk_count <= 0;
		rx_state <= 0;
		rx_res <= 0;
	end

	always @ (posedge clk)
	begin
		if (reset)
		begin
			rx_buf = 0;
			rx_bit_count = 0;
			rx_clk_count = 0;
			rx_state = 0;
		end
		else
		begin
			rx_res = 0;
			if (rx_en)
			begin
				if (rx_state == 0 && rx == 0)
				begin
					rx_state = 1;
					rx_bit_count = 0;
					rx_clk_count = 0;
				end
				else if (rx_state == 1)
				begin
					if(rx_bit_count == 0 && rx_clk_count == CLKS_FOR_RECV)
					begin
						rx_bit_count = 1;
						rx_clk_count = 0;
					end
					else if(1 <= rx_bit_count && rx_bit_count <= DATA_BITS && rx_clk_count == CLKS_FOR_SEND)
					begin
						rx_buf[rx_bit_count-1] = rx;
						rx_bit_count = rx_bit_count + 1;
						rx_clk_count = 0;
					end
					else if(rx_bit_count > DATA_BITS && rx_clk_count == CLKS_FOR_SEND && rx == 1)
					begin
						rx_state = 0;
						rx_clk_count = 0;
						rx_bit_count = 0;
						data = rx_buf;
						rx_res = 1;
					end
					else if(rx_bit_count > DATA_BITS && rx_clk_count == CLKS_FOR_SEND && rx != 1)
					begin
						rx_state = 0;
						rx_clk_count = 0;
						rx_bit_count = 0;
						rx_buf = 0;
					end
					rx_clk_count = rx_clk_count + 1;
				end
			end
		end
	end

	assign rx_data = data;

`ifdef FOR_SIM_UART
	assign prob_rx_buf = rx_buf;
	assign prob_rx_bit_count = rx_bit_count;
	assign prob_rx_clk_count = rx_clk_count;
	assign prob_rx_state = rx_state;
`endif

endmodule

`endif /*__UART_RX_V__*/
