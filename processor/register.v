module register (
	clock,
	ctrl_writeEnable, ctrl_reset,
	//ctrl_readRegA, ctrl_readRegB, data_writeReg,
	data_in, data_out);

	input clock;
	input ctrl_writeEnable, ctrl_reset;

	//input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
	input [31:0] data_in;

	output [31:0] data_out;

	//and clock_enabl(clock_enable, ctrl_writeEnable, clock);
	
	//d0, d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12, d13, d14, d15, d16, d17, d18, d19, d20, d21, d22, d23, d24, d25, d26, d27, d28, d29, d30, d31

	dffe_ref dff0(data_out[0], data_in[0], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff1(data_out[1], data_in[1], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff2(data_out[2], data_in[2], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff3(data_out[3], data_in[3], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff4(data_out[4], data_in[4], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff5(data_out[5], data_in[5], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff6(data_out[6], data_in[6], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff7(data_out[7], data_in[7], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff8(data_out[8], data_in[8], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff9(data_out[9], data_in[9], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff10(data_out[10], data_in[10], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff11(data_out[11], data_in[11], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff12(data_out[12], data_in[12], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff13(data_out[13], data_in[13], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff14(data_out[14], data_in[14], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff15(data_out[15], data_in[15], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff16(data_out[16], data_in[16], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff17(data_out[17], data_in[17], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff18(data_out[18], data_in[18], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff19(data_out[19], data_in[19], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff20(data_out[20], data_in[20], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff21(data_out[21], data_in[21], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff22(data_out[22], data_in[22], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff23(data_out[23], data_in[23], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff24(data_out[24], data_in[24], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff25(data_out[25], data_in[25], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff26(data_out[26], data_in[26], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff27(data_out[27], data_in[27], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff28(data_out[28], data_in[28], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff29(data_out[29], data_in[29], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff30(data_out[30], data_in[30], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff31(data_out[31], data_in[31], clock, ctrl_writeEnable, ctrl_reset);

endmodule
