module move_one_step(clock_in, out, move1, move2);
    
input clock_in; // input clock on FPGA
output reg out; // output clock after dividing the input clock by divisor
reg[27:0] counter= 28'd0;
parameter DIVISOR = 28'd3;

initial counter = 0;
initial out = 0;
// The frequency of the output clk_out
//  = The frequency of the input clk_in divided by DIVISOR
// For example: Fclk_in = 50Mhz, if you want to get 1Hz signal to blink LEDs
// You will modify the DIVISOR parameter value to 28'd50.000.000
// Then the frequency of the output clk_out = 50Mhz/50.000.000 = 1Hz
always @(posedge clock_in) begin
    if(counter > 28'd1000000) begin
        counter <= 28'd0;
        //clock_out <= (counter< DIVISOR / 2) ? 1'b1 : 1'b0;
    end
    else if (counter > 28'd1000) begin
        counter <= counter + 28'd1;
        out <= 0;
    end
    else begin
        counter <= counter + 28'd1;
        out <= 1;

    end
end


endmodule