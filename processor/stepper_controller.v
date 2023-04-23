module stepper_controller (
    input wire en,
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
initial stepCounter = 0;

initial pulseCounter = clockCyclesPerStep + 1;
initial stepOutput = 0;


always @(posedge en) begin
     done = 0;
     clockCounter = 0;
     stepCounter = 0;
     pulseCounter = clockCyclesPerStep + 1;
     stepOutput = 0;
end

always @(posedge clk) begin
    if (en) begin
        if (clockCounter % cyclesBetweenSteps == 0) begin
            pulseCounter <= 28'd0;
            //clock_out <= (counter< DIVISOR / 2) ? 1'b1 : 1'b0;
        end
        if (pulseCounter < clockCyclesPerStep && stepCounter <= numOfSteps) begin
            pulseCounter <= pulseCounter + 28'd1;
            stepOutput <= 1;
        end
        else if (pulseCounter == clockCyclesPerStep) begin
            stepCounter <= stepCounter + 28'd1;
            pulseCounter <= pulseCounter + 28'd1;
            stepOutput <= 0;
        end
        else begin 
            stepOutput <= 0;
        end
        clockCounter = clockCounter + 28'd1;
    end
end

endmodule