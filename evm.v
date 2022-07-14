`timescale 1ns / 1ps
module buttoncontrol(
input clock,
input reset,
input button,
output reg valid_vote
);
reg [30:0] counter;
always @(posedge clock)
begin 
if(reset)
counter<=0;
else
begin 
   if(button & counter < 11)
    counter<=counter+1;
else if(!button)
counter<=0;
   end
end
always@(posedge clock)
begin
if(reset)
valid_vote<=1'b0;
else
  begin
       if(counter==10)
       valid_vote=1'b1;
       else 
       valid_vote=1'b0;
   end
end
        
endmodule
module vote_logging(
   input clock,
    input reset,
    input mode,
    input candidate1,
      input candidate2,
      input candidate3,
      input candidate4,
      input candidate5,
      input candidate6,
       output reg [7:0]  candidate1_recieved,
     output    reg [7:0]  candidate2_recieved,
      output  reg [7:0]  candidate3_recieved,
      output    reg [7:0]  candidate4_recieved,
       output    reg [7:0]  candidate5_recieved,
       output   reg [7:0]  candidate6_recieved 
);
   always @(posedge clock)
    begin
    if(reset)
    begin
    candidate1_recieved<=0;
    candidate2_recieved<=0;
    candidate3_recieved<=0;
    candidate4_recieved<=0;
    candidate5_recieved<=0;
    candidate6_recieved<=0;
   end
   else
   begin
   if(candidate1 & mode==0)
   candidate1_recieved <=   candidate1_recieved+1;
  else  if(candidate2 & mode==0)
   candidate2_recieved <=   candidate2_recieved+1;
   else  if(candidate3 & mode==0)
   candidate3_recieved <=   candidate3_recieved+1;
 else if(candidate4 & mode==0)
   candidate4_recieved <=   candidate4_recieved+1;
   else if(candidate5 & mode==0)
   candidate5_recieved <=   candidate5_recieved+1;
   else if(candidate6 & mode==0)
   candidate6_recieved <=   candidate6_recieved+1;
   end
    end
endmodule
module mode_control(
   input clock,
    input reset,
    input mode,
    input valid_vote_casted,
    input [7:0] candidate1_votes,
      input [7:0] candidate2_votes,
        input [7:0] candidate3_votes,
          input [7:0] candidate4_votes,
            input [7:0] candidate5_votes,
                input [7:0] candidate6_votes,
       input candidate1_button_press,
       input candidate2_button_press,
       input candidate3_button_press,
       input candidate4_button_press,
       input candidate5_button_press,
       input candidate6_button_press,
       output reg [7:0]result
);
reg [30:0] counter; 
always @(posedge clock)
begin
if(reset)
counter<=0;
else if (valid_vote_casted)
counter<=counter+1;
else if(counter!=0 &counter<10)
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
if(mode==0 & counter > 0)
result<=8'hFF;
else if(mode==0)
result<=8'h00;
else if(mode==1)
begin 
if(candidate1_button_press)
result<=candidate1_votes;
 else if(candidate2_button_press)
result<=candidate2_votes;
 else if(candidate3_button_press)
result<=candidate3_votes;
 else if(candidate4_button_press)
result<=candidate4_votes;
else if(candidate5_button_press)
result<=candidate5_votes;
else if(candidate6_button_press)
result<=candidate6_votes;
end
end
end
endmodule

module evm(
  input clock,
    input reset,
    input mode,
       input candidate1_button,
       input candidate2_button,
       input candidate3_button,
       input candidate4_button,
       input candidate5_button,
       input candidate6_button,
       output [7:0]result
       
);
wire anyValid_vote;
wire valid_vote1;
wire valid_vote2;
wire valid_vote3;
wire valid_vote4;
wire valid_vote5;
wire valid_vote6;
 wire [7:0] candidate1_vote_recieved;
wire [7:0] candidate2_vote_recieved;
wire  [7:0] candidate3_vote_recieved;
wire  [7:0] candidate4_vote_recieved;
wire  [7:0] candidate5_vote_recieved;
wire  [7:0] candidate6_vote_recieved;
 assign anyValid_vote=valid_vote1|valid_vote2|valid_vote3|valid_vote4|valid_vote5|valid_vote6;
buttoncontrol bc1(
.clock(clock),
.reset(reset),
.button(candidate1_button),
.valid_vote(valid_vote1));
buttoncontrol bc2(
.clock(clock),
.reset(reset),
.button(candidate2_button),
.valid_vote(valid_vote2));
buttoncontrol bc3(
.clock(clock),
.reset(reset),
.button(candidate3_button),
.valid_vote(valid_vote3));
buttoncontrol bc4(
.clock(clock),
.reset(reset),
.button(candidate4_button),
.valid_vote(valid_vote4));
buttoncontrol bc5(
.clock(clock),
.reset(reset),
.button(candidate5_button),
.valid_vote(valid_vote5));
buttoncontrol bc6(
.clock(clock),
.reset(reset),
.button(candidate6_button),
.valid_vote(valid_vote6));

vote_logging vl(
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
 .candidate6_recieved(candidate6_vote_recieved));
     


mode_control Mc(
 .clock(clock),
    .reset(reset),
     .mode(mode),
   .valid_vote_casted(anyValid_vote),
   .candidate1_votes(candidate1_vote_recieved),
   .candidate2_votes(candidate2_vote_recieved),
   .candidate3_votes(candidate3_vote_recieved),
   .candidate4_votes(candidate4_vote_recieved),
   .candidate5_votes(candidate5_vote_recieved),
   .candidate6_votes(candidate6_vote_recieved),
      .candidate1_button_press(valid_vote1),
      .candidate2_button_press(valid_vote2),
      .candidate3_button_press(valid_vote3),
      .candidate4_button_press(valid_vote4),
      .candidate5_button_press(valid_vote5),
      .candidate6_button_press(valid_vote6),
      .result(result)
                        
);

endmodule
