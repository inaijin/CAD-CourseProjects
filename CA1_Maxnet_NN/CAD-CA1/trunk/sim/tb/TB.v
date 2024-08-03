`timescale 1ns/1ns
module MaxnetTB();

    wire[31:0] max;
    wire done;
    reg[31:0] x1, x2, x3, x4;
    reg[31:0] w1, w2;
    reg clk = 0, rst = 0, start = 0;

    Maxnet UUT(.x1(x1), .x2(x2), .x3(x3), .x4(x4), .w1(w1), .w2(w2), .done(done), .max(max), .clk(clk), .rst(rst), .start(start));

    always #5 clk = ~clk;

    initial begin
        #5 rst = 1;
        #5 rst = 0;
        #10 x1 = 32'h3E4CCCCD;
        x2 = 32'h3ECCCCCD;
        x3 = 32'h3F19999A;
        x4 = 32'h3F4CCCCD;
        w1 = 32'hBE4CCCCD;
        w2 = 32'h3F800000;
        #10 start = 1;
        #10 start = 0;
        #160 $stop;
    end

endmodule