// *****************************************************************
// Module Name  : resource_sharing
// Author       : Omkar V
//
// Description  : Understanding different ways to generate hw,
//				  with same functionality
// *****************************************************************
`define OPTIMIZED_DESIGN
module resource_sharing (
	input  wire a_in,
	input  wire b_in,
	input  wire opcode,

	output reg  carry_borrow_flag,
	output reg  [DATA_WIDTH-1:0] add_sub_out, 
);

	// Optimized Design---------------------------------------------
	`ifdef OPTIMIZED_DESIGN
		reg interim__;

		// Using 2's Compliment method for area optimization.
		assign {carry_borrow_flag, add_sub_out} = a_in + interim__ + opcode;
		always @(*) begin : calculate_interim__
			if (opcode == 1'b0) begin
				interim__ = b_in;
			end else begin
				interim__ = !b_in;
			end
		end
	// Unoptimized Design ------------------------------------------
	`else 
		always @(*) begin : add_sub_operation
			if (opcode == 1'b0) begin
				{carry_borrow_flag, add_sub_out} = a_in + b_in;
			end else begin
				{carry_borrow_flag, add_sub_out} = a_in - b_in;
			end
		end
	`endif

endmodule : resource_sharing