
module servo(clock_in, out, duty);
    
input clock_in; // input clock on FPGA
input [31:0] duty;
output reg out; // output clock after dividing the input clock by divisor
reg[31:0] counter= 28'd0;
parameter DIVISOR = 28'd3;

initial counter = 0;
initial out = 0;
// The frequency of the output clk_out
//  = The frequency of the input clk_in divided by DIVISOR
// For example: Fclk_in = 50Mhz, if you want to get 1Hz signal to blink LEDs
// You will modify the DIVISOR parameter value to 28'd50.000.000
// Then the frequency of the output clk_out = 50Mhz/50.000.000 = 1Hz
always @(posedge clock_in) begin
    if(counter > 32'd2000000) begin
        counter = 32'd0;
        //clock_out <= (counter< DIVISOR / 2) ? 1'b1 : 1'b0;
    end
    if (counter > duty) begin
        out <= 0;
    end
    else begin
        out <= 1;

    end
        counter <= counter + 28'd1;

end 
endmodule