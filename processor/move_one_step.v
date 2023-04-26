module move_one_step(clock_in, speed, out);
    
input clock_in; // input clock on FPGA
input[31:0] speed; 

output reg out; // output clock after dividing the input clock by divisor
reg[27:0] counter = 28'd0;

reg [50:0] clock_cycles;

//assign clock_cycles = (10 / (speed) * 100000000); 

reg off_flag;


parameter DIVISOR = 28'd3;

initial counter = 0;
initial out = 0;

initial clock_cycles = 50'b0;

initial off_flag = 1;

// The frequency of the output clk_out
//d480000
//  = The frequency of the input clk_in divided by DIVISOR
// For example: Fclk_in = 50Mhz, if you want to get 1Hz signal to blink LEDs
// You will modify the DIVISOR parameter value to 28'd50.000.000
// Then the frequency of the output clk_out = 50Mhz/50.000.000 = 1Hz

always @(posedge clock_in) begin
    //clock_cycles <= (50'd10 / (speed) * 50'd100000000); 
    //clock_cycles <= speed * 2;
    //clock_cycles <= (50'd10 * 50'd10000000) / (speed) ; 

    if (speed == 0) begin
        off_flag <= 1;
        out <= 0;
    end
    else begin
        off_flag <= 0;
        clock_cycles <= (50'd10 * 50'd10000000) / (speed) ; 
        //clock_cycles <= (50'd10 * 50'd100000) / (speed) ; 

    end
    
    if (!off_flag) begin
        //if (counter > 32'd50000) begin
        if(counter > clock_cycles) begin
            counter <= 28'd0;
            //clock_out <= (counter< DIVISOR / 2) ? 1'b1 : 1'b0;
        end
        //else if (counter > 28'd1000) begin
        else if (counter > 28'd10) begin
            counter <= counter + 28'd1;
            out <= 0;
        end
        else begin
            counter <= counter + 28'd1;
            out <= 1;
        end
    end
end


endmodule