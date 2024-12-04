`timescale 1ns / 1ps

module sevenSegment(input [3:0] d, output reg [7:0] seg);
always@(d)
begin
	case (d)
		4'b0000: seg=8'b11111110;
		4'b0001: seg=8'b11111101;
		4'b0010: seg=8'b11111011;
		4'b0011: seg=8'b11110111;
		4'b0100: seg=8'b11101111;
		4'b0101: seg=8'b11011111;
		4'b0110: seg=8'b10111111;
		4'b0111: seg=8'b01111111;
		4'b1000: seg=8'b11111111;
		4'b1001: seg=8'b01111111;
		4'b1010: seg=8'b1110111;
		4'b1011: seg=8'b01111111;
	endcase
end
endmodule
			7'b0000001;
            1 : seg = 7'b1001111;
            2 : seg = 7'b0010010;
            3 : seg = 7'b0000110;
            4 : seg = 7'b1001100;
            5 : seg = 7'b0100100;
            6 : seg = 7'b0100000;
            7 : seg = 7'b0001111;
            8 : seg = 7'b0000000;
            9 : seg = 7'b0000100;
