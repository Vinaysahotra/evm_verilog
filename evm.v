`timescale 1ns / 1ps

module evm(
input clock,
input reset,
input mode,
input button1,
input button2,
input button3,
input button4,
input button5,
input button6,
output [7:0] result

    );
    wire valid_vote1;
     wire valid_vote2;
      wire valid_vote3;
       wire valid_vote4;
        wire valid_vote5;
         wire valid_vote6;
         wire [7:0]candidate1_vote_recieved;
          wire [7:0]candidate2_vote_recieved;
          wire [7:0]candidate3_vote_recieved;
          wire [7:0]candidate4_vote_recieved;
          wire [7:0]candidate5_vote_recieved;
          wire [7:0]candidate6_vote_recieved;
          wire valid_vote_anyone;
         assign valid_vote_anyone=valid_vote1|valid_vote2|valid_vote3|valid_vote4|valid_vote5|valid_vote6;
    button button1_pr(
.clock(clock),
   .button(button1),
    .valid_vote(valid_vote1),
  .reset(reset)
    );
      button button2_pr(
.clock(clock),
   .button(button2),
    .valid_vote(valid_vote1),
  .reset(reset)
    );
      button button3_pr(
.clock(clock),
   .button(button3),
    .valid_vote(valid_vote1),
  .reset(reset)
    );
      button button4_pr(
.clock(clock),
   .button(button4),
    .valid_vote(valid_vote1),
  .reset(reset)
    );
      button button5_pr(
.clock(clock),
   .button(button5),
    .valid_vote(valid_vote1),
  .reset(reset)
    );
      button button6_pr(
.clock(clock),
   .button(button6),
    .valid_vote(valid_vote1),
  .reset(reset)
    );
    
    vote_account ac(
    .clock(clock),
    .reset(reset),
    .mode(mode),
    .candidate1(valid_vote1),
      .candidate2(valid_vote2),
     .candidate3(valid_vote3),
      .candidate4(valid_vote4),
     .candidate5(valid_vote5),
      .candidate6(valid_vote6),
     .candidate1_recieved(candidate1_vote_recieved),
      .candidate2_recieved(candidate2_vote_recieved),
     .candidate3_recieved(candidate3_vote_recieved),
      .candidate4_recieved(candidate4_vote_recieved),
      .candidate5_recieved(candidate5_vote_recieved),
      .candidate6_recieved(candidate6_vote_recieved)  
    );
    
     modechosen mc(
   .clock(clock),
    .reset(reset),
    .mode(mode),
    .valid_vote_casted(valid_vote_anyone),
        .candidate1_vote(candidate1_vote_recieved),
        .candidate2_vote(candidate2_vote_recieved),
       .candidate3_vote(candidate3_vote_recieved),
    .candidate4_vote(candidate4_vote_recieved),
    .candidate5_vote(candidate5_vote_recieved),
    .candidate6_vote(candidate6_vote_recieved),
    .candidate1_button_pressed(valid_vote1),
    . candidate2_button_pressed(valid_vote2),
    . candidate3_button_pressed(valid_vote3),
    . candidate4_button_pressed(valid_vote4),
    .candidate5_button_pressed(valid_vote5),
  . candidate6_button_pressed(valid_vote6),
    .result(result)
    );
endmodule
