module C2(input D00, D01, D10, D11, A1, B1, A0, B0, output reg out);

    wire S0, S1;
    wire[1:0] S;

    assign S1 = A1 | B1;
    assign S0 = A0 & B0;

    assign S = {S1, S0};

    always @(*) begin

        case(S)
            2'b00: out = D00;
            2'b01: out = D01;
            2'b10: out = D10;
            2'b11: out = D11;
        endcase

    end

endmodule