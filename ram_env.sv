
class ram_env;

   virtual ram_if vif;

   mailbox#(ram_transaction) gen2drv_mbx;
   mailbox#(ram_transaction) mon2sb_mbx;

   ram_generator ram_gen;
   ram_driver ram_drv;
   ram_monitor ram_mon;

   function new(virtual ram_if vif);
      this.vif = vif;
      gen2drv_mbx = new();
      mon2sb_mbx = new();
      ram_gen = new(gen2drv_mbx);
      ram_drv = new(vif,gen2drv_mbx);
      ram_mon = new(vif,mon2sb_mbx);
   endfunction

   task start();
      
      fork

         ram_gen.run();
         ram_drv.run();
         ram_mon.run();
      join

   endtask: start

endclass: ram_env
