class mod_write_drv;

virtual mod_if.WR_DRV_MP wr_drv_if;

mod_trans data2duv;

mailbox #(mod_trans) gen2wr;

function new(virtual mod_if.WR_DRV_MP wr_drv_if,mailbox #(mod_trans) gen2wr);
     this.wr_drv_if=wr_drv_if;
     this.gen2wr=gen2wr;
endfunction:new

virtual task drive();
       @(wr_drv_if.wr_drv_cb);
       wr_drv_if.wr_drv_cb.load<=data2duv.load;
       wr_drv_if.wr_drv_cb.mode<=data2duv.mode;
       wr_drv_if.wr_drv_cb.count_in<=data2duv.count_in;
       repeat(2) @(wr_drv_if.wr_drv_cb);
       wr_drv_if.wr_drv_cb.load<='0;
endtask:drive

virtual task start();
  fork
    forever
       begin
          gen2wr.get(data2duv);
          drive();
       end
  join_none
endtask:start

endclass:mod_write_drv
