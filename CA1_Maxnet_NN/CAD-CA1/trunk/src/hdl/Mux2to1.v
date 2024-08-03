module mux2to1(input_0, input_1, sel, out);

    input[31:0] input_0, input_1;
    input sel;
    output[31:0] out;

    assign out = sel ? input_1 : input_0;

endmodule