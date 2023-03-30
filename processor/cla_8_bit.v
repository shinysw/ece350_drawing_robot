

module cla_8_bit(A, B, cin, out, cout, P, G);
    input [7:0] A;
    input [7:0] B;
    input cin;

    output [7:0] out;
    output P, G, cout;
    

    wire c0, c1, c2, c3, c4, c5, c6, c7;
    wire g0, g1, g2, g3, g4, g5, g6, g7;
    wire p0, p1, p2, p3, p4, p5, p6, p7; 
    
    assign c0 = cin;
    
    and and_g0(g0, A[0], B[0]);
    and and_g1(g1, A[1], B[1]);
    and and_g2(g2, A[2], B[2]);
    and and_g3(g3, A[3], B[3]);
    and and_g4(g4, A[4], B[4]);
    and and_g5(g5, A[5], B[5]);
    and and_g6(g6, A[6], B[6]);
    and and_g7(g7, A[7], B[7]);

    or xor_p0(p0, A[0], B[0]);
    or xor_p1(p1, A[1], B[1]);
    or xor_p2(p2, A[2], B[2]);
    or xor_p3(p3, A[3], B[3]);
    or xor_p4(p4, A[4], B[4]);
    or xor_p5(p5, A[5], B[5]);
    or xor_p6(p6, A[6], B[6]);
    or xor_p7(p7, A[7], B[7]);

    xor s0_xor(out[0], c0, A[0], B[0]);

    wire c1_temp_0, c1_temp_1;
    and c1_and_0(c1_temp_0, c0, p0);
    and c1_and_1(c1_temp_1, g0);
    or c1_or(c1, c1_temp_0, c1_temp_1, g0);
    xor s1_xor(out[1], c1, A[1], B[1]);

    wire c2_temp_0, c2_temp_1, c2_temp_2;
    and c2_and_0(c2_temp_0, c0, p0, p1);
    and c2_and_1(c2_temp_1, g1);
    and c2_and_2(c2_temp_2, g0, p1);
    or c2_or(c2, c2_temp_0, c2_temp_1, c2_temp_2, g1);
    xor s2_xor(out[2], c2, A[2], B[2]);

    wire c3_temp_0, c3_temp_1, c3_temp_2, c3_temp_3;
    and c3_and_0(c3_temp_0, c0, p0, p1, p2);
    and c3_and_1(c3_temp_1, g2);
    and c3_and_2(c3_temp_2, g1, p2);
    and c3_and_3(c3_temp_3, g0, p1, p2);
    or c3_or(c3, c3_temp_0, c3_temp_1, c3_temp_2, c3_temp_3, g2);
    xor s3_xor(out[3], c3, A[3], B[3]);

    wire c4_temp_0, c4_temp_1, c4_temp_2, c4_temp_3, c4_temp_4;
    and c4_and_0(c4_temp_0, c0, p0, p1, p2, p3);
    and c4_and_1(c4_temp_1, g3);
    and c4_and_2(c4_temp_2, g2, p3);
    and c4_and_3(c4_temp_3, g1, p2, p3);
    and c4_and_4(c4_temp_4, g0, p1, p2, p3);
    or c4_or(c4, c4_temp_0, c4_temp_1, c4_temp_2, c4_temp_3, c4_temp_4, g3);
    xor s4_xor(out[4], c4, A[4], B[4]);

    wire c5_temp_0, c5_temp_1, c5_temp_2, c5_temp_3, c5_temp_4, c5_temp_5;
    and c5_and_0(c5_temp_0, c0, p0, p1, p2, p3, p4);
    and c5_and_1(c5_temp_1, g4);
    and c5_and_2(c5_temp_2, g3, p4);
    and c5_and_3(c5_temp_3, g2, p3, p4);
    and c5_and_4(c5_temp_4, g1, p2, p3, p4);
    and c5_and_5(c5_temp_5, g0, p1, p2, p3, p4);
    or c5_or(c5, c5_temp_0, c5_temp_1, c5_temp_2, c5_temp_3, c5_temp_4, c5_temp_5, g4);
    xor s5_xor(out[5], c5, A[5], B[5]);

    wire c6_temp_0, c6_temp_1, c6_temp_2, c6_temp_3, c6_temp_4, c6_temp_5, c6_temp_6;
    and c6_and_0(c6_temp_0, c0, p0, p1, p2, p3, p4, p5);
    and c6_and_1(c6_temp_1, g5);
    and c6_and_2(c6_temp_2, g4, p5);
    and c6_and_3(c6_temp_3, g3, p4, p5);
    and c6_and_4(c6_temp_4, g2, p3, p4, p5);
    and c6_and_5(c6_temp_5, g1, p2, p3, p4, p5);
    and c6_and_6(c6_temp_6, g0, p1, p2, p3, p4, p5);
    or c6_or(c6, c6_temp_0, c6_temp_1, c6_temp_2, c6_temp_3, c6_temp_4, c6_temp_5, c6_temp_6, g5);
    xor s6_xor(out[6], c6, A[6], B[6]);

    wire c7_temp_0, c7_temp_1, c7_temp_2, c7_temp_3, c7_temp_4, c7_temp_5, c7_temp_6, c7_temp_7;
    and c7_and_0(c7_temp_0, c0, p0, p1, p2, p3, p4, p5, p6);
    and c7_and_1(c7_temp_1, g6);
    and c7_and_2(c7_temp_2, g5, p6);
    and c7_and_3(c7_temp_3, g4, p5, p6);
    and c7_and_4(c7_temp_4, g3, p4, p5, p6);
    and c7_and_5(c7_temp_5, g2, p3, p4, p5, p6);
    and c7_and_6(c7_temp_6, g1, p2, p3, p4, p5, p6);
    and c7_and_7(c7_temp_7, g0, p1, p2, p3, p4, p5, p6);
    or c7_or(c7, c7_temp_0, c7_temp_1, c7_temp_2, c7_temp_3, c7_temp_4, c7_temp_5, c7_temp_6, c7_temp_7, g6);
    xor s7_xor(out[7], c7, A[7], B[7]);


    wire c8_temp_0, c8_temp_1, c8_temp_2, c8_temp_3, c8_temp_4, c8_temp_5, c8_temp_6, c8_temp_7, c8_temp_8;
    and c8_and_0(c8_temp_0, c0, p0, p1, p2, p3, p4, p5, p6, p7);
    and c8_and_1(c8_temp_1, g7);
    and c8_and_2(c8_temp_2, g6, p7);
    and c8_and_3(c8_temp_3, g5, p6, p7);
    and c8_and_4(c8_temp_4, g4, p5, p6, p7);
    and c8_and_5(c8_temp_5, g3, p4, p5, p6, p7);
    and c8_and_6(c8_temp_6, g2, p3, p4, p5, p6, p7);
    and c8_and_7(c8_temp_7, g1, p2, p3, p4, p5, p6, p7);
    and c8_and_8(c8_temp_8, g0, p1, p2, p3, p4, p5, p6, p7);
    or c8_or(cout, c8_temp_0, c8_temp_1, c8_temp_2, c8_temp_3, c8_temp_4, c8_temp_5, c8_temp_6, c8_temp_7, c8_temp_8, g7);


    wire big_gen_0, big_gen_1, big_gen_2, big_gen_3, big_gen_4, big_gen_5, big_gen_6, big_gen_7;
    and and_big_gen_0(big_gen_0, g0, p1, p2, p3, p4, p5, p6, p7);
    and and_big_gen_1(big_gen_1, g1, p2, p3, p4, p5, p6, p7);
    and and_big_gen_2(big_gen_2, g2, p3, p4, p5, p6, p7);
    and and_big_gen_3(big_gen_3, g3, p4, p5, p6, p7);
    and and_big_gen_4(big_gen_4, g4, p5, p6, p7);
    and and_big_gen_5(big_gen_5, g5, p6, p7);
    and and_big_gen_6(big_gen_6, g6, p7);

    or big_gen(G, big_gen_0, big_gen_1, big_gen_2, big_gen_3, big_gen_4, big_gen_5, big_gen_6, g7);

    and big_prop(P, p7, p6, p5, p4, p3, p2, p1, p0);

    //assign cout = {c0, c1, c2, c3, c4, c5, c6, c7};
    //assign cout = {c7, c6, c5, c4, c3, c2, c1, c0};
    //assign cout = c7;

endmodule