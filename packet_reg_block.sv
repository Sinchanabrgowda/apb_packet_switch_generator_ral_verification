
  class packet_reg_block extends uvm_reg_block;
    `uvm_object_utils(packet_reg_block)

    rand device_id_reg device_id;
    rand version_reg version;
    rand switch_status_reg switch_status;
    rand port_status_reg port_status;
    rand gen_status_reg gen_status;
    rand stat_rx_reg stat_rx;
    rand stat_tx_reg stat_tx;
    rand stat_drop_reg stat_drop;
    rand switch_ctrl_reg switch_ctrl;
    rand port_enable_reg port_enable;
    rand fwd_enable_reg fwd_enable;
    rand gen_ctrl_reg gen_ctrl;
    rand gen_pkt_cfg_reg gen_pkt_cfg;
    rand gen_interval_reg gen_interval;
    rand gen_count_reg gen_count;
    rand irq_status_reg irq_status;
    rand irq_enable_reg irq_enable;
    rand irq_force_reg irq_force;
    rand err_status_reg err_status;
    rand err_enable_reg err_enable;
    rand err_inject_reg err_inject;
    rand err_count_reg err_count;
    rand err_info_reg err_info;
    rand lock_reg lock;
    rand soft_reset_reg soft_reset;

    function new(string name = "pkt_reg_block");
     super.new(name, build_coverage(UVM_CVR_FIELD_VALS));
    endfunction

    virtual function void build();
    uvm_reg::include_coverage("*", UVM_CVR_ALL);

      device_id = device_id_reg::type_id::create("device_id");
      device_id.build();
      device_id.configure(this);
      device_id.set_coverage(UVM_CVR_FIELD_VALS);

      version = version_reg::type_id::create("version");
      version.build();
      version.configure(this);
      version.set_coverage(UVM_CVR_FIELD_VALS);
      

      switch_status = switch_status_reg::type_id::create("switch_status");
      switch_status.build();
      switch_status.configure(this);
      switch_status.set_coverage(UVM_CVR_FIELD_VALS);
      

      port_status = port_status_reg::type_id::create("port_status");
       port_status.build();
      port_status.configure(this);
      port_status.set_coverage(UVM_CVR_FIELD_VALS);
      

      gen_status = gen_status_reg::type_id::create("gen_status");
      gen_status.build();
      gen_status.configure(this);
      gen_status.set_coverage(UVM_CVR_FIELD_VALS);
      

      stat_rx = stat_rx_reg::type_id::create("stat_rx");
      stat_rx.build();
      stat_rx.configure(this);
      stat_rx.set_coverage(UVM_CVR_FIELD_VALS);
      

      stat_tx = stat_tx_reg::type_id::create("stat_tx");
      stat_tx.build();
      stat_tx.configure(this);
      stat_tx.set_coverage(UVM_CVR_FIELD_VALS);
      

      stat_drop = stat_drop_reg::type_id::create("stat_drop");
      stat_drop.build();
      stat_drop.configure(this);
      stat_drop.set_coverage(UVM_CVR_FIELD_VALS);
      

      switch_ctrl = switch_ctrl_reg::type_id::create("switch_ctrl");
      switch_ctrl.build();
      switch_ctrl.configure(this);
      switch_ctrl.add_hdl_path_slice("switch_ctrl_q", 0, 32);
      switch_ctrl.set_coverage(UVM_CVR_FIELD_VALS);
      

      port_enable = port_enable_reg::type_id::create("port_enable");
       port_enable.build();
      port_enable.configure(this);
      port_enable.set_coverage(UVM_CVR_FIELD_VALS);
      
      
      fwd_enable = fwd_enable_reg::type_id::create("fwd_enable");
      fwd_enable.build();
      fwd_enable.configure(this);
      fwd_enable.set_coverage(UVM_CVR_FIELD_VALS);
      

      gen_ctrl = gen_ctrl_reg::type_id::create("gen_ctrl");
      gen_ctrl.build();
      gen_ctrl.configure(this);
      gen_ctrl.set_coverage(UVM_CVR_FIELD_VALS);
      

      gen_pkt_cfg = gen_pkt_cfg_reg::type_id::create("gen_pkt_cfg");
            gen_pkt_cfg.build();
      gen_pkt_cfg.configure(this);
      gen_pkt_cfg.set_coverage(UVM_CVR_FIELD_VALS);
      

      gen_interval = gen_interval_reg::type_id::create("gen_interval");
            gen_interval.build();
      gen_interval.configure(this);
      gen_interval.set_coverage(UVM_CVR_FIELD_VALS);
      
     
      gen_count = gen_count_reg::type_id::create("gen_count");
            gen_count.build();
      gen_count.configure(this);
      gen_count.set_coverage(UVM_CVR_FIELD_VALS);
      

      irq_status = irq_status_reg::type_id::create("irq_status");
            irq_status.build();
      irq_status.configure(this);
      irq_status.set_coverage(UVM_CVR_FIELD_VALS);
       

      irq_enable = irq_enable_reg::type_id::create("irq_enable");
            irq_enable.build();
      irq_enable.configure(this);
      irq_enable.set_coverage(UVM_CVR_FIELD_VALS);
      

      irq_force = irq_force_reg::type_id::create("irq_force");
            irq_force.build();
      irq_force.configure(this);
      irq_force.set_coverage(UVM_CVR_FIELD_VALS);
      

      err_status = err_status_reg::type_id::create("err_status");
            err_status.build();
      err_status.configure(this);
      err_status.set_coverage(UVM_CVR_FIELD_VALS);
      

      err_enable = err_enable_reg::type_id::create("err_enable");
            err_enable.build();
      err_enable.configure(this);
      err_enable.set_coverage(UVM_CVR_FIELD_VALS);
      

      err_inject = err_inject_reg::type_id::create("err_inject");
      err_inject.build();
      err_inject.configure(this);
      err_inject.set_coverage(UVM_CVR_FIELD_VALS);
      

      err_count = err_count_reg::type_id::create("err_count");
            err_count.build();
      err_count.configure(this);
      err_count.set_coverage(UVM_CVR_FIELD_VALS);
      

      err_info = err_info_reg::type_id::create("err_info");
            err_info.build();
      err_info.configure(this);
     err_info.set_coverage(UVM_CVR_FIELD_VALS);
      

      lock = lock_reg::type_id::create("lock");
           lock.build();
       lock.configure(this);
      lock.set_coverage(UVM_CVR_FIELD_VALS);
      

      soft_reset = soft_reset_reg::type_id::create("soft_reset");
            soft_reset.build();
      soft_reset.configure(this);
      soft_reset.set_coverage(UVM_CVR_FIELD_VALS);
      
      
      //maping
      default_map = create_map("default_map", 'h0, 4, UVM_LITTLE_ENDIAN);
      
      
      default_map.add_reg(device_id, 'h00, "RO");
      default_map.add_reg(version, 'h04, "RO");
      default_map.add_reg(switch_status, 'h08, "RO");
      default_map.add_reg(port_status, 'h0C, "RO");
      default_map.add_reg(gen_status, 'h10, "RO");
      default_map.add_reg(stat_rx, 'h14, "RO");
      default_map.add_reg(stat_tx, 'h18, "RO");
      default_map.add_reg(stat_drop, 'h1C, "RO");
      default_map.add_reg(switch_ctrl, 'h20, "RW");
      default_map.add_reg(port_enable, 'h24, "RW");
	  default_map.add_reg(fwd_enable, 'h28, "RW");
      default_map.add_reg(gen_ctrl, 'h2C, "RW");
      default_map.add_reg(gen_pkt_cfg, 'h30, "RW");
      default_map.add_reg(gen_interval, 'h34, "RW");

      default_map.add_reg(gen_count, 'h38, "RW");
      default_map.add_reg(irq_status, 'h3C, "RW");
      default_map.add_reg(irq_enable, 'h40, "RW");
      default_map.add_reg(irq_force, 'h44, "WO");
      default_map.add_reg(err_status, 'h48, "RW");
      default_map.add_reg(err_enable, 'h4C, "RW");
      default_map.add_reg(err_inject, 'h50, "WO");
      default_map.add_reg(err_count, 'h54, "RO");
      default_map.add_reg(err_info, 'h58, "RO");
      default_map.add_reg(lock, 'h5C, "RW");
      default_map.add_reg(soft_reset, 'h60, "WO");
      
      //HDL PATH
      add_hdl_path("tb.dut");
         switch_status.add_hdl_path_slice("switch_status_r", 0, 32);
port_status.add_hdl_path_slice("port_status_r", 0, 32);
gen_status.add_hdl_path_slice("gen_status_r", 0, 32);


switch_ctrl.add_hdl_path_slice("switch_ctrl_q", 0, 32);
port_enable.add_hdl_path_slice("port_enable_q", 0, 4);
fwd_enable.add_hdl_path_slice("fwd_enable_q", 0, 4);

gen_ctrl.add_hdl_path_slice("gen_ctrl_q", 0, 32);
gen_pkt_cfg.add_hdl_path_slice("gen_pkt_cfg_q", 0, 32);
gen_interval.add_hdl_path_slice("gen_interval_q", 0, 16);
gen_count.add_hdl_path_slice("gen_count_q", 0, 16);

irq_status.add_hdl_path_slice("irq_status_q", 0, 8);
irq_enable.add_hdl_path_slice("irq_enable_q", 0, 8);

err_status.add_hdl_path_slice("err_status_q", 0, 8);
err_enable.add_hdl_path_slice("err_enable_q", 0, 8);
err_count.add_hdl_path_slice("err_count_q", 0, 16);
err_info.add_hdl_path_slice("err_info_q", 0, 32);

lock.add_hdl_path_slice("locked", 0, 1); 

      lock_model();
    endfunction
  endclass

