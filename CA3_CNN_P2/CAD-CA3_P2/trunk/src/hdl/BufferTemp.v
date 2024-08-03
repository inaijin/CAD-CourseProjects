module BufferTemp (inbuffTemp,clk, WETemp, RETemp, rstTemp,outBuffTemp,emptyTemp , fullTemp);
    input[31:0] inbuffTemp;
    input clk,WETemp, RETemp,rstTemp;
    output  emptyTemp , fullTemp;
    output outBuffTemp;
    reg[127:0] outBuffTemp;
    reg[2:0] counterColumn = 3'b0, counterRow = 3'b0;
    reg[3:0] counterOut = 4'b0;
    reg[127:0] buffTemp[0:3];

    always@(counterColumn) begin
        if(counterColumn == 3'b100) begin
            if(counterRow!= 3'b011)begin
            buffTemp[0] = buffTemp[1];
            buffTemp[1] = buffTemp[2];
            buffTemp[2] = buffTemp[3];
            end
            counterRow = counterRow + 1;
            counterColumn = 3'd0;
        end
    end

     

    always@(posedge clk) begin
        if(rstTemp)begin
            buffTemp[0] = 128'b0;

            buffTemp[1] = 128'b0;

            buffTemp[2] = 128'b0;

            buffTemp[3] = 128'b0;

            counterColumn = 3'b0;

            counterRow = 3'b0;
            counterOut = 4'b0;
        end
        else if(RETemp) begin
            outBuffTemp = {buffTemp[0][127:96], buffTemp[1][127:96], buffTemp[2][127:96], buffTemp[3][127:96]};
            buffTemp[0] = {buffTemp[0][119:0], 8'bxxxxxxxx};

            buffTemp[1] = {buffTemp[1][119:0], 8'bxxxxxxxx};

            buffTemp[2] = {buffTemp[2][119:0], 8'bxxxxxxxx};

            buffTemp[3] = {buffTemp[3][119:0], 8'bxxxxxxxx};

            counterOut = counterOut + 1;
        end
        else if(WETemp) begin
            if(!fullTemp)begin
                buffTemp[3] = {buffTemp[3][95:0], inbuffTemp};
                counterColumn = counterColumn + 1;
            end
        end
        
    end

    
    assign emptyTemp = (counterOut == 4'd13) ? 1 : 0;
    assign fullTemp = (counterRow== 3'b100) ? 1 : 0;
    

endmodule
