module mem(clk, load, d0, d1, d2, d3, d4, d5, q0, q1, q2, q3, q4, q5);

    input clk, load; 
    input[4:0] d0, d1, d2, d3, d4, d5;
    output[4:0] q0, q1, q2, q3, q4, q5;

    Reg #(5) REG1(.data_in(d0),.clk(clk), .clr(1'b0),.en(load),.data_out(q0));
    Reg #(5) REG2(.data_in(d1),.clk(clk), .clr(1'b0),.en(load),.data_out(q1));
    Reg #(5) REG3(.data_in(d2),.clk(clk), .clr(1'b0),.en(load),.data_out(q2));
    Reg #(5) REG4(.data_in(d3),.clk(clk), .clr(1'b0),.en(load),.data_out(q3));
    Reg #(5) REG5(.data_in(d4),.clk(clk), .clr(1'b0),.en(load),.data_out(q4));
    Reg #(5) REG6(.data_in(d5),.clk(clk), .clr(1'b0),.en(load),.data_out(q5));


endmodule
