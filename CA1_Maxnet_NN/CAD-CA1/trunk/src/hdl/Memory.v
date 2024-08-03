module float_mem(clk, load, d0, d1, d2, d3, d4, d5, q0, q1, q2, q3, q4, q5);

    input clk, load; 
    input[31:0] d0, d1, d2, d3, d4, d5;
    output[31:0] q0, q1, q2, q3, q4, q5;
    reg[31:0] q0, q1, q2, q3, q4, q5;

    reg [31:0] mem [0:7];

    always @(posedge clk) begin

    if (load) begin
        mem[0] = d0;
        mem[1] = d1;
        mem[2] = d2;
        mem[3] = d3;
        mem[4] = d4;
        mem[5] = d5;
    end

    q0 = mem[0];
    q1 = mem[1];
    q2 = mem[2];
    q3 = mem[3];
    q4 = mem[4];
    q5 = mem[5];

    end

endmodule