module Maxnet(x1, x2, x3, x4, w1, w2, done, max, clk, rst, start);

    input[31:0] x1, x2, x3, x4, w1, w2;
    input clk, rst, start;
    output[31:0] max;
    output done;
    reg[31:0] max;
    reg done;

    wire ld, sel, doneDP;
    wire[31:0] maxRes;
    wire ctrDone;

    dataPath dp(.x1(x1), .x2(x2), .x3(x3), .x4(x4), .w1(w1), .w2(w2), .done(doneDP), .max(maxRes), .clk(clk), .rst(rst), .ld(ld), .sel(sel));
    Controller ctr(.done(doneDP), .sel(sel), .ld(ld), .clk(clk), .rst(rst), .start(start),.ctrDone(ctrDone));

    assign done = ctrDone;
    assign max = maxRes;

endmodule