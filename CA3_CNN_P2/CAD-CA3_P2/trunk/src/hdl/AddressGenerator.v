module AddressGenerator(x, y, z, sel,ld,rstX,clk,adrOut,doneAdr);

    input ld , clk , rstX;
    input[1:0] sel;
    input[6:0] x, y, z;
    output doneAdr , adrOut;
    reg[6:0] adrOut;
    reg[6:0] xReg, yReg, zReg;
    reg[3:0] rowCounter = 4'b0;

    reg[4:0] xCounter = 5'b0; 
    reg[1:0] yCounter = 2'b0;
    reg[5:0] zCounter = 4'b0;

    always@(posedge clk) begin
        if(rstX)begin
            xCounter = 5'b00000;
        end
        if(ld) begin
            xReg = x;
            yReg = y;
            zReg = z;
        end
        else begin
            case (sel)
                2'b00 : begin
                    if(xCounter == 5'b10000) begin
                        xReg = xReg + 4;
                        rowCounter = rowCounter + 1;
                    end
                    adrOut = xReg + xCounter;
                    xCounter = xCounter + 1;
                end 

                2'b01 : begin
                    adrOut = yReg + yCounter;
                    yCounter = yCounter + 1;
                end 

                2'b10 : begin
                        adrOut = zReg + zCounter;
                        zCounter = zCounter + 1;
                end 

                default: adrOut = 7'bxxxxxx;
            endcase
        end
    end

    assign doneAdr = (rowCounter == 4'd14) ? 1 : 0;

endmodule