module S1(input D00, D01, D10, D11, A1, B1, A0, clr, clk, output reg out);

    wire S0, S1;
    reg muxOut;
    wire[1:0] S;

    assign S1 = A1 & B1;
    assign S0 = A0 & clr;

    assign S = {S1, S0};

    always @(*) begin

        case(S)
            2'b00: muxOut = D00;
            2'b01: muxOut = D01;
            2'b10: muxOut = D10;
            2'b11: muxOut = D11;
        endcase

    end

    always @(posedge clk) begin

        if(clr)
            out <= 0;
        else
            out <= muxOut;

    end

endmodule