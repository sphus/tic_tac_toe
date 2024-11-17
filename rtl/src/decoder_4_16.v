module decoder_4_16
    (
        input       [3:0]       in,     // 4-bit input
        output reg  [15:0]      out     // 16-bit output
    );

    always @(*)
    begin
        out = 16'b0; // Initialize all outputs to 0
        out[in] = 1'b1; // Set the output corresponding to the input to 1
    end

endmodule
