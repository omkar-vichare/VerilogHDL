module missing_default_in_combo (
	input  wire [3:0] d_in,
	input  wire [1:0] case_item,

	output reg  mux_out	
);

	always @(*) begin
		case (case_item)
			2'b00: mux_out = d_in[0];
			2'b01: mux_out = d_in[1];
			2'b11: mux_out = d_in[2];
		endcase
	end

endmodule