module selectMap(input[3:0] in, output[1:0] out);

    Mux16to1 #(2) mux (.A(2'b00), .B(2'b00), .C(2'b01), .D(), .E(2'b10), .F(), .G(), .H(), .I(2'b11), .J(), .K(), .L(), .M(), .N(), .O(), .P(), .S(in), .FF(out));

endmodule

module doneCheck(input[4:0] a, b, c, d, output out, output reg[1:0] sel);

    wire a_or, b_or, c_or, d_or;
    wire aComp, bComp, cComp, dComp;
    wire aAndb, dAndc, abAndc, abAndD, dcAnda, dcAndb;
    wire outOr1, outOr2, outOr3 , outOr3Comp;
    wire [1:0] select;

    OrSingle OS1 (.A(a), .F(a_or));
    OrSingle OS2 (.A(b), .F(b_or));
    OrSingle OS3 (.A(c), .F(c_or));
    OrSingle OS4 (.A(d), .F(d_or));

    selectMap s(.in({d_or,c_or,b_or,a_or}), .out(select));

    Not no1 (.A(a_or), .F(aComp));
    Not no2 (.A(b_or), .F(bComp));
    Not no3 (.A(c_or), .F(cComp));
    Not no4 (.A(d_or), .F(dComp));

    And and1 (.A(aComp), .B(bComp), .F(aAndb));
    And and2 (.A(dComp), .B(cComp), .F(dAndc));
    And and3 (.A(aAndb), .B(cComp), .F(abAndc));
    And and4 (.A(aAndb), .B(dComp), .F(abAndD));
    And and5 (.A(dAndc), .B(aComp), .F(dcAnda));
    And and6 (.A(dAndc), .B(bComp), .F(dcAndb));

    Or or1 (.A(abAndc), .B(abAndD), .F(outOr1));
    Or or2 (.A(dcAnda), .B(dcAndb), .F(outOr2));
    Or or3 (.A(outOr1), .B(outOr2), .F(outOr3));

    Not no5 (.A(outOr3), .F(outOr3Comp));

    wire[2:0] result;

    Mux2to1 #(3) mux (.A({1'b1, select}), .B(3'b0xx), .S(outOr3Comp), .F(result));

    assign out = result[2];
    assign sel = result[1:0]; 

endmodule
