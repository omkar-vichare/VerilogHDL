module zero_latency_arbiter #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 8
)(
    input  wire agent0_request,
    input  wire agent1_request,

    output reg  agent0_grant,
    output reg  agent1_grant,

    input  wire [DATA_WIDTH-1:0] agent0_data,
    input  wire [ADDR_WIDTH-1:0] agent0_addr,

    input  wire [DATA_WIDTH-1:0] agent1_data,
    input  wire [ADDR_WIDTH-1:0] agent1_addr,

    output wire                  mem_en,
    output wire [DATA_WIDTH-1:0] mem_data,
    output wire [DATA_WIDTH-1:0] mem_addr,
);

    localparam AGENT0 = 1'b1;
    localparam AGENT1 = 1'b0;

    reg priority_bit;

    always @(*) begin
        case (priority_bit)
        AGENT0: begin
            if (agent0_request == 1'b1) begin
                mem_en       = 1'b1;
                mem_addr     = agent0_addr;
                mem_data     = agent0_data;
                agent0_grant = 1'b1;
                agent1_grant = 1'b0;
            end else if (agent1_request == 1'b1) begin
                mem_en       = 1'b1;
                mem_addr     = agent1_addr;
                mem_data     = agent1_data;
                agent0_grant = 1'b0;
                agent1_grant = 1'b1;
            end else begin
                mem_en       = 1'b0;
                mem_addr     = {ADDR_WIDTH{1'b0}};
                mem_data     = {DATA_WIDTH{1'b0}};
                agent0_grant = 1'b0;
                agent1_grant = 1'b0;
            end
        end
        AGENT1: begin
            if (agent1_request == 1'b1) begin
                mem_en       = 1'b1;
                mem_addr     = agent1_addr;
                mem_data     = agent1_data;
                agent0_grant = 1'b0;
                agent1_grant = 1'b1;
            end else if (agent0_request == 1'b1) begin
                mem_en       = 1'b1;
                mem_addr     = agent0_addr;
                mem_data     = agent0_data;
                agent0_grant = 1'b1;
                agent1_grant = 1'b0;
            end else begin
                mem_en       = 1'b0;
                mem_addr     = {ADDR_WIDTH{1'b0}};
                mem_data     = {DATA_WIDTH{1'b0}};
                agent0_grant = 1'b0;
                agent1_grant = 1'b0;
            end
        end
        endcase
    end

    always @(posedge clk) begin : priority_logic
        if(reset == 1'b1) begin
            priority_bit <= 1'b1;
        end else if (agent0_grant == 1'b1) begin
            priority_bit <= 1'b0;
        end else if (agent1_grant == 1'b1) begin
            priority_bit <= 1'b1;
        end
    end

endmodule