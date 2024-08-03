`define S0 5'd0
`define S1 5'd1
`define S2 5'd2
`define S3 5'd3
`define S4 5'd4
`define S5 5'd5
`define S6 5'd6
`define S7 5'd7
`define S8 5'd8
`define S9 5'd9
`define S10 5'd10
`define S11 5'd11
`define S12 5'd12
`define S13 5'd13
`define S14 5'd14
`define S15 5'd15
`define S16 5'd16
`define S17 5'd17
`define S18 5'd18
`define S19 5'd19
`define S20 5'd20
`define S22 5'd21


module Controller(adrDoneWW,sel,start, ldAdr,rstX,clk,rstWR,ldWR,weMem, reMem , rstCalc,enCalc,WEview, REview,WEFilter, REFilter, WETemp, RETemp, rstTemp,rstFilter ,lastWR,doneAdr,fullWR,calcDone,fullFilter, fullTemp , emptyTemp,done);

    
    reg[4:0] ps = 5'b0, ns;
    input doneAdr,fullWR,calcDone,fullFilter, fullTemp , emptyTemp,  start , clk, adrDoneWW;
    output ldAdr,rstX,rstWR,ldWR,weMem, reMem , rstCalc,enCalc,WEview, REview,WEFilter, REFilter, WETemp, RETemp, rstTemp ,rstFilter,lastWR, done;
    reg  ldAdr,rstX,rstWR,ldWR,weMem, reMem , rstCalc,enCalc,WEview, REview,WEFilter, REFilter, WETemp, RETemp, rstTemp ,rstFilter,lastWR, done;
    output sel;
    reg [1:0] sel;

    always@(posedge clk)
        ps = ns;

    always@(ps) begin
        {WEview, REview, enCalc, ldWR,reMem,weMem,rstX , rstCalc, rstTemp, rstWR, ldAdr, WETemp, RETemp, WEFilter, REFilter,rstFilter,lastWR } = 17'b0;
        sel = 2'b11;
        case(ps)
            `S1:{rstCalc,rstTemp,rstWR,ldAdr} = 4'b1111;
            `S2:begin {WEFilter,reMem} = 2'b11 ;  sel = 2'b01; end
            `S3:begin {WETemp,reMem} = 2'b11; sel = 2'b00; end
            `S4:begin {RETemp,rstCalc} = 2'b11; end
            `S5:begin {enCalc,REview,REFilter} = 3'b111;end
            `S7:begin {ldWR} = 1'b1; end
            `S8:begin {weMem} = 1'b1 ;end
            `S9:begin {rstWR} = 1'b1;end
            `S10:begin {ldWR,lastWR} = 2'b11; end
            `S11:begin  {weMem} = 1'b1 ; end
            `S12:begin {rstTemp} = 1'b1;end
            `S13:begin {done} = 1'b1; end
            `S15:begin {rstCalc} = 1'b1;end
            `S16:begin {WEview,rstFilter} = 2'b11; end
            `S17:begin {sel} = 2'b10; end
            `S18:begin {sel} = 2'b10; end
            `S19:begin {rstX} = 1'b1;sel = 2'b00; end
        endcase
    end

    always@(ps, start,emptyTemp,doneAdr,fullWR ,fullFilter, fullTemp,calcDone, adrDoneWW) begin
        case(ps)
            `S0: ns = (start) ? `S1 :`S0;
            `S1: ns = `S22;
            `S22: ns = (adrDoneWW) ? `S2 : `S22;
            `S2: ns =(fullFilter) ? `S19 : `S2;
            `S3: ns = (fullTemp) ? `S4 : `S3;
            `S4: ns = `S16;
            `S5: ns =(calcDone) ?  `S6:`S5;
            `S6: ns =(doneAdr) ?  `S10:`S7;
            `S7: ns =`S14;
            `S8: ns = `S9;
            `S9: ns = `S20;
            `S10: ns = `S15;
            `S11 :ns = `S13 ;
            `S12 :ns = `S19;
            `S13 :ns = `S0;
            `S14: ns = (fullWR) ? `S17 : `S20;
            `S15: ns = (fullWR) ? `S18:`S10;
            `S16:ns = `S5;
            `S17:ns = `S8;
            `S18:ns =`S11;
            `S19:ns =`S3;
            `S20: ns = (emptyTemp) ? `S12 : `S4;
        endcase
    end

endmodule