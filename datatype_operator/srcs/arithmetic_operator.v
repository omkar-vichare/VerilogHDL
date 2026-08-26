// *****************************************************************
// Module Name  : arithmetic_operator
// Author       : Omkar V
//
// Description  : 
// *****************************************************************
module arithmetic_operator #(
    parameter DATA_WIDTH = 4
)(
    input  wire [DATA_WIDTH-1:0] a_in,
    input  wire [DATA_WIDTH-1:0] b_in,

    output reg  [DATA_WIDTH-1:0] add_out,
    output reg  [DATA_WIDTH-1:0] sub_out,

    output reg carry__flag,
    output reg borrow_flag,

    output reg  [2*(DATA_WIDTH)-1:0] mul_out,
    output reg  [2*(DATA_WIDTH)-1:0] div_out,
);

    reg [DATA_WIDTH-1:0] quotient;
    reg [DATA_WIDTH-1:0] remainder;

    //--------------------------------------------------------------
    // Addition Operator.
    // Output size should be input vector size + 1.
    // MSB is used to store CARRY bit. But here a seperate carry
    // flag is used to store the carry of addition.
    //-------------------------------------------------------------- 
    always @(*) begin : addition_logic
        {carry__flag, add_out} = a_in + b_in; // MSB is CARRY_bit.
    end

    //--------------------------------------------------------------
    // Subtraction Operator.
    // Output size should be input vector size + 1.
    // MSB is used to store BORROW bit. But here a seperate borrow
    // flag is used to store the borrow of subtraction.
    //-------------------------------------------------------------- 
    always @(*) begin : subtraction_logic
        {borrow_flag, sub_out} = a_in - b_in; // MSB is BORROW_bit.
    end

    //--------------------------------------------------------------
    // Multiplication Operator.
    // Output size should be (2x) the input vector size.
    //-------------------------------------------------------------- 
    always @(*) begin : multiplication_logic
        mul_out = a_in * b_in;
    end

    //--------------------------------------------------------------
    // Division, Modulus Operator.
    // Output size should be (2x) the input vector size.
    // Output has two parts, first LSB bits (half output size) is
    // used to stored quotient and MSB bits is used to store
    // remainder. Remainder is calculated using "%" modulus operator
    //-------------------------------------------------------------- 
    always @(*) begin : division_logic
        remainder = a_in % b_in;           // modulus_operator
        quotient  = a_in / b_in;           // division_operator
        div_out   = {remainder, quotient};
    end

endmodule : arithmetic_operator