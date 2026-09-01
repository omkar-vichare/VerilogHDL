`define USING_TERNARY
`define USING_PROCESS_BLOCK
module intentional_latch #(
    parameter N = 4
)(
    input  wire latch_en_in,
    input  wire [N-1:0] data_in,

    `ifdef USING_TERNARY
        output wire [N-1:0] data_out
    `elsif USING_PROCESS_BLOCK
        output reg  [N-1:0] data_out
    `endif
);

    `ifdef USING_TERNARY
        assign data_out = (latch_en_in == 1'b1) ? data_in : data_out;
    `elsif USING_PROCESS_BLOCK
        always @(*) begin : positive_level_latch
            if (latch_en_in == 1'b1) begin
                data_out = data_in;
            end else begin
                data_out = data_out;
            end
        end
    `endif

endmodule