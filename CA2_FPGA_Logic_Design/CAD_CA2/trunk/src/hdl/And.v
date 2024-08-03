module And #(parameter INPUT_SIZE = 1)(input [INPUT_SIZE-1:0] A, B, output reg [INPUT_SIZE-1:0] F);

    wire [INPUT_SIZE-1:0] fTemp;

    genvar i;
    generate
        for (i = 0; i < INPUT_SIZE; i = i + 1) begin
            C2 u_C2 (
                .D00(1'b0),
                .D01(1'b0),
                .D10(1'b0),
                .D11(1'b1),
                .A1(1'b1),
                .B1(1'b1),
                .A0(A[i]),
                .B0(B[i]),
                .out(fTemp[i])
            );
        end
    endgenerate

    assign F = fTemp;

endmodule