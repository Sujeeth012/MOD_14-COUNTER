class mod_write_mon;

virtual mod_if.WR_MON_MP wr_mon_if;
mod_trans data2rm;
mod_trans cov_data;


mailbox #(mod_trans) mon2rm;

function new(virtual mod_if.WR_MON_MP wr_mon_if,mailbox #(mod_trans) mon2rm);
   this.wr_mon_if=wr_mon_if;
   this.mon2rm=mon2rm;
   this.data2rm=new();
endfunction:new

task monitor();
  @(wr_mon_if.wr_mon_cb);
  //wait(wr_mon_if.wr_mon_cb.load==1)
 // @(wr_mon_if.wr_mon_cb);
  begin
  data2rm.load=wr_mon_if.wr_mon_cb.load;
  data2rm.mode=wr_mon_if.wr_mon_cb.mode;
  data2rm.count_in=wr_mon_if.wr_mon_cb.count_in;
  data2rm.display("DATA FROM WRITE MONITOR");
  
  end
endtask:monitor

task start();
  fork
    forever
       begin
          monitor();
          mon2rm.put(data2rm);
       end
  join_none
endtask:start

endclass:mod_write_mon
