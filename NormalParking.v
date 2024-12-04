module NormalParking(input clk, reset, entry0, exit0,output reg [4:0] normal_spaces,output normal_green, normal_red);
    wire entry , exit;

  Debounce dentry(clk, entry0, entry);
  Debounce dexit(clk, exit0, exit);

    always @(posedge clk) 
    begin
        if (reset)
            normal_spaces <= 5'b10100;
        end
        else if (entry && normal_spaces > 0)
            normal_spaces <= normal_spaces - 1;
        end
        else if (exit && normal_spaces < 5'b10100)
            normal_spaces <= normal_spaces + 1;
        end
    end

    assign normal_green = (normal_spaces >0);
    assign normal_red = (normal_spaces == 0);
endmodule

