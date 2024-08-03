module DataPath(input[31:0] DataInInit, input[6:0] x, y, z,input[1:0] sel,input ldAdr,rstX,clk,rstWR,ldWR,weMem, reMem , WeInit, rstCalc,enCalc,WEview, REview,WEFilter, REFilter, WETemp, RETemp, rstTemp,rstFilter,lastWR , output doneAdr,fullWR,calcDone,fullFilter, fullTemp , emptyTemp);

    wire [31:0] DataIn, DataOut;
    wire [6:0] AdrOut;
    wire [7:0] calcOut , FilterOut,ViewOut;
    wire [127:0] OutTemp;


    BufferTemp bt(.inbuffTemp(DataOut),.clk(clk), .WETemp(WETemp), .RETemp(RETemp), .rstTemp(rstTemp),.outBuffTemp(OutTemp),.emptyTemp(emptyTemp) , .fullTemp(fullTemp));
    BufferFilter bf(.clk(clk), .filterIn(DataOut), .WEFilter(WEFilter), .REFilter(REFilter), .filterOut(FilterOut), .fullFilter(fullFilter),.rstFilter(rstFilter));
    BufferView bv(.clk(clk),.WEview(WEview), .REview(REview) ,.viewIn(OutTemp),.viewOut(ViewOut));
    Calc calc(.ai(ViewOut), .bi(FilterOut), .clk(clk), .rst(rstCalc), .en(enCalc),.calcDone(calcDone),.calcOut(calcOut));
    Memory mem(.weInit(WeInit), .dataInInit(DataInInit), .dataIn(DataIn),.we(1'b0), .re(reMem), .clk(clk),.adr(AdrOut), .dataOut(DataOut));
    AddressGenerator adr(.x(x), .y(y), .z(z), .sel(sel),.ld(ldAdr),.rstX(rstX),.clk(clk),.adrOut(AdrOut),.doneAdr(doneAdr));
    WRDataReg wr(.inputWR(calcOut), .clk(clk),.rstWR(rstWR),.ld(ldWR), .outWR(DataIn) ,.fullWR(fullWR),.lastWR(lastWR));
    Memory memOut(.weInit(1'b0), .dataInInit(DataInInit), .dataIn(DataIn),.we(weMem), .re(1'b0), .clk(clk), .adr(AdrOut), .dataOut());

endmodule