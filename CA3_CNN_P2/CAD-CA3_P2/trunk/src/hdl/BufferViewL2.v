module BufferViewL2 (input clk, WEview, REview, input[127:0] viewIn, output reg[7:0] viewOut);

    reg[127:0] buffView;

    always@(posedge clk) begin

        if(WEview)
            buffView = viewIn;

        else if(REview) begin

            viewOut = buffView[127:120];
            buffView = {buffView[119:0], 8'bxxxxxxxx};

        end

    end

endmodule