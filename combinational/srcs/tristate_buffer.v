// *****************************************************************
// Module Name  : tristate_buffer
// Author       : Omkar V
//
// Description  : 
// *****************************************************************
module tristate_buffer #(
	parameter BUS_WIDTH = 8
)(
	input  wire [BUS_WIDTH-1:0] data_bus_in,
	input  wire enable,

	output reg  [BUS_WIDTH-1:0] data_bus_out
);

	always @(*) begin : tristate_buff
		if (enable == 1'b1) begin
			data_bus_out = data_bus_in;
		end else begin
			data_bus_out = {BUS_WIDTH{1'bz}};
		end
	end

endmodule : tristate_buffer