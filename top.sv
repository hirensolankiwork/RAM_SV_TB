
`define ADDR_WIDTH 16
`define DATA_WIDTH 8
`define DEPTH 8

`define NUM_TRANSACTION 20

`include "ram_16x8.v"
`include "ram_interface.sv"
`include "ram_package.sv"

import ram_package::*;

module top;

  bit clk, rst;

  ram_if vif(clk,rst);

  ram_test test;

  ram ram_dut(
     .clk(clk),
     .rst(rst),
     .wr_enb(vif.dut.wr_enb),
     .wr_addr(vif.dut.wr_addr),
     .wr_data(vif.dut.wr_data),
     .rd_enb(vif.dut.rd_enb),
     .rd_addr(vif.dut.rd_addr),
     .rd_data(vif.dut.rd_data)
  );

  always #5 clk = ~clk;

  initial begin
    rst =1;
    #20 rst =0;
    #500 $finish;
  end

  initial begin
     $dumpvars;
     $dumpfile("dum.vcd");

     test = new(vif);
     test.build_and_run();
   end

endmodule
