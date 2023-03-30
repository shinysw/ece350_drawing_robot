module multdiv(
	data_operandA, data_operandB, 
	ctrl_MULT, ctrl_DIV, 
	clock, 
	data_result, data_exception, data_multRDY, data_divRDY);

    input [31:0] data_operandA, data_operandB;
    input ctrl_MULT, ctrl_DIV, clock;

    output [31:0] data_result;
    output data_exception, data_multRDY, data_divRDY;

	wire [31:0] mult_data_result;
	wire mult_exp;

	wallace_mult mult(data_operandA, data_operandB, mult_data_result, mult_exp);

	wire c1, c2, c3, c4, div_res_ready, mult_res_ready;
	wire div_ready, div_exp;
	
	//module dffe_ref (q, d, clk, en, clr);
	dffe_ref dff_0(c1, div_ready, clock, 1'b1, 1'b0);
	dffe_ref dff_1(c2, c1, clock, 1'b1, 1'b0);
	and debounce(div_res_ready, c1, !c2);

	//DFF circuit for keeping the ready signal high for one clock cycle
	dffe_ref dff_2(c3, ctrl_MULT, clock, 1'b1, 1'b0);
	dffe_ref dff_3(mult_res_ready, c3, clock, 1'b1, 1'b0);
	//and debounce1(mult_res_ready, c3, !c4);

	//Latch when there is a mult operation
	wire mult_d, mult_q;
	dffe_ref dff_mult_latch(mult_q, 1'b1, ctrl_MULT, 1'b1, ctrl_DIV);
	//or or_mult(mult_d, ctrl_MULT, mult_q);

	//Latch when there is a div operation
	wire div_d, div_q;
	dffe_ref dff_div_latch(div_q, 1'b1, ctrl_DIV, 1'b1, ctrl_MULT);

	//assign data_resultRDY = mult_q ? mult_res_ready : div_res_ready;
	assign data_result = mult_q ? mult_data_result : div_data_result;
	//assign data_result = mult_data_result;
	wire [3:0] cout;
	counter_16 count(clock, ctrl_MULT, cout);

	assign data_divRDY = div_res_ready;
	assign data_multRDY = 1'b1;
	//assign data_multRDY = mult_ready;
	
	wire [31:0] temp, temp2, temp3, div_data_result;

	
	//module divider(A, B, clock, out, start, exp, ready);
	divider div(data_operandA, data_operandB, clock, div_data_result, ctrl_DIV, div_exp, div_ready);

	assign data_exception = mult_q ? mult_exp : div_exp;

endmodule