module dataPath(x1, x2, x3, x4, w1, w2, done, max, clk, rst, ld, sel);

    input[4:0] x1, x2, x3, x4, w1, w2;
    output[4:0] max;
    output done;
    input clk, rst, ld, sel;

    wire[4:0] memx1, memx2, memx3, memx4, wE, w11, outP1, outP2, outP3, outP4;
    wire[4:0] outMux1, outMux2, outMux3, outMux4, maxRes;
    wire[1:0] selD;

    mem memory(.clk(clk), .load(ld), .d0(x1), .d1(x2), .d2(x3), .d3(x4), .d4(w1), .d5(w2), .q0(memx1), .q1(memx2), .q2(memx3), .q3(memx4), .q4(wE), .q5(w11));

    PU P1(.x1(outMux1), .x2(outMux2), .x3(outMux3), .x4(outMux4), .w1(w11), .w2(wE), .w3(wE), .w4(wE), .out(outP1), .clk(clk), .rst(rst));
    PU P2(.x1(outMux1), .x2(outMux2), .x3(outMux3), .x4(outMux4), .w1(wE), .w2(w11), .w3(wE), .w4(wE), .out(outP2), .clk(clk), .rst(rst));
    PU P3(.x1(outMux1), .x2(outMux2), .x3(outMux3), .x4(outMux4), .w1(wE), .w2(wE), .w3(w11), .w4(wE), .out(outP3), .clk(clk), .rst(rst));
    PU P4(.x1(outMux1), .x2(outMux2), .x3(outMux3), .x4(outMux4), .w1(wE), .w2(wE), .w3(wE), .w4(w11), .out(outP4), .clk(clk), .rst(rst));


    Mux2to1 #(5) mux1(.A(memx1), .B(outP1), .S(sel), .F(outMux1));
    Mux2to1 #(5) mux2(.A(memx2), .B(outP2), .S(sel), .F(outMux2));
    Mux2to1 #(5) mux3(.A(memx3), .B(outP3), .S(sel), .F(outMux3));
    Mux2to1 #(5) mux4(.A(memx4), .B(outP4), .S(sel), .F(outMux4));

    doneCheck Done(.a(outP1), .b(outP2), .c(outP3), .d(outP4), .out(done), .sel(selD));
    Mux4to1 #(5) mux5(.A(x1), .B(x2), .C(x3), .D(x4), .S(selD), .F(maxRes));

    Reg #(5) regRes(.data_in(maxRes),.clk(clk), .clr(rst),.en(1'b1),.data_out(max));


endmodule
