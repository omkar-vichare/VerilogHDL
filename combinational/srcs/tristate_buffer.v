// *****************************************************************
// Module Name  : tristate_buffer
// Author       : Omkar V
//
// Description  : generate tristate buffer, high impedence at
//                output based on enable bit.
// *****************************************************************
module tristate_buffer #(
	parameter BUS_WIDTH = 8
)(
	input  wire [BUS_WIDTH-1:0] data_bus_in,
	input  wire enable,

	output reg  [BUS_WIDTH-1:0] data_bus_out
);

	//--------------------------------------------------------------
	// When output is driven to (Z) which is high impedence, tool
	// will infer a tristate buffer.
	//--------------------------------------------------------------
	always @(*) begin : tristate_buff
		if (enable == 1'b1) begin
			data_bus_out = data_bus_in;
		end else begin
			data_bus_out = {BUS_WIDTH{1'bz}};
		end
	end

endmodule : tristate_buffer