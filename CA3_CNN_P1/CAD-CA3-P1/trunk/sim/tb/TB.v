`timescale 1ns/1ns

module TB();
 
    reg clk = 1'b0;
    reg rst = 1'b0;
    reg start = 1'b0;
    reg [7:0] x_adr = 8'd16;
    reg [7:0] y_adr = 8'd0;
    reg [6:0] z_adr = 7'd15;
    wire done;

    TopLevel#(4) topM(clk, start, x_adr, y_adr , z_adr, done);

    always #1 clk = ~clk;

    initial begin
        #2 start = 1'b1;
        #2 start = 1'b0;
        #10000 $stop;
    end

endmodule