/**
* READ THIS DESCRIPTION!
*
* This is your processor module that will contain the bulk of your code submission. You are to implement
* a 5-stage pipelined processor in this module, accounting for hazards and implementing bypasses as
* necessary.
*
* Ultimately, your processor will be tested by a master skeleton, so the
* testbench can see which controls signal you active when. Therefore, there needs to be a way to
* "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
* file, Wrapper.v, acts as a small wrapper around your processor for this purpose. Refer to Wrapper.v
* for more details.
*
* As a result, this module will NOT contain the RegFile nor the memory modules. Study the inputs
* very carefully - the RegFile-related I/Os are merely signals to be sent to the RegFile instantiated
* in your Wrapper module. This is the same for your memory elements.
*
*
*/
module processor(
// Control signals
clock, // I: The master clock
reset, // I: A reset signal

// Imem
address_imem, // O: The address of the data to get from imem
q_imem, // I: The data from imem

// Dmem
address_dmem, // O: The address of the data to get or put from/to dmem
data, // O: The data to write to dmem
wren, // O: Write enable for dmem
q_dmem, // I: The data from dmem

// Regfile
ctrl_writeEnable, // O: Write enable for RegFile
ctrl_writeReg, // O: Register to write to in RegFile
ctrl_readRegA, // O: Register to read from port A of RegFile
ctrl_readRegB, // O: Register to read from port B of RegFile
data_writeReg, // O: Data to write to for RegFile
data_readRegA, // I: Data from port A of RegFile
data_readRegB, // I: Data from port B of RegFile

// Presets
pre

);

// Control signals
input clock, reset;
input[2:0] pre;

// Imem
output [31:0] address_imem;
input [31:0] q_imem;

// Dmem
output [31:0] address_dmem, data;
output wren;
input [31:0] q_dmem;

// Regfile
output ctrl_writeEnable;
output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
output [31:0] data_writeReg;
input [31:0] data_readRegA, data_readRegB;


/*****************************Fetch*****************************/
wire [31:0] address_imem_new, address_imem_curr, address_imem_add;

// + 1 adder for the PC
wire pc_carry, pc_neq, pc_lt;
cla_32_bit program_counter(address_imem, 32'b1, 1'b0, address_imem_add, pc_carry, pc_neq, pc_lt);

wire reg_pc_w_en;
//Program Counter PC
falling_register reg_pc(clock, reg_pc_w_en, reset, address_imem_new, address_imem);

//Register for the +1 PC out
wire [31:0] fet_pc_out;
falling_register fet_pc(clock, reg_f_d_w_en, reset, address_imem_add, fet_pc_out);

//Register for the instruction
wire reg_f_d_w_en;
falling_register reg_f_d(clock, reg_f_d_w_en, reset, reg_f_d_out_inter, reg_f_d_out);

wire [31:0] reg_f_d_out, reg_d_x_out, reg_x_m_out, reg_m_w_out;

wire [31:0] reg_f_d_out_inter;
wire square, triangle, star, square_out, triangle_out, star_out, controller_reset;
assign square = pre[2];
assign traingle = pre[1];
assign star = pre[0];

assign controller_reset = reset || (square == 1'b0 && triangle == 1'b0 && star == 1'b0);
preset_controller preset_controller(clock, controller_reset, pre, square_out, triangle_out, star_out);

wire[31:0] add1tosquare, add1totriangle, add1tostar;

assign add1tosquare = 32'b00101010000000000000000000000001;
assign add1totriangle = 32'b00101010010000000000000000000001;
assign add1tostar = 32'b00101010100000000000000000000001;
assign reg_f_d_out_inter = stall_fetch ? square_out ? add1tosquare : triangle_out ? add1totriangle : star_out ? add1tostar : 32'b0 : q_imem;


/*****************************Decode*****************************/
wire [4:0] dec_opcode;
assign dec_opcode = reg_f_d_out[31:27];

wire [4:0] dec_rd_parse = reg_f_d_out[26:22];
wire [4:0] dec_rs_parse = reg_f_d_out[21:17];
wire [4:0] dec_rt_parse = reg_f_d_out[16:12];

wire dec_is_alu = (dec_opcode == 5'b00000);
wire dec_is_addi = (dec_opcode == 5'b00101);

wire dec_is_sw = (dec_opcode == 5'b00111);
wire dec_is_lw = (dec_opcode == 5'b01000);

wire dec_is_jump = (dec_opcode == 5'b00001);
wire dec_is_jal = (dec_opcode == 5'b00011);
wire dec_is_jr = (dec_opcode == 5'b00100);

wire dec_is_bne = (dec_opcode == 5'b00010);
wire dec_is_blt = (dec_opcode == 5'b00110);

wire dec_is_bex = (dec_opcode == 5'b10110);
wire dec_is_setx = (dec_opcode == 5'b10101);

//ALU opcode constants
wire [4:0] add_OP, sub_OP, and_OP, or_OP, sll_OP, sra_OP;
assign add_OP = 5'b00000;
assign sub_OP = 5'b00001;
// assign and_OP = 5'b00010;
// assign or_OP  = 5'b00011;
// assign sll_OP = 5'b00001;

//Determines if data will be written to the regfile (write enable)
wire dec_write_en = (dec_is_alu || dec_is_addi || dec_is_lw || dec_is_jal) || (dec_is_setx);

//Determines if instruction is a branch     
wire dec_is_branch = dec_is_bne || dec_is_blt;


//Determines what $rs to read
//For branch instructions $rd is read from instead of $rs to compare
assign ctrl_readRegA = dec_is_bne || dec_is_blt ? dec_rd_parse : dec_rs_parse; 

//Determines what $rt to read
//For branches, [21:17] is read from instead of [16:12]
//For jr, this needs to be $rd (makes it easier later for pipelining)
//For bex and setx this needs to be $r30 for ALU operand check later on
//For sw this is $rd
//For everything else, defaults to [16:12]
wire [4:0] dec_branch_B, dec_branch_B_status, dec_jr_B;
assign ctrl_readRegB = dec_is_sw ? dec_rd_parse : dec_branch_B_status;
assign dec_branch_B_status = (dec_is_bex || dec_is_setx) ? 5'd30 : dec_jr_B;
assign dec_jr_B = dec_is_jr ? dec_rd_parse : dec_branch_B;
assign dec_branch_B = dec_is_branch ? dec_rs_parse : dec_rt_parse;

//Determines the destination register number. Defaults to $rd except for $r30 and $r31 exceptions
wire [4:0] dec_rd, dec_exp;
assign dec_exp = dec_is_setx ? 5'd30 : dec_rd_parse;
assign dec_rd = dec_is_jal ? 5'd31 : dec_exp;

//Addi sign extension
wire [31:0] add_i_imm;
wire [15:0] add_i_sign;

//Sign extension for negative addi
assign add_i_sign = reg_f_d_out[16] ? 16'b1111111111111111 : 16'b0000000000000000;
assign add_i_imm = {add_i_sign, reg_f_d_out[16:0]};

//Reads RegA and RegB data
assign d_x_A_in = data_readRegA;
assign d_x_B_in = data_readRegB;

//Pipeline Latch Stuff
wire [31:0] d_x_A_in, d_x_A_out, d_x_B_in, d_x_B_out, d_x_S_out;
wire [31:0] d_x_A_in_inter, d_x_B_in_inter, d_x_S_in_inter;

assign d_x_A_in_inter = stall_decode ? 32'b0 : data_readRegA;
assign d_x_B_in_inter = stall_decode ? 32'b0 : data_readRegB;
assign d_x_S_in_inter = stall_decode ? 32'b0 : add_i_imm;

falling_register reg_d_x_A(clock, reg_d_x_w_en, reset, d_x_A_in_inter, d_x_A_out);
falling_register reg_d_x_B(clock, reg_d_x_w_en, reset, d_x_B_in_inter, d_x_B_out);
falling_register reg_d_x_S(clock, reg_d_x_w_en, reset, d_x_S_in_inter, d_x_S_out);

wire [31:0] exe_pc, dec_pc_inter;
assign dec_pc_inter = stall_decode ? 32'b0 : fet_pc_out;

falling_register exe_reg_pc(clock, reg_d_x_w_en, reset, fet_pc_out, exe_pc);

wire [4:0] exe_rs, exe_rt, exe_rd;
wire [4:0] dec_rs, dec_rt;
assign dec_rs = ctrl_readRegA;
assign dec_rt = ctrl_readRegB;

wire [4:0] dec_rs_inter, dec_rt_inter, dec_rd_inter;

assign dec_rs_inter = stall_decode ? 5'b0 : ctrl_readRegA;
assign dec_rt_inter = stall_decode ? 5'b0 : ctrl_readRegB;
assign dec_rd_inter = stall_decode ? 5'b0 : dec_rd;

falling_register_5 reg_dec_rs(clock, reg_d_x_w_en, reset, dec_rs_inter, exe_rs);
falling_register_5 reg_dec_rt(clock, reg_d_x_w_en, reset, dec_rt_inter, exe_rt);
falling_register_5 reg_dec_rd(clock, reg_d_x_w_en, reset, dec_rd_inter, exe_rd);

wire reg_d_x_w_en;
wire [31:0] reg_d_x_out_inter;
assign reg_d_x_out_inter = stall_decode ? 32'b0 : reg_f_d_out;

falling_register reg_d_x(clock, reg_d_x_w_en, reset, reg_d_x_out_inter, reg_d_x_out);

/*****************************Execute*****************************/
//Passed WE
wire exe_write_en;
dffe_ref_fall exe_we(exe_write_en, dec_write_en, clock, 1'b1, reset);

wire placeholder;
wire [31:0] exe_pc_out;
cla_32_bit exec_pc_add(exe_pc, d_x_S_out, 1'b0, exe_pc_out, placeholder, pc_neq, pc_lt);

//Opcode
wire [4:0] exe_opcode;
assign exe_opcode = reg_d_x_out[31:27];

wire exe_is_alu = (exe_opcode == 5'b00000);
wire exe_is_addi = (exe_opcode == 5'b00101);

wire exe_is_sw = (exe_opcode == 5'b00111);
wire exe_is_lw = (exe_opcode == 5'b01000);

wire exe_is_jump = (exe_opcode == 5'b00001);
wire exe_is_jal = (exe_opcode == 5'b00011);
wire exe_is_jr = (exe_opcode == 5'b00100);

wire exe_is_bne = (exe_opcode == 5'b00010);
wire exe_is_blt = (exe_opcode == 5'b00110);

wire exe_is_bex = (exe_opcode == 5'b10110);
wire exe_is_setx = (exe_opcode == 5'b10101);


//Pad bits for JI target
wire [31:0] exe_ji_t = {5'b0, reg_d_x_out[26:0]};

//Shift amount
wire [4:0] shamt;
assign shamt = reg_d_x_out[11:7];

//ALU OP
wire [4:0] alu_op;
assign alu_op = reg_d_x_out[6:2];
//zeroes

//Selects either addi or normal alu operation
wire is00000opcode;
assign is00000opcode = exe_opcode == 0;

wire [31:0] ALU_out;
wire alu_lessThan, alu_notEqual, alu_overFlow, nan;

wire [31:0] alu_op_A, alu_op_B;
wire [1:0] sel_A, sel_B;

//If instruction uses PC = T, switch ALU output to T
wire [31:0] data_alu_out;
assign data_alu_out =  (exe_is_bex & exe_ji_t != 0) ? exe_ji_t : ALU_res;

//Mux select for bypassing
//module mux_4 (out, select, in0, in1, in2, in3);
//OUT 0 = Default from previous decode
//OUT 1 = Bypass from memory 
//OUT 2 = Bypass from previous ALU result
mux_4 mux_alu_a(alu_op_A, sel_A, d_x_A_out, data_writeReg, ALU_res, ALU_res);
mux_4 mux_alu_b(alu_op_B, sel_B, d_x_B_out, data_writeReg, data_alu_out, data_writeReg);

//module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);
wire [31:0] ALU_inter;
alu alu(alu_op_A, alu_op_B_res, alu_act_op, shamt, ALU_inter, alu_notEqual, alu_lessThan, alu_overFlow);

//module multdiv(data_operandA, data_operandB, ctrl_MULT, ctrl_DIV, clock, data_result, data_exception, data_resultRDY);

wire [31:0] multdiv_res;
wire is_mult, is_div;

assign is_mult = (alu_op == 5'b00110);
assign is_div = (alu_op == 5'b00111) && (exe_is_alu);

wire mult_op, div_op, multdiv_exp, mult_ready, div_ready;

dffe_ref_fall dff_0(div_op, (timer_out == 6'b111111), clock, 1'b1, 1'b0);

//Counter for mult_div ready
//module counter_64 (clk, rst, out);
wire timer_rst, sing_pulse, counter_en;
wire [5:0] timer_out;
counter_64_falling timer(clock, timer_rst, counter_en, timer_out);

assign counter_en = is_div;
//assign sing_pulse = (timer_out == 6'b000001);
assign timer_rst = div_ready;
assign mult_op = is_mult;
//assign div_op = (timer_out == 6'b111111);

multdiv multdiv(alu_op_A, alu_op_B_res, mult_op, div_op, clock, multdiv_res, multdiv_exp, mult_ready, div_ready);

wire [31:0] ALU_res, reg_e_2_out, exe_ji_t_out;
wire [31:0] alu_op_B_res;

//Selects between the sign extended and data from reg B for certain instructions
wire alu_is_branch = (exe_opcode == 5'b00010) || (exe_opcode == 5'b00110);
assign alu_op_B_res = (is00000opcode || alu_is_branch) ? alu_op_B : d_x_S_out;
wire [4:0] alu_act_op, alu_is_addi;

//Selects the correct opcode depending on the instruction
assign alu_is_addi = exe_is_addi ? add_OP : alu_op;
assign alu_act_op = alu_is_branch ? sub_OP : alu_is_addi;


//Exception data to write out to $rstatus
//add:1, addi:2, sub:3, mul:4, div:5
wire [2:0] r_status_sel;
assign r_status_sel = (exe_is_addi) ? 3'd3 : alu_op[2:0];

wire [31:0] exe_rstatus_out;
mux_8 exe_rstatus(exe_rstatus_out, r_status_sel, 32'd1, 32'd3, 32'd2, 32'd2, 32'd0, 32'd0, 32'd4, 32'd5);

//If exception or overflow detected, change $rd and data to be written out
wire div_exp = is_div && alu_op_B == 0;

wire [31:0] ALU_out_or_exp;
assign ALU_out = (alu_overFlow || multdiv_exp || div_exp) ? exe_rstatus_out : ALU_out_or_exp;
assign ALU_out_or_exp = (is_mult || is_div) ? multdiv_res : ALU_inter;

wire [31:0] reg_x_m_out_inter;
assign reg_x_m_out_inter = stall_execute ? 32'b0 : reg_d_x_out;

wire reg_x_m_w_en;
falling_register reg_x_m(clock, reg_x_m_w_en, reset, reg_x_m_out_inter, reg_x_m_out);

//ALU output
falling_register reg_alu(clock, reg_x_m_w_en, reset, ALU_out, ALU_res);

//Raw data from readregB ($rt data)
falling_register reg_e_2(clock, reg_x_m_w_en, reset, d_x_B_out, reg_e_2_out);

//Padded bits for ji_t 
falling_register reg_exe_ji_t(clock, reg_x_m_w_en, reset, exe_ji_t, exe_ji_t_out);

wire [31:0] mem_pc;
falling_register mem_reg_pc(clock, reg_x_m_w_en, reset, exe_pc, mem_pc);

wire [4:0] mem_rs, mem_rt, mem_rd;
wire [4:0] exe_rs_inter, exe_rt_inter, exe_rd_inter, exe_rd_exp;

assign exe_rd_exp = (alu_overFlow || multdiv_exp || div_exp) ? 5'd30 : exe_rd; 

assign exe_rs_inter = stall_execute ? 5'b0 : exe_rs;
assign exe_rt_inter = stall_execute ? 5'b0 : exe_rt;
assign exe_rd_inter = stall_execute ? 5'b0 : exe_rd_exp;

falling_register_5 reg_exe_rs(clock, reg_x_m_w_en, reset, exe_rs_inter, mem_rs);
falling_register_5 reg_exe_rt(clock, reg_x_m_w_en, reset, exe_rt_inter, mem_rt);
falling_register_5 reg_exe_rd(clock, reg_x_m_w_en, reset, exe_rd_inter, mem_rd);


// CUSTOM COMMAND exe_opcode
// OPCODE FOR PRESET COMMANDS 11101
wire stall_out, stall_counter_reset;

wire[27:0] stall_time;
assign stall_time = 27'd50; // ARBITRARY FOR NOW, WILL GET ACTUAL NUMBER LATER
assign stall_counter_reset = exe_opcode == 5'b11101;

stalling stalling(clock, stall_counter_reset, stall_time, stall_out);

/*****************************Memory*****************************/
wire [31:0] write_pc;
falling_register write_reg_pc(clock, reg_m_w_w_en, reset, mem_pc, write_pc);

wire reg_m_w_w_en;
falling_register reg_m_w(clock, reg_m_w_w_en, reset, reg_x_m_out, reg_m_w_out);

wire mem_alu_exp;
dffe_ref_fall mem_alu_ovf(mem_alu_exp, alu_overFlow, clock, reg_m_w_w_en, reset);

wire mem_write_en, mem_write_reset;
dffe_ref_fall mem_we(mem_write_en, exe_write_en, clock, reg_m_w_w_en, mem_write_reset);

//OP code select
wire [4:0] mem_opcode = reg_x_m_out[31:27];

wire mem_is_branch = (mem_opcode == 5'b00010) || (mem_opcode == 5'b00110);
wire mem_is_jump = (mem_opcode == 5'b00001);
wire mem_is_jal = (mem_opcode == 5'b00011);
wire mem_is_lw = (mem_opcode == 5'b01000);
wire mem_is_sw = (mem_opcode == 5'b00111);
wire [31:0] ram_data;

//Bypass specific to store word instructions
wire mem_bypass = (mem_rt == write_rd) & (ctrl_writeEnable) & mem_is_sw; 
assign ram_data = (mem_rt == write_rd) & (ctrl_writeEnable) ? data_writeReg : reg_e_2_out;

//Adress to store word into
assign address_dmem = ALU_res;
//Data to write into RAM
assign data = ram_data;

//Only writes memory for sw
assign wren = (mem_is_sw);

wire [31:0] reg_m_alu_inter, reg_m_read_inter, mem_ji_inter;
assign reg_m_alu_inter = stall_memory ? 32'b0 : ALU_res;
assign reg_m_read_inter = stall_memory ? 32'b0 : q_dmem;
assign mem_ji_inter = stall_memory ? 32'b0 : exe_ji_t_out;

wire [31:0] reg_m_alu_out, reg_m_read_out;
falling_register reg_m_alu(clock, temp_mem_en, reset, reg_m_alu_inter, reg_m_alu_out);
falling_register reg_m_read(clock, temp_mem_en, reset, reg_m_read_inter, reg_m_read_out);

wire temp_mem_en;

wire [31:0] mem_ji_t_out;
falling_register reg_mem_ji_t(clock, temp_mem_en, reset, mem_ji_inter, mem_ji_t_out);

wire [4:0] write_rs, write_rt, write_rd;
wire [4:0] mem_rs_inter, mem_rt_inter, mem_rd_inter;

assign mem_rs_inter = stall_memory ? 5'b0 : mem_rs;
assign mem_rt_inter = stall_memory ? 5'b0 : mem_rt;
assign mem_rd_inter = stall_memory ? 5'b0 : mem_rd;

falling_register_5 reg_mem_rs(clock, temp_mem_en, reset, mem_rs_inter, write_rs);
falling_register_5 reg_mem_rt(clock, temp_mem_en, reset, mem_rt_inter, write_rt);
falling_register_5 reg_mem_rd(clock, temp_mem_en, reset, mem_rd_inter, write_rd);

/*****************************Write*****************************/
wire wr_write_en, wr_write_reset;
dffe_ref_fall write_we(wr_write_en, mem_write_en, clock, temp_mem_en, wr_write_reset);

wire write_alu_exp;
dffe_ref_fall write_alu_ovf(write_alu_exp, mem_alu_exp, clock, temp_mem_en, reset);

//wire [4:0] write_opcode, write_rd, write_rs, write_rt, write_alu_op;
wire [4:0] write_opcode;
assign write_opcode = reg_m_w_out[31:27];

wire write_is_branch = (write_opcode == 5'b00010) || (write_opcode == 5'b00110);
wire write_is_jump = (write_opcode == 5'b00001);
wire write_is_jal = (write_opcode == 5'b00011);
wire write_is_lw = (write_opcode == 5'b01000);
wire write_is_sw = (write_opcode == 5'b00111);
wire write_is_setx = (write_opcode == 5'b10101);

//Always writes memory except for listed exceptions
//assign ctrl_writeEnable = !(write_is_sw || write_is_branch || write_is_jump);
assign ctrl_writeEnable = wr_write_en; 

//Register address to write to, is always $rd except for jal instructions or overflow
assign ctrl_writeReg = write_rd;

//All arithmetic and addi instructions uses ALU_out, lw uses dmem write_pc

//Determines final data to be written out
//Changes for jal, lw, and setx, otherwise defaults to the ALU result
wire [31:0] lw_data, data_write_jal, data_write_setx;
assign lw_data = write_is_lw ? reg_m_read_out : reg_m_alu_out;
assign data_write_jal = write_is_jal ? write_pc : lw_data;
assign data_writeReg = write_is_setx ? mem_ji_t_out : data_write_jal;

/***********************Branch, Jump, PC, Hazard stuff******************/

//Determines if there is a write hazard for any instruction that uses rs
assign sel_A[0] = ctrl_writeEnable & (write_rd == exe_rs) & (write_rd != 0);
//Determines if there is a memory hazard for any instruction that uses rs
assign sel_A[1] = !(mem_opcode == 5'b00111) & (mem_rd == exe_rs) & (mem_rd != 0);

//Determines if there is a write hazard for any instruction that uses rt
assign sel_B[0] = ctrl_writeEnable & (write_rd == exe_rt) & (write_rd != 0);
//Determines if there ia a memory hazard for any instruction that uses rt
assign sel_B[1] = !(mem_opcode == 5'b00111) & (mem_rd == exe_rt) & (mem_rd != 0);

wire stall;
assign stall = exe_is_lw & ((dec_rs == exe_rd) || ((dec_rt == exe_rd) & (!dec_is_sw)));

wire is_branch, is_jump, take_bex;

//True if branch and ALU conditions are met
assign is_branch = (exe_is_bne & alu_notEqual) || (exe_is_blt & alu_lessThan);

//True if jump or jal instruction
assign is_jump = (exe_is_jump) || (exe_is_jal);

wire stall_decode, stall_fetch, stall_execute, stall_memory;

//Flushes the instructions in the fetch and decode pipeline whenever a branch/jump is taken
// ADD THE PRESET STALL 
assign stall_fetch = stall || is_jump || is_branch || exe_is_jr || (exe_is_bex & (alu_op_B != 0)) || square_out || triangle_out || star_out;
assign stall_decode = is_jump || is_branch || exe_is_jr || (exe_is_bex & (alu_op_B != 0));
assign stall_execute = 0;
assign stall_memory = 0;

//Stalls all the intermediate pipeline registers 
assign reg_pc_w_en = !(is_div && !div_ready) && !stall_out;
assign reg_f_d_w_en = !(stall || (is_div && !div_ready)) && !stall_out;
assign reg_d_x_w_en = !(is_div && !div_ready) && !stall_out;
assign reg_x_m_w_en = !(is_div && !div_ready) && !stall_out;
assign reg_m_w_w_en = !(is_div && !div_ready) && !stall_out;
assign temp_mem_en = !(is_div && !div_ready) && !stall_out;

wire [31:0] address_branch_t, addresss_branch_jr;

//If branch, change address to new PC 
assign address_branch_t = is_branch ? exe_pc_out : address_imem_add;
//If jr, change address to specified $rt
assign addresss_branch_jr = exe_is_jr ? alu_op_B : address_branch_t;
//If jump or bex
assign address_imem_new = is_jump || (exe_is_bex & (alu_op_B != 0)) ? exe_ji_t : addresss_branch_jr;

assign wr_write_reset = 0;
assign mem_write_reset = 0;

/***********************Branch, Jump, PC stuff******************/


endmodule

module stalling(clk, start, stalltime, out);
    input clk, start;
    input[27:0] stalltime;
    output out;
     // MULTIPLY SECONDS BY 10^8 need 27 bits
    
    wire[27:0] count;
    wire starttemp, starttemp2, boof;
    dffe_ref delayed_mult(starttemp, start, clk, 1'b1, boof);
    assign starttemp2 = start == 1'b1 && starttemp == 1'b0;
    counter_27 counter_27(clk, starttemp2, stalltime, count);
    assign out = count > 27'd0 && start? 1'b1 : 1'b0;
endmodule

