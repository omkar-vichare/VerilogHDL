// *****************************************************************
// Module Name  : logical_operator
// Author       : Omkar V
//
// Description  : 
// *****************************************************************
module logical_operator #(
	parameter DATA_WIDTH = 4
)(
	input  wire [DATA_WIDTH-1:0] a_in,
	input  wire [DATA_WIDTH-1:0] b_in,

	input  wire c_in,
	input  wire d_in,

	output reg  logical_and_out,
	output reg  logical_orr_out,
	output reg  logical_not_out,

	output reg  [DATA_WIDTH-1:0] logical_out,
);

	//--------------------------------------------------------------
	// Output of logical operators is always 1-bit.
	// What hardware is generated, if logical operation is performed 
	// on two vector(bus) signal ???
	// -> Those vector signals are converted to 1-bit using
	//    reduction OR, and logical operation is performed on output 
	//    of reduction OR.
	// -> So, even if any bit is high in bus, reduction OR output
	//    will be 1 and given as input to logical operator. 
	// In below example, output is also a vector, how it affect on
	// hardware
	// -> logical operation output(1-bit) is assigned to 0th bit
	//    of logical_out, remaining higher bits are grounded (1'b0)
	//    by the synthesis tool. 
	//-------------------------------------------------------------- 
	always @(*) begin : logical_AND
		logical_out = a_in && b_in; 
	end

	always @(*) begin : logical_OR
		logical_out = a_in || b_in; 
	end

	always @(*) begin : logical_NOT
		logical_out = !a_in; 
	end

	//--------------------------------------------------------------
	// And hence it is preferred to operate logical operations on
	// 1-bit signals as shown below.
	//--------------------------------------------------------------
	always @(*) begin : logical_and
		logical_and_out = c_in && d_in;
	end

	always @(*) begin : logical_orr
		logical_orr_out = c_in || d_in;
	end

	always @(*) begin : logical_not
		logical_not_out = !c_in;
	end

endmodule : logical_operator