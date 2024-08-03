module AdrGenInit #(parameter macCount = 1)(input clk, rst, input[7:0] adrX, adrY, output reg[7:0] adr, output reg[macCount - 1 : 0] enables, output reg adrDone = 1'b0);

    reg [7:0] xCounter = 8'b0;
    reg [7:0] yCounter = 8'b0;
    reg [7:0] select = 8'b0;

    always @(posedge clk, posedge rst) begin

        if (rst) begin 
            xCounter = 8'b0;
            yCounter = 8'b0;
            select = 8'b0;
            enables = {(macCount){1'b0}}; 
        end

        if (xCounter < 8'd64) begin
            adr = adrX + xCounter;
            enables = {(macCount){1'b1}};
            xCounter = xCounter + 8'd1;
        end
        else begin
            if (adrDone == 1'b1) begin enables = {(macCount){1'b0}}; end
            if (adrDone == 1'b0) begin
                enables = {(macCount){1'b0}};
                adr = adrY + yCounter;
                yCounter = yCounter + 8'd1;
                enables[select] = 1'b1;
                if (!(yCounter % 8'd4) && (yCounter != 8'b0)) begin
                    select = select + 8'd1;
                end
                if (select == macCount) begin adrDone = 1'b1; end
            end
        end

    end

endmodule