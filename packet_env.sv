class packet_env extends uvm_env;
  `uvm_component_utils(packet_env)
  
  packet_agent pkt_agt;
  packet_reg_block pkt_regmodel;
  packet_adapter pkt_adapter;
  uvm_reg_predictor #(packet_seq_item) pkt_predictor_inst;
  packet_subscriber pkt_subscrb;
  
  function new(string name = "packet_env", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    pkt_predictor_inst = uvm_reg_predictor#(packet_seq_item)::type_id::create("pkt_predictor_inst", this);
    pkt_agt = packet_agent::type_id::create("pkt_agt", this);
    pkt_subscrb = packet_subscriber::type_id::create("pkt_subscrb", this);
    pkt_regmodel = packet_reg_block::type_id::create("pkt_regmodel", this);
pkt_regmodel.set_hdl_path_root("top.dut");   
 pkt_regmodel.build();
    pkt_adapter = packet_adapter::type_id::create("packet_adapter", this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    
    pkt_agt.pkt_mon.mon_port.connect(pkt_subscrb.subscrb_port);
    
    pkt_regmodel.default_map.set_sequencer(.sequencer(pkt_agt.seqr),.adapter(pkt_adapter));
    pkt_regmodel.default_map.set_base_addr(0);
    
    pkt_predictor_inst.map = pkt_regmodel.default_map;
    pkt_predictor_inst.adapter = pkt_adapter;
    
    pkt_agt.pkt_mon.mon_port.connect(pkt_predictor_inst.bus_in);
    
    pkt_regmodel.default_map.set_auto_predict(0);
  endfunction
  
endclass
