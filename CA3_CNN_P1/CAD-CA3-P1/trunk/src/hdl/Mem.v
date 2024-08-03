module Memory(dataIn, dataInInit, weInit, we, re, clk, adr, dataOut);

    input[31:0] dataIn;
    input[31:0] dataInInit;
    input[6:0] adr;
    input we, re, clk, weInit;
    output dataOut;
    reg[31:0] dataOut;
    reg[31:0] memory[0:127];
    reg[6:0] counter = 7'b0;

    always@(posedge clk) begin

        if(we) begin
            memory[adr] = dataIn;
        end

        if(weInit) begin
            memory[counter] = dataInInit;
            counter = counter + 1;
        end

    end

    assign dataOut = (re) ? memory[adr] : 31'dx;

endmodule