module stepper_controller (
    input wire clk,               
    input wire [31:0] numOfSteps, 
    input wire [31:0] cyclesBetweenSteps, 
    output reg stepOutput        
);

// Parameters
localparam STEP_DISTANCE = 10; 
localparam PULSE_WIDTH = 1000;  
localparam STEPPER_CYCLES = 1000; 

reg [31:0] clockCounter;
reg [31:0] stepCounter;
reg [31:0] pulseCounter;
reg [31:0] speedCounter;
wire [31:0] stepsPerSecond;
wire [31:0] clockCyclesPerStep;
assign clockCyclesPerStep = 1000;

reg done;

initial done = 0;
initial clockCounter = 0;

initial stepCounter = clockCyclesPerStep + 1;
initial stepOutput = 0;


always @(posedge clk) begin

    if (clockCounter % cyclesBetweenSteps == 0) begin
        stepCounter <= 28'd0;
        //clock_out <= (counter< DIVISOR / 2) ? 1'b1 : 1'b0;
    end
    if (stepCounter < clockCyclesPerStep) begin
        stepCounter <= stepCounter + 28'd1;
        stepOutput <= 1;
    end
    else begin
        stepOutput <= 0;
    end
    clockCounter = clockCounter + 28'd1;

end

endmodule
