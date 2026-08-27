`define ACTIVE_HIGH_RESET
`define ACTIVE_LOW__RESET

module dff_posedge_async_reset (
	input  wire clk,

	`ifdef ACTIVE_HIGH_RESET
		input  wire reset_p,
	`endif

	`ifdef ACTIVE_LOW__RESET
		input  wire reset_n,
	`endif

	input  wire d_in,
	output wire d_out
);

	`ifdef ACTIVE_HIGH_RESET
		always @(posedge clk or posedge reset_p) begin : dff
			if(reset_p == 1'b1) begin
				d_out <= 1'b0;
			end else begin
				d_out <= d_in;
			end
		end
	`endif

	`ifdef ACTIVE_LOW__RESET
		always @(posedge clk or negedge reset_n) begin : dff
			if(reset_n == 1'b0) begin
				d_out <= 1'b0;
			end else begin
				d_out <= d_in;
			end
		end
	`endif

endmodule