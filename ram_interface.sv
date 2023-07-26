

interface ram_if(input clk,  input rst);

logic               wr_enb;
logic [`ADDR_WIDTH-1:0] wr_addr;
logic [`DATA_WIDTH-1:0] wr_data;

logic               rd_enb;
logic [`ADDR_WIDTH-1:0] rd_addr;
logic [`DATA_WIDTH-1:0] rd_data;

clocking drv_cb @(posedge clk);

   default input #1 output #1;
   output wr_enb;
   output wr_addr;
   output wr_data;
   
   output rd_enb;
   output rd_addr;
   input  rd_data;

endclocking: drv_cb


clocking mon_cb @(posedge clk);

   default input #1 output #1;
   input wr_enb;
   input wr_addr;
   input wr_data;
   
   input rd_enb;
   input rd_addr;
   input  rd_data;

endclocking: mon_cb

modport dut(input wr_enb, input wr_addr, input wr_data, input rd_enb, input rd_addr, output rd_data);

modport drv_mp (input clk, input rst, clocking drv_cb);
modport mon_mp (input clk, input rst, clocking mon_cb);

endinterface

