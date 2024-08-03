`define S0 3'd0
`define S1 3'd1
`define S2 3'd2
`define S3 3'd3
`define S4 3'd4

module Controller(input done, output reg sel, ld, input clk, rst, start, output reg ctrDone);

    wire[2:0] nsSel0, nsSel1, nsSel2, nsSel3, nsSel4;
    wire[2:0] nsSelOut, ps, out;
    wire[3:0] pss;

    assign nsSel1 = `S2;
    assign nsSel2 = `S3;
    assign nsSel4 = `S4;
    assign pss = {1'b0, ps};

    Reg #(3) regg (.data_in(nsSelOut), .clk(clk), .clr(rst), .en(1'b1), .data_out(ps));

    Mux2to1 #(3) mx1 (.A(`S0), .B(`S1), .S(start), .F(nsSel0));
    Mux2to1 #(3) mx2 (.A(`S1), .B(`S4), .S(done), .F(nsSel3));

    Mux16to1 #(3) mxx1 (.A(nsSel0), .B(nsSel1), .C(nsSel2), .D(nsSel3), .E(nsSel4), .F(), .G(), .H(), .I(), .J(), .K(), .L(), .M(), .N(), .O(), .P(), .S(pss), .FF(nsSelOut));
    Mux16to1 #(3) mxx2 (.A(3'b010), .B(3'b100), .C(3'b100), .D(3'b100), .E(3'b101), .F(), .G(), .H(), .I(), .J(), .K(), .L(), .M(), .N(), .O(), .P(), .S(pss), .FF(out));

    assign sel = out[2];
    assign ld = out[1];
    assign ctrDone = out[0];

endmodule