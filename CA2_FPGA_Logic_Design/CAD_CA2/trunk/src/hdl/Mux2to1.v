module Mux2to1 #(parameter INPUT_WIDTH = 1) (input [INPUT_WIDTH-1:0] A, B, input S, output reg [INPUT_WIDTH-1:0] F);

    wire [INPUT_WIDTH-1:0] fTemp;

    genvar i;
    generate
        for (i = 0; i < INPUT_WIDTH; i = i + 1) begin : mux_instances
            C1 mux_instance(.A0(A[i]), .A1(B[i]), .SA(S), .B0(1'b0), .B1(1'b0), .SB(1'b0), .S0(1'b0), .S1(1'b0), .F(fTemp[i]));
        end
    endgenerate

    assign F = fTemp;

endmodule