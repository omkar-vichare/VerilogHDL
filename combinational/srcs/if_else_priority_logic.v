// *****************************************************************
// Module Name  : arithmetic_operator
// Author       : Omkar Vichare
//
// Description  : 
// *****************************************************************
module if_else_priority_logic #(
	parameter DATA_WIDTH = 8,
	parameter NO_OF_OPER = 4
)(
	input  wire [DATA_WIDTH-1:0] a_in,
	input  wire [DATA_WIDTH-1:0] b_in,

	input  wire [$clog2(NO_OF_OPER)-1:0] select_operation,

	output wire [DATA_WIDTH-1:0] mux_out
);

	wire [] interim__;

	//--------------------------------------------------------------
	// 
	// 
	//--------------------------------------------------------------

	always @(*) begin : arithmetics
		if (select_operation == 2'b00) begin
			mux_out = a_in + b_in;
		end else if (select_operation == 2'b01) begin
			mux_out = a_in - b_in;
		end else if (select_operation == 2'b10) begin
			mux_out = a_in * b_in;
		end else begin
			mux_out = a_in / b_in;
		end
	end

endmodule : if_else_priority_logic