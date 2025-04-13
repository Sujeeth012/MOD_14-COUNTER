interface mod_if(input bit clock);

logic reset;
logic load;
logic mode;
logic [3:0]count_in;
logic [3:0]count_out;

clocking wr_drv_cb @(posedge clock);
default input #1 output #1;
output load;
output mode;
output count_in;
endclocking:wr_drv_cb

clocking wr_mon_cb @(posedge clock);
default input #1 output #1;
input load;
input mode;
input count_in;
endclocking:wr_mon_cb

clocking rd_mon_cb @(posedge clock);
default input #1 output #1;
input count_out;
endclocking:rd_mon_cb

modport WR_DRV_MP(clocking wr_drv_cb);

modport WR_MON_MP(clocking wr_mon_cb);

modport RD_MON_MP(clocking rd_mon_cb);

endinterface:mod_if
