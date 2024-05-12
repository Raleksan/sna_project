module m;

    // Define structure
    struct { 
        logic a; 
    } s;

    int i = s.a + 1;

    initial $display("%d", i);

endmodule