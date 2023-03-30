module tristate(d, en, out);

input [31:0] d;
input en;
output [31:0] out;

assign out = en ? d : 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;

endmodule