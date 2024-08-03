module selectMap(in, out);

    input[3:0] in;
    output[1:0] out;
    reg[1:0] out;

    always @(*) begin
        case(in)
        4'b0001: out = 2'b00;
        4'b0010: out = 2'b01; 
        4'b0100: out = 2'b10;
        4'b1000: out = 2'b11;
        4'b0000: out = 2'b00;
        default: out = 2'bxx; 
        endcase
    end

    endmodule


    module doneCheck(a, b, c, d, out, sel);

    input[31:0] a, b, c, d;
    output out;
    reg out;
    output[1:0] sel;
    reg[1:0] sel;

    wire a_or, b_or, c_or, d_or;
    wire [1:0]select;

    assign a_or = |a;
    assign b_or = |b;
    assign c_or = |c;
    assign d_or = |d;

    selectMap s(.in({d_or,c_or,b_or,a_or}),.out(select));

    always @(*) begin
        if ((~a_or & ~b_or & ~c_or) | (~a_or & ~b_or & ~d_or) | (~a_or & ~c_or & ~d_or) | (~b_or & ~c_or & ~d_or))begin 
            out = 1;
            sel = select;
        end
        else begin
            out = 0;
            sel = 2'bxx;
        end
    end

endmodule