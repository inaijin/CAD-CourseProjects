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

module ControllerL2(output reg[1:0] sel, input start, output reg ldAdr, rstX, input clk, output reg rstWR, ldWR, weMem, reMem, rstCalc, enCalc, WEview, REview, WEFilter, REFilter, WETemp, RETemp, rstTemp,
rstFilter, lastWR, input doneAdr, fullWR, macDone, fullFilter, fullTemp, emptyTemp, output reg done);

    reg[4:0] psn = 0, nsn = 0;

    always@(posedge clk)
        psn = nsn;

    always@(psn) begin

        {WEview, REview, enCalc, ldWR,reMem,weMem,rstX , rstCalc, rstTemp, rstWR, ldAdr, WETemp, RETemp, WEFilter, REFilter,rstFilter,lastWR } = 17'b0;

        sel = 2'b11;

        case(psn)

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

    always@(psn, start, emptyTemp, doneAdr, fullWR, fullFilter, fullTemp, macDone) begin

        case(psn)

            `S0: nsn = (start) ? `S1 :`S0;
            `S1: nsn = `S2;
            `S2: nsn =(fullFilter) ? `S19 : `S2;
            `S3: nsn = (fullTemp) ? `S4 : `S3;
            `S4: nsn = `S16;
            `S5: nsn =(macDone) ?  `S6:`S5;
            `S6: nsn =(doneAdr) ?  `S10:`S7;
            `S7: nsn =`S14;
            `S8: nsn = `S9;
            `S9: nsn = `S20;
            `S10: nsn = `S15;
            `S11 :nsn = `S13 ;
            `S12 :nsn = `S19;
            `S13 :nsn = `S0;
            `S14: nsn = (fullWR) ? `S17 : `S20;
            `S15: nsn = (fullWR) ? `S18:`S10;
            `S16:nsn = `S5;
            `S17:nsn = `S8;
            `S18:nsn =`S11;
            `S19:nsn =`S3;
            `S20: nsn = (emptyTemp) ? `S12 : `S4;

        endcase

    end

endmodule