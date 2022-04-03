`timescale 1ns / 1ps

module modechosen(
    input clock,
    input reset,
    input mode,
    input valid_vote_casted,
        input [7:0] candidate1_vote,
        input [7:0] candidate2_vote,
        input [7:0] candidate3_vote,
    input [7:0] candidate4_vote,
    input [7:0] candidate5_vote,
    input [7:0] candidate6_vote,
    input candidate1_button_pressed,
    input candidate2_button_pressed,
    input candidate3_button_pressed,
    input candidate4_button_pressed,
    input candidate5_button_pressed,
    input candidate6_button_pressed,
    
    output reg [7:0] result
    );
    reg [30:0] counter;
    always @(posedge clock)
    begin
    if(reset)
    counter<=0;
    else if( valid_vote_casted)
    counter<=counter+1;
        else if(counter!=0&counter<100000000)
        counter<=counter+1;
        else 
        counter<=0;
    end
    always @(posedge clock)
    begin
    if(reset)
        result<=0;
        else
        begin
        if(mode==0& counter>0)
        result<=0'hFF;
        else if(mode==0)
        result<=0'h00;
        else if(mode==1)
        begin
        if(candidate1_button_pressed)
        result<=candidate1_vote;
           else if(candidate2_button_pressed)
        result<=candidate2_vote;
        else    if(candidate3_button_pressed)
        result<=candidate3_vote;
          else  if(candidate4_button_pressed)
        result<=candidate4_vote;
       else if(candidate5_button_pressed)
        result<=candidate5_vote;
      else  if(candidate6_button_pressed)
        result<=candidate6_vote;
        end
        
    end
    end
endmodule
