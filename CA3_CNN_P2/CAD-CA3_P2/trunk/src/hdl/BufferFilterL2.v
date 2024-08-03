module BufferFilterL2 (input clk, input[31:0] filterIn, input WEFilter, REFilter, output reg[7:0] filterOut, output fullFilter, input rstFilter);

    reg[2:0] counterWrite = 3'b0;
    reg[3:0] counterShift = 4'b0;
    reg[127:0] buffF, tempBuff;

    always@(posedge clk) begin

        if(rstFilter)
            counterShift = 4'b0;

        if(REFilter) begin

            if(counterShift == 4'b0000)
                tempBuff = buffF;

            filterOut = tempBuff[127:120];
            tempBuff = {tempBuff[119:0],8'bxxxxxxxx};
            counterShift = counterShift + 1;

        end

        else if(WEFilter) begin

            buffF = {buffF[95:0], filterIn};
            counterWrite = counterWrite + 1;

        end

    end

    assign fullFilter = (counterWrite == 3'b100) ? 1 : 0;

endmodule