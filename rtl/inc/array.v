//二维数组打包为一维数组
`define PACK_ARRAY(PK_WIDTH,PK_LEN,PK_SRC,PK_DEST) \
generate \
genvar pk_idx; \
for (pk_idx=0; pk_idx<(PK_LEN); pk_idx=pk_idx+1) \
begin \
        assign PK_DEST[((PK_WIDTH)*pk_idx+((PK_WIDTH)-1)):((PK_WIDTH)*pk_idx)] = PK_SRC[pk_idx][((PK_WIDTH)-1):0]; \
end \
endgenerate 

//一维数组展开为二维数组
`define UNPACK_ARRAY(PK_WIDTH,PK_LEN,PK_DEST,PK_SRC) \
generate  \
genvar unpk_idx; \
for (unpk_idx=0; unpk_idx<(PK_LEN); unpk_idx=unpk_idx+1) \
begin \
        assign PK_DEST[unpk_idx][((PK_WIDTH)-1):0] = PK_SRC[((PK_WIDTH)*unpk_idx+(PK_WIDTH-1)):((PK_WIDTH)*unpk_idx)]; \
end \
endgenerate
// // 使用方法
// module example
//     (
//         input  [63:0] pack_4_16_in,
//         output [31:0] pack_16_2_out
//     );

//     wire [3:0] din [0:15];
//     `UNPACK_ARRAY(4,16,din,pack_4_16_in)

//                  wire [15:0] out [0:1];
//     `PACK_ARRAY(16,2,din,pack_16_2_out)
//            endmodule

