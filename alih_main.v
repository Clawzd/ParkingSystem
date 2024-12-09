
module SmartParkingSystem (input clk, input reset, input n_entry, input n_exit, input h_entry, input h_exit, output [6:0] seg_n, output [6:0] seg_h, output N_green, output N_red, output H_green, output H_red);
  wire [4:0] N_count;
  wire [2:0] H_count;
    wire N_full, H_full;
  
  HandicappedParking hp(clk, reset, h_entry, h_exit, H_count, H_full, H_green, H_red);
  
  NormalParking np(clk, reset, n_entry, n_exit, N_count, N_full, N_green, N_red);
  
  DISP7SEG sev();
