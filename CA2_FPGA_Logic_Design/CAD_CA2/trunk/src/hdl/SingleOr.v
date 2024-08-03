module OrSingle (input[4:0] A, output F);

    wire temp1, temp2, temp3;

    Or or1 (.A(A[4]), .B(A[3]), .F(temp1));
    Or or2 (.A(A[2]), .B(A[1]), .F(temp2));

    Or or3 (.A(temp1), .B(temp2), .F(temp3));

    Or or4 (.A(temp3), .B(A[0]), .F(F));

endmodule
