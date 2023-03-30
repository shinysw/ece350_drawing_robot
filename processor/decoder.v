module decoder_2 (out0, out1, out2, out3, en, select);
	input [1:0] select;
	input en;
	output out0, out1, out2, out3;

	and and0(out0, en, !select[0], !select[1]);
	and and1(out1, en, select[0], !select[1]);
	and and2(out2, en, !select[0], select[1]);
	and and3(out3, en, select[0], select[1]);

endmodule  

module decoder_3 (out0, out1, out2, out3, out4, out5, out6, out7, en, select);
	input [2:0] select;
	input en;
	output out0, out1, out2, out3, out4, out5, out6, out7;

	and and0(out0, en, !select[0], !select[1], !select[2]);
	and and1(out1, en,  select[0], !select[1], !select[2]);
	and and2(out2, en, !select[0],  select[1], !select[2]);
	and and3(out3, en,  select[0],  select[1], !select[2]);
	and and4(out4, en, !select[0], !select[1],  select[2]);
	and and5(out5, en,  select[0], !select[1],  select[2]);
	and and6(out6, en, !select[0],  select[1],  select[2]);
	and and7(out7, en,  select[0],  select[1],  select[2]);

	//decoder_2 first_dec(out0, out1, out2, out3, !select[2], select[1:0]);
	//decoder_2 secon_dec(out0, out1, out2, out3, select[2], select[1:0]);
endmodule  

module decoder_5 (out0, out1, out2, out3, out4, out5, out6, out7, out8, out9, out10, out11, out12, out13, out14, out15, out16, out17, out18, out19, out20, out21, out22, out23, out24, out25, out26, out27, out28, out29, out30, out31, en, select);
	input [4:0] select;
	input en;
	output out0, out1, out2, out3, out4, out5, out6, out7, out8, out9, out10, out11, out12, out13, out14, out15, out16, out17, out18, out19, out20, out21, out22, out23, out24, out25, out26, out27, out28, out29, out30, out31;

	wire w0, w1, w2, w3;
	decoder_2 dec_2(w0, w1, w2, w3, 1'b1, select[4:3]);

	decoder_3 dec_3_0(out0, out1, out2, out3, out4, out5, out6, out7, w0, select[2:0]);
	decoder_3 dec_3_1(out8, out9, out10, out11, out12, out13, out14, out15, w1, select[2:0]);
	decoder_3 dec_3_2(out16, out17, out18, out19, out20, out21, out22, out23, w2, select[2:0]);
	decoder_3 dec_3_3(out24, out25, out26, out27, out28, out29, out30, out31, w3, select[2:0]);
	//decoder_2 secon_dec(out0, out1, out2, out3, select[2], select[1:0]);
endmodule  