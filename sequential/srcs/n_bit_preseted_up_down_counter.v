module n_bit_preseted_up_down_counter #(
	parameter N = 4
)(
	input  wire clk,
	input  wire reset_p,
	
	input  wire up_down_in,
	input  wire load_enable,

	input  wire [N-1:0] load_value,
	input  wire [N-1:0] count
);

	always @(posedge clk) begin : up_down_counter
		if(reset_p == 1'b1) begin
			count <= {N{1'b0}};
		end else if (load_enable == 1'b1) begin
			count <= load_value;
		end else if (up_down_in  == 1'b1) begin
			count <= count + 1'b1;
		end else begin
			count <= count - 1'b1;
		end
	end

endmodule