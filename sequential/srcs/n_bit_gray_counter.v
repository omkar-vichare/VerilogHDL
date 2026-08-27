module n_bit_gray_counter #(
	parameter N = 4
)(
	input  wire clk,
	input  wire reset_p,

	output reg  [N-1:0] gray_code
);

	reg [N-1:0] bin_counter;

	always @(posedge clk) begin : binary_counter
		if(reset_p == 1'b1) begin
			bin_counter <= {N{1'b0}};
		end else begin
			bin_counter <= bin_counter + 1'b1;
		end
	end

	generate
		genvar i;
		for (i = 0; i < (N-1); i++) begin
			xor U0 (gray_code[i], bin_counter[i], bin_counter[i+1]);
		end
	endgenerate

endmodule : n_bit_gray_counter