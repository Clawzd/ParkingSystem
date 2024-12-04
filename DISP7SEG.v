`timescale 1ns / 1ps

module decoder3to8N (input [3:0] d, output reg [7:0] seg);
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
		4'b1000: seg=8'b01111111;
		4'b1001: seg=8'b01111111;
		4'b1010: seg=8'b01111111;
		4'b1011: seg=8'b01111111;
	endcase
end
endmodule
