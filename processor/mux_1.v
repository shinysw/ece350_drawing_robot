module mux_2_1 (out, select, in0, in1);
	input select;
	input  in0, in1;
	output  out;
	assign out = select ? in1 : in0;
endmodule  

module mux_4_1 (out, select, in0, in1, in2, in3);
	input [1:0] select;
	input  in0, in1, in2, in3;
	output  out;
	wire  w1, w2;

	mux_2_1 first_top(w1, select[0], in0, in1);
	mux_2_1 first_bottom(w2, select[0], in2, in3);
	mux_2_1 second(out, select[1], w1, w2);
endmodule

module mux_8_1 (out, select, in0, in1, in2, in3, in4, in5, in6, in7);
	input [2:0] select;
	input  in0, in1, in2, in3, in4, in5, in6, in7;
	output  out;
	wire  w1, w2;

	mux_4_1 first_top(w1, select[1:0], in0, in1, in2, in3);
	mux_4_1 first_bottom(w2, select[1:0], in4, in5, in6, in7);
	mux_2_1 second(out, select[2], w1, w2);
endmodule

module mux_16_1(out, select, in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15);
	input [3:0] select;
	input  in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15;
	output  out;
	wire  w1, w2;

	mux_8_1 first_top(w1, select[2:0], in0, in1, in2, in3, in4, in5, in6, in7);
	mux_8_1 first_bottom(w2, select[2:0], in8, in9, in10, in11, in12, in13, in14, in15);
	mux_2_1 second(out, select[3], w1, w2);
endmodule

module mux_32_1(out, select, in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16, in17, in18, in19, in20, in21, in22, in23, in24, in25, in26, in27, in28, in29, in30, in31);
	input [4:0] select;
	input  in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16, in17, in18, in19, in20, in21, in22, in23, in24, in25, in26, in27, in28, in29, in30, in31;
	output  out;
	wire  w1, w2;

	mux_16_1 first_top(w1, select[3:0], in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15);
	mux_16_1 first_bottom(w2, select[3:0], in16, in17, in18, in19, in20, in21, in22, in23, in24, in25, in26, in27, in28, in29, in30, in31);
	mux_2_1 second(out, select[4], w1, w2);
endmodule
