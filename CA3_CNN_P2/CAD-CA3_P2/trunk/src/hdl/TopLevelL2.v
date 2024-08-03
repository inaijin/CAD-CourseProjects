module TopLevelL2(input clk, start, input[6:0] X, Y, Z, output done);

    wire ldAdr, rstX, rstWR, ldWR, weMem, reMem, rstCalc, enCalc, WEview, REview, WEFilter, REFilter, WETemp, RETemp, rstTemp, rstFilter, doneAdr, fullWR, macDone, fullFilter, fullTemp, emptyTemp, lastWR;
    wire[1:0] sel;

    ControllerL2 ctr(.sel(sel), .start(start), .ldAdr(ldAdr), .rstX(rstX), .clk(clk), .rstWR(rstWR), .ldWR(ldWR), .weMem(weMem), .reMem(reMem), .rstCalc(rstCalc), .enCalc(enCalc), .WEview(WEview), .REview(REview), .WEFilter(WEFilter), .REFilter(REFilter),
    .WETemp(WETemp), .RETemp(RETemp), .rstTemp(rstTemp), .rstFilter(rstFilter), .lastWR(lastWR), .doneAdr(doneAdr), .fullWR(fullWR), .macDone(macDone), .fullFilter(fullFilter), .fullTemp(fullTemp), .emptyTemp(emptyTemp), .done(done));

    DataPathL2 dp(.x(X), .y(Y), .z(Z), .sel(sel), .ldAdr(ldAdr), .rstX(rstX), .clk(clk), .rstWR(rstWR), .ldWR(ldWR), .weMem(weMem), .reMem(reMem), .rstCalc(rstCalc), .enCalc(enCalc), .WEview(WEview),
    .REview(REview), .WEFilter(WEFilter), .REFilter(REFilter), .WETemp(WETemp), .RETemp(RETemp), .rstTemp(rstTemp), .rstFilter(rstFilter), .lastWR(lastWR), .doneAdr(doneAdr), .fullWR(fullWR), .macDone(macDone), .fullFilter(fullFilter), .fullTemp(fullTemp), .emptyTemp(emptyTemp), .macOO());

    DataPathL2 dp1(.x(X), .y(Y), .z(Z), .sel(sel), .ldAdr(ldAdr), .rstX(rstX), .clk(clk), .rstWR(rstWR), .ldWR(ldWR), .weMem(weMem), .reMem(reMem), .rstCalc(rstCalc), .enCalc(enCalc), .WEview(WEview),
    .REview(REview), .WEFilter(WEFilter), .REFilter(REFilter), .WETemp(WETemp), .RETemp(RETemp), .rstTemp(rstTemp), .rstFilter(rstFilter), .lastWR(lastWR), .doneAdr(doneAdr), .fullWR(fullWR), .macDone(macDone), .fullFilter(fullFilter), .fullTemp(fullTemp), .emptyTemp(emptyTemp), .macOO());

    DataPathL2 dp2(.x(X), .y(Y), .z(Z), .sel(sel), .ldAdr(ldAdr), .rstX(rstX), .clk(clk), .rstWR(rstWR), .ldWR(ldWR), .weMem(weMem), .reMem(reMem), .rstCalc(rstCalc), .enCalc(enCalc), .WEview(WEview),
    .REview(REview), .WEFilter(WEFilter), .REFilter(REFilter), .WETemp(WETemp), .RETemp(RETemp), .rstTemp(rstTemp), .rstFilter(rstFilter), .lastWR(lastWR), .doneAdr(doneAdr), .fullWR(fullWR), .macDone(macDone), .fullFilter(fullFilter), .fullTemp(fullTemp), .emptyTemp(emptyTemp), .macOO());

    DataPathL2 dp3(.x(X), .y(Y), .z(Z), .sel(sel), .ldAdr(ldAdr), .rstX(rstX), .clk(clk), .rstWR(rstWR), .ldWR(ldWR), .weMem(weMem), .reMem(reMem), .rstCalc(rstCalc), .enCalc(enCalc), .WEview(WEview),
    .REview(REview), .WEFilter(WEFilter), .REFilter(REFilter), .WETemp(WETemp), .RETemp(RETemp), .rstTemp(rstTemp), .rstFilter(rstFilter), .lastWR(lastWR), .doneAdr(doneAdr), .fullWR(fullWR), .macDone(macDone), .fullFilter(fullFilter), .fullTemp(fullTemp), .emptyTemp(emptyTemp), .macOO());

endmodule