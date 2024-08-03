`define S0 3'd0
`define S1 3'd1
`define S2 3'd2
`define S3 3'd3
`define S4 3'd4

module Controller(done, sel, ld, clk, rst, start,ctrDone);

    input clk, rst, done, start;
    output sel, ld , ctrDone;
    reg sel, ld , ctrDone;
    reg[2:0] ps = 3'b0, ns;

    always@(posedge clk)
        ps = ns;

    always@(ps, done, start) begin
        case(ps)
            `S0: ns = start ? `S1 : `S0;
            `S1: ns = `S2;
            `S2: ns = `S3;
            `S3: ns = done ? `S4 : `S1;
            `S4: ns = `S4;
        endcase
    end

    always@(ps) begin
        {sel, ld ,ctrDone} = 3'b100;
        case(ps)
            `S0:{sel, ld} = 2'b01;
            `S4:ctrDone = 1'b1;
        endcase
    end

endmodule