class test;
  virtual mod_if.WR_DRV_MP wr_drv_if;
  virtual mod_if.WR_MON_MP wr_mon_if;
  virtual mod_if.RD_MON_MP rd_mon_if;

  mod_env env_h;
  
  function new(virtual mod_if.WR_DRV_MP wr_drv_if,
               virtual mod_if.WR_MON_MP wr_mon_if,
               virtual mod_if.RD_MON_MP rd_mon_if);
    this.wr_drv_if=wr_drv_if;
    this.wr_mon_if=wr_mon_if;
    this.rd_mon_if=rd_mon_if;
    env_h=new(wr_drv_if,wr_mon_if,rd_mon_if);
  endfunction:new

  task build_and_run();
    begin
    env_h.build();
    env_h.run();
    $finish;
    end
  endtask:build_and_run

endclass:test

