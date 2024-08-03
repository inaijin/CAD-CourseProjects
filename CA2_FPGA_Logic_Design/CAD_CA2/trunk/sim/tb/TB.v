`timescale 1ns/1ns
module TB();

    wire[4:0] max;
    wire done;
    reg[4:0] x1, x2, x3, x4;
    reg[4:0] w1, w2;
    reg clk = 0, rst = 0, start = 0;

    Maxnet UUT(.x1(x1), .x2(x2), .x3(x3), .x4(x4), .w1(w1), .w2(w2), .done(done), .max(max), .clk(clk), .rst(rst), .start(start));

    always #5 clk = ~clk;

    initial begin
        #5 rst = 1;
        #5 rst = 0;
        #10 x1 = 5'b00010;
        x2 =  5'b00100;
        x3 = 5'b01000;
        x4 = 5'b10100;
        w1 = 5'b11110;
        w2 = 5'b01000;
        #10 start = 1;
        #10 start = 0;
        #500 $stop;
    end

endmodule