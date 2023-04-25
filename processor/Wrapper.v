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

module Wrapper (clock, reset, regAData, stepper_x_out, stepper_y_out, stepper_x_dir, stepper_y_dir, control_sel, servo_out, switches, btnL, btnR, btnD, btnU, square_in, triangle_in, star_in);

	input clock, reset, switches, control_sel, btnL, btnR, btnD, btnU, square_in, triangle_in, star_in;
	
	output [15:0] regAData;
	output stepper_x_out, stepper_y_out, stepper_x_dir, stepper_y_dir, servo_out;

	wire[31:0] step_x_dir, step_y_dir, step_x_speed, step_y_speed, servo_duty_cycle, square, triangle, star;

	//Switches control of stepper between manual vs. programmed memory
	assign stepper_x_out = control_sel ? button_stepper_x : prog_x;
	assign stepper_y_out = control_sel ? button_stepper_y : prog_y;

	//Button stepper control for speed
	wire button_stepper_x, button_stepper_y;
	assign button_stepper_x = (btnL || btnR) ? def_x : 0;
	assign button_stepper_y = (btnU || btnD) ? def_y : 0; 
	
	//Switches control of stepper between selected vs. programmed memory
	assign stepper_x_dir = control_sel ? button_x_dir : step_x_dir[0];
	assign stepper_y_dir = control_sel ? button_y_dir : step_y_dir[0];

	//Button stepper control for directionf
	wire button_x_dir, button_y_dir;
	assign button_x_dir = (btnL || btnR) ? (btnL ? 1 : 0) : 0;
	assign button_y_dir = (btnU || btnD) ? (btnU ? 1 : 0) : 0;

	assign square = square_in ? 32'd1 : 32'd0;
	assign triangle = triangle_in ? 32'd1 : 32'd0;
	assign star = star_in ? 32'd1 : 32'd0;

	wire def_x, def_y;
	move_one_step move_one_step_x(.clock_in(clock), .speed(31'd20000), .out(def_x));
	move_one_step move_one_step_y(.clock_in(clock), .speed(31'd20000), .out(def_y));
	
	wire mem_x, mem_y, prog_x, prog_y;
	move_one_step move_one_step_x_prog(.clock_in(clock), .speed(step_x_speed), .out(prog_x));
	move_one_step move_one_step_y_prog(.clock_in(clock), .speed(step_y_speed), .out(prog_y));
	
    // assign mem_x = step_x_speed[0] ? prog_x : 1'b0;
    // assign mem_y = step_y_speed[0] ? prog_y : 1'b0;

    // wire mem_x_dir, mem_y_dir, prog_x, prog_y;
	wire stepOutput;

	wire en;
	assign en = 1;
     
	stepper_controller stepper_controller (.en(en),.clk(clockIn), .numOfSteps (32'd5), .cyclesBetweenSteps(32'd1000), .stepOutput (stepOutput));

	//Servo Stuff
    wire [31:0] manual_duty_cycle, program_duty_cycle;
    //Allows servo to be controlled by switch wow
    assign manual_duty_cycle = switches ? 32'd100000 : 32'd200000;
    assign program_duty_cycle = servo_duty_cycle * 1000 + 100000;

    assign duty_cycle = control_sel ? manual_duty_cycle : program_duty_cycle;

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
	localparam INSTR_FILE = "C:/Users/shiny/Desktop/ShinySw/School/ECE350/processor/processor/Test Files/Memory Files/presets";
	
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
		.step_x_dir(step_x_dir), .step_y_dir(step_y_dir), .step_x_speed(step_x_speed), .step_y_speed(step_y_speed), .servo_duty_cycle(servo_duty_cycle),
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
