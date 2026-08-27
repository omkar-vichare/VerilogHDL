module single_port_ram_with_registered_output #(
	parameter DATA_WIDTH = 8,
	parameter ADDR_WIDTH = 4
)(
	input  wire clk,
	input  wire chip_select,
	
	input  wire wr_en,
	input  wire rd_en,

	input  wire [ADDR_WIDTH-1:0] addr_in,
	input  wire [DATA_WIDTH-1:0] data_in,
	output wire [DATA_WIDTH-1:0] data_out,
);

	reg [ADDR_WIDTH-1:0] memory [DATA_WIDTH-1:0];

	reg [DATA_WIDTH-1:0] temp_reg;

	always @(posedge clk) begin : write_logic
		if(chip_select == 1'b1 && wr_en == 1'b1) begin
			memory[addr_in] <= data_in;
		end
	end

	always @(posedge clk) begin : read_logic
		if(chip_select == 1'b1 && wr_en == 1'b0) begin
			temp_reg <= memory[addr_in];
		end
	end

	always @(*) begin : drive_data_out_port
		if (chip_select == 1'b1 && wr_en == 1'b0 && rd_en == 1'b1) begin
			data_out = temp_reg;
		end else begin
			data_out = {DATA_WIDTH{1'b0}};
		end
	end
endmodule