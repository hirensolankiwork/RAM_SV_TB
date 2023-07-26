
class ram_test;

   ram_env env;

   virtual ram_if vif;


   function new(virtual ram_if vif);
      this.vif = vif;
      env = new(vif);
   endfunction

   task build_and_run;
      env.start();
   endtask

endclass

  
      
