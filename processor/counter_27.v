module counter_27(clk, reset, out);

    input clk, reset;
    output[27:0] out;

    wire q0, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15, q16, q17, q18, q19, q20, q21, q22, q23, q24, q25, q26, q27;

    
    dffe_reg diff_0(q0, !q0, clk, 1'b1, reset);
    dffe_reg diff_1(q1, !q1, q0, 1'b1, reset);
    dffe_reg diff_2(q2, !q2, q1, 1'b1, reset);
    dffe_reg diff_3(q3, !q3, q2, 1'b1, reset);
    dffe_reg diff_4(q4, !q4, q3, 1'b1, reset);
    dffe_reg diff_5(q5, !q5, q4, 1'b1, reset);
    dffe_reg diff_6(q6, !q6, q5, 1'b1, reset);
    dffe_reg diff_7(q7, !q7, q6, 1'b1, reset);
    dffe_reg diff_8(q8, !q8, q7, 1'b1, reset);
    dffe_reg diff_9(q9, !q9, q8, 1'b1, reset);
    dffe_reg diff_10(q10, !q10, q9, 1'b1, reset);
    dffe_reg diff_11(q11, !q11, q10, 1'b1, reset);
    dffe_reg diff_12(q12, !q12, q11, 1'b1, reset);
    dffe_reg diff_13(q13, !q13, q12, 1'b1, reset);
    dffe_reg diff_14(q14, !q14, q13, 1'b1, reset);
    dffe_reg diff_15(q15, !q15, q14, 1'b1, reset);
    dffe_reg diff_16(q16, !q16, q15, 1'b1, reset);
    dffe_reg diff_17(q17, !q17, q16, 1'b1, reset);
    dffe_reg diff_18(q18, !q18, q17, 1'b1, reset);
    dffe_reg diff_19(q19, !q19, q18, 1'b1, reset);
    dffe_reg diff_20(q20, !q20, q19, 1'b1, reset);
    dffe_reg diff_21(q21, !q21, q20, 1'b1, reset);
    dffe_reg diff_22(q22, !q22, q21, 1'b1, reset);
    dffe_reg diff_23(q23, !q23, q22, 1'b1, reset);
    dffe_reg diff_24(q24, !q24, q23, 1'b1, reset);
    dffe_reg diff_25(q25, !q25, q24, 1'b1, reset);
    dffe_reg diff_26(q26, !q26, q25, 1'b1, reset);
    dffe_reg diff_27(q27, !q27, q26, 1'b1, reset);

    assign out[0] = !q0;
    assign out[1] = !q1;    
    assign out[2] = !q2;
    assign out[3] = !q3;
    assign out[4] = !q4;
    assign out[5] = !q5;
    assign out[6] = !q6;
    assign out[7] = !q7;
    assign out[8] = !q8;
    assign out[9] = !q9;
    assign out[10] = !q10;
    assign out[11] = !q11;
    assign out[12] = !q12;
    assign out[13] = !q13;
    assign out[14] = !q14;
    assign out[15] = !q15;
    assign out[16] = !q16;
    assign out[17] = !q17;
    assign out[18] = !q18;
    assign out[19] = !q19;
    assign out[20] = !q20;
    assign out[21] = !q21;
    assign out[22] = !q22;
    assign out[23] = !q23;
    assign out[24] = !q24;
    assign out[25] = !q25;
    assign out[26] = !q26;
    assign out[27] = !q27;



endmodule