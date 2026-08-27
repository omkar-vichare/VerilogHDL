module n_bit_shift_register #(
	parameter N = 4
)(
	input  wire clk,
	input  wire reset_p,
	
	input  wire load_enable,
	input  wire [N-1:0] load_value,

	input  wire shifting_direction,

	output reg  [N-1:0] Q_out
);

	always @(posedge clk) begin : shift_register
		if(reset_p == 1'b1) begin
			Q_out <= {N{1'b0}};
		end else if (load_enable == 1'b1) begin
			Q_out <= load_value;
		end else if (shifting_direction == 1'b1) begin
			Q_out <= {1'b0, Q_out[N-1:1]};
		end else begin
			Q_out <= {Q_out[N-2:0], 1'b0};
		end
	end

endmodule