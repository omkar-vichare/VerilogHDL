module divide_by_3_output_frequency (
	input  wire clk,
	input  wire reset_p,

	output wire Q_out
);

	reg [1:0] interim__;

	always @(posedge clk) begin : divide_by_3_out_freq
		if(reset_p == 1'b1) begin
			interim__ <= 2'd0;
		end else if (interim__ == 2'b10) begin
			interim__ <= 2'b00;
		end else begin
			interim__ <= interim__ + 2'b01;
		end
	end

	assign Q_out = interim__[0];

endmodule