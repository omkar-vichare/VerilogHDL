module n_bit_ring_counter #(
	parameter N = 4
)(
	input  wire clk,
	input  wire reset_p,

	input  wire load_enable,

	input  wire [N-1:0] load_value,
	output reg  [N-1:0] count
);

	always @(posedge clk) begin : ring_counter
		if(reset_p == 1'b1) begin
			count <= {N{1'b0}};
		end else if (load_enable == 1'b1) begin
			count <= load_value;
		end else begin
			count <= {count[0], count[N-1:1]};
		end
	end

endmodule : n_bit_ring_counter