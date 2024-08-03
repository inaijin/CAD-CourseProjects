module WRDataReg(inputWR, clk,rstWR,ld, outWR ,fullWR , lastWR);
    input clk, rstWR, ld,lastWR;
    input[7:0] inputWR;
    output outWR , fullWR;
    reg[31:0] outWR;
    reg[2:0] counter = 3'b0;
    reg[31:0] regData;

    always@(posedge clk) begin
        if(rstWR) begin
            counter = 2'b0;
        end
        else if(ld) begin
            if(lastWR)begin
                regData ={regData[23:0],8'b0};
            end
            else begin
            regData ={regData[23:0],inputWR};
            end
            counter = counter + 1;
        end
    end

    
    assign fullWR = (counter == 3'd4) ? 1 : 0;
    assign outWR = (counter == 3'd4) ? regData : 32'bx;

endmodule
