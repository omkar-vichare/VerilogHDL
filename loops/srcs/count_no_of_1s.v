// *****************************************************************
// Module Name  : count_no_of_1s
// Author       : Omkar V
//
// Description  : Count number of 1s combinationally using for 
//                loop.
// *****************************************************************
module count_no_of_1s #(
    parameter DATA_WIDTH = 8
)(
    input  wire [DATA_WIDTH-1:0] a_in,

    output wire [$clog2(DATA_WIDTH)-1:0] count
);
    
    wire [$clog2(DATA_WIDTH)-1:0] interim__;

    integer i;

    //--------------------------------------------------------------
    // Design iterates through each bit of a_in, if wire has
    // logic 1, interim__ variable increments otherwise,
    // we add zero. 
    // we add zero instead of holding value to avoid latch.
    // Generally, for loop is avoided for hardware design because 
    // tool generates cascaded mux. And number of mux implemented in
    // cascade depends upon size of input signal.
    //--------------------------------------------------------------

    always @(*) begin : count_no_of_1s_in_input
        for (i = 0; i < DATA_WIDTH; i++) begin
            if (a_in[i] == 1'b1) begin
                interim__ = interim__ + 1'b1;
            end else begin
                interim__ = interim__ + 1'b0;
            end
        end
    end

    assign count = interim__;

endmodule : count_no_of_1s