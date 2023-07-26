

class ram_monitor;

   virtual ram_if.mon_mp vif;

   mailbox#(ram_transaction) mon2sb_mbx;

   ram_transaction trans;

   function new(virtual ram_if.mon_mp vif, mailbox#(ram_transaction) mon2sb_mbx);
      this.vif = vif;
      this.mon2sb_mbx = mon2sb_mbx;
   endfunction

   task run;
      forever begin
        @(vif.mon_cb);
         if(vif.mon_cb.wr_enb || vif.mon_cb.rd_enb)begin
            trans = new();
            trans.wr_enb = vif.mon_cb.wr_enb;
            trans.wr_addr = vif.mon_cb.wr_addr;
            trans.wr_data = vif.mon_cb.wr_data;
            trans.rd_enb = vif.mon_cb.rd_enb;
            trans.rd_addr = vif.mon_cb.rd_addr;
            trans.rd_data = vif.mon_cb.rd_data;
            mon2sb_mbx.put(trans);
         end
      end
   endtask:run

endclass: ram_monitor
