module top();
  import mod_pkg::*;
  parameter cycle=10;
  reg clock;
  mod_if DUV_IF(clock);

  test test_h;

  mod14_counter counter(.load(DUV_IF.load),
                        .mode(DUV_IF.mode),
                        .clock(clock),
                        .reset(DUV_IF.reset),
                        .count_in(DUV_IF.count_in),
                        .count_out(DUV_IF.count_out));

  initial
    begin
      clock=1'b0;
      forever #(cycle/2) clock=~clock;
    end

  initial
   begin
    if($test$plusargs("TEST1"))
    begin
      number_of_transactions=50;
      test_h=new(DUV_IF,DUV_IF,DUV_IF);
      test_h.build_and_run();
      $finish;
    end
   end
 
endmodule:top
