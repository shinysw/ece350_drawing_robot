module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);
        
    input [31:0] data_operandA, data_operandB;
    input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

    output [31:0] data_result;

    output isNotEqual, isLessThan, overflow;

    wire [31:0] plh;
    wire [31:0] add_result, sub_result, or_result, and_result, sra_result, sll_result;
    wire [31:0] bitMask;
    wire [31:0] flipped;
    wire [31:0] added;

    wire [31:0] one, op_b;
    assign one = 1;
    assign plh = 0;

    assign bitMask = 32'b11111111111111111111111111111111;
    alu_xor alu_xor(data_operandB, bitMask, flipped);

    wire carry_over, carry_over_2, overflow_sub, overflow_add;
    wire nan, nan2, nan3, nan4;    

    cla_32_bit alu_add_one(flipped, one, 1'b0, added, carry_over, nan, nan2);

    cla_32_bit alu_sub(data_operandA, added, carry_over, sub_result, overflow_sub, isNotEqual, isLessThan);


    alu_or alu_or(data_operandA, data_operandB, or_result);
    alu_and alu_and(data_operandA, data_operandB, and_result);
    rshifter alu_sra(data_operandA, ctrl_shiftamt, sra_result);
    lshifter alu_sll(data_operandA, ctrl_shiftamt, sll_result);
    cla_32_bit alu_add(data_operandA, data_operandB, 1'b0, add_result, overflow_add, nan3, nan4);
    //cla_8_bit alu_add(data_operandA, data_operandB, 0, add_result);
    //assign overflow = overflow_add;
    assign overflow = ctrl_ALUopcode[0] ? overflow_sub : overflow_add;

    //add = 0, sub = 1, and = 2, or = 3, sll = 4, sra = 5
    mux_32 ALU_op_mux(data_result, ctrl_ALUopcode, add_result, sub_result, and_result, or_result, sll_result, sra_result, plh, plh, plh, plh, plh, plh, plh, plh, plh, plh, plh, plh, plh, plh, plh, plh, plh, plh, plh, plh, plh, plh, plh, plh, plh, plh);

    
endmodule