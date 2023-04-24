`timescale 1ns / 1ps
/**
 * 
 * READ THIS DESCRIPTION:
 *
 * This is the Wrapper module that will serve as the header file combining your processor, 
 * RegFile and Memory elements together.
 *
 * This file will be used to generate the bitstream to upload to the FPGA.
 * We have provided a sibling file, Wrapper_tb.v so that you can test your processor's functionality.
 * 
 * We will be using our own separate Wrapper_tb.v to test your code. You are allowed to make changes to the Wrapper files 
 * for your own individual testing, but we expect your final processor.v and memory modules to work with the 
 * provided Wrapper interface.
 * 
 * Refer to Lab 5 documents for detailed instructions on how to interface 
 * with the memory elements. Each imem and dmem modules will take 12-bit 
 * addresses and will allow for storing of 32-bit values at each address. 
 * Each memory module should receive a single clock. At which edges, is 
 * purely a design choice (and thereby up to you). 
 * 
 * You must change line 36 to add the memory file of the test you created using the assembler
 * For example, you would add sample inside of the quotes on line 38 after assembling sample.s
 *
 **/

module Wrapper (clock, reset, regAData, stepper_x_out, stepper_y_out, stepper_x_dir, stepper_y_dir, servo_out, switches, btnL, btnR, btnD, btnU, square_in, triange_in, star_in);

	input clock, reset, switches, btnL, btnR, btnD, btnU, square_in, triangle_in, star_in;

	output [15:0] regAData;
	output stepper_x_out, stepper_y_out, stepper_x_dir, stepper_y_dir, servo_out;

	wire[31:0] step_x_dir, step_y_dir, step_x_speed, step_y_speed, square, triangle, star;

	assign stepper_x_out = (btnL || btnR) ? def_x :  step_x_speed;
	assign stepper_y_out = (btnU || btnD) ? def_y : step_y_speed; 
	
	assign square = square_in ? 32'd1 : 32'd0;
	assign triangle = triange_in ? 32'd1 : 32'd0;
	assign star = star_in ? 32'd1 : 32'd0;
	assign stepper_x_dir = (btnL) ? 0 : 1;
	assign stepper_y_dir = (btnU) ? 0 : 1;

	wire def_x, def_y;
	move_one_step move_one_step_x(.clock_in(clock), .out(def_x));
	move_one_step move_one_step_y(.clock_in(clock), .out(def_y));

	wire stepOutput;

	wire en;
	assign en = 1;
     
	stepper_controller stepper_controller (.en(en),.clk(clockIn), .numOfSteps (32'd5), .cyclesBetweenSteps(32'd1000), .stepOutput (stepOutput));

	//Servo Stuff
    wire [31:0] duty_cycle;
    //Allows servo to be controlled by switch wow
    assign duty_cycle = switches ? 32'd100000 : 32'd200000;

    //Outputs pwm for servo
	wire servo_var;
	assign servo_out = servo_var;
	servo servo( .clock_in(clock), .out(servo_var), .duty(duty_cycle));

	wire rwe, mwe;
	wire[4:0] rd, rs1, rs2;
	wire[31:0] instAddr, instData, 
		rData, regA, regB,
		memAddr, memDataIn, memDataOut;

	// ADD YOUR MEMORY FILE HERE
	//localparam INSTR_FILE = "";
	localparam INSTR_FILE = "C:/Users/shiny/Desktop/ShinySw/School/ECE350/processor/processor/Test Files/Memory Files/test32";
	
	wire controller_reset;
	wire[2:0] presets;
	assign presets[2] = square_in;
	assign presets[1] = triangle_in;
	assign presets[0] = star_in;


	// Main Processing Unit
	processor CPU(.clock(clock), .reset(reset), 
								
		// ROM
		.address_imem(instAddr), .q_imem(instData),
									
		// Regfile
		.ctrl_writeEnable (rwe),     .ctrl_writeReg(rd),
		.ctrl_readRegA(rs1),     .ctrl_readRegB(rs2), 
		.data_writeReg(rData), .data_readRegA(regA), .data_readRegB(regB),
									
		// RAM
		.wren(mwe), .address_dmem(memAddr), 
		.data(memDataIn), .q_dmem(memDataOut), .pre(presets)); 
	
	// Instruction Memory (ROM)
	ROM #(.MEMFILE({INSTR_FILE, ".mem"}))
	InstMem(.clk(clock), 
		.addr(instAddr[11:0]), 
		.dataOut(instData));
	
	// Register File
	regfile RegisterFile(.clock(clock), 
		.ctrl_writeEnable(rwe), .ctrl_reset(reset), 
		.ctrl_writeReg(rd),
		.ctrl_readRegA(rs1), .ctrl_readRegB(rs2), 
		.step_x_dir(step_x_dir), .step_y_dir(step_y_dir), .step_x_speed(step_x_speed), .step_y_speed(step_y_speed),
		.data_writeReg(rData), .data_readRegA(regA), .data_readRegB(regB), .square(square), .triangle(triangle), .star(star));
						
	// Processor Memory (RAM)
	RAM ProcMem(.clk(clock), 
		.wEn(mwe), 
		.addr(memAddr[11:0]), 
		.dataIn(memDataIn), 
		.dataOut(memDataOut));

	assign regAData = regA[15:0];
	//assign regBData = regB;

endmodule
