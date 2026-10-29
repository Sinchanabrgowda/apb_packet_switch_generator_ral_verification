
`include "uvm_macros.svh"
`include "packet_pkg.sv"
`include "packet_interface.sv"
`include "rtl/apb_pkt_pkg.sv"
`include "rtl/pkt_generator.sv"
`include "rtl/pkt_switch.sv"
`include "rtl/apb_pkt_switch.sv"

module top;

  bit pclk = 0;

  always #5 pclk = ~pclk;

  import uvm_pkg::*;
  import packet_pkg::*;

  packet_interface vif(pclk);

  apb_pkt_switch dut (.pclk (pclk), .presetn (vif.preset_n),.psel (vif.psel),.penable (vif.penable),.pwrite(vif.pwrite),.paddr(vif.paddr),.pwdata(vif.pwdata),.prdata(vif.prdata), .pready(vif.pready),.pslverr (vif.pslverr), .irq (vif.irq) );

  initial begin
    vif.preset_n = 1'b0;
    #20;
    vif.preset_n = 1'b1;
  end

  initial begin
    uvm_config_db#(virtual packet_interface)::set(null, "*", "vif", vif);
  end
  
   initial begin
    $dumpfile("dumpfile.vcd");
     $dumpvars(0, top);
  end

  initial begin
    run_test("packet_regression_test");
//run_test("switch_ctrl_backdoor_test");
  end

endmodule

