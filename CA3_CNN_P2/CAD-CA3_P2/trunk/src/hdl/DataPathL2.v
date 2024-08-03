module DataPathL2(input [31:0]inpker,inpimage, input[1:0] sel, input ldAdr, rstX, clk, rstWR, ldWR, weMem, reMem, rstCalc, enCalc, WEview, REview, WEFilter, REFilter, WETemp, RETemp, rstTemp, rstFilter, lastWR, output doneAdr, fullWR, macDone, fullFilter, fullTemp, emptyTemp, output reg[11:0] macOO);

    wire [31:0] DataIn, DataOut;
    wire [6:0] AdrOut;
    wire [7:0] FilterOut,ViewOut;
    wire[11:0] macOut;
    wire [127:0] OutTemp;

    assign macOO = macOut;

    BufferMainL2 bm(.inbuffTemp(inpimage),.clk(clk), .WETemp(WETemp), .RETemp(RETemp), .rstTemp(rstTemp),.outBuffTemp(OutTemp),.emptyTemp(emptyTemp) , .fullTemp(fullTemp));
    BufferFilterL2 bf(.clk(clk), .filterIn(inpker), .WEFilter(WEFilter), .REFilter(REFilter), .filterOut(FilterOut), .fullFilter(fullFilter),.rstFilter(rstFilter));
    BufferViewL2 bv(.clk(clk),.WEview(WEview), .REview(REview) ,.viewIn(OutTemp),.viewOut(ViewOut));
    MACL2 mac(.viewIn(ViewOut), .filterIn(FilterOut), .clk(clk), .rst(rstCalc), .en(enCalc),.macDone(macDone),.macOut(macOut));
    // MemoryL2 mem(.dataIn(DataIn),.we(weMem), .re(reMem), .clk(clk),.adr(AdrOut), .dataOut(DataOut));
    // AddressGeneratorL2 adr(.x(x), .y(y), .z(z), .sel(sel),.ld(ldAdr),.rstX(rstX),.clk(clk),.adrOut(AdrOut),.doneAdr(doneAdr));
    // WRDataRegL2 wr(.inputWR(macOut), .clk(clk),.rstWR(rstWR),.ld(ldWR), .outWR(DataIn) ,.fullWR(fullWR),.lastWR(lastWR));

endmodule