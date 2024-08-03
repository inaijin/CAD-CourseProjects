module TopLevel#(parameter macCount = 1, parameter[6:0] m = 0)(input clk, start, input[7:0] X, Y,input [6:0]Z , output done);

    wire ldAdr,rstX,rstWR,ldWR,weMem, reMem , rstCalc,enCalc,WEview, REview,WEFilter, REFilter, WETemp, RETemp, rstTemp,rstFilter , doneAdr,fullWR,calcDone,fullFilter, fullTemp , emptyTemp,lastWR, adrDoneW;
    wire[1:0] sel; wire[7:0] addressW;
    wire[macCount - 1 : 0] enablesW;
    wire[31:0] datasW;
    wire doneE;
    wire doneinit, donefull, linearstart, computestart, computeenable, donemem, rstCCTV;
    wire[6:0] adroutL21;
    wire ldAdrL2, rstXL2, rstWRL2, ldWRL2, weMemL2, reMemL2, rstCalcL2, enCalcL2, WEviewL2, REviewL2, WEFilterL2, REFilterL2, WETempL2, RETempL2, rstTempL2, rstFilterL2, doneAdrL2, fullWRL2, macDoneL2, fullFilterL2, fullTempL2, emptyTempL2, lastWRL2;
    wire[1:0] selL2;
    wire[11:0] macOutO1, macoutO2, macoutO3, macoutO4, macOut11, macout12, macout13, macout14, macOut21, macout22, macout23, macout24, macOut31, macout32, macout33, macout34;
    wire[7:0] macoutFinal1, macoutFinal2, macoutFinal3, macoutFinal4;
    wire [31:0] dataoutfinal, dataoutfinal1, dataoutfinal2, dataoutfinal3;

    MemInit #(macCount) MI(.address(addressW), .data(datasW));

    AdrGenInit #(macCount) AI(.clk(clk), .rst(), .adrX(X), .adrY(Y), .adr(addressW), .enables(enablesW), .adrDone(adrDoneW));

    Controller ctr(adrDoneW,sel,start, ldAdr,rstX,clk,rstWR,ldWR,weMem, reMem , rstCalc,enCalc,WEview, REview,WEFilter, REFilter,
     WETemp, RETemp, rstTemp, rstFilter,lastWR ,doneAdr,fullWR,calcDone,fullFilter, fullTemp , emptyTemp,doneE, rstCCTV);

    Controller_Second_Layer ctr2(.clk(clk), .rst(rst), .start(doneE), .Done_Init(doneinit), .Done_Full(donefull), .Linear_Start(linearstart), .Compute_Start(computestart), .Compute_Enable(computeenable), .Done_Mem_Modifier(donemem));

    wire[31:0] datainM1 , outKer11, outKer12, outKer13, outKer14, outKer21, outKer22, outKer23, outKer24, outKer31, outKer32, outKer33, outKer34, outKer41, outKer42, outKer43, outKer44, outImg1;
    wire[6:0] adroutM1;
    DataPath dp(datasW ,7'd0, 7'd64, Z,sel,ldAdr,rstX,clk,rstWR,ldWR,weMem, reMem , enablesW[0] ,rstCalc,enCalc,WEview
    , REview,WEFilter, REFilter, WETemp, RETemp, rstTemp , rstFilter,lastWR , doneAdr,fullWR,calcDone,fullFilter, fullTemp , emptyTemp, datainM1, adroutM1);
    Memory_Mid #("file/filter1_L2.txt", m) memOut(.weInit(1'b0), .dataInInit(datasW), .dataIn(datainM1),.we(weMem), .reMem(reMemL2), .clk(clk), .adr(adroutM1), .adr2(adroutL21), .dataOut(outImg1), .rst(rstCCTV), .en(computeenable), .linierStart(linearstart), .computeStart(computestart), .doneInit(doneinit), .doneFull(donefull), .z(Z), .dataOut1(outKer11), .dataOut2(outKer12), .dataOut3(outKer13), .dataOut4(outKer14));

    wire[31:0] datainM2,outImg2;
    wire[6:0] adroutM2;
    DataPath dp1(datasW ,7'd0, 7'd64, Z,sel,ldAdr,rstX,clk,rstWR,ldWR,weMem, reMem , enablesW[1] ,rstCalc,enCalc,WEview
    , REview,WEFilter, REFilter, WETemp, RETemp, rstTemp , rstFilter,lastWR , doneAdr,fullWR,calcDone,fullFilter, fullTemp , emptyTemp, datainM2, adroutM2);
    Memory_Mid #("file/filter2_L2.txt", m) memOut1(.weInit(1'b0), .dataInInit(datasW), .dataIn(datainM2),.we(weMem), .reMem(reMemL2), .clk(clk), .adr(adroutM2), .adr2(adroutL21), .dataOut(outImg2), .rst(rstCCTV), .en(computeenable), .linierStart(linearstart), .computeStart(computestart), .doneInit(doneinit), .doneFull(donefull), .z(Z), .dataOut1(outKer21), .dataOut2(outKer22), .dataOut3(outKer23), .dataOut4(outKer24));

    wire[31:0] datainM3,outImg3;
    wire[6:0] adroutM3;
    DataPath dp2(datasW ,7'd0, 7'd64, Z,sel,ldAdr,rstX,clk,rstWR,ldWR,weMem, reMem , enablesW[2] ,rstCalc,enCalc,WEview
    , REview,WEFilter, REFilter, WETemp, RETemp, rstTemp , rstFilter,lastWR , doneAdr,fullWR,calcDone,fullFilter, fullTemp , emptyTemp, datainM3, adroutM3);
    Memory_Mid #("file/filter3_L2.txt", m) memOut2(.weInit(1'b0), .dataInInit(datasW), .dataIn(datainM3),.we(weMem), .reMem(reMemL2), .clk(clk), .adr(adroutM3), .adr2(adroutL21), .dataOut(outImg3), .rst(rstCCTV), .en(computeenable), .linierStart(linearstart), .computeStart(computestart), .doneInit(doneinit), .doneFull(donefull), .z(Z), .dataOut1(outKer31), .dataOut2(outKer32), .dataOut3(outKer33), .dataOut4(outKer34));

    wire[31:0] datainM4,outImg4;
    wire[6:0] adroutM4;
    DataPath dp3(datasW ,7'd0, 7'd64, Z,sel,ldAdr,rstX,clk,rstWR,ldWR,weMem, reMem , enablesW[3] ,rstCalc,enCalc,WEview
    , REview,WEFilter, REFilter, WETemp, RETemp, rstTemp , rstFilter,lastWR , doneAdr,fullWR,calcDone,fullFilter, fullTemp , emptyTemp, datainM4, adroutM4);
    Memory_Mid #("file/filter4_L2.txt", m) memOut3(.weInit(1'b0), .dataInInit(datasW), .dataIn(datainM4),.we(weMem), .reMem(reMemL2), .clk(clk), .adr(adroutM4), .adr2(adroutL21), .dataOut(outImg4), .rst(rstCCTV), .en(computeenable), .linierStart(linearstart), .computeStart(computestart), .doneInit(doneinit), .doneFull(donefull), .z(Z), .dataOut1(outKer41), .dataOut2(outKer42), .dataOut3(outKer43), .dataOut4(outKer44));




    ControllerL2 ctrL2(.sel(selL2), .start(donemem), .ldAdr(ldAdrL2), .rstX(rstXL2), .clk(clk), .rstWR(rstWRL2), .ldWR(ldWRL2), .weMem(weMemL2), .reMem(reMemL2), .rstCalc(rstCalcL2), .enCalc(enCalcL2), .WEview(WEviewL2), .REview(REviewL2), .WEFilter(WEFilterL2), .REFilter(REFilterL2),
    .WETemp(WETempL2), .RETemp(RETempL2), .rstTemp(rstTempL2), .rstFilter(rstFilterL2), .lastWR(lastWRL2), .doneAdr(doneAdrL2), .fullWR(fullWRL2), .macDone(macDoneL2), .fullFilter(fullFilterL2), .fullTemp(fullTempL2), .emptyTemp(emptyTempL2), .done(done));

    AddressGeneratorL2 adr1L2(.x(Z), .y(m), .z(7'd5), .sel(selL2),.ld(ldAdrL2),.rstX(rstXL2),.clk(clk),.adrOut(adroutL21),.doneAdr(doneAdrL2));

    DataPathL2 dpL2(.inpker(outKer11),.inpimage(outImg1),.sel(selL2), .ldAdr(ldAdrL2), .rstX(rstXL2), .clk(clk), .rstWR(rstWRL2), .ldWR(ldWRL2), .weMem(weMemL2), .reMem(reMemL2), .rstCalc(rstCalcL2), .enCalc(enCalcL2), .WEview(WEviewL2),
    .REview(REviewL2), .WEFilter(WEFilterL2), .REFilter(REFilterL2), .WETemp(WETempL2), .RETemp(RETempL2), .rstTemp(rstTempL2), .rstFilter(rstFilterL2), .lastWR(lastWRL2), .doneAdr(doneAdrL2), .fullWR(fullWRL2), .macDone(macDoneL2), .fullFilter(fullFilterL2), .fullTemp(fullTempL2), .emptyTemp(emptyTempL2), .macOO(macOutO1));

    DataPathL2 dp1L2(.inpker(outKer12),.inpimage(outImg2),.sel(selL2), .ldAdr(ldAdrL2), .rstX(rstXL2), .clk(clk), .rstWR(rstWRL2), .ldWR(ldWRL2), .weMem(weMemL2), .reMem(reMemL2), .rstCalc(rstCalcL2), .enCalc(enCalcL2), .WEview(WEviewL2),
    .REview(REviewL2), .WEFilter(WEFilterL2), .REFilter(REFilterL2), .WETemp(WETempL2), .RETemp(RETempL2), .rstTemp(rstTempL2), .rstFilter(rstFilterL2), .lastWR(lastWRL2), .doneAdr(doneAdrL2), .fullWR(fullWRL2), .macDone(macDoneL2), .fullFilter(fullFilterL2), .fullTemp(fullTempL2), .emptyTemp(emptyTempL2), .macOO(macoutO2));

    DataPathL2 dp2L2(.inpker(outKer13),.inpimage(outImg3),.sel(selL2), .ldAdr(ldAdrL2), .rstX(rstXL2), .clk(clk), .rstWR(rstWRL2), .ldWR(ldWRL2), .weMem(weMemL2), .reMem(reMemL2), .rstCalc(rstCalcL2), .enCalc(enCalcL2), .WEview(WEviewL2),
    .REview(REviewL2), .WEFilter(WEFilterL2), .REFilter(REFilterL2), .WETemp(WETempL2), .RETemp(RETempL2), .rstTemp(rstTempL2), .rstFilter(rstFilterL2), .lastWR(lastWRL2), .doneAdr(doneAdrL2), .fullWR(fullWRL2), .macDone(macDoneL2), .fullFilter(fullFilterL2), .fullTemp(fullTempL2), .emptyTemp(emptyTempL2), .macOO(macoutO3));

    DataPathL2 dp3L2(.inpker(outKer14),.inpimage(outImg4),.sel(selL2), .ldAdr(ldAdrL2), .rstX(rstXL2), .clk(clk), .rstWR(rstWRL2), .ldWR(ldWRL2), .weMem(weMemL2), .reMem(reMemL2), .rstCalc(rstCalcL2), .enCalc(enCalcL2), .WEview(WEviewL2),
    .REview(REviewL2), .WEFilter(WEFilterL2), .REFilter(REFilterL2), .WETemp(WETempL2), .RETemp(RETempL2), .rstTemp(rstTempL2), .rstFilter(rstFilterL2), .lastWR(lastWRL2), .doneAdr(doneAdrL2), .fullWR(fullWRL2), .macDone(macDoneL2), .fullFilter(fullFilterL2), .fullTemp(fullTempL2), .emptyTemp(emptyTempL2), .macOO(macoutO4));

    SumMAC SM1L2 (.mac1(macOutO1), .mac2(macoutO2), .mac3(macoutO3), .mac4(macoutO4), .macOutFinal(macoutFinal1));

    WRDataRegL2 wr1L2(.inputWR(macoutFinal1), .clk(clk), .rstWR(rstWRL2), .ld(ldWRL2), .outWR(dataoutfinal) ,.fullWR(fullWRL2), .lastWR(lastWRL2));

    Memory meme(.dataIn(dataoutfinal), .dataInInit(), .weInit(), .we(weMemL2), .re(reMemL2), .clk(clk), .adr(adroutL21), .dataOut());




    DataPathL2 dpL21(.inpker(outKer21),.inpimage(outImg1),.sel(selL2), .ldAdr(ldAdrL2), .rstX(rstXL2), .clk(clk), .rstWR(rstWRL2), .ldWR(ldWRL2), .weMem(weMemL2), .reMem(reMemL2), .rstCalc(rstCalcL2), .enCalc(enCalcL2), .WEview(WEviewL2),
    .REview(REviewL2), .WEFilter(WEFilterL2), .REFilter(REFilterL2), .WETemp(WETempL2), .RETemp(RETempL2), .rstTemp(rstTempL2), .rstFilter(rstFilterL2), .lastWR(lastWRL2), .doneAdr(doneAdrL2), .fullWR(fullWRL2), .macDone(macDoneL2), .fullFilter(fullFilterL2), .fullTemp(fullTempL2), .emptyTemp(emptyTempL2), .macOO(macOut11));

    DataPathL2 dp1L21(.inpker(outKer22),.inpimage(outImg2),.sel(selL2), .ldAdr(ldAdrL2), .rstX(rstXL2), .clk(clk), .rstWR(rstWRL2), .ldWR(ldWRL2), .weMem(weMemL2), .reMem(reMemL2), .rstCalc(rstCalcL2), .enCalc(enCalcL2), .WEview(WEviewL2),
    .REview(REviewL2), .WEFilter(WEFilterL2), .REFilter(REFilterL2), .WETemp(WETempL2), .RETemp(RETempL2), .rstTemp(rstTempL2), .rstFilter(rstFilterL2), .lastWR(lastWRL2), .doneAdr(doneAdrL2), .fullWR(fullWRL2), .macDone(macDoneL2), .fullFilter(fullFilterL2), .fullTemp(fullTempL2), .emptyTemp(emptyTempL2), .macOO(macout12));

    DataPathL2 dp2L21(.inpker(outKer23),.inpimage(outImg3),.sel(selL2), .ldAdr(ldAdrL2), .rstX(rstXL2), .clk(clk), .rstWR(rstWRL2), .ldWR(ldWRL2), .weMem(weMemL2), .reMem(reMemL2), .rstCalc(rstCalcL2), .enCalc(enCalcL2), .WEview(WEviewL2),
    .REview(REviewL2), .WEFilter(WEFilterL2), .REFilter(REFilterL2), .WETemp(WETempL2), .RETemp(RETempL2), .rstTemp(rstTempL2), .rstFilter(rstFilterL2), .lastWR(lastWRL2), .doneAdr(doneAdrL2), .fullWR(fullWRL2), .macDone(macDoneL2), .fullFilter(fullFilterL2), .fullTemp(fullTempL2), .emptyTemp(emptyTempL2), .macOO(macout13));

    DataPathL2 dp3L21(.inpker(outKer24),.inpimage(outImg4),.sel(selL2), .ldAdr(ldAdrL2), .rstX(rstXL2), .clk(clk), .rstWR(rstWRL2), .ldWR(ldWRL2), .weMem(weMemL2), .reMem(reMemL2), .rstCalc(rstCalcL2), .enCalc(enCalcL2), .WEview(WEviewL2),
    .REview(REviewL2), .WEFilter(WEFilterL2), .REFilter(REFilterL2), .WETemp(WETempL2), .RETemp(RETempL2), .rstTemp(rstTempL2), .rstFilter(rstFilterL2), .lastWR(lastWRL2), .doneAdr(doneAdrL2), .fullWR(fullWRL2), .macDone(macDoneL2), .fullFilter(fullFilterL2), .fullTemp(fullTempL2), .emptyTemp(emptyTempL2), .macOO(macout14));

    SumMAC SM1L21 (.mac1(macOut11), .mac2(macout12), .mac3(macout13), .mac4(macout14), .macOutFinal(macoutFinal2));

    WRDataRegL2 wr1L21(.inputWR(macoutFinal2), .clk(clk), .rstWR(rstWRL2), .ld(ldWRL2), .outWR(dataoutfinal1) ,.fullWR(fullWRL2), .lastWR(lastWRL2));

    Memory meme1(.dataIn(dataoutfinal1), .dataInInit(), .weInit(), .we(weMemL2), .re(reMemL2), .clk(clk), .adr(adroutL21), .dataOut());




    DataPathL2 dpL22(.inpker(outKer31),.inpimage(outImg1),.sel(selL2), .ldAdr(ldAdrL2), .rstX(rstXL2), .clk(clk), .rstWR(rstWRL2), .ldWR(ldWRL2), .weMem(weMemL2), .reMem(reMemL2), .rstCalc(rstCalcL2), .enCalc(enCalcL2), .WEview(WEviewL2),
    .REview(REviewL2), .WEFilter(WEFilterL2), .REFilter(REFilterL2), .WETemp(WETempL2), .RETemp(RETempL2), .rstTemp(rstTempL2), .rstFilter(rstFilterL2), .lastWR(lastWRL2), .doneAdr(doneAdrL2), .fullWR(fullWRL2), .macDone(macDoneL2), .fullFilter(fullFilterL2), .fullTemp(fullTempL2), .emptyTemp(emptyTempL2), .macOO(macOut21));

    DataPathL2 dp1L22(.inpker(outKer32),.inpimage(outImg2),.sel(selL2), .ldAdr(ldAdrL2), .rstX(rstXL2), .clk(clk), .rstWR(rstWRL2), .ldWR(ldWRL2), .weMem(weMemL2), .reMem(reMemL2), .rstCalc(rstCalcL2), .enCalc(enCalcL2), .WEview(WEviewL2),
    .REview(REviewL2), .WEFilter(WEFilterL2), .REFilter(REFilterL2), .WETemp(WETempL2), .RETemp(RETempL2), .rstTemp(rstTempL2), .rstFilter(rstFilterL2), .lastWR(lastWRL2), .doneAdr(doneAdrL2), .fullWR(fullWRL2), .macDone(macDoneL2), .fullFilter(fullFilterL2), .fullTemp(fullTempL2), .emptyTemp(emptyTempL2), .macOO(macout22));

    DataPathL2 dp2L22(.inpker(outKer33),.inpimage(outImg3),.sel(selL2), .ldAdr(ldAdrL2), .rstX(rstXL2), .clk(clk), .rstWR(rstWRL2), .ldWR(ldWRL2), .weMem(weMemL2), .reMem(reMemL2), .rstCalc(rstCalcL2), .enCalc(enCalcL2), .WEview(WEviewL2),
    .REview(REviewL2), .WEFilter(WEFilterL2), .REFilter(REFilterL2), .WETemp(WETempL2), .RETemp(RETempL2), .rstTemp(rstTempL2), .rstFilter(rstFilterL2), .lastWR(lastWRL2), .doneAdr(doneAdrL2), .fullWR(fullWRL2), .macDone(macDoneL2), .fullFilter(fullFilterL2), .fullTemp(fullTempL2), .emptyTemp(emptyTempL2), .macOO(macout23));

    DataPathL2 dp3L22(.inpker(outKer34),.inpimage(outImg4),.sel(selL2), .ldAdr(ldAdrL2), .rstX(rstXL2), .clk(clk), .rstWR(rstWRL2), .ldWR(ldWRL2), .weMem(weMemL2), .reMem(reMemL2), .rstCalc(rstCalcL2), .enCalc(enCalcL2), .WEview(WEviewL2),
    .REview(REviewL2), .WEFilter(WEFilterL2), .REFilter(REFilterL2), .WETemp(WETempL2), .RETemp(RETempL2), .rstTemp(rstTempL2), .rstFilter(rstFilterL2), .lastWR(lastWRL2), .doneAdr(doneAdrL2), .fullWR(fullWRL2), .macDone(macDoneL2), .fullFilter(fullFilterL2), .fullTemp(fullTempL2), .emptyTemp(emptyTempL2), .macOO(macout24));

    SumMAC SM1L22 (.mac1(macOut21), .mac2(macout22), .mac3(macout23), .mac4(macout24), .macOutFinal(macoutFinal3));

    WRDataRegL2 wr1L22(.inputWR(macoutFinal3), .clk(clk), .rstWR(rstWRL2), .ld(ldWRL2), .outWR(dataoutfinal2) ,.fullWR(fullWRL2), .lastWR(lastWRL2));

    Memory meme2(.dataIn(dataoutfinal2), .dataInInit(), .weInit(), .we(weMemL2), .re(reMemL2), .clk(clk), .adr(adroutL21), .dataOut());



    DataPathL2 dpL23(.inpker(outKer41),.inpimage(outImg1),.sel(selL2), .ldAdr(ldAdrL2), .rstX(rstXL2), .clk(clk), .rstWR(rstWRL2), .ldWR(ldWRL2), .weMem(weMemL2), .reMem(reMemL2), .rstCalc(rstCalcL2), .enCalc(enCalcL2), .WEview(WEviewL2),
    .REview(REviewL2), .WEFilter(WEFilterL2), .REFilter(REFilterL2), .WETemp(WETempL2), .RETemp(RETempL2), .rstTemp(rstTempL2), .rstFilter(rstFilterL2), .lastWR(lastWRL2), .doneAdr(doneAdrL2), .fullWR(fullWRL2), .macDone(macDoneL2), .fullFilter(fullFilterL2), .fullTemp(fullTempL2), .emptyTemp(emptyTempL2), .macOO(macOut31));

    DataPathL2 dp1L23(.inpker(outKer42),.inpimage(outImg2),.sel(selL2), .ldAdr(ldAdrL2), .rstX(rstXL2), .clk(clk), .rstWR(rstWRL2), .ldWR(ldWRL2), .weMem(weMemL2), .reMem(reMemL2), .rstCalc(rstCalcL2), .enCalc(enCalcL2), .WEview(WEviewL2),
    .REview(REviewL2), .WEFilter(WEFilterL2), .REFilter(REFilterL2), .WETemp(WETempL2), .RETemp(RETempL2), .rstTemp(rstTempL2), .rstFilter(rstFilterL2), .lastWR(lastWRL2), .doneAdr(doneAdrL2), .fullWR(fullWRL2), .macDone(macDoneL2), .fullFilter(fullFilterL2), .fullTemp(fullTempL2), .emptyTemp(emptyTempL2), .macOO(macout32));

    DataPathL2 dp2L23(.inpker(outKer43),.inpimage(outImg3),.sel(selL2), .ldAdr(ldAdrL2), .rstX(rstXL2), .clk(clk), .rstWR(rstWRL2), .ldWR(ldWRL2), .weMem(weMemL2), .reMem(reMemL2), .rstCalc(rstCalcL2), .enCalc(enCalcL2), .WEview(WEviewL2),
    .REview(REviewL2), .WEFilter(WEFilterL2), .REFilter(REFilterL2), .WETemp(WETempL2), .RETemp(RETempL2), .rstTemp(rstTempL2), .rstFilter(rstFilterL2), .lastWR(lastWRL2), .doneAdr(doneAdrL2), .fullWR(fullWRL2), .macDone(macDoneL2), .fullFilter(fullFilterL2), .fullTemp(fullTempL2), .emptyTemp(emptyTempL2), .macOO(macout33));

    DataPathL2 dp3L23(.inpker(outKer44),.inpimage(outImg4),.sel(selL2), .ldAdr(ldAdrL2), .rstX(rstXL2), .clk(clk), .rstWR(rstWRL2), .ldWR(ldWRL2), .weMem(weMemL2), .reMem(reMemL2), .rstCalc(rstCalcL2), .enCalc(enCalcL2), .WEview(WEviewL2),
    .REview(REviewL2), .WEFilter(WEFilterL2), .REFilter(REFilterL2), .WETemp(WETempL2), .RETemp(RETempL2), .rstTemp(rstTempL2), .rstFilter(rstFilterL2), .lastWR(lastWRL2), .doneAdr(doneAdrL2), .fullWR(fullWRL2), .macDone(macDoneL2), .fullFilter(fullFilterL2), .fullTemp(fullTempL2), .emptyTemp(emptyTempL2), .macOO(macout34));

    SumMAC SM1L23 (.mac1(macOut31), .mac2(macout32), .mac3(macout33), .mac4(macout34), .macOutFinal(macoutFinal4));

    WRDataRegL2 wr1L23(.inputWR(macoutFinal4), .clk(clk), .rstWR(rstWRL2), .ld(ldWRL2), .outWR(dataoutfinal3) ,.fullWR(fullWRL2), .lastWR(lastWRL2));

    Memory meme3(.dataIn(dataoutfinal3), .dataInInit(), .weInit(), .we(weMemL2), .re(reMemL2), .clk(clk), .adr(adroutL21), .dataOut());

endmodule