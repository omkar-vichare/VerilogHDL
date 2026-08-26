// *****************************************************************
// Module Name  : resource_sharing
// Author       : Omkar V
//
// Description  : 
// *****************************************************************
`define OPTIMIZED_DESIGN
module resource_sharing #(
	parameter DATA_WIDTH = 8,
	parameter NO_OF_OPER = 2
)(
	input  wire [DATA_WIDTH-1:0] a_in,
	input  wire [DATA_WIDTH-1:0] b_in,

	input  wire [$clog2(NO_OF_OPER)-1:0] opcode,

	output reg  [DATA_WIDTH-1:0] add_sub_out, 
);

	`ifdef OPTIMIZED_DESIGN

	`else 

	`endif

endmodule : resource_sharing