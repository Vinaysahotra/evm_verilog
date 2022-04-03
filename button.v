`timescale 1ns / 1ps


module button(
    input clock,
    input button,
    output reg valid_vote,
    input reset
    );
    reg [40:0] counter;
    always @(posedge clock)
    begin 
    if(reset)
    counter<=0;
    else
    begin 
    if(button & counter<10000001)
        counter<=counter + 1;
    else if(!button)
    counter<=0;
    end
    
    end
    
    always @(posedge clock)
    begin
    if(reset)
    valid_vote<=1'b0;
    else
    begin 
    if(counter==10000000)
    valid_vote<=1'b1;
    else
    valid_vote<=1'b0;
    end
    end
    
    
    
endmodule
