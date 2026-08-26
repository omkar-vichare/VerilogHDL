module re_order_nba_in_clocked_design 
(
	input  wire clk,
	input  wire reset,

	input  wire a_in,

	output reg  Q_out
);

	reg interim1__; 
	reg interim2__;

	always @(posedge clk) begin : shift_register
	 	if(reset == 1'b1) begin
	 		interim1__ <= 1'b0;
	 		interim2__ <= 1'b0;
	 		Q_out      <= 1'b0;
	 	end else begin
	 		interim1__ <= a_in;
	 		interim2__ <= interim1__;
	 		Q_out      <= interim2__;
	 	end
	 end 

endmodule : re_order_nba_in_clocked_design