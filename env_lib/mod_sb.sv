class mod_sb;
   event DONE;
   int rm_data_count;
   int rcvd_data_count;
   int data_verified;

   mod_trans rm_data;
   mod_trans rcvd_data;
   mod_trans cov_data;
   
   mailbox #(mod_trans) rm2sb; 
   mailbox #(mod_trans) mon2sb;
 
   covergroup mem_coverage;
       C1:coverpoint cov_data.load{bins LOAD={0,1};}
       C2:coverpoint cov_data.mode{bins UP_DOWN={0,1};}
       C3:coverpoint cov_data.reset{bins RESET={0,1};}
       C4:coverpoint cov_data.count_in{bins COUNT={0,1,2,3,4,5,6,7,8,9,10,11,12,13};}
       C1xC2xC4: cross C1,C2,C4;
endgroup:mem_coverage

   function new(mailbox #(mod_trans) rm2sb,mailbox #(mod_trans) mon2sb);
      this.rm2sb=rm2sb;
      this.mon2sb=mon2sb;
      this.mem_coverage=new();
   endfunction:new
  
   task start();
       fork
        forever
         begin
           rm2sb.get(rm_data);
           rm_data_count++;
           mon2sb.get(rcvd_data);
           rcvd_data_count++;
           check(rcvd_data);
         end
       join_none
   endtask:start

   virtual task check(mod_trans rc_data);
	if(rm_data.count_out==rc_data.count_out)
            begin
		$display("Matched");
            end
	else begin
		$display("MISMATCHED");
                
            end
        cov_data=new rm_data;
        mem_coverage.sample();
	data_verified++;
	if(data_verified==number_of_transactions) begin
		->DONE;
          end
   endtask:check
  
   function void report();
         $display("-------------SCOREBOARD REPORT-------------");
         $display("%0d Read Data Generated,%0d Received data received,%0d Read Data verified\n",rm_data_count,rcvd_data_count,data_verified);
         $display("-------------------------------------------");
   endfunction:report
endclass:mod_sb
              
