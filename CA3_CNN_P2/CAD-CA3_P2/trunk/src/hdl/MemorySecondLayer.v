`timescale 1ns/1ns
module Memory_Second_Layer(clk, rst, en, linierStart, computeStart, doneInit, doneFull, res);
    input clk, rst, en, linierStart, computeStart;
    reg[31:0] memory [0:42];
    reg[31:0] tempVal;
    reg[1375:0] LinierMem;
    output reg[31:0] res[0:127];
    output reg doneInit, doneFull;
    reg[1:0] counter_fill;
    reg[5:0] counteri, counterj;
    initial $readmemh("input.txt", memory);
    always@(posedge clk) begin
        if(rst) begin
            counter_fill = 2'b0;
            counteri = 6'b0;
        end
        else if(computeStart) begin 
            counterj = 6'b0;
        end
        else if(en) begin
            counter_fill = counter_fill + 1;
            counterj = counterj + 1;
        end
        else if(linierStart) begin 
            counteri = counteri + 1;
        end
    end
    always @(counteri) begin
        tempVal = memory[counteri];
        LinierMem = {LinierMem[1343:0], tempVal};
    end
    always @(counter_fill, counterj) begin
        if(en) begin
            res[counterj]  = (counter_fill == 2'b11) ? {LinierMem[1375:1368], 24'b0}: LinierMem[1375:1344];
            LinierMem = (counter_fill == 2'b11) ? {LinierMem[1367:0], 8'b0} : {LinierMem[1343:0], 32'b0};
        end
    end
    assign doneInit = (counteri == 6'd41) ? 1'b1 : 1'b0; 
    assign doneFull = (counterj == 6'd50) ? 1'b1 : 1'b0; 
endmodule
