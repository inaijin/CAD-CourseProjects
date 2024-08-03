module MemoryL2(input[31:0] dataIn, input we, re, clk, input[6:0] adr, output reg[31:0] dataOut);

    reg[31:0] memory[0:127];

    // For Test Case 1234:
    initial $readmemh("file/test1234.txt", memory);

    // For Test Case 2345:
    // initial $readmemh("file/test2345.txt", memory);

    // For Test Case 3456:
    // initial $readmemh("file/test3456.txt", memory);

    always@(posedge clk) begin

        if(we)
            memory[adr] = dataIn;

    end

    assign dataOut = (re) ? memory[adr] : 31'dx;

endmodule