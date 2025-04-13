module mod14_counter(input load,mode,clock,reset,
                     input [3:0]count_in,
	             output reg [3:0]count_out);
always@(posedge clock)
begin
	if(reset) begin
		count_out<=4'b0000;
	end
	else if(load) begin
		count_out<=count_in;
	end
	else if(mode) begin
	  if(count_out==4'b1101)
	      count_out<=4'b0000;
          else
	      count_out<=count_out+1;
          end
        else begin
          if(count_out<=4'b0000)
             count_out<=4'b1101;
          else
	     count_out<=count_out-1;
        end     
        
end
endmodule:mod14_counter
