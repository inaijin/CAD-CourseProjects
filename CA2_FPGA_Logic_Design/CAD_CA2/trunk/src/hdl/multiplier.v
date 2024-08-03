module Multiplier(input [4:0] A, input [4:0] B, output [9:0] P);

    wire[4:0] AF, BF, compATemp, compBTemp, compA, compB;
    wire[9:0] compResTemp, compRes;
    wire sign;
    wire [9:0] sum;

    Not #(5) compa (.A(A), .F(compATemp));
    Adder #(5) full_addera (.A(compATemp), .B(5'b0), .Cin(1'b1), .S(compA), .Cout());

    Not #(5) compb (.A(B), .F(compBTemp));
    Adder #(5) full_adderb (.A(compBTemp), .B(5'b0), .Cin(1'b1), .S(compB), .Cout());

    Not #(10) compRess (.A(sum), .F(compResTemp));
    Adder #(10) full_adderres (.A(compResTemp), .B(10'b0), .Cin(1'b1), .S(compRes), .Cout());

    Mux2to1 #(5) mx1 (.A(A), .B(compA), .S(A[4]), .F(AF));
    Mux2to1 #(5) mx2 (.A(B), .B(compB), .S(B[4]), .F(BF));

    Mux2to1 #(10) mx3 (.A(sum), .B(compRes), .S(sign), .F(P));

    Xor xor1 (.A(A[4]), .B(B[4]), .F(sign));

    wire [4:0] partial_products [0:4];

    wire[3:0] inner [0:3];
    wire[2:0] inSum [0:3];

    genvar i, j;
    generate
        for (i = 0; i < 5; i = i + 1) begin
        for (j = 0; j < 5; j = j + 1) begin
            And #(1) and_gate (
            .A(AF[i]),
            .B(BF[j]),
            .F(partial_products[i][j])
            );
        end
        end
    endgenerate

    assign sum[0] = partial_products[0][0];

    Fadder full_adder1 (.A(partial_products[1][0]), .B(partial_products[0][1]), .Cin(1'b0), .S(sum[1]), .Cout(inner[0][0]));
    Fadder full_adder2 (.A(partial_products[2][0]), .B(partial_products[1][1]), .Cin(1'b0), .S(inSum[0][0]), .Cout(inner[0][1]));
    Fadder full_adder3 (.A(partial_products[3][0]), .B(partial_products[2][1]), .Cin(1'b0), .S(inSum[0][1]), .Cout(inner[0][2]));
    Fadder full_adder4 (.A(partial_products[4][0]), .B(partial_products[3][1]), .Cin(1'b0), .S(inSum[0][2]), .Cout(inner[0][3]));

    genvar k, h;
    generate
        for (k = 0; k < 3; k = k + 1) begin
            Fadder full_adderr5 (.A(inSum[k][0]), .B(partial_products[0][k + 2]), .Cin(inner[k][0]), .S(sum[k + 2]), .Cout(inner[k + 1][0]));
        for (h = 0; h < 2; h = h + 1) begin
            Fadder full_adderr6 (.A(inSum[k][h + 1]), .B(partial_products[h + 1][k + 2]), .Cin(inner[k][h + 1]), .S(inSum[k + 1][h]), .Cout(inner[k + 1][h + 1]));
        end
            Fadder full_adderr7 (.A(partial_products[4][k + 1]), .B(partial_products[3][k + 2]), .Cin(inner[k][3]), .S(inSum[k + 1][2]), .Cout(inner[k + 1][3]));
        end
    endgenerate

    wire co1, co2, co3;

    Fadder full_adder8 (.A(inSum[3][0]), .B(1'b0), .Cin(inner[3][0]), .S(sum[5]), .Cout(co1));
    Fadder full_adder9 (.A(inSum[3][1]), .B(co1), .Cin(inner[3][1]), .S(sum[6]), .Cout(co2));
    Fadder full_adder10 (.A(inSum[3][2]), .B(co2), .Cin(inner[3][2]), .S(sum[7]), .Cout(co3));
    Fadder full_adder11 (.A(partial_products[4][4]), .B(co3), .Cin(inner[3][3]), .S(sum[8]), .Cout(sum[9]));

endmodule