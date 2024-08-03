module Mux4to1 #(parameter INPUT_WIDTH = 1) (input [INPUT_WIDTH-1:0] A, B, C, D, input[1:0] S, output [INPUT_WIDTH-1:0] F);

    wire [INPUT_WIDTH-1:0] fTemp;

    genvar i;
    generate
        for (i = 0; i < INPUT_WIDTH; i = i + 1) begin : mux_instances
            C2 mux_instance(.D00(A[i]), .D01(B[i]), .D10(C[i]), .D11(D[i]), .A1(S[1]), .B1(1'b0), .A0(S[0]), .B0(1'b1), .out(fTemp[i]));
        end
    endgenerate

    assign F = fTemp;

endmodule