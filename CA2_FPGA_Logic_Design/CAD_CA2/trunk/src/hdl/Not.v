module Not #(parameter INPUT_SIZE = 1) (input [INPUT_SIZE-1:0] A, output [INPUT_SIZE-1:0] F);

    wire [INPUT_SIZE-1:0] fTemp;

    genvar i;
    generate
        for (i = 0; i < INPUT_SIZE; i = i + 1) begin : gen_loop
            C1 u1 (.A0(1'b1), .A1(1'b0), .SA(A[i]), .B0(1'b0), .B1(1'b0), .SB(1'b0), .S0(1'b0), .S1(1'b0), .F(fTemp[i]));
        end
    endgenerate

    assign F = fTemp;

endmodule