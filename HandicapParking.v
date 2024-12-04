module HandicapParking(input clk, reset, entry0, exit0,output reg [2:0] handicap_spaces,output handicap_green, handicap_red);
    wire entry , exit;

  Debounce dentry(clk, entry0, entry);
  Debounce dexit(clk, exit0, exit);

    always @(posedge clk) 
    begin
        if (reset)
            handicap_spaces <= 3'b101;
        end
  else if (entry && handicap_spaces > 0)
            handicap_spaces <= handicap_spaces - 1;
        end
        else if (exit && handicap_spaces < 5'b101)
            handicap_spaces <= handicap_spaces + 1;
        end
    end

    assign handicap_green = (handicap_spaces >0);
    assign handicap_red = (handicap_spaces == 0);
endmodule
