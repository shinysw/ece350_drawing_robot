//`include "half_adder.v"

module full_adder(a, b, cin, sout, cout);
    //what are the input ports.
    input a, b, cin;
    output sout, cout;

     wire c1, s1, c2, s2;
     //module half_adder(a, b, sum, carry);
     half_adder first(a, b, s1, c1);
     half_adder second(s1, cin, sout, c2);

     or or_carry(cout, c1, c2);
    
endmodule