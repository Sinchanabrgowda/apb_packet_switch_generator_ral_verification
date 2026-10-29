class packet_adapter extends uvm_reg_adapter;
  `uvm_object_utils(packet_adapter)
  
function new(string name = "packet_adapter");
super.new(name);
endfunction
  
function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
packet_seq_item pkt_item;
pkt_item = packet_seq_item::type_id::create("pkt_item");
pkt_item.pwrite = (rw.kind == UVM_WRITE) ? 1'b1 : 1'b0;
pkt_item.paddr = rw.addr;
if(rw.kind == UVM_WRITE) pkt_item.pwdata = rw.data;
return pkt_item;
endfunction
  
function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
packet_seq_item pkt_item;
assert($cast(pkt_item, bus_item));
    
rw.kind = (pkt_item.pwrite == 1'b1) ? UVM_WRITE : UVM_READ;
rw.data = (pkt_item.pwrite == 1'b1) ? pkt_item.pwdata : pkt_item.prdata;
rw.addr = pkt_item.paddr;
rw.status = UVM_IS_OK;
endfunction
  
endclass
