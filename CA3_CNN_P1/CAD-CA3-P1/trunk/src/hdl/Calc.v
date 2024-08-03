module Calc(ai, bi, clk, rst, en,calcDone,calcOut);

    
    input clk, rst, en;
    input [7:0] ai, bi;
    output calcDone;
    output calcOut;
    reg[7:0] calcOut;
    reg[15:0] sum = 16'b0;
    reg[7:0]  multiplie = 8'b0;
    reg[11:0] regCalc = 12'b0;
    reg[7:0] out ;
    reg[4:0] counter = 5'b0;
    reg last;

    always@(posedge clk) begin
        if(rst) begin
            counter = 5'b0;
            regCalc = 12'b0;
        end
        if(last)begin
            out = regCalc[11:4];
            last = 1'b0;
        end
        else if(en) begin
             if(counter == 5'b10000)begin
                last = 1'b1;
            end
            if(counter == 5'b00000)begin
                counter = counter + 1;
            end
            else begin
                sum = bi * ai;
                multiplie = sum[15:8];
                regCalc = regCalc + multiplie;
                counter = counter + 1;
            end
        end
    end
    assign calcOut = out;
    assign calcDone = (counter == 5'b10000) ? 1 : 0;
    

endmodule
