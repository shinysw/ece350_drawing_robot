module divider(A, B, clock, out, start, exp, ready);

input [31:0] A, B;
output [31:0] out;
wire [63:0] prod;
output exp, ready;
input clock, start;

//add = 0, sub = 1, and = 2, or = 3, sll = 4, sra = 5
wire [4:0] add_OP, sub_OP, and_OP, or_OP, sll_OP, sra_OP;
assign add_OP = 5'd0;
assign sub_OP = 5'd1;

wire [31:0] signed_div, onee;
wire placeholder, reset, cont;

//counter
wire [4:0] cout;
counter_32 count(clock, start, cout);


mux_32_1 count_time(ready, cout, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0);

wire is_dividend_0, is_divisor_0;
assign is_dividend_0 = A & 32'b0;
assign is_divisor_0 = B & 32'b0;

wire [31:0] negA, negB, dividend, divisor, accumul_divis;
wire flip_noteq_a, flip_noteq_b, flip_lessthan_a, flip_lessthan_b;
//Flip bits and add one for positive equivalents
cla_32_bit flip_add_one_A(~A, 32'b1, 1'b0, negA, placeholder, flip_noteq_a, flip_lessthan_a);
cla_32_bit flip_add_one_B(~B, 32'b1, 1'b0, negB, placeholder, flip_noteq_b, flip_lessthan_b);
//Picks the positive version of each number
assign dividend = A[31] ? negA : A;
assign divisor = B[31] ? negB : B;


wire [31:0] divid_in, divis_in, divid_end, divis_end, divid_out, accumul_in, divid_curr, accumul_curr;
//"First" loop
assign divid_in = start ? dividend : divid_end;
assign accumul_in = start ? 32'b0 : accumul_end;

register divid_reg(clock, 1'b1, reset, divid_in, divid_curr);
register accumul_reg(clock, 1'b1, reset, accumul_in, accumul_curr);

//condition ? value_if_true : value_if_false

//Shifts dividend
wire [31:0] divid_shifted;
lshifter shiftleft(divid_curr, 5'b1, divid_shifted);

//Puts shifted out dividend bit into temporary accumulator
wire [31:0] accum_temp;
assign accum_temp = { accumul_curr[30:0],divid_curr[31]};

//module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

//Subtracts divisor from the accumulator
wire [31:0] sub_accum_div, accumul_end;
wire none, none1, none2;
alu sub_c_b(accum_temp, divisor, sub_OP, 5'b0, sub_accum_div, none, none1, none2);

//Determines msb of A
wire msb;
assign msb = sub_accum_div[31] ? 1'b0 : 1'b1;

//Determines what new bits should be
assign accumul_end = msb ? sub_accum_div : accum_temp;
assign divid_end = {divid_shifted[31:1], msb};

//Restores sign if result should be negative
wire [31:0] neg_out;
wire out_c, flip_noteq_res, flip_lessthan_res;
cla_32_bit flip_add_one_res(~divid_end, 32'b1, 1'b0, neg_out, out_c, flip_noteq_res, flip_lessthan_res);

wire neg_res;
xnor neg_res_xnor(neg_res, A[31], B[31]);

assign out = neg_res ? divid_end : neg_out;
assign exp = is_dividend_0 ? 1'b1: 1'b0;

endmodule