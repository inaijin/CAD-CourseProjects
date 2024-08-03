module SumMAC(input[11:0] mac1, mac2, mac3, mac4, output reg[7:0] macOutFinal);

    reg[11:0] sumMac; 
    assign sumMac = mac1 + mac2 + mac3 + mac4;

    assign macOutFinal = sumMac[11:4];

endmodule