class mod_env;

   virtual mod_if.WR_DRV_MP wr_drv_if;
   virtual mod_if.WR_MON_MP wr_mon_if;
   virtual mod_if.RD_MON_MP rd_mon_if;

   mailbox #(mod_trans) gen2wr=new();
   mailbox #(mod_trans) mon2rm=new();
   mailbox #(mod_trans) rm2sb=new();
   mailbox #(mod_trans) mon2sb=new();

   mod_gen gen_h;
   mod_write_drv wr_drv_h;
   mod_write_mon wr_mon_h;
   mod_read_mon rd_mon_h;
   ref_model ref_mod_h;
   mod_sb sb_h;

   function new(virtual mod_if.WR_DRV_MP wr_drv_if,
                virtual mod_if.WR_MON_MP wr_mon_if,
                virtual mod_if.RD_MON_MP rd_mon_if);
       this.wr_drv_if=wr_drv_if;
       this.wr_mon_if=wr_mon_if;
       this.rd_mon_if=rd_mon_if;
   endfunction:new

   task build();
      gen_h=new(gen2wr);
      wr_drv_h=new(wr_drv_if,gen2wr);
      wr_mon_h=new(wr_mon_if,mon2rm);
      rd_mon_h=new(rd_mon_if,mon2sb);
      ref_mod_h=new(mon2rm,rm2sb);
      sb_h=new(rm2sb,mon2sb);
   endtask:build

  
   task start();
         gen_h.start();
         wr_drv_h.start();
         wr_mon_h.start();
         rd_mon_h.start();
         ref_mod_h.start();
         sb_h.start();
   endtask:start

   task stop();
     wait(sb_h.DONE.triggered);
   endtask:stop
  
   task run();
      start();
      stop();
      sb_h.report();
   endtask:run

endclass:mod_env

