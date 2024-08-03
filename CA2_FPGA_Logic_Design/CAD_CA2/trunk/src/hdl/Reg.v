module Reg #(parameter DATA_WIDTH = 1) (input wire [DATA_WIDTH-1:0] data_in, input wire clk, clr,en, output reg [DATA_WIDTH-1:0] data_out);

    wire[DATA_WIDTH - 1 : 0] dataOut;

    genvar i;
    generate
        for (i = 0; i < DATA_WIDTH; i = i + 1) begin : gen_block
            S2 inst_s2 (
                .D00(data_out[i]),
                .D01(data_in[i]),
                .D10(1'b0),
                .D11(1'b0),
                .A1(1'b0),
                .B1(1'b0),
                .A0(en),
                .B0(1'b1),
                .clr(clr),
                .clk(clk),
                .out(dataOut[i])
            );
        end
    endgenerate

    assign data_out = dataOut;

endmodule