`define S0 5'd0
`define S1 5'd1
`define S2 5'd2
`define S3 5'd3
`define S4 5'd4
`define S5 5'd5
`define S6 5'd6

module Controller_Second_Layer(clk, rst, start, Done_Init, Done_Full, Linear_Start, Compute_Start, Compute_Enable, Done_Mem_Modifier);

    input clk, rst, start, Done_Init, Done_Full;
    output reg Linear_Start, Compute_Start, Compute_Enable, Done_Mem_Modifier;

    reg [2:0] ps = 3'd0, ns = 3'd0;
    always @(posedge clk) begin
        if (rst) ps <= `S1;
        else ps <= ns;
    end

    always @(ps or start or Done_Init or Done_Full) begin
        case(ps)
            `S1: ns = start ? `S2 : `S1;
            `S2: ns = Done_Init ? `S3 : `S2;
            `S3: ns = `S4; 
            `S4: ns = Done_Full ? `S5 : `S4;
            `S5: ns = `S6;
            `S6: ns = `S6;
            default: ns = `S1;
        endcase
    end

    always @(ps) begin
        {Linear_Start, Compute_Start, Compute_Enable, Done_Mem_Modifier} = 4'b0000;
        case(ps)
        `S1: ;
        `S2: Linear_Start = 1'b1;
        `S3: begin Compute_Enable = 1'b1; Compute_Start = 1'b1; end
        `S4: Compute_Enable = 1'b1;
        `S5: Done_Mem_Modifier = 1'b1;
        endcase
    end

endmodule