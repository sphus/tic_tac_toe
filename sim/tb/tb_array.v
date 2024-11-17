`include "../../rtl/inc/array.v"
`timescale 1ns/1ns
module tb_array ();


    reg     [7:0]  unpack_2_4_in ;
    // wire    [31:0]  pack_16_2_out;

    wire    [1:0]   din [3:0];
    // wire    [15:0]  out [0:1];
    `UNPACK_ARRAY
        (2,4,din,unpack_2_4_in)

        //  `PACK_ARRAY(16,2,din,pack_16_2_out)

        initial
        begin
            unpack_2_4_in[7:0] = 7'd0;
            while(unpack_2_4_in[7:0] < 8'd200)
            begin
                #10;
                unpack_2_4_in[7:0] =unpack_2_4_in[7:0] + 1'd1;
            end
        end


    endmodule



