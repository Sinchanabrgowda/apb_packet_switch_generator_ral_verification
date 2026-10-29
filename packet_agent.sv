class packet_agent extends uvm_agent;
  `uvm_component_utils(packet_agent)
  
  packet_driver pkt_drv;
  uvm_sequencer#(packet_seq_item) seqr;
  packet_monitor pkt_mon;
  
  function new(string name = "packet_agent", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    pkt_drv = packet_driver::type_id::create("pkt_drv", this);
    pkt_mon = packet_monitor::type_id::create("pkt_mon", this);
    seqr = uvm_sequencer#(packet_seq_item)::type_id::create("seqr", this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    pkt_drv.seq_item_port.connect(seqr.seq_item_export);
  endfunction
  
endclass
