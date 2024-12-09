`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:03:03 12/09/2024 
// Design Name: 
// Module Name:    Main 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Main (input clk, input reset, input n_entry, input n_exit, input h_entry, input h_exit, 
output [7:0] seg, an, output N_green, output N_red, output H_green, output H_red);
 
 
  wire [4:0] N_count;
  wire [2:0] H_count;
	 
  
  HandicappedParking hp(clk, reset, h_entry, h_exit, H_count, H_green, H_red);
  
  NormalParking np(clk, reset, n_entry, n_exit, N_count,N_green, N_red);
  
  wire[3:0] d0 = N_count % 10;
  wire[3:0] d1 = N_count / 10;
  wire[3:0] d2 = 4'd12;
  wire[3:0] d3 = 4'd10; //A
  wire[3:0] d4 = H_count ;
  wire[3:0] d5 =4'd12;
  wire[3:0] d6 = 4'd10 ;
  wire[3:0] d7 = 4'd11 ;
  
  
  DISP7SEG ten(clk, d0, d1, d2, d3, d4, d5, d6, d7, text_mode, mid, error, slow, fast, seg, an);  
  //DISP7SEG A(1011,seg_na);  //A
  
  //DISP7SEG hand(H_count,seg_h);
 // DISP7SEG HA(1011,seg_ha);  //A
 // DISP7SEG H(1010,seg_hh); //H

endmodule


module NormalParking(input clk, reset, entry0, exit0,output reg [4:0] normal_spaces,output normal_green, normal_red);
    wire entry , exit;
	 wire dentry , dexit;

  debounce dentry1(clk, entry0, entry);
  debounce dexit1(clk, exit0, exit);
  
  Detection dc(clk, reset, entry, exit ,dentry, dexit);
  
  
  

    always @(posedge clk or posedge reset) 
        if (reset)
            normal_spaces <= 5'b10100;
        else if (dentry && normal_spaces > 0)
            normal_spaces <= normal_spaces - 1;
        else if (dexit && normal_spaces < 5'b10100)
            normal_spaces <= normal_spaces + 1;

    assign normal_green = (normal_spaces >0);
    assign normal_red = (normal_spaces == 0);
endmodule








module HandicappedParking(input clk, reset, entry0, exit0,output reg [2:0] hand_spaces,output hand_green, hand_red);
    wire entry , exit;
	 wire dentry , dexit;

  debounce dentry1(clk, entry0, entry);
  debounce dexit1(clk, exit0, exit);
  
  Detection dc(clk, reset, entry, exit ,dentry, dexit);
  
  
    always @(posedge clk or posedge reset) 
        if (reset)
            hand_spaces <= 3'b101;
        else if (dentry && hand_spaces > 0)
            hand_spaces <= hand_spaces - 1;
        else if (dexit && hand_spaces < 3'b101)
            hand_spaces <= hand_spaces + 1;

    assign hand_green = (hand_spaces >0);
    assign hand_red = (hand_spaces == 0);
endmodule







//module HandicappedParking (input clk, input reset, input entry0, input exit0, output reg [2:0] handicap_spaces, output H_green, H_red);
//	wire entry , exit;
//	wire dentry , dexit;
//  debounce dentry2(clk, entry0, entry);
//  debounce dexit2(clk, exit0, exit);
//  
  //Detection dc(clk, reset, entry, exit ,dentry, dexit);
 //

   //always @(posedge clk) 
     //   if (reset)
       //     handicap_spaces <= 3'b101;
    //
      //  else if (entry && handicap_spaces > 0)
        //    handicap_spaces <= handicap_spaces - 1;
    //
      //  else if (exit && handicap_spaces < 3'b101)
        //    handicap_spaces <= handicap_spaces + 1;
  //
    //assign H_green = (handicap_spaces >0);
    //assign H_red = (handicap_spaces == 0);
  
//endmodule




//`timescale 1ns / 1ps
//module sevenSegment(input [3:0] dig, output reg [6:0] seg);
//	always@(*)
	//	begin
			//case (dig)
			//	4'b0000: seg=7'b0000001;
			//	4'b0001: seg=7'b1001111;
			//	4'b0010: seg=7'b0010010;
			//	4'b0011: seg=7'b0000110;
			//	4'b0100: seg=7'b1001100;
			//	4'b0101: seg=7'b0100100;
			//	4'b0110: seg=7'b0100000;
			//	4'b0111: seg=7'b0001111;
			//	4'b1000: seg=7'b0000000;
			//	4'b1001: seg=7'b0000100;
			//	4'b1010: seg=7'b1001000; //H
			//	4'b1011: seg=7'b0001000; //A
		//	endcase
		//end
//endmodule



`timescale 1ns / 1ps
module debounce(clock,noisyclk,cleanclk);
        parameter delay=500000;
  input clock,noisyclk;
  output cleanclk;

  reg  [19:0] count;
  reg new,cleanclk;

  always @(posedge clock)
          if (noisyclk!= new)
        begin
        new <= noisyclk;
        count <=0;
        end

        else if (count==delay)
        cleanclk <=        new;
        else
        count<= count+1;
endmodule




module Detection(
    input clk,            
    input reset,          
    input entry,      
    input exit,       
    output entry_d,   
    output exit_d);
    reg entry_prev, exit_prev;

   
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            entry_prev <= 0;
            exit_prev <= 0;
        end else begin
            entry_prev <= entry;
            exit_prev <= exit;
        end
    end

    assign entry_d = entry && !entry_prev; 
    assign exit_d = exit && !exit_prev; 
endmodule










