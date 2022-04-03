`timescale 1ns / 1ps


module vote_account(
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
      output reg [7:0]  candidate2_recieved,
      output reg [7:0]  candidate3_recieved,
       output reg [7:0]  candidate4_recieved,
      output reg [7:0]  candidate5_recieved,
       output reg [7:0]  candidate6_recieved  
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
   
 else if(candidate4 &mode==0)
   candidate4_recieved <=   candidate4_recieved+1;
   else if(candidate5 & mode==0)
   candidate5_recieved <=   candidate5_recieved+1;
   else if(candidate6 & mode==0)
   candidate6_recieved <=   candidate6_recieved+1;
   
   end
   
    
    
    
    end
endmodule
