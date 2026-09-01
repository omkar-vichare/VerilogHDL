module n_bit_twisted_ring_counter #(
	parameter N = 4
)(
	input  wire clk,
	input  wire reset_p,

	output reg  [N-1:0] count
);

	always @(posedge clk) begin : twisted_ring_counter
		if(reset_p == 1'b1) begin
			count <= {N{1'b0}};
		end else begin
			count <= {!count[0], count[N-1:1]};
		end
	end

endmodule : n_bit_twisted_ring_counter