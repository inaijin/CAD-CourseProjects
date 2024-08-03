module BufferView (clk,WEview, REview ,viewIn,viewOut);

    input  clk,WEview, REview;
    output viewOut;
    reg[7:0] viewOut;
    input[127:0] viewIn;
    reg[127:0] buffView;

    always@(posedge clk) begin
        if(WEview) begin
            buffView = viewIn;
        end
        else if(REview) begin
            viewOut = buffView[127:120];
            buffView = {buffView[119:0], 8'bxxxxxxxx };
        end
    end

endmodule
