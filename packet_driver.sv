
class packet_driver extends uvm_driver #(packet_seq_item);
  `uvm_component_utils(packet_driver)

virtual packet_interface vif;

function new(string name = "packet_driver", uvm_component parent);
super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);

 if (!uvm_config_db#(virtual packet_interface)::get(this, "", "vif", vif))
`uvm_fatal("DRV", "Driver does not have interface")
endfunction

task drive_transfer(packet_seq_item tr);
@(vif.driver_cb);
vif.driver_cb.psel    <= 1'b1;
vif.driver_cb.penable <= 1'b0;
vif.driver_cb.pwrite  <= tr.pwrite;
vif.driver_cb.paddr   <= tr.paddr;

if (tr.pwrite)
vif.driver_cb.pwdata <= tr.pwdata;
else
vif.driver_cb.pwdata <= '0;

@(vif.driver_cb);
vif.driver_cb.penable <= 1'b1;

 do begin
 @(vif.driver_cb);
 end while (!vif.driver_cb.pready);

 tr.pslverr = vif.driver_cb.pslverr;

 if (!tr.pwrite)
 tr.prdata = vif.driver_cb.prdata;

`uvm_info("APB_DRV",$sformatf("APB %s addr=%0h data=%0h pslverr=%0b",tr.pwrite ? "WRITE" : "READ",tr.paddr,tr.pwrite ? tr.pwdata : tr.prdata, tr.pslverr),UVM_MEDIUM)

vif.driver_cb.psel    <= 1'b0;
vif.driver_cb.penable <= 1'b0;
vif.driver_cb.pwrite  <= 1'b0;
vif.driver_cb.paddr   <= '0;
vif.driver_cb.pwdata  <= '0;
endtask

task run_phase(uvm_phase phase);
super.run_phase(phase);

vif.driver_cb.psel    <= 1'b0;
vif.driver_cb.penable <= 1'b0;
vif.driver_cb.pwrite  <= 1'b0;
vif.driver_cb.paddr   <= '0;
vif.driver_cb.pwdata  <= '0;

forever begin
seq_item_port.get_next_item(req);
drive_transfer(req);
seq_item_port.item_done();
end
endtask

endclass

