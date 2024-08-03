module MemInit #(parameter MacCount = 1, MemSize = 64 + (4 * MacCount), MemWidth = 32)(input [7:0] address, output reg [MemWidth - 1 : 0] data);

    reg[MemWidth - 1 : 0] memInit[0: MemSize - 1];

    initial begin
        $readmemh("file/input.txt", memInit);
    end

    always @(*) begin
        data = memInit[address];
    end

endmodule