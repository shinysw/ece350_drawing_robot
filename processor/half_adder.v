module half_adder(a, b, sum, carry);
    input a;
    input b;
    output sum;
    output carry;

    xor xor_gate(sum, a, b);
    and and_gate(carry, a, b);
     
endmodule