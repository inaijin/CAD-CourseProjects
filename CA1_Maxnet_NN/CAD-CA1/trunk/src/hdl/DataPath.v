module dataPath(x1, x2, x3, x4, w1, w2, done, max, clk, rst, ld, sel);

    input[31:0] x1, x2, x3, x4, w1, w2;
    output[31:0] max;
    reg[31:0] max;
    output done;
    reg done;
    input clk, rst, ld, sel;

    wire[31:0] memx1, memx2, memx3, memx4, wE, w11, outP1, outP2, outP3, outP4;
    wire[31:0] outMux1, outMux2, outMux3, outMux4, maxRes;
    wire[1:0] selD;
    wire doneRes;

    float_mem memory(.clk(clk), .load(ld), .d0(x1), .d1(x2), .d2(x3), .d3(x4), .d4(w1), .d5(w2), .q0(memx1), .q1(memx2), .q2(memx3), .q3(memx4), .q4(wE), .q5(w11));

    PU P1(.x1(outMux1), .x2(outMux2), .x3(outMux3), .x4(outMux4), .w1(w11), .w2(wE), .w3(wE), .w4(wE), .out(outP1), .clk(clk), .rst(rst));
    PU P2(.x1(outMux1), .x2(outMux2), .x3(outMux3), .x4(outMux4), .w1(wE), .w2(w11), .w3(wE), .w4(wE), .out(outP2), .clk(clk), .rst(rst));
    PU P3(.x1(outMux1), .x2(outMux2), .x3(outMux3), .x4(outMux4), .w1(wE), .w2(wE), .w3(w11), .w4(wE), .out(outP3), .clk(clk), .rst(rst));
    PU P4(.x1(outMux1), .x2(outMux2), .x3(outMux3), .x4(outMux4), .w1(wE), .w2(wE), .w3(wE), .w4(w11), .out(outP4), .clk(clk), .rst(rst));

    mux2to1 mux1(.input_0(memx1), .input_1(outP1), .sel(sel), .out(outMux1));
    mux2to1 mux2(.input_0(memx2), .input_1(outP2), .sel(sel), .out(outMux2));
    mux2to1 mux3(.input_0(memx3), .input_1(outP3), .sel(sel), .out(outMux3));
    mux2to1 mux4(.input_0(memx4), .input_1(outP4), .sel(sel), .out(outMux4));

    doneCheck Done(.a(outP1), .b(outP2), .c(outP3), .d(outP4), .out(doneRes), .sel(selD));
    mux_4to1 mux5(.in0(x1), .in1(x2), .in2(x3), .in3(x4), .sel(selD), .out(maxRes));

    assign done = doneRes;
    assign max = maxRes;

endmodule