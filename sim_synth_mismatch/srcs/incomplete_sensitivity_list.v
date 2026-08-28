module incomplete_sensitivity_list (
	input  wire a_in,
	input  wire b_in,
	input  wire s_in,

	output reg  mux_out
);

	always @(a_in, s_in) begin
		if (s_in == 1'b0) begin
			mux_out = a_in;
		end else begin
			mux_out = b_in;
		end
	end

endmodule