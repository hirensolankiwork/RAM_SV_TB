
class ram_generator;

   mailbox#(ram_transaction) gen2drv_mbx;

   ram_transaction trans;

   function new (mailbox#(ram_transaction) gen2drv_mbx);
      this.gen2drv_mbx = gen2drv_mbx;
   endfunction: new

   task run;
      repeat(`NUM_TRANSACTION)begin
        trans = new();
         if(trans.randomize() with {wr_enb == 1; wr_addr inside {[1:15]}; rd_enb == 0;} == 0) $fatal("ram_transaction Randomization failed");
         trans.print("GEN_SEND_PKT_TO_DRV");
         gen2drv_mbx.put(trans);
      end
      repeat(`NUM_TRANSACTION)begin
        trans = new();
         if(trans.randomize() with {rd_enb == 1; rd_addr inside {[1:15]}; wr_enb == 0;} == 0) $fatal("ram_transaction Randomization failed");
         trans.print("GEN_SEND_PKT_TO_DRV");
         gen2drv_mbx.put(trans);
      end
   endtask

endclass: ram_generator

