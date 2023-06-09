module alu_and(A, B, out);
    input [31:0] A;
    input [31:0] B;

    output [31:0] out;

    and and_out0(out[0], A[0], B[0]);
    and and_out1(out[1], A[1], B[1]);
    and and_out2(out[2], A[2], B[2]);
    and and_out3(out[3], A[3], B[3]);
    and and_out4(out[4], A[4], B[4]);
    and and_out5(out[5], A[5], B[5]);
    and and_out6(out[6], A[6], B[6]);
    and and_out7(out[7], A[7], B[7]);
    and and_out8(out[8], A[8], B[8]);
    and and_out9(out[9], A[9], B[9]);
    and and_out10(out[10], A[10], B[10]);
    and and_out11(out[11], A[11], B[11]);
    and and_out12(out[12], A[12], B[12]);
    and and_out13(out[13], A[13], B[13]);
    and and_out14(out[14], A[14], B[14]);
    and and_out15(out[15], A[15], B[15]);
    and and_out16(out[16], A[16], B[16]);
    and and_out17(out[17], A[17], B[17]);
    and and_out18(out[18], A[18], B[18]);
    and and_out19(out[19], A[19], B[19]);
    and and_out20(out[20], A[20], B[20]);
    and and_out21(out[21], A[21], B[21]);
    and and_out22(out[22], A[22], B[22]);
    and and_out23(out[23], A[23], B[23]);
    and and_out24(out[24], A[24], B[24]);
    and and_out25(out[25], A[25], B[25]);
    and and_out26(out[26], A[26], B[26]);
    and and_out27(out[27], A[27], B[27]);
    and and_out28(out[28], A[28], B[28]);
    and and_out29(out[29], A[29], B[29]);
    and and_out30(out[30], A[30], B[30]);
    and and_out31(out[31], A[31], B[31]);

endmodule
