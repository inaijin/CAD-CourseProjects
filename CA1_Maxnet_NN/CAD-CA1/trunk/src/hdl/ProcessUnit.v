module PU(x1, x2, x3, x4, w1, w2, w3, w4, out, clk, rst);

    input[31:0] x1, x2, x3, x4, w1, w2, w3, w4;
    output[31:0] out;
    reg[31:0] out;
    input clk, rst;

    wire[31:0] outX1, outX2, outX3, outX4, outW1, outW2, outW3, outW4, outMX1W1, outMX2W2, outMX3W3, outMX4W4;
    wire[31:0] outRegX1W1, outRegX2W2, outRegX3W3, outRegX4W4, out12, out34, outFinalAdd, outF, outRes;

    float_reg regX1(.clk(clk), .reset(rst), .d(x1), .q(outX1));
    float_reg regX2(.clk(clk), .reset(rst), .d(x2), .q(outX2));
    float_reg regX3(.clk(clk), .reset(rst), .d(x3), .q(outX3));
    float_reg regX4(.clk(clk), .reset(rst), .d(x4), .q(outX4));
    float_reg regW1(.clk(clk), .reset(rst), .d(w1), .q(outW1));
    float_reg regW2(.clk(clk), .reset(rst), .d(w2), .q(outW2));
    float_reg regW3(.clk(clk), .reset(rst), .d(w3), .q(outW3));
    float_reg regW4(.clk(clk), .reset(rst), .d(w4), .q(outW4));

    Multiplier MX1W1(.A(outX1), .B(outW1), .out(outMX1W1));
    Multiplier MX2W2(.A(outX2), .B(outW2), .out(outMX2W2));
    Multiplier MX3W3(.A(outX3), .B(outW3), .out(outMX3W3));
    Multiplier MX4W4(.A(outX4), .B(outW4), .out(outMX4W4));

    float_reg regMX1W1(.clk(clk), .reset(rst), .d(outMX1W1), .q(outRegX1W1));
    float_reg regMX2W2(.clk(clk), .reset(rst), .d(outMX2W2), .q(outRegX2W2));
    float_reg regMX3W3(.clk(clk), .reset(rst), .d(outMX3W3), .q(outRegX3W3));
    float_reg regMX4W4(.clk(clk), .reset(rst), .d(outMX4W4), .q(outRegX4W4));

    float_add add12(.A(outRegX1W1), .B(outRegX2W2), .result(out12));
    float_add add34(.A(outRegX3W3), .B(outRegX4W4), .result(out34));

    float_add addFinal(.A(out12), .B(out34), .result(outFinalAdd));

    RELU F(.in(outFinalAdd), .out(outF));

    float_reg regResult(.clk(clk), .reset(rst), .d(outF), .q(outRes));

    assign out = outRes;

endmodule