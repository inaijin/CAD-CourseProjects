module float_reg #(parameter DATA_WIDTH = 32) (clk, reset, d, q);

    input clk, reset;
    input[DATA_WIDTH-1:0] d;
    output[DATA_WIDTH-1:0] q;
    reg[DATA_WIDTH-1:0] q;


    always @(posedge clk) begin
      if (reset)
        q <= 0;
      else 
        q <= d;
    end

endmodule