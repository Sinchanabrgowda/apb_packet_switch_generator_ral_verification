
`include "uvm_macros.svh"

class packet_seq_item extends uvm_sequence_item;

  rand bit pwrite;
  rand bit [15:0] paddr;
  rand bit [31:0] pwdata;
  bit [31:0] prdata;
  bit pslverr;

  function new(string name = "packet_seq_item");
    super.new(name);
  endfunction

  `uvm_object_utils_begin(packet_seq_item)
    `uvm_field_int(pwrite, UVM_ALL_ON)
    `uvm_field_int(paddr, UVM_ALL_ON)
    `uvm_field_int(pwdata, UVM_ALL_ON)
    `uvm_field_int(prdata, UVM_ALL_ON)
    `uvm_field_int(pslverr, UVM_ALL_ON)
  `uvm_object_utils_end

  constraint c1 {
    paddr[1:0] == 2'b00;
    paddr inside {[16'h0000:16'h0060]};
  }

endclass

