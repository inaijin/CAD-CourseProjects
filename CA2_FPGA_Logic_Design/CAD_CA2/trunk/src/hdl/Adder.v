module Adder #(parameter INPUT_SIZE = 1) (input [INPUT_SIZE-1:0] A,B,input Cin, output [INPUT_SIZE-1:0] S,output Cout);

    wire [INPUT_SIZE-1:0] sTemp;
    wire [INPUT_SIZE:0] c;
    assign c[0] = Cin;
    assign Cout = c[INPUT_SIZE];

    genvar i;
    generate
        for (i = 0; i < INPUT_SIZE; i = i + 1) begin : gen_loop
            Fadder f(.A(A[i]),.B(B[i]), .Cin(c[i]), .S(S[i]) , .Cout(c[i+1]));
        end
    endgenerate


endmodule
