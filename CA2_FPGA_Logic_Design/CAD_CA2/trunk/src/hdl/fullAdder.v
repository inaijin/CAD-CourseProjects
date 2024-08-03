module Fadder(input A,B, Cin, output S , Cout);

    wire x1W,a1W,a2W;
    Xor  x1(.A(A),.B(B),.F(x1W));
    And a1(.A(A),.B(B),.F(a1W));
    Xor  x2(.A(x1W),.B(Cin),.F(S));
    And a2(.A(x1W),.B(Cin),.F(a2W));
    Or o1(.A(a2W),.B(a1W),.F(Cout));


endmodule
