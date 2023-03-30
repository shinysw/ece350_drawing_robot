module cla_32_bit(A, B, cin, out, cout, noteq, lessthan);
    input [31:0] A;
    input [31:0] B;
    input cin;

    output [31:0] out;
    output cout, noteq, lessthan;

    wire [7:0] first_out;
    wire first_carry, first_g, first_p;
    wire [31:0] xor_out;

    alu_xor eq_check(A, B, xor_out);

    cla_8_bit cla_8_bit_1(A[7:0], B[7:0], 1'b0, out[7:0], first_carry, first_p, first_g);

    wire temp_1, big_carry_1;
    and first_carry_0(temp_1, first_p, cin);
    or first_carry_1(big_carry_1, temp_1, first_g);


    wire second_carry, second_p, second_g;
    cla_8_bit cla_8_bit_2(A[15:8], B[15:8], big_carry_1, out[15:8], second_carry, second_p, second_g);

    wire carry_2_temp_0, carry_2_temp_1, carry_2_temp_2, big_carry_2;
    and carry_2_0(carry_2_temp_0, first_g, second_p);
    and carry_2_1(carry_2_temp_1, second_p, first_p, cin);
    or first_carry_2(big_carry_2, carry_2_temp_0, carry_2_temp_1, second_g);


    wire third_carry, third_p, third_g;
    cla_8_bit cla_8_bit_3(A[23:16], B[23:16], big_carry_2, out[23:16], third_carry, third_p, third_g);


    wire carry_3_temp_0, carry_3_temp_1, carry_3_temp_2, big_carry_3;
    and carry_3_0(carry_3_temp_0, third_p, second_g);
    and carry_3_1(carry_3_temp_1, third_p, second_p, first_g);
    and carry_3_2(carry_3_temp_2, third_p, second_p, first_p, cin);
    or carry_3_3(big_carry_3, carry_3_temp_0, carry_3_temp_1, carry_3_temp_2, third_g);

    wire fourth_carry, fourth_p, fourth_g;
    cla_8_bit cla_8_bit_4(A[31:24], B[31:24], big_carry_3, out[31:24], fourth_carry, fourth_p, fourth_g);

    wire carry_4_temp_0, carry_4_temp_1, carry_4_temp_2, carry_4_temp_3, big_carry_4;
    and carry_4_0(carry_4_temp_0, fourth_p, third_g);
    and carry_4_1(carry_4_temp_1, fourth_p, third_p, second_g);
    and carry_4_2(carry_4_temp_2, fourth_p, third_p, second_p, first_g);
    and carry_4_3(carry_4_temp_3, fourth_p, third_p, second_p, first_p, cin);
    or carry_4_4(big_carry_4, carry_4_temp_0, carry_4_temp_1, carry_4_temp_2, carry_4_temp_3, fourth_g);

    wire last_A, last_B, last_O, not_last_A, not_last_B, not_last_O, same_sign, check, check2, check3, check4;
    assign last_A = A[31];
    assign last_B = B[31];
    assign last_O = out[31];


    xor negateA(not_last_A, last_A, 1);
    xor negateB(not_last_B, last_B, 1);
    xor negateO(not_last_O, last_O, 1);

    and neg(check, not_last_A, not_last_B, last_O);
    and pos(check2, last_A, last_B, not_last_O);

    or over(cout, check, check2);

    wire res_zero;
    or check0(noteq, out[0], out[1], out[2], out[3], out[4], out[5], out[6], out[7], out[8], out[9], out[10], out[11], out[12], out[13], out[14], out[15], out[16], out[17], out[18], out[19], out[20], out[21], out[22], out[23], out[24], out[25], out[26], out[27], out[28], out[29], out[30], out[31]);
    

    xor lesssthan(lessthan, last_O, cout);


    //assign lessthan = last_O;

endmodule