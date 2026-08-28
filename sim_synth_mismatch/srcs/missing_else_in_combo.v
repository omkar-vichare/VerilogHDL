module missing_else_in_combo (
	input  wire a_in,
	input  wire b_in,
	input  wire s_in,

	output reg  mux_out
);

	always @(*) begin
		if (s_in == 1'b1) begin
			mux_out = b_in;
		end
	end

endmodule