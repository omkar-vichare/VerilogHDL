// *****************************************************************
// Module Name  : case_parallel_logic
// Author       : Omkar V
//
// Description  : 
// *****************************************************************
module case_parallel_logic #(
    parameter DATA_WIDTH = 8,
    parameter NO_OF_OPER = 8
)(
    input  wire [DATA_WIDTH-1:0] a_in,
    input  wire [DATA_WIDTH-1:0] b_in,

    input  wire [2*($clog2(NO_OF_OPER))-1:0] select_operation,

    output reg  carry_borrow_flag,
    output reg  [2*(DATA_WIDTH)-1:0] mux_out
);
    
    // parameter only local to this module.
    localparam ADD = 2'b00;
    localparam SUB = 2'b01;
    localparam MUL = 2'b10;
    localparam DIV = 2'b11;

    // interim__ variables.
    wire [DATA_WIDTH:0] add_out; 
    wire [DATA_WIDTH:0] sub_out;

    wire [DATA_WIDTH-1:0] quotient;
    wire [DATA_WIDTH-1:0] remainder;

    // compute arithmetics.
    assign add_out = a_in + b_in;
    assign sub_out = a_in - b_in;

    assign remainder = a_in % b_in;
    assign quotient  = a_in / b_in;

    //--------------------------------------------------------------
    // mux's are generated in such a way that output of each
    // operator will have same delay to reach output.
    //--------------------------------------------------------------

    always @(*) begin : arithmetics
        case (select_operation)
            ADD: begin
                mux_out = {{DATA_WIDTH{1'b0}}, add_out[DATA_WIDTH-1:0]};
                carry_borrow_flag = add_out[DATA_WIDTH];
            end 
            SUB: begin
                mux_out = {{DATA_WIDTH{1'b0}}, sub_out[DATA_WIDTH-1:0]};
                carry_borrow_flag = sub_out[DATA_WIDTH];
            end
            MUL: begin
                mux_out = a_in * b_in;
                carry_borrow_flag = 1'b0;
            end
            DIV: begin
                mux_out = {remainder, quotient};
                carry_borrow_flag = 1'b0;
            end
        endcase
    end

endmodule : case_parallel_logic