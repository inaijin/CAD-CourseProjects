module Or #(parameter INPUT_SIZE = 1)(input [INPUT_SIZE-1:0] A, B, output reg [INPUT_SIZE-1:0] F);

    wire [INPUT_SIZE-1:0] fTemp;

    genvar i;
    generate
        for (i = 0; i < INPUT_SIZE; i = i + 1) begin
            C2 u_C22 (
                .D00(1'b0),
                .D01(1'b0),
                .D10(1'b1),
                .D11(1'b0),
                .A1(A[i]),
                .B1(B[i]),
                .A0(1'b0),
                .B0(1'b0),
                .out(fTemp[i])
            );
        end
    endgenerate

    assign F = fTemp;

endmodule