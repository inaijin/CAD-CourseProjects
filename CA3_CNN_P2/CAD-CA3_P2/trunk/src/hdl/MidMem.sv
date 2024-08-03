module Memory_Mid#(parameter string filename,parameter int unsigned m = 0)(clk, rst, en, linierStart, computeStart, doneInit, doneFull, dataIn, dataInInit, weInit, we, reMem , adr, adr2, dataOut, dataOut1, dataOut2, dataOut3, dataOut4, z);

    input[31:0] dataIn;
    input[31:0] dataInInit;
    input[6:0] adr, adr2;
    input[6:0] z;
    input we, reMem, clk, weInit;
    output dataOut, dataOut1, dataOut2, dataOut3, dataOut4;
    reg[31:0] dataOut, dataOut1, dataOut2, dataOut3, dataOut4;
    reg[31:0] memory[0:127];
    reg[6:0] counter = 7'b0;
    input rst, en, linierStart, computeStart;
    reg[31:0] tempVal;
    reg[1375:0] LinierMem;
    reg[31:0] res[0:127];
    output reg doneInit, doneFull;
    reg[1:0] counter_fill;
    reg[5:0] counteri, counterj;
    initial begin
        $readmemh(filename,res, m); 
    end

    always@(posedge clk) begin

        if(we) begin
            memory[adr] = dataIn;
        end

        if(weInit) begin
            memory[counter] = dataInInit;
            counter = counter + 1;
        end

    end

    assign dataOut = (reMem) ? res[adr2] : 31'dx;
    assign dataOut1 = (reMem) ? res[adr2] : 31'dx;
    assign dataOut2 = (reMem) ? res[adr2 + 4] : 31'dx;
    assign dataOut3 = (reMem) ? res[adr2 + 8] : 31'dx;
    assign dataOut4 = (reMem) ? res[adr2 + 12] : 31'dx;

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
        tempVal = memory[counteri + z];
        LinierMem = {LinierMem[1343:0], tempVal};
    end
    always @(counter_fill, counterj) begin
        if(en) begin
            res[counterj + z]  = (counter_fill == 2'b11) ? {LinierMem[1375:1368], 24'b0}: LinierMem[1375:1344];
            LinierMem = (counter_fill == 2'b11) ? {LinierMem[1367:0], 8'b0} : {LinierMem[1343:0], 32'b0};
        end
    end

    assign doneInit = (counteri == 6'd41) ? 1'b1 : 1'b0; 
    assign doneFull = (counterj == 6'd50) ? 1'b1 : 1'b0; 

endmodule

