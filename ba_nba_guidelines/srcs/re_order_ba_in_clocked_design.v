// *****************************************************************
// Module Name  : re_order_ba_in_clocked_design
// Author       : Omkar V
//
// Description  : explains how BA in sequential design affects the
//                hardware. Our intention is to design 3-bit shift
//                register and so we are expecting 3FF to be
//                infer by tool. 
// *****************************************************************
`define SYNTH_1FF
`define SYNTH_2FF
`define SYNTH_3FF
module re_order_ba_in_clocked_design
(
	input  wire clk,
	input  wire reset,

	input  wire a_in,

	output reg  Q_out
);

	reg interim1__; 
	reg interim2__;

	`ifdef SYNTH_1FF
		always @(posedge clk) begin : shift_register
	 		if(reset == 1'b1) begin
	 			interim1__ = 1'b0;
	 			interim2__ = 1'b0;
	 			Q_out      = 1'b0;
	 		end else begin
	 			interim1__ = a_in;
	 			interim2__ = interim1__;
	 			Q_out      = interim2__;
	 		end
	 	end
	`elsif SYNTH_2FF
		always @(posedge clk) begin : shift_register
	 		if(reset == 1'b1) begin
	 			interim1__ = 1'b0;
	 			interim2__ = 1'b0;
	 			Q_out      = 1'b0;
	 		end else begin
	 			Q_out      = interim2__;
	 			interim1__ = a_in;
	 			interim2__ = interim1__;
	 		end
	 	end 
	`elsif SYNTH_3FF 
	 	always @(posedge clk) begin : shift_register
	 		if(reset == 1'b1) begin
	 			interim1__ = 1'b0;
	 			interim2__ = 1'b0;
	 			Q_out      = 1'b0;
	 		end else begin
	 			Q_out      = interim2__;
	 			interim2__ = interim1__;
	 			interim1__ = a_in;
	 		end
	 	end
	`endif

endmodule