module register_5 (
	clock,
	ctrl_writeEnable, ctrl_reset,
	//ctrl_readRegA, ctrl_readRegB, data_writeReg,
	data_in, data_out);

	input clock;
	input ctrl_writeEnable, ctrl_reset;

	//input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
	input [4:0] data_in;

	output [4:0] data_out;

	//and clock_enabl(clock_enable, ctrl_writeEnable, clock);
	
	//d0, d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12, d13, d14, d15, d16, d17, d18, d19, d20, d21, d22, d23, d24, d25, d26, d27, d28, d29, d30, d31

	dffe_ref dff0(data_out[0], data_in[0], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff1(data_out[1], data_in[1], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff2(data_out[2], data_in[2], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff3(data_out[3], data_in[3], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff4(data_out[4], data_in[4], clock, ctrl_writeEnable, ctrl_reset);

endmodule
