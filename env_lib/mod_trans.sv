class mod_trans;
rand bit reset,mode;
rand bit load;
rand bit [3:0]count_in;
logic [3:0]count_out;

static int trans_id;
static int no_of_increments;

constraint C1{reset dist{0:=50,1:=500};}
constraint C2{mode dist{0:=10,1:=50};}
constraint C3{load dist{0:=50,1:=1000};}
constraint C4{count_in inside {[0:3]};}

function void display(input string name);
$display("=======%s=======",name);
$display("reset value=%d",reset);
$display("mode is %d",mode);
$display("load value is %d",load);
$display("input data is %d",count_in);
$display("output data is %d",count_out);
endfunction:display

function void post_randomize();
      trans_id++;
endfunction:post_randomize

endclass:mod_trans
