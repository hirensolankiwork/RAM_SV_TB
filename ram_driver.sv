
class ram_driver;

   virtual ram_if.drv_mp vif;

   mailbox#(ram_transaction) gen2drv_mbx;

   ram_transaction req;

   function new(virtual ram_if.drv_mp vif, mailbox#(ram_transaction) gen2drv_mbx);
      this.vif = vif;
      this.gen2drv_mbx = gen2drv_mbx;
   endfunction

   task run();

      reset();
      forever begin
        wait(vif.rst == 0);
        gen2drv_mbx.get(req);
        fork
           begin: MEM_WR
              if(req.wr_enb) send_mem_wr(req);
           end: MEM_WR
           begin: MEM_RD
              if(req.rd_enb) send_mem_rd(req);
           end: MEM_RD
           begin:RST
             wait(vif.rst == 1);
             reset();
             disable fork;
          end
        join
      end
   endtask:run

   task reset();
     vif.drv_cb.wr_enb <= 0;
     vif.drv_cb.wr_data <= 0;
     vif.drv_cb.wr_addr <= 0;
     vif.drv_cb.rd_enb <= 0;
     vif.drv_cb.rd_addr <= 0;
   endtask

   task send_mem_wr(ram_transaction trans);

      vif.drv_cb.wr_enb <= trans.wr_enb;
      vif.drv_cb.wr_addr <= trans.wr_addr;
      vif.drv_cb.wr_data <= trans.wr_data;
      @(vif.drv_cb);
      vif.drv_cb.wr_enb <= 0;
   endtask:send_mem_wr

   task send_mem_rd(ram_transaction trans);

      vif.drv_cb.rd_enb <= trans.rd_enb;
      vif.drv_cb.rd_addr <= trans.rd_addr;
      @(vif.drv_cb);
      vif.drv_cb.wr_enb <= 0;
      trans.rd_data = vif.drv_cb.rd_data;
   endtask:send_mem_rd

endclass:ram_driver


