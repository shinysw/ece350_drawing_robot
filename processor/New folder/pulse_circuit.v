module pulse_circuit(input clk, input input_signal, output reg output_signal);

reg pulse_trigger;

always @(posedge clk) begin
  if (input_signal == 1'b1) begin
    pulse_trigger <= 1'b1;
  end
end

always @(posedge clk) begin
  if (pulse_trigger == 1'b1) begin
    output_signal <= 1'b1;
    pulse_trigger <= 1'b0;
  end else begin
    output_signal <= 1'b0;
  end
end

endmodule
