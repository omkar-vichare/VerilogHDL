module dual_port_ram_with_bidirectional_port #(
	parameter DATA_WIDTH = 8,
	parameter ADDR_WIDTH = 4
)(
	input  wire clk,

	input  wire chip_select0,
	input  wire chip_select1,
	
	input  wire wr_en0,
	input  wire wr_en1,

	input  wire rd_en0,
	input  wire rd_en1,

	input  wire [ADDR_WIDTH-1:0] addr0_in,
	input  wire [ADDR_WIDTH-1:0] addr1_in,

	inout  wire [DATA_WIDTH-1:0] data_io0,
	inout  wire [DATA_WIDTH-1:0] data_io1
);

	reg [ADDR_WIDTH-1:0] memory [DATA_WIDTH-1:0];

	reg [DATA_WIDTH-1:0] temp_reg0;
	reg [DATA_WIDTH-1:0] temp_reg1;

	always @(posedge clk) begin : write_logic_for_port0
		if(chip_select0 == 1'b1 && wr_en0 == 1'b1) begin
			memory[addr0_in] <= data_io0;
		end
	end

	always @(posedge clk) begin : write_logic_for_port1
		if(chip_select1 == 1'b1 && wr_en1 == 1'b1) begin
			memory[addr1_in] <= data_io1;
		end
	end

	always @(posedge clk) begin : read_logic_for_port0
		if(chip_select0 == 1'b1 && wr_en0 == 1'b0) begin
			temp_reg0 <= memory[addr0_in];
		end
	end

	always @(posedge clk) begin : read_logic_for_port1
		if(chip_select1 == 1'b1 && wr_en1 == 1'b0) begin
			temp_reg0 <= memory[addr1_in];
		end
	end

	always @(*) begin : drive_output_data_for_port0
		if (chip_select0 == 1'b1 && wr_en0 == 1'b0 && rd_en0 == 1'b1) begin
			data_io0 = temp_reg0;
		end else begin
			data_io0 = {DATA_WIDTH{1'bz}};
		end
	end

	always @(*) begin : drive_output_data_for_port1
		if (chip_select1 == 1'b1 && wr_en1 == 1'b0 && rd_en1 == 1'b1) begin
			data_io1 = temp_reg1;
		end else begin
			data_io1 = {DATA_WIDTH{1'bz}};
		end
	end

endmodule