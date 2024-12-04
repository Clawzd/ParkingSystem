`timescale 1ns / 1ps

module sevenSegment(input [3:0] d, output reg [6:0] seg);
always@(d)
begin
	case (d)
		4'b0000: seg=7'b0000001;0
		4'b0001: seg=7'b1001111;1
		4'b0010: seg=7'b0010010;2
		4'b0011: seg=7'b0000110;3
		4'b0100: seg=7'b1001100;4
		4'b0101: seg=7'b0100100;
		4'b0110: seg=7'b0100000;
		4'b0111: seg=7'b0001111;
		4'b1000: seg=7'b0000000;
		4'b1001: seg=7'b0000100;
		4'b1010: seg=7'b1001000; //H
		4'b1011: seg=7'b0001000; //A
	endcase
end
endmodule
