module RELU(in, out);

    input[31:0] in;
    output[31:0] out;
    reg[31:0] out;

    always @(*) begin
      if(in[31] == 1'b0) 
        out = in;
      else
        out = 32'd0;
    end

endmodule