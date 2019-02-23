`ifndef __UART_TX_V__
`define __UART_TX_V__

module UART_Tx # (
	parameter CLK_FREQ = 100000000,
	parameter BAUD_RATE = 115200,
	parameter DATA_BITS = 8,
	parameter STOP_BITS = 1
	)   (
	input wire clk,
	input wire reset,
	output wire tx,
	input wire [DATA_BITS-1:0] tx_data,
	input wire enable,
	output reg response
	);

	localparam CLKS_FOR_SEND = CLK_FREQ / BAUD_RATE;

	reg [DATA_BITS-1:0] data;
	reg [DATA_BITS-1:0] tx_buf;
	reg [$clog2(DATA_BITS):0] tx_bit_count;
	reg [$clog2(CLKS_FOR_SEND)-1:0] tx_clk_count;
	reg tx_bit;

	initial
	begin
		data <= 0;
		tx_buf <= 0;
		tx_bit_count <= 0;
		tx_clk_count <= 0;
		tx_bit <= 0;
		response <= 0;
	end

	always @ (posedge clk)
	begin
		if (reset)
		begin
			tx_buf = 0;
			tx_bit_count = 0;
			tx_clk_count = 0;
			tx_bit = 0;
		end
		else
		begin
			response = 0;
			if (enable)
			begin
				if (tx_clk_count == CLKS_FOR_SEND)
				begin
					if (tx_bit_count == 0)
					begin
						tx_bit = 1;
						tx_bit_count = 1;
						tx_buf = data;
					end
					else if (tx_bit_count == 1)
					begin
						tx_bit = 0;
						tx_bit_count = 2;
					end
					else if (2 <= tx_bit_count && tx_bit_count <= DATA_BITS + 1)
					begin
						tx_bit = tx_buf[tx_bit_count-2];
						tx_bit_count = tx_bit_count + 1;
					end
					else if (DATA_BITS + 2 <= tx_bit_count && tx_bit_count < DATA_BITS + STOP_BITS + 1)
					begin
						tx_bit = 1;
						tx_bit_count = tx_bit_count + 1;
					end
					else
					begin
						tx_bit = 1;
						tx_bit_count = 0;
						response = 1;
					end
					tx_clk_count = 0;
				end
				tx_clk_count = tx_clk_count + 1;
			end
		end
	end

	assign tx = tx_bit;

	always @ (tx_data)
	begin
		data <= tx_data;
	end

endmodule

`endif /*__UART_TX_V__*/
