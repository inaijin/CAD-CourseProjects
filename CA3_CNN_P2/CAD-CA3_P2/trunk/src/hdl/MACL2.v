module MACL2(input[7:0] viewIn, filterIn, input clk, rst, en, output macDone, output reg[11:0] macOut);

    reg[15:0] sum = 16'b0;
    reg[7:0] multiply = 8'b0;
    reg[11:0] regMAC = 12'b0;
    reg[7:0] out;
    reg[4:0] counter = 5'b0;
    reg last;

    always@(posedge clk) begin

        if(rst) begin
            counter = 5'b0;
            regMAC = 12'b0;
        end

        if(last)begin
            out = regMAC;
            last = 1'b0;
        end

        else if(en) begin

            if(counter == 5'b10000)
                last = 1'b1;
            if(counter == 5'b00000)
                counter = counter + 1;
            else begin

                sum = filterIn * viewIn;
                multiply = sum[15:8];
                regMAC = regMAC + multiply;
                counter = counter + 1;

            end

        end

    end

    assign macOut = out;
    assign macDone = (counter == 5'b10000) ? 1 : 0;

endmodule