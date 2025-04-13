class ref_model;
   mod_trans mon_data1;
   
   mailbox #(mod_trans) mon2rm;
   mailbox #(mod_trans) rm2sb;

   static logic [3:0]ref_count;  

  function new(mailbox #(mod_trans) mon2rm,
               mailbox #(mod_trans) rm2sb);
      this.mon2rm=mon2rm;
      this.rm2sb=rm2sb;
  endfunction:new

  virtual task fun_write(mod_trans mon_data1);
     begin
     	 if(mon_data1.load) begin
	      	mon_data1.count_out<=mon_data1.count_in;
    	end
	    else if(mon_data1.mode) begin
	        if(mon_data1.count_out==4'b1101)
	           mon_data1.count_out<=4'b0000;
          else
	           mon_data1.count_out<=mon_data1.count_out+1;
      end
      else begin
          if(mon_data1.count_out<=4'b0000)
             mon_data1.count_out<=4'b1101;
          else
	           mon_data1.count_out<=mon_data1.count_out-1;
      end     
    end   
  endtask:fun_write


  virtual task start();
      fork
       begin
         forever
           begin
             mon2rm.get(mon_data1);
             fun_write(mon_data1);
             mon_data1.count_out=ref_count;
             rm2sb.put(mon_data1);
            end
       end
      join_none
  endtask:start
endclass:ref_model
