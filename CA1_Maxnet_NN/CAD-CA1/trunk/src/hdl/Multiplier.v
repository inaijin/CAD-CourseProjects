module multi24_24(a, b, mul_out);

    input [23:0] a, b;
    output[47:0] mul_out;
    reg[47:0] mul_out;

    always @* begin
        mul_out = a*b;
    end

endmodule

module Multiplier(A, B, out);

    input[31:0] A, B;
    output[31:0] out;

    reg sign_a, sign_b;
    reg [7:0] exponent_a, exponent_b;
    reg [22:0] mantissa_a, mantissa_b;
    wire [47:0] mantissa_result;
    reg [22:0] final_mantissa;
    reg [8:0] exponent_add;
    reg [9:0] exponent_sub;
    reg [7:0] final_exp;

    assign exponent_a = A[30:23];
    assign mantissa_a = A[22:0];
    assign sign_a = A[31];
    assign sign_b = B[31];

    assign exponent_b = B[30:23];
    assign mantissa_b = B[22:0];

    reg carry,sub_carry,dumb;
    reg sign_result;

    assign sign_result = sign_a ^ sign_b;
    assign exponent_add = exponent_a + exponent_b;
    assign exponent_sub = {exponent_add} - 9'd127;

    multi24_24 mul({1'b1,mantissa_a},{1'b1,mantissa_b},mantissa_result);

    assign final_mantissa = (mantissa_result[47])?mantissa_result[46:24]:mantissa_result[45:23];
    assign {dumb,final_exp} = exponent_sub[7:0] + {7'b0,mantissa_result[47]};

    assign out = ({sign_result, final_exp, final_mantissa} == 32'hfecccccd) ? 32'h00000000 : {sign_result, final_exp, final_mantissa};

endmodule