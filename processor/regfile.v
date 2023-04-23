module regfile (clock, ctrl_writeEnable, ctrl_reset, ctrl_writeReg, ctrl_readRegA, ctrl_readRegB, data_writeReg, data_readRegA, data_readRegB, step_x_dir, step_y_dir, step_x_speed, step_y_speed);

	input clock, ctrl_writeEnable, ctrl_reset;
	input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
	input [31:0] data_writeReg;

	output [31:0] data_readRegA, data_readRegB;
	output [31:0] step_x_dir, step_y_dir, step_x_speed, step_y_speed;


	assign step_x_dir = reg19_read;
	assign step_y_dir = reg20_read;
	assign step_x_speed = reg21_read;
	assign step_y_speed = reg22_read;


	wire [31:0] reg0_read, reg1_read, reg2_read, reg3_read, reg4_read, reg5_read, reg6_read, reg7_read, reg8_read, reg9_read, reg10_read, reg11_read, reg12_read, reg13_read, reg14_read, reg15_read, reg16_read, reg17_read, reg18_read, reg19_read, reg20_read, reg21_read, reg22_read, reg23_read, reg24_read, reg25_read, reg26_read, reg27_read, reg28_read, reg29_read, reg30_read, reg31_read;

	//dffe_ref dff0(data_out[0],data_in[0], clock, clock_enable, ctrl_reset);

	//tri sel0()

	wire write0, write1, write2, write3, write4, write5, write6, write7, write8, write9, write10, write11, write12, write13, write14, write15, write16, write17, write18, write19, write20, write21, write22, write23, write24, write25, write26, write27, write28, write29, write30, write31;

	decoder_5 write_dec(write0, write1, write2, write3, write4, write5, write6, write7, write8, write9, write10, write11, write12, write13, write14, write15, write16, write17, write18, write19, write20, write21, write22, write23, write24, write25, write26, write27, write28, write29, write30, write31, 1'b1, ctrl_writeReg);

	wire we_0, we_1, we_2, we_3, we_4, we_5, we_6, we_7, we_8, we_9, we_10, we_11, we_12, we_13, we_14, we_15, we_16, we_17, we_18, we_19, we_20, we_21, we_22, we_23, we_24, we_25, we_26, we_27, we_28, we_29, we_30, we_31;

	and reg1_write(we_1, write1, ctrl_writeEnable);
	and reg2_write(we_2, write2, ctrl_writeEnable);
	and reg3_write(we_3, write3, ctrl_writeEnable);
	and reg4_write(we_4, write4, ctrl_writeEnable);
	and reg5_write(we_5, write5, ctrl_writeEnable);
	and reg6_write(we_6, write6, ctrl_writeEnable);
	and reg7_write(we_7, write7, ctrl_writeEnable);
	and reg8_write(we_8, write8, ctrl_writeEnable);
	and reg9_write(we_9, write9, ctrl_writeEnable);
	and reg10_write(we_10, write10, ctrl_writeEnable);
	and reg11_write(we_11, write11, ctrl_writeEnable);
	and reg12_write(we_12, write12, ctrl_writeEnable);
	and reg13_write(we_13, write13, ctrl_writeEnable);
	and reg14_write(we_14, write14, ctrl_writeEnable);
	and reg15_write(we_15, write15, ctrl_writeEnable);
	and reg16_write(we_16, write16, ctrl_writeEnable);
	and reg17_write(we_17, write17, ctrl_writeEnable);
	and reg18_write(we_18, write18, ctrl_writeEnable);
	and reg19_write(we_19, write19, ctrl_writeEnable);
	and reg20_write(we_20, write20, ctrl_writeEnable);
	and reg21_write(we_21, write21, ctrl_writeEnable);
	and reg22_write(we_22, write22, ctrl_writeEnable);
	and reg23_write(we_23, write23, ctrl_writeEnable);
	and reg24_write(we_24, write24, ctrl_writeEnable);
	and reg25_write(we_25, write25, ctrl_writeEnable);
	and reg26_write(we_26, write26, ctrl_writeEnable);
	and reg27_write(we_27, write27, ctrl_writeEnable);
	and reg28_write(we_28, write28, ctrl_writeEnable);
	and reg29_write(we_29, write29, ctrl_writeEnable);
	and reg30_write(we_30, write30, ctrl_writeEnable);
	and reg31_write(we_31, write31, ctrl_writeEnable);
	
	//module register (clock, ctrl_writeEnable, ctrl_reset, data_in, data_out);
	register reg0(clock, we_0, ctrl_reset, 32'b0, reg0_read);
	register reg1(clock, we_1, ctrl_reset, data_writeReg, reg1_read);
	register reg2(clock, we_2, ctrl_reset, data_writeReg, reg2_read);
	register reg3(clock, we_3, ctrl_reset, data_writeReg, reg3_read);
	register reg4(clock, we_4, ctrl_reset, data_writeReg, reg4_read);
	register reg5(clock, we_5, ctrl_reset, data_writeReg, reg5_read);
	register reg6(clock, we_6, ctrl_reset, data_writeReg, reg6_read);
	register reg7(clock, we_7, ctrl_reset, data_writeReg, reg7_read);
	register reg8(clock, we_8, ctrl_reset, data_writeReg, reg8_read);
	register reg9(clock, we_9, ctrl_reset, data_writeReg, reg9_read);
	register reg10(clock, we_10, ctrl_reset, data_writeReg, reg10_read);
	register reg11(clock, we_11, ctrl_reset, data_writeReg, reg11_read);
	register reg12(clock, we_12, ctrl_reset, data_writeReg, reg12_read);
	register reg13(clock, we_13, ctrl_reset, data_writeReg, reg13_read);
	register reg14(clock, we_14, ctrl_reset, data_writeReg, reg14_read);
	register reg15(clock, we_15, ctrl_reset, data_writeReg, reg15_read);
	register reg16(clock, we_16, ctrl_reset, data_writeReg, reg16_read);
	register reg17(clock, we_17, ctrl_reset, data_writeReg, reg17_read);
	register reg18(clock, we_18, ctrl_reset, data_writeReg, reg18_read);
	register reg19(clock, we_19, ctrl_reset, data_writeReg, reg19_read);
	register reg20(clock, we_20, ctrl_reset, data_writeReg, reg20_read);
	register reg21(clock, we_21, ctrl_reset, data_writeReg, reg21_read);
	register reg22(clock, we_22, ctrl_reset, data_writeReg, reg22_read);
	register reg23(clock, we_23, ctrl_reset, data_writeReg, reg23_read);
	register reg24(clock, we_24, ctrl_reset, data_writeReg, reg24_read);
	register reg25(clock, we_25, ctrl_reset, data_writeReg, reg25_read);
	register reg26(clock, we_26, ctrl_reset, data_writeReg, reg26_read);
	register reg27(clock, we_27, ctrl_reset, data_writeReg, reg27_read);
	register reg28(clock, we_28, ctrl_reset, data_writeReg, reg28_read);
	register reg29(clock, we_29, ctrl_reset, data_writeReg, reg29_read);
	register reg30(clock, we_30, ctrl_reset, data_writeReg, reg30_read);
	register reg31(clock, we_31, ctrl_reset, data_writeReg, reg31_read);

	wire readA_0, readA_1, readA_2, readA_3, readA_4, readA_5, readA_6, readA_7, readA_8, readA_9, readA_10, readA_11, readA_12, readA_13, readA_14, readA_15, readA_16, readA_17, readA_18, readA_19, readA_20, readA_21, readA_22, readA_23, readA_24, readA_25, readA_26, readA_27, readA_28, readA_29, readA_30, readA_31;

	wire readB_0, readB_1, readB_2, readB_3, readB_4, readB_5, readB_6, readB_7, readB_8, readB_9, readB_10, readB_11, readB_12, readB_13, readB_14, readB_15, readB_16, readB_17, readB_18, readB_19, readB_20, readB_21, readB_22, readB_23, readB_24, readB_25, readB_26, readB_27, readB_28, readB_29, readB_30, readB_31;

	decoder_5 read_A(readA_0, readA_1, readA_2, readA_3, readA_4, readA_5, readA_6, readA_7, readA_8, readA_9, readA_10, readA_11, readA_12, readA_13, readA_14, readA_15, readA_16, readA_17, readA_18, readA_19, readA_20, readA_21, readA_22, readA_23, readA_24, readA_25, readA_26, readA_27, readA_28, readA_29, readA_30, readA_31, 1'b1, ctrl_readRegA);

	decoder_5 read_B(readB_0, readB_1, readB_2, readB_3, readB_4, readB_5, readB_6, readB_7, readB_8, readB_9, readB_10, readB_11, readB_12, readB_13, readB_14, readB_15, readB_16, readB_17, readB_18, readB_19, readB_20, readB_21, readB_22, readB_23, readB_24, readB_25, readB_26, readB_27, readB_28, readB_29, readB_30, readB_31, 1'b1, ctrl_readRegB);

	//module tristate(d, en, out);
	tristate tri_A_0(reg0_read, readA_0, data_readRegA);
	tristate tri_A_1(reg1_read, readA_1, data_readRegA);
	tristate tri_A_2(reg2_read, readA_2, data_readRegA);
	tristate tri_A_3(reg3_read, readA_3, data_readRegA);
	tristate tri_A_4(reg4_read, readA_4, data_readRegA);
	tristate tri_A_5(reg5_read, readA_5, data_readRegA);
	tristate tri_A_6(reg6_read, readA_6, data_readRegA);
	tristate tri_A_7(reg7_read, readA_7, data_readRegA);
	tristate tri_A_8(reg8_read, readA_8, data_readRegA);
	tristate tri_A_9(reg9_read, readA_9, data_readRegA);
	tristate tri_A_10(reg10_read, readA_10, data_readRegA);
	tristate tri_A_11(reg11_read, readA_11, data_readRegA);
	tristate tri_A_12(reg12_read, readA_12, data_readRegA);
	tristate tri_A_13(reg13_read, readA_13, data_readRegA);
	tristate tri_A_14(reg14_read, readA_14, data_readRegA);
	tristate tri_A_15(reg15_read, readA_15, data_readRegA);
	tristate tri_A_16(reg16_read, readA_16, data_readRegA);
	tristate tri_A_17(reg17_read, readA_17, data_readRegA);
	tristate tri_A_18(reg18_read, readA_18, data_readRegA);
	tristate tri_A_19(reg19_read, readA_19, data_readRegA);
	tristate tri_A_20(reg20_read, readA_20, data_readRegA);
	tristate tri_A_21(reg21_read, readA_21, data_readRegA);
	tristate tri_A_22(reg22_read, readA_22, data_readRegA);
	tristate tri_A_23(reg23_read, readA_23, data_readRegA);
	tristate tri_A_24(reg24_read, readA_24, data_readRegA);
	tristate tri_A_25(reg25_read, readA_25, data_readRegA);
	tristate tri_A_26(reg26_read, readA_26, data_readRegA);
	tristate tri_A_27(reg27_read, readA_27, data_readRegA);
	tristate tri_A_28(reg28_read, readA_28, data_readRegA);
	tristate tri_A_29(reg29_read, readA_29, data_readRegA);
	tristate tri_A_30(reg30_read, readA_30, data_readRegA);
	tristate tri_A_31(reg31_read, readA_31, data_readRegA);


	tristate tri_B_0(reg0_read, readB_0, data_readRegB);
	tristate tri_B_1(reg1_read, readB_1, data_readRegB);
	tristate tri_B_2(reg2_read, readB_2, data_readRegB);
	tristate tri_B_3(reg3_read, readB_3, data_readRegB);
	tristate tri_B_4(reg4_read, readB_4, data_readRegB);
	tristate tri_B_5(reg5_read, readB_5, data_readRegB);
	tristate tri_B_6(reg6_read, readB_6, data_readRegB);
	tristate tri_B_7(reg7_read, readB_7, data_readRegB);
	tristate tri_B_8(reg8_read, readB_8, data_readRegB);
	tristate tri_B_9(reg9_read, readB_9, data_readRegB);
	tristate tri_B_10(reg10_read, readB_10, data_readRegB);
	tristate tri_B_11(reg11_read, readB_11, data_readRegB);
	tristate tri_B_12(reg12_read, readB_12, data_readRegB);
	tristate tri_B_13(reg13_read, readB_13, data_readRegB);
	tristate tri_B_14(reg14_read, readB_14, data_readRegB);
	tristate tri_B_15(reg15_read, readB_15, data_readRegB);
	tristate tri_B_16(reg16_read, readB_16, data_readRegB);
	tristate tri_B_17(reg17_read, readB_17, data_readRegB);
	tristate tri_B_18(reg18_read, readB_18, data_readRegB);
	tristate tri_B_19(reg19_read, readB_19, data_readRegB);
	tristate tri_B_20(reg20_read, readB_20, data_readRegB);
	tristate tri_B_21(reg21_read, readB_21, data_readRegB);
	tristate tri_B_22(reg22_read, readB_22, data_readRegB);
	tristate tri_B_23(reg23_read, readB_23, data_readRegB);
	tristate tri_B_24(reg24_read, readB_24, data_readRegB);
	tristate tri_B_25(reg25_read, readB_25, data_readRegB);
	tristate tri_B_26(reg26_read, readB_26, data_readRegB);
	tristate tri_B_27(reg27_read, readB_27, data_readRegB);
	tristate tri_B_28(reg28_read, readB_28, data_readRegB);
	tristate tri_B_29(reg29_read, readB_29, data_readRegB);
	tristate tri_B_30(reg30_read, readB_30, data_readRegB);
	tristate tri_B_31(reg31_read, readB_31, data_readRegB);

endmodule
