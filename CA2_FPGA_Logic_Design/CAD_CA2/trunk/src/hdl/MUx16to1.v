module Mux16to1 #(parameter INPUT_WIDTH = 1) (input [INPUT_WIDTH-1:0] A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, input[3:0] S, output [INPUT_WIDTH-1:0] FF);

    wire [INPUT_WIDTH-1 : 0] M1, M2, M3, M4;

    Mux4to1 #(INPUT_WIDTH) mux1 (.A(A), .B(B), .C(C), .D(D), .S(S[1:0]), .F(M1));
    Mux4to1 #(INPUT_WIDTH) mux2 (.A(E), .B(F), .C(G), .D(H), .S(S[1:0]), .F(M2));
    Mux4to1 #(INPUT_WIDTH) mux3 (.A(I), .B(J), .C(K), .D(L), .S(S[1:0]), .F(M3));
    Mux4to1 #(INPUT_WIDTH) mux4 (.A(M), .B(N), .C(O), .D(P), .S(S[1:0]), .F(M4));

    Mux4to1 #(INPUT_WIDTH) mux5 (.A(M1), .B(M2), .C(M3), .D(M4), .S(S[3:2]), .F(FF));

endmodule
