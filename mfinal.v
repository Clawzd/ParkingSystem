// Main module to manage parking spaces and display their status
module Main (input clk, input reset, input normalEntry, input normalExit, input handicapEntry, input handicapExit, 
    output [7:0] seg, an, output normalGreen, normalRed, output handicapGreen, handicapRed);

    wire [4:0] normalSpaces; // Counter for normal parking spaces
    wire [2:0] handicapSpaces; // Counter for handicap parking spaces

    // Instantiate HandicappedParking and NormalParking modules
    HandicappedParking hp(clk, reset, handicapEntry, handicapExit, handicapSpaces, handicapGreen, handicapRed);
    NormalParking np(clk, reset, normalEntry, normalExit, normalSpaces, normalGreen, normalRed);

    // Prepare data for the 7-segment display
    wire [3:0] d0 = normalSpaces % 10; // Display unit digit of normal spaces
    wire [3:0] d1 = normalSpaces / 10; // Display tens digit of normal spaces
    wire [3:0] d2 = 4'd12; // Blank space
    wire [3:0] d3 = 4'd10; // Display letter 'A'
    wire [3:0] d4 = handicapSpaces; // Display handicap spaces
    wire [3:0] d5 = 4'd12; // Blank space
    wire [3:0] d6 = 4'd10; // Display letter 'H'
    wire [3:0] d7 = 4'd11; // Display letter 'A'

    // Drive the 7-segment display
    DISP7SEG display(clk, d0, d1, d2, d3, d4, d5, d6, d7, text_mode, mid, error, slow, fast, seg, an);
endmodule

// Module to manage logic for normal parking
module NormalParking(input clk, reset, normalEntry, normalExit, output reg [4:0] normalSpaces, output normalGreen, normalRed);
    wire entry, exit;
    wire detectedEntry, detectedExit;

    debounce debounceEntry(clk, normalEntry, entry);
    debounce debounceExit(clk, normalExit, exit);

    Detection dc(clk, reset, entry, exit, detectedEntry, detectedExit);

    always @(posedge clk or posedge reset) begin
        if (reset)
            normalSpaces <= 5'b10100; // Reset spaces to 20
        else if (detectedEntry && normalSpaces > 0)
            normalSpaces <= normalSpaces - 1; // Decrement spaces on entry
        else if (detectedExit && normalSpaces < 5'b10100)
            normalSpaces <= normalSpaces + 1; // Increment spaces on exit
    end

    assign normalGreen = (normalSpaces > 0); // Green LED when spaces are available
    assign normalRed = (normalSpaces == 0); // Red LED when spaces are full
endmodule

// Module to manage logic for handicap parking
module HandicappedParking(input clk, reset, handicapEntry, handicapExit, output reg [2:0] handicapSpaces, output handicapGreen, handicapRed);
    wire entry, exit;
    wire detectedEntry, detectedExit;

    debounce debounceEntry(clk, handicapEntry, entry);
    debounce debounceExit(clk, handicapExit, exit);

    Detection dc(clk, reset, entry, exit, detectedEntry, detectedExit);

    always @(posedge clk or posedge reset) begin
        if (reset)
            handicapSpaces <= 3'b101; // Reset spaces to 5
        else if (detectedEntry && handicapSpaces > 0)
            handicapSpaces <= handicapSpaces - 1; // Decrement spaces on entry
        else if (detectedExit && handicapSpaces < 3'b101)
            handicapSpaces <= handicapSpaces + 1; // Increment spaces on exit
    end

    assign handicapGreen = (handicapSpaces > 0); // Green LED when spaces are available
    assign handicapRed = (handicapSpaces == 0); // Red LED when spaces are full
endmodule

`timescale 1ns / 1ps
module debounce(clock, noisyclk, cleanclk);
    parameter delay = 500000;
    input clock, noisyclk;
    output cleanclk;

    reg [19:0] count;
    reg new, cleanclk;

    always @(posedge clock)
        if (noisyclk != new) begin
            new <= noisyclk;
            count <= 0;
        end else if (count == delay)
            cleanclk <= new;
        else
            count <= count + 1;
endmodule

module Detection(input clk, reset, input entry, exit, output entry_d, exit_d);
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
