
class ram_transaction;

   randc bit [`ADDR_WIDTH-1:0] wr_addr;
   rand bit [`DATA_WIDTH-1:0] wr_data;
   rand bit                   wr_enb;
   
   rand bit [`ADDR_WIDTH-1:0] rd_addr;
   randc bit [`DATA_WIDTH-1:0] rd_data;
   rand bit                   rd_enb;

   // Constraint

   // Methods

   function void copy (ram_transaction trans);
      this.wr_addr = trans.wr_addr;
      this.wr_data = trans.wr_data;
      this.wr_enb = trans.wr_enb;
      
      this.rd_addr = trans.rd_addr;
      this.rd_data = trans.rd_data;
      this.rd_enb = trans.rd_enb;
   endfunction: copy

   function void print(string prfx = "");

      $display("%0s | ======================= RAM_TRANSACTION ========================",prfx);
      $display("%0s | WR_ADDR :- 0x%0h",prfx,this.wr_addr);
      $display("%0s | WR_DATA :- 0x%0h",prfx,this.wr_data);
      $display("%0s | WR_ENB  :- 0x%0h",prfx,this.wr_enb);
      $display("%0s | RD_ADDR :- 0x%0h",prfx,this.rd_addr);
      $display("%0s | RD_DATA :- 0x%0h",prfx,this.rd_data);
      $display("%0s | RD_ENB  :- 0x%0h",prfx,this.rd_enb);
      $display("%0s | ================================================================",prfx);
   endfunction: print

   function bit compare(ram_transaction trans);

      if(this.wr_addr != trans.wr_addr)begin
         $error(" wr_addr 0x%0h != 0x%0h",this.wr_addr,trans.wr_addr);
         return 0;
      end

      if(this.wr_data != trans.wr_data)begin
         $error(" wr_addr 0x%0h != 0x%0h",this.wr_data,trans.wr_data);
         return 0;
      end

      if(this.rd_addr != trans.rd_addr)begin
         $error(" rd_addr 0x%0h != 0x%0h",this.rd_addr,trans.rd_addr);
         return 0;
      end

      if(this.rd_data != trans.rd_data)begin
         $error(" rd_addr 0x%0h != 0x%0h",this.rd_data,trans.rd_data);
         return 0;
      end

      return 0;

   endfunction: compare

endclass: ram_transaction
