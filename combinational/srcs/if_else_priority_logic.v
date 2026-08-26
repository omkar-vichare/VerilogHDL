// *****************************************************************
// Module Name  : if_else_priority_logic
// Author       : Omkar V
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

    output reg  [DATA_WIDTH-1:0] mux_out
);

    //--------------------------------------------------------------
    // if else generates priority logic.
    // What happens when opcode for subtraction is same as addition
    // which is 2'b00???
    // -> because addition has priority over subtraction, output of
    //    addition will be choosen always. And only decoding logic
    //    will change.
    // -> And so, for opcode 2'b01 and 2'b11, div will be performed
    //    and subtraction branch will never execute.
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

endmodule