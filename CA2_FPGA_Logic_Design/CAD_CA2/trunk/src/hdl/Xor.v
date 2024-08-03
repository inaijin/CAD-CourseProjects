module Xor #(parameter INPUT_WIDTH = 1) (input [INPUT_WIDTH-1:0] A, B,output reg [INPUT_WIDTH-1:0] F);

    wire [INPUT_WIDTH-1:0] fTemp;

    genvar i;
    generate
        for (i = 0; i < INPUT_WIDTH; i = i + 1) begin : mux_instances
            C2 xor_instance(.D00(1'b0), .D01(1'b1), .D10(1'b1), .D11(1'b0), .A1(A[i]), .B1(1'b0), .A0(B[i]), .B0(1'b1), .out(fTemp[i]));
        end
    endgenerate

    assign F = fTemp;

endmodule
