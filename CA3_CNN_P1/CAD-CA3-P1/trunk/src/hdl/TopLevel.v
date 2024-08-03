module TopLevel#(parameter macCount = 1)(input clk, start, input[7:0] X, Y,input [6:0]Z , output done);

    wire ldAdr,rstX,rstWR,ldWR,weMem, reMem , rstCalc,enCalc,WEview, REview,WEFilter, REFilter, WETemp, RETemp, rstTemp,rstFilter , doneAdr,fullWR,calcDone,fullFilter, fullTemp , emptyTemp,lastWR, adrDoneW;
    wire[1:0] sel; wire[7:0] addressW;
    wire[macCount - 1 : 0] enablesW;
    wire[31:0] datasW;

    MemInit #(macCount) MI(.address(addressW), .data(datasW));

    AdrGenInit #(macCount) AI(.clk(clk), .rst(), .adrX(X), .adrY(Y), .adr(addressW), .enables(enablesW), .adrDone(adrDoneW));

    Controller ctr(adrDoneW,sel,start, ldAdr,rstX,clk,rstWR,ldWR,weMem, reMem , rstCalc,enCalc,WEview, REview,WEFilter, REFilter,
     WETemp, RETemp, rstTemp, rstFilter,lastWR ,doneAdr,fullWR,calcDone,fullFilter, fullTemp , emptyTemp,done);

    generate
        genvar i;
        for (i = 0; i < macCount; i = i + 1) begin : instance_gen
            DataPath dp(datasW ,7'd0, 7'd64, Z,sel,ldAdr,rstX,clk,rstWR,ldWR,weMem, reMem , enablesW[i] ,rstCalc,enCalc,WEview
            , REview,WEFilter, REFilter, WETemp, RETemp, rstTemp , rstFilter,lastWR , doneAdr,fullWR,calcDone,fullFilter, fullTemp , emptyTemp);
        end
    endgenerate

endmodule