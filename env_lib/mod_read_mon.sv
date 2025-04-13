class mod_read_mon;

virtual mod_if.RD_MON_MP rd_mon_if;

mod_trans data2sb;
mod_trans rd_data;

mailbox #(mod_trans) mon2sb;

function new(virtual mod_if.RD_MON_MP rd_mon_if,mailbox #(mod_trans) mon2sb);
    this.rd_mon_if=rd_mon_if;
    this.mon2sb=mon2sb;
    this.rd_data=new();
endfunction:new

task monitor();
   @(rd_mon_if.rd_mon_cb);
   begin
   rd_data.count_out=rd_mon_if.rd_mon_cb.count_out;
   rd_data.display("DATA FROM READ MONITOR");
   end
endtask:monitor

task start();
  fork
    forever
      begin
        monitor();
        data2sb=new rd_data;
        mon2sb.put(data2sb);
      end
  join_none
endtask:start
endclass:mod_read_mon
