module PU(x1, x2, x3, x4, w1, w2, w3, w4, out, clk, rst);

    input[4:0] x1, x2, x3, x4, w1, w2, w3, w4;
    output[4:0] out;
    reg[4:0] out;
    input clk, rst;

    wire[4:0] outX1, outX2, outX3, outX4, outW1, outW2, outW3, outW4;
    wire[9:0] outMX1W1, outMX2W2, outMX3W3, outMX4W4;
    wire[9:0] outRegX1W1, outRegX2W2, outRegX3W3, outRegX4W4;
    wire[10:0] out12, out34 ;
    wire cout12,cout34,coutf;
    wire[11:0] outFinalAdd;
    wire[4:0] outF, outRes;


    Reg #(5) regX1(.clk(clk), .clr(rst), .data_in(x1), .data_out(outX1),.en(1'b1));
    Reg #(5) regX2(.clk(clk), .clr(rst), .data_in(x2), .data_out(outX2),.en(1'b1));
    Reg #(5) regX3(.clk(clk), .clr(rst), .data_in(x3), .data_out(outX3),.en(1'b1));
    Reg #(5) regX4(.clk(clk), .clr(rst), .data_in(x4), .data_out(outX4),.en(1'b1));
    Reg #(5) regW1(.clk(clk), .clr(rst), .data_in(w1), .data_out(outW1),.en(1'b1));
    Reg #(5) regW2(.clk(clk), .clr(rst), .data_in(w2), .data_out(outW2),.en(1'b1));
    Reg #(5) regW3(.clk(clk), .clr(rst), .data_in(w3), .data_out(outW3),.en(1'b1));
    Reg #(5) regW4(.clk(clk), .clr(rst), .data_in(w4), .data_out(outW4),.en(1'b1));


    Multiplier MX1W1(.A(outX1), .B(outW1), .P(outMX1W1));
    Multiplier MX2W2(.A(outX2), .B(outW2), .P(outMX2W2));
    Multiplier MX3W3(.A(outX3), .B(outW3), .P(outMX3W3));
    Multiplier MX4W4(.A(outX4), .B(outW4), .P(outMX4W4));

    Reg #(10) regMX1W1(.clk(clk), .clr(rst), .data_in(outMX1W1), .data_out(outRegX1W1),.en(1'b1));
    Reg #(10) regMX2W2(.clk(clk), .clr(rst), .data_in(outMX2W2), .data_out(outRegX2W2),.en(1'b1));
    Reg #(10) regMX3W3(.clk(clk), .clr(rst), .data_in(outMX3W3), .data_out(outRegX3W3),.en(1'b1));
    Reg #(10) regMX4W4(.clk(clk), .clr(rst), .data_in(outMX4W4), .data_out(outRegX4W4),.en(1'b1));

    Adder #(11) add12(.A({outRegX1W1[9],outRegX1W1}), .B({outRegX2W2[9],outRegX2W2}),.Cin(1'b0),.Cout(cout12), .S(out12));
    Adder #(11) add34(.A({outRegX3W3[9],outRegX3W3}), .B({outRegX4W4[9],outRegX4W4}),.Cin(1'b0),.Cout(cout34), .S(out34));

    Adder #(12) addFinal(.A({out12[9],out12}), .B({out34[9],out34}),.Cin(1'b0),.Cout(coutf) ,.S(outFinalAdd));

    RELU F(.in(outFinalAdd), .out(outF));

    Reg #(5) regResult(.clk(clk), .clr(rst), .data_in(outF), .data_out(outRes),.en(1'b1));

    assign out = outRes;

endmodule
