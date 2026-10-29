
class packet_monitor extends uvm_monitor;
  `uvm_component_utils(packet_monitor)

  uvm_analysis_port #(packet_seq_item) mon_port;

  virtual packet_interface vif;

  packet_seq_item mon_item;

  function new(string name = "packet_monitor", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    mon_port = new("mon_port", this);

    if (!uvm_config_db#(virtual packet_interface)::get( this, "", "vif", vif))
      `uvm_fatal("MON", "Monitor does not have interface")
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      @(vif.monitor_cb);

      if (vif.monitor_cb.psel && vif.monitor_cb.penable && vif.monitor_cb.pready) begin

        mon_item = packet_seq_item::type_id::create("mon_item");

        mon_item.paddr   = vif.monitor_cb.paddr;
        mon_item.pwrite  = vif.monitor_cb.pwrite;
        mon_item.pwdata  = vif.monitor_cb.pwdata;
        mon_item.prdata  = vif.monitor_cb.prdata;
        mon_item.pslverr = vif.monitor_cb.pslverr;

        `uvm_info("APB_MON", $sformatf("APB %s addr=%0h pwdata=%0h prdata=%0h pslverr=%0b", mon_item.pwrite ? "WRITE" : "READ", mon_item.paddr,mon_item.pwdata,mon_item.prdata, mon_item.pslverr),UVM_MEDIUM)

        mon_port.write(mon_item);
      end
    end
  endtask

endclass

