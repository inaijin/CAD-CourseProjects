module RELU(in, out);

    input[11:0] in;
    output[4:0] out;

    Mux2to1 #(5) mux(.A({in[11],in[6:3]}),.B(5'b00000),.S(in[11]),.F(out));

endmodule
