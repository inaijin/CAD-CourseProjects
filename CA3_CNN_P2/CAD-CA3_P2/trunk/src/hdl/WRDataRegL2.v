module WRDataRegL2(input[7:0] inputWR, input clk, rstWR, ld, output reg[31:0] outWR, output fullWR, input lastWR);

    reg[2:0] counter = 3'b0;
    reg[31:0] regData;

    always@(posedge clk) begin

        if(rstWR)
            counter = 2'b0;

        else if(ld) begin

            if(lastWR)
                regData = 32'bx;
            else
                regData ={regData[23:0],inputWR};

            counter = counter + 1;

        end

    end

    assign fullWR = (counter == 3'd4) ? 1 : 0;
    assign outWR = (counter == 3'd4) ? regData : 32'bx;

endmodule