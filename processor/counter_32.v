module counter_32 (clk, rst, out);

input clk, rst;
output [4:0] out;

  wire trig;
  assign trig = 1'b1;

    wire test;
    wire q0, q1, q2, q3, q4, clr;

    assign clr = rst;

dffe_ref dff_a(q0, !q0, clk, 1'b1, clr);
dffe_ref dff_b(q1, !q1, q0, 1'b1, clr);
dffe_ref dff_c(q2, !q2, q1, 1'b1, clr);
dffe_ref dff_d(q3, !q3, q2, 1'b1, clr);
dffe_ref dff_e(q4, !q4, q3, 1'b1, clr);

//nand rst(clr, q0, q1, q2, q3);

    assign out[0] = !q0;
    assign out[1] = !q1;
    assign out[2] = !q2;
    assign out[3] = !q3;
    assign out[4] = !q4;


endmodule