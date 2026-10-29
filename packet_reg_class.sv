  import uvm_pkg::*;
  `include "uvm_macros.svh"

  // 0x00 DEVICE_ID
class device_id_reg extends uvm_reg;
  `uvm_object_utils(device_id_reg)

  rand uvm_reg_field revision;
  rand uvm_reg_field vendor_id;
  rand uvm_reg_field product_id;

  covergroup revision_cov;
    option.per_instance = 1;
    coverpoint revision.value[7:0]
    {
      bins revision_bin = {[8'h00:8'hFF]};
    }
  endgroup

  covergroup vendor_id_cov;
    option.per_instance = 1;
    coverpoint vendor_id.value[7:0]
    {
      bins vendor_id_bin = {[8'h00:8'hFF]};
    }
  endgroup

  covergroup product_id_cov;
    option.per_instance = 1;
    coverpoint product_id.value[15:0]
    {
      bins product_id_bin = {[16'h0000:16'hFFFF]};
    }
  endgroup

  function new(string name = "device_id_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      revision_cov = new();
      vendor_id_cov = new();
      product_id_cov = new();
    end
  endfunction

  virtual function void sample(
    uvm_reg_data_t data,
    uvm_reg_data_t byte_en,
    bit is_read,
    uvm_reg_map map
  );
    revision_cov.sample();
    vendor_id_cov.sample();
    product_id_cov.sample();
  endfunction

  virtual function void sample_values();
    super.sample_values();
    revision_cov.sample();
    vendor_id_cov.sample();
    product_id_cov.sample();
  endfunction

  virtual function void build();
    revision = uvm_reg_field::type_id::create("revision");
    revision.configure(this, 8, 24, "RO", 0, 8'h02, 1, 1, 1);

    vendor_id = uvm_reg_field::type_id::create("vendor_id");
    vendor_id.configure(this, 8, 16, "RO", 0, 8'hA5, 1, 1, 1);

    product_id = uvm_reg_field::type_id::create("product_id");
    product_id.configure(this, 16, 0, "RO", 0, 16'h5357, 1, 1, 1);
  endfunction

endclass

  // 0x04 VERSION
 class version_reg extends uvm_reg;
  `uvm_object_utils(version_reg)

  rand uvm_reg_field rsvd;
  rand uvm_reg_field major;
  rand uvm_reg_field minor;
  rand uvm_reg_field patch;


  covergroup major_cov;
    option.per_instance = 1;
    coverpoint major.value[7:0]
    {
      bins major_bin = {[8'h00:8'hFF]};
    }
  endgroup

  covergroup minor_cov;
    option.per_instance = 1;
    coverpoint minor.value[7:0]
    {
      bins minor_bin = {[8'h00:8'hFF]};
    }
  endgroup

  covergroup patch_cov;
    option.per_instance = 1;
    coverpoint patch.value[7:0]
    {
      bins patch_bin = {[8'h00:8'hFF]};
    }
  endgroup

  function new(string name = "version_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      major_cov = new();
      minor_cov = new();
      patch_cov = new();
    end
  endfunction

  virtual function void sample(
    uvm_reg_data_t data,
    uvm_reg_data_t byte_en,
    bit is_read,
    uvm_reg_map map
  );
    major_cov.sample();
    minor_cov.sample();
    patch_cov.sample();
  endfunction

  virtual function void sample_values();
    super.sample_values();
    major_cov.sample();
    minor_cov.sample();
    patch_cov.sample();
  endfunction

  virtual function void build();
    rsvd = uvm_reg_field::type_id::create("rsvd");
    rsvd.configure(this, 8, 24, "RO", 0, 0, 1, 1, 1);

    major = uvm_reg_field::type_id::create("major");
    major.configure(this, 8, 16, "RO", 0, 1, 1, 1, 1);

    minor = uvm_reg_field::type_id::create("minor");
    minor.configure(this, 8, 8, "RO", 0, 2, 1, 1, 1);

    patch = uvm_reg_field::type_id::create("patch");
    patch.configure(this, 8, 0, "RO", 0, 0, 1, 1, 1);
  endfunction

endclass

  // 0x08 SWITCH_STATUS
class switch_status_reg extends uvm_reg;
  `uvm_object_utils(switch_status_reg)

  rand uvm_reg_field rsvd_hi;
  rand uvm_reg_field gen_fsm;
  rand uvm_reg_field rsvd_mid;
  rand uvm_reg_field err_pending;
  rand uvm_reg_field gen_running;
  rand uvm_reg_field port_enabled;
  rand uvm_reg_field locked;
  rand uvm_reg_field switch_enabled;
  rand uvm_reg_field busy;
  rand uvm_reg_field ready;



  covergroup gen_fsm_cov;
    option.per_instance = 1;
    coverpoint gen_fsm.value[1:0]
    {
      bins idle_bin = {2'd0};
      bins send_bin = {2'd1};
      bins gap_bin = {2'd2};
      bins done_bin = {2'd3};
    }
  endgroup

 
  covergroup err_pending_cov;
    option.per_instance = 1;
    coverpoint err_pending.value[0]
    {
      bins clear_bin = {1'b0};
      bins pending_bin = {1'b1};
    }
  endgroup

  covergroup gen_running_cov;
    option.per_instance = 1;
    coverpoint gen_running.value[0]
    {
      bins stopped_bin = {1'b0};
      bins running_bin = {1'b1};
    }
  endgroup

  covergroup port_enabled_cov;
    option.per_instance = 1;
    coverpoint port_enabled.value[3:0]
    {
      bins no_ports_bin = {4'h0};
      bins one_port_bin = {4'h1, 4'h2, 4'h4, 4'h8};
      bins multiple_ports_bin = {[4'h3:4'hE]};
      bins all_ports_bin = {4'hF};
    }
  endgroup

  covergroup locked_cov;
    option.per_instance = 1;
    coverpoint locked.value[0]
    {
      bins unlocked_bin = {1'b0};
      bins locked_bin = {1'b1};
    }
  endgroup

  covergroup switch_enabled_cov;
    option.per_instance = 1;
    coverpoint switch_enabled.value[0]
    {
      bins disabled_bin = {1'b0};
      bins enabled_bin = {1'b1};
    }
  endgroup

  covergroup busy_cov;
    option.per_instance = 1;
    coverpoint busy.value[0]
    {
      bins idle_bin = {1'b0};
      bins busy_bin = {1'b1};
    }
  endgroup

  covergroup ready_cov;
    option.per_instance = 1;
    coverpoint ready.value[0]
    {
      bins not_ready_bin = {1'b0};
      bins ready_bin = {1'b1};
    }
  endgroup

  function new(string name = "switch_status_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      gen_fsm_cov = new();
      err_pending_cov = new();
      gen_running_cov = new();
      port_enabled_cov = new();
      locked_cov = new();
      switch_enabled_cov = new();
      busy_cov = new();
      ready_cov = new();
    end
  endfunction

  virtual function void sample(
    uvm_reg_data_t data,
    uvm_reg_data_t byte_en,
    bit is_read,
    uvm_reg_map map
  );
 
    gen_fsm_cov.sample();
    err_pending_cov.sample();
    gen_running_cov.sample();
    port_enabled_cov.sample();
    locked_cov.sample();
    switch_enabled_cov.sample();
    busy_cov.sample();
    ready_cov.sample();
  endfunction

  virtual function void sample_values();
    super.sample_values();
    gen_fsm_cov.sample();
    err_pending_cov.sample();
    gen_running_cov.sample();
    port_enabled_cov.sample();
    locked_cov.sample();
    switch_enabled_cov.sample();
    busy_cov.sample();
    ready_cov.sample();
  endfunction

  virtual function void build();
    rsvd_hi = uvm_reg_field::type_id::create("rsvd_hi");
    rsvd_hi.configure(this, 14, 18, "RO", 0, 0, 1, 1, 1);

    gen_fsm = uvm_reg_field::type_id::create("gen_fsm");
    gen_fsm.configure(this, 2, 16, "RO", 1, 0, 1, 1, 1);

    rsvd_mid = uvm_reg_field::type_id::create("rsvd_mid");
    rsvd_mid.configure(this, 6, 10, "RO", 0, 0, 1, 1, 1);

    err_pending = uvm_reg_field::type_id::create("err_pending");
    err_pending.configure(this, 1, 9, "RO", 1, 0, 1, 1, 1);

    gen_running = uvm_reg_field::type_id::create("gen_running");
    gen_running.configure(this, 1, 8, "RO", 1, 0, 1, 1, 1);

    port_enabled = uvm_reg_field::type_id::create("port_enabled");
    port_enabled.configure(this, 4, 4, "RO", 1, 'hF, 1, 1, 1);

    locked = uvm_reg_field::type_id::create("locked");
    locked.configure(this, 1, 3, "RO", 1, 1, 1, 1, 1);

    switch_enabled = uvm_reg_field::type_id::create("switch_enabled");
    switch_enabled.configure(this, 1, 2, "RO", 1, 0, 1, 1, 1);

    busy = uvm_reg_field::type_id::create("busy");
    busy.configure(this, 1, 1, "RO", 1, 0, 1, 1, 1);

    ready = uvm_reg_field::type_id::create("ready");
    ready.configure(this, 1, 0, "RO", 1, 1, 1, 1, 1);
  endfunction

endclass

  // 0x0C PORT_STATUS
  class port_status_reg extends uvm_reg;
  `uvm_object_utils(port_status_reg)

  rand uvm_reg_field port3_level;
  rand uvm_reg_field port2_level;
  rand uvm_reg_field port1_level;
  rand uvm_reg_field port0_level;

  covergroup port3_level_cov;
    option.per_instance = 1;
    coverpoint port3_level.value[7:0]
    {
      bins port3_level_bin = {[8'h00:8'hFF]};
    }
  endgroup

  covergroup port2_level_cov;
    option.per_instance = 1;
    coverpoint port2_level.value[7:0]
    {
      bins port2_level_bin = {[8'h00:8'hFF]};
    }
  endgroup

  covergroup port1_level_cov;
    option.per_instance = 1;
    coverpoint port1_level.value[7:0]
    {
      bins port1_level_bin = {[8'h00:8'hFF]};
    }
  endgroup

  covergroup port0_level_cov;
    option.per_instance = 1;
    coverpoint port0_level.value[7:0]
    {
      bins port0_level_bin = {[8'h00:8'hFF]};
    }
  endgroup

  function new(string name = "port_status_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      port3_level_cov = new();
      port2_level_cov = new();
      port1_level_cov = new();
      port0_level_cov = new();
    end
  endfunction

  virtual function void sample(
    uvm_reg_data_t data,
    uvm_reg_data_t byte_en,
    bit is_read,
    uvm_reg_map map
  );
    port3_level_cov.sample();
    port2_level_cov.sample();
    port1_level_cov.sample();
    port0_level_cov.sample();
  endfunction

  virtual function void sample_values();
    super.sample_values();
    port3_level_cov.sample();
    port2_level_cov.sample();
    port1_level_cov.sample();
    port0_level_cov.sample();
  endfunction

  virtual function void build();
    port3_level = uvm_reg_field::type_id::create("port3_level");
    port3_level.configure(this, 8, 24, "RO", 1, 0, 1, 1, 1);

    port2_level = uvm_reg_field::type_id::create("port2_level");
    port2_level.configure(this, 8, 16, "RO", 1, 0, 1, 1, 1);

    port1_level = uvm_reg_field::type_id::create("port1_level");
    port1_level.configure(this, 8, 8, "RO", 1, 0, 1, 1, 1);

    port0_level = uvm_reg_field::type_id::create("port0_level");
    port0_level.configure(this, 8, 0, "RO", 1, 0, 1, 1, 1);
  endfunction

endclass

  // 0x10 GEN_STATUS
 class gen_status_reg extends uvm_reg;
  `uvm_object_utils(gen_status_reg)

  rand uvm_reg_field rsvd_hi;
  rand uvm_reg_field remaining;
  rand uvm_reg_field rsvd_lo;
  rand uvm_reg_field fsm;
  rand uvm_reg_field done;
  rand uvm_reg_field running;

  covergroup remaining_cov;
    option.per_instance = 1;
    coverpoint remaining.value[15:0]
    {
      bins remaining_zero = {16'h0000};
      bins remaining_nonzero = {[16'h0001:16'hFFFF]};
    }
  endgroup

  covergroup fsm_cov;
    option.per_instance = 1;
    coverpoint fsm.value[1:0]
    {
      bins idle_bin = {2'd0};
      bins send_bin = {2'd1};
      bins gap_bin = {2'd2};
      bins done_bin = {2'd3};
    }
  endgroup

  covergroup done_cov;
    option.per_instance = 1;
    coverpoint done.value[0]
    {
      bins not_done_bin = {1'b0};
      bins done_bin = {1'b1};
    }
  endgroup

  covergroup running_cov;
    option.per_instance = 1;
    coverpoint running.value[0]
    {
      bins stopped_bin = {1'b0};
      bins running_bin = {1'b1};
    }
  endgroup

  function new(string name = "gen_status_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      remaining_cov = new();
      fsm_cov = new();
      done_cov = new();
      running_cov = new();
    end
  endfunction

  virtual function void sample(
    uvm_reg_data_t data,
    uvm_reg_data_t byte_en,
    bit is_read,
    uvm_reg_map map
  );
    remaining_cov.sample();
    fsm_cov.sample();
    done_cov.sample();
    running_cov.sample();
  endfunction

  virtual function void sample_values();
    super.sample_values();
    remaining_cov.sample();
    fsm_cov.sample();
    done_cov.sample();
    running_cov.sample();
  endfunction

  virtual function void build();
    rsvd_hi = uvm_reg_field::type_id::create("rsvd_hi");
    rsvd_hi.configure(this, 8, 24, "RO", 0, 0, 1, 1, 1);

    remaining = uvm_reg_field::type_id::create("remaining");
    remaining.configure(this, 16, 8, "RO", 1, 0, 1, 1, 1);

    rsvd_lo = uvm_reg_field::type_id::create("rsvd_lo");
    rsvd_lo.configure(this, 4, 4, "RO", 0, 0, 1, 1, 1);

    fsm = uvm_reg_field::type_id::create("fsm");
    fsm.configure(this, 2, 2, "RO", 1, 0, 1, 1, 1);

    done = uvm_reg_field::type_id::create("done");
    done.configure(this, 1, 1, "RO", 1, 0, 1, 1, 1);

    running = uvm_reg_field::type_id::create("running");
    running.configure(this, 1, 0, "RO", 1, 0, 1, 1, 1);
  endfunction

endclass

  // 0x14 STAT_RX
  class stat_rx_reg extends uvm_reg;
  `uvm_object_utils(stat_rx_reg)

  rand uvm_reg_field rsvd;
  rand uvm_reg_field rx_packets;

  covergroup rx_packets_cov;
    option.per_instance = 1;
    coverpoint rx_packets.value[15:0]
    {
      bins zero_packets = {16'h0000};
      bins multiple_packets = {[16'h0001:16'hFFFF]};
    }
  endgroup

  function new(string name = "stat_rx_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      rx_packets_cov = new();
    end
  endfunction

  virtual function void sample(
    uvm_reg_data_t data,
    uvm_reg_data_t byte_en,
    bit is_read,
    uvm_reg_map map
  );
    rx_packets_cov.sample();
  endfunction

  virtual function void sample_values();
    super.sample_values();
    rx_packets_cov.sample();
  endfunction

  virtual function void build();
    rsvd = uvm_reg_field::type_id::create("rsvd");
    rsvd.configure(this, 16, 16, "RO", 0, 0, 1, 1, 1);

    rx_packets = uvm_reg_field::type_id::create("rx_packets");
    rx_packets.configure(this, 16, 0, "RO", 1, 0, 1, 1, 1);
  endfunction

endclass

  // 0x18 STAT_TX
 class stat_tx_reg extends uvm_reg;
  `uvm_object_utils(stat_tx_reg)

  rand uvm_reg_field rsvd;
  rand uvm_reg_field tx_packets;

  covergroup tx_packets_cov;
    option.per_instance = 1;
    coverpoint tx_packets.value[15:0]
    {
      bins zero_packets = {16'h0000};
      bins multiple_packets = {[16'h0001:16'hFFFF]};
    }
  endgroup

  function new(string name = "stat_tx_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      tx_packets_cov = new();
    end
  endfunction

  virtual function void sample(
    uvm_reg_data_t data,
    uvm_reg_data_t byte_en,
    bit is_read,
    uvm_reg_map map
  );
    tx_packets_cov.sample();
  endfunction

  virtual function void sample_values();
    super.sample_values();
    tx_packets_cov.sample();
  endfunction

  virtual function void build();
    rsvd = uvm_reg_field::type_id::create("rsvd");
    rsvd.configure(this, 16, 16, "RO", 0, 0, 1, 1, 1);

    tx_packets = uvm_reg_field::type_id::create("tx_packets");
    tx_packets.configure(this, 16, 0, "RO", 1, 0, 1, 1, 1);
  endfunction

endclass

  // 0x1C STAT_DROP
 class stat_drop_reg extends uvm_reg;
  `uvm_object_utils(stat_drop_reg)

  rand uvm_reg_field rsvd;
  rand uvm_reg_field dropped_packets;

  covergroup dropped_packets_cov;
    option.per_instance = 1;
    coverpoint dropped_packets.value[15:0]
    {
      bins zero_drops = {16'h0000};
      bins one_drop = {16'h0001};
      bins multiple_drops = {[16'h0002:16'hFFFF]};
    }
  endgroup

  function new(string name = "stat_drop_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      dropped_packets_cov = new();
    end
  endfunction

  virtual function void sample(
    uvm_reg_data_t data,
    uvm_reg_data_t byte_en,
    bit is_read,
    uvm_reg_map map
  );
    dropped_packets_cov.sample();
  endfunction

  virtual function void sample_values();
    super.sample_values();
    dropped_packets_cov.sample();
  endfunction

  virtual function void build();
    rsvd = uvm_reg_field::type_id::create("rsvd");
    rsvd.configure(this, 16, 16, "RO", 0, 0, 1, 1, 1);

    dropped_packets = uvm_reg_field::type_id::create("dropped_packets");
    dropped_packets.configure(this, 16, 0, "RO", 1, 0, 1, 1, 1);
  endfunction

endclass

  // 0x20 SWITCH_CTRL
  class switch_ctrl_reg extends uvm_reg;
  `uvm_object_utils(switch_ctrl_reg)

  rand uvm_reg_field rsvd_hi;
  rand uvm_reg_field irq_global_en;
  rand uvm_reg_field rsvd_mid;
  rand uvm_reg_field stat_clear;
  rand uvm_reg_field enable;

  covergroup irq_global_en_cov;
    option.per_instance = 1;
    coverpoint irq_global_en.value[0]
    {
      bins disabled_bin = {1'b0};
      bins enabled_bin = {1'b1};
    }
  endgroup

  covergroup stat_clear_cov;
    option.per_instance = 1;
    coverpoint stat_clear.value[0]
    {
      bins clear_deasserted_bin = {1'b0};
      bins clear_asserted_bin = {1'b1};
    }
  endgroup

  covergroup enable_cov;
    option.per_instance = 1;
    coverpoint enable.value[0]
    {
      bins disabled_bin = {1'b0};
      bins enabled_bin = {1'b1};
    }
  endgroup

  function new(string name = "switch_ctrl_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      irq_global_en_cov = new();
      stat_clear_cov = new();
      enable_cov = new();
    end
  endfunction

  virtual function void sample(
    uvm_reg_data_t data,
    uvm_reg_data_t byte_en,
    bit is_read,
    uvm_reg_map map
  );
    irq_global_en_cov.sample();
    stat_clear_cov.sample();
    enable_cov.sample();
  endfunction

  virtual function void sample_values();
    super.sample_values();
    irq_global_en_cov.sample();
    stat_clear_cov.sample();
    enable_cov.sample();
  endfunction

  virtual function void build();
    rsvd_hi = uvm_reg_field::type_id::create("rsvd_hi");
    rsvd_hi.configure(this, 28, 4, "RO", 0, 0, 1, 1, 1);

    irq_global_en = uvm_reg_field::type_id::create("irq_global_en");
    irq_global_en.configure(this, 1, 3, "RW", 0, 0, 1, 1, 1);

    rsvd_mid = uvm_reg_field::type_id::create("rsvd_mid");
    rsvd_mid.configure(this, 1, 2, "RO", 0, 0, 1, 1, 1);

    stat_clear = uvm_reg_field::type_id::create("stat_clear");
    stat_clear.configure(this, 1, 1, "WO", 0, 0, 1, 1, 1);

    enable = uvm_reg_field::type_id::create("enable");
    enable.configure(this, 1, 0, "RW", 0, 0, 1, 1, 1);
  endfunction

endclass

  // 0x24 PORT_ENABLE
 class port_enable_reg extends uvm_reg;
  `uvm_object_utils(port_enable_reg)

  rand uvm_reg_field rsvd;
  rand uvm_reg_field port3_en;
  rand uvm_reg_field port2_en;
  rand uvm_reg_field port1_en;
  rand uvm_reg_field port0_en;

  covergroup port3_en_cov;
    option.per_instance = 1;
    coverpoint port3_en.value[0]
    {
      bins disabled_bin = {1'b0};
      bins enabled_bin = {1'b1};
    }
  endgroup

  covergroup port2_en_cov;
    option.per_instance = 1;
    coverpoint port2_en.value[0]
    {
      bins disabled_bin = {1'b0};
      bins enabled_bin = {1'b1};
    }
  endgroup

  covergroup port1_en_cov;
    option.per_instance = 1;
    coverpoint port1_en.value[0]
    {
      bins disabled_bin = {1'b0};
      bins enabled_bin = {1'b1};
    }
  endgroup

  covergroup port0_en_cov;
    option.per_instance = 1;
    coverpoint port0_en.value[0]
    {
      bins disabled_bin = {1'b0};
      bins enabled_bin = {1'b1};
    }
  endgroup

  function new(string name = "port_enable_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      port3_en_cov = new();
      port2_en_cov = new();
      port1_en_cov = new();
      port0_en_cov = new();
    end
  endfunction

  virtual function void sample(
    uvm_reg_data_t data,
    uvm_reg_data_t byte_en,
    bit is_read,
    uvm_reg_map map
  );
    port3_en_cov.sample();
    port2_en_cov.sample();
    port1_en_cov.sample();
    port0_en_cov.sample();
  endfunction

  virtual function void sample_values();
    super.sample_values();
    port3_en_cov.sample();
    port2_en_cov.sample();
    port1_en_cov.sample();
    port0_en_cov.sample();
  endfunction

  virtual function void build();
    rsvd = uvm_reg_field::type_id::create("rsvd");
    rsvd.configure(this, 28, 4, "RO", 0, 0, 1, 1, 1);

    port3_en = uvm_reg_field::type_id::create("port3_en");
    port3_en.configure(this, 1, 3, "RW", 0, 1, 1, 1, 1);

    port2_en = uvm_reg_field::type_id::create("port2_en");
    port2_en.configure(this, 1, 2, "RW", 0, 1, 1, 1, 1);

    port1_en = uvm_reg_field::type_id::create("port1_en");
    port1_en.configure(this, 1, 1, "RW", 0, 1, 1, 1, 1);

    port0_en = uvm_reg_field::type_id::create("port0_en");
    port0_en.configure(this, 1, 0, "RW", 0, 1, 1, 1, 1);
  endfunction

endclass

  // 0x28 FWD_ENABLE
class fwd_enable_reg extends uvm_reg;
  `uvm_object_utils(fwd_enable_reg)

  rand uvm_reg_field rsvd;
  rand uvm_reg_field fwd3_en;
  rand uvm_reg_field fwd2_en;
  rand uvm_reg_field fwd1_en;
  rand uvm_reg_field fwd0_en;

  covergroup fwd3_en_cov;
    option.per_instance = 1;
    coverpoint fwd3_en.value[0]
    {
      bins disabled_bin = {1'b0};
      bins enabled_bin = {1'b1};
    }
  endgroup

  covergroup fwd2_en_cov;
    option.per_instance = 1;
    coverpoint fwd2_en.value[0]
    {
      bins disabled_bin = {1'b0};
      bins enabled_bin = {1'b1};
    }
  endgroup

  covergroup fwd1_en_cov;
    option.per_instance = 1;
    coverpoint fwd1_en.value[0]
    {
      bins disabled_bin = {1'b0};
      bins enabled_bin = {1'b1};
    }
  endgroup

  covergroup fwd0_en_cov;
    option.per_instance = 1;
    coverpoint fwd0_en.value[0]
    {
      bins disabled_bin = {1'b0};
      bins enabled_bin = {1'b1};
    }
  endgroup

  function new(string name = "fwd_enable_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      fwd3_en_cov = new();
      fwd2_en_cov = new();
      fwd1_en_cov = new();
      fwd0_en_cov = new();
    end
  endfunction

  virtual function void sample(
    uvm_reg_data_t data,
    uvm_reg_data_t byte_en,
    bit is_read,
    uvm_reg_map map
  );
    fwd3_en_cov.sample();
    fwd2_en_cov.sample();
    fwd1_en_cov.sample();
    fwd0_en_cov.sample();
  endfunction

  virtual function void sample_values();
    super.sample_values();
    fwd3_en_cov.sample();
    fwd2_en_cov.sample();
    fwd1_en_cov.sample();
    fwd0_en_cov.sample();
  endfunction

  virtual function void build();
    rsvd = uvm_reg_field::type_id::create("rsvd");
    rsvd.configure(this, 28, 4, "RO", 0, 0, 1, 1, 1);

    fwd3_en = uvm_reg_field::type_id::create("fwd3_en");
    fwd3_en.configure(this, 1, 3, "RW", 0, 1, 1, 1, 1);

    fwd2_en = uvm_reg_field::type_id::create("fwd2_en");
    fwd2_en.configure(this, 1, 2, "RW", 0, 1, 1, 1, 1);

    fwd1_en = uvm_reg_field::type_id::create("fwd1_en");
    fwd1_en.configure(this, 1, 1, "RW", 0, 1, 1, 1, 1);

    fwd0_en = uvm_reg_field::type_id::create("fwd0_en");
    fwd0_en.configure(this, 1, 0, "RW", 0, 1, 1, 1, 1);
  endfunction

endclass

  // 0x2C GEN_CTRL
  class gen_ctrl_reg extends uvm_reg;
  `uvm_object_utils(gen_ctrl_reg)

  rand uvm_reg_field rsvd;
  rand uvm_reg_field continuous;
  rand uvm_reg_field stop;
  rand uvm_reg_field start;
  rand uvm_reg_field enable;

  covergroup continuous_cov;
    option.per_instance = 1;
    coverpoint continuous.value[0]
    {
      bins disabled_bin = {1'b0};
      bins enabled_bin = {1'b1};
    }
  endgroup

  covergroup stop_cov;
    option.per_instance = 1;
    coverpoint stop.value[0]
    {
      bins deasserted_bin = {1'b0};
      bins asserted_bin = {1'b1};
    }
  endgroup

  covergroup start_cov;
    option.per_instance = 1;
    coverpoint start.value[0]
    {
      bins deasserted_bin = {1'b0};
      bins asserted_bin = {1'b1};
    }
  endgroup

  covergroup enable_cov;
    option.per_instance = 1;
    coverpoint enable.value[0]
    {
      bins disabled_bin = {1'b0};
      bins enabled_bin = {1'b1};
    }
  endgroup

  function new(string name = "gen_ctrl_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      continuous_cov = new();
      stop_cov = new();
      start_cov = new();
      enable_cov = new();
    end
  endfunction

  virtual function void sample(
    uvm_reg_data_t data,
    uvm_reg_data_t byte_en,
    bit is_read,
    uvm_reg_map map
  );
    continuous_cov.sample();
    stop_cov.sample();
    start_cov.sample();
    enable_cov.sample();
  endfunction

  virtual function void sample_values();
    super.sample_values();
    continuous_cov.sample();
    stop_cov.sample();
    start_cov.sample();
    enable_cov.sample();
  endfunction

  virtual function void build();
    rsvd = uvm_reg_field::type_id::create("rsvd");
    rsvd.configure(this, 28, 4, "RO", 0, 0, 1, 1, 1);

    continuous = uvm_reg_field::type_id::create("continuous");
    continuous.configure(this, 1, 3, "RW", 0, 0, 1, 1, 1);

    stop = uvm_reg_field::type_id::create("stop");
    stop.configure(this, 1, 2, "WO", 0, 0, 1, 1, 1);

    start = uvm_reg_field::type_id::create("start");
    start.configure(this, 1, 1, "WO", 0, 0, 1, 1, 1);

    enable = uvm_reg_field::type_id::create("enable");
    enable.configure(this, 1, 0, "RW", 0, 0, 1, 1, 1);
  endfunction

endclass

  // 0x30 GEN_PKT_CFG
  // NOTE: LENGTH=0 is stored as 1 by the RTL (mirror differs if 0 is written)
 class gen_pkt_cfg_reg extends uvm_reg;
  `uvm_object_utils(gen_pkt_cfg_reg)

  rand uvm_reg_field rsvd_hi;
  rand uvm_reg_field seed;
  rand uvm_reg_field length;
  rand uvm_reg_field rsvd_lo;
  rand uvm_reg_field src_port;
  rand uvm_reg_field dst_port;

  covergroup seed_cg;
    seed_cp: coverpoint seed.value[7:0] {
      bins zero = {8'h00};
      bins low = {[8'h01:8'h3F]};
      bins mid = {[8'h40:8'hBF]};
      bins high = {[8'hC0:8'hFF]};
    }
  endgroup

covergroup length_cg;
  length_cp: coverpoint length.value[7:0] {
    bins zero_requested = {8'h00};
    bins small1 = {[8'h01:8'h10]};
    bins above_limit = {[8'h11:8'hFF]};
  }
endgroup

  covergroup src_port_cg;
    src_port_cp: coverpoint src_port.value[1:0] {
      bins port0 = {2'd0};
      bins port1 = {2'd1};
      bins port2 = {2'd2};
      bins port3 = {2'd3};
    }
  endgroup

  covergroup dst_port_cg;
    dst_port_cp: coverpoint dst_port.value[1:0] {
      bins port0 = {2'd0};
      bins port1 = {2'd1};
      bins port2 = {2'd2};
      bins port3 = {2'd3};
    }
  endgroup

  function new(string name = "gen_pkt_cfg_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);

    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      seed_cg = new();
      length_cg = new();
      src_port_cg = new();
      dst_port_cg = new();
    end
  endfunction

  virtual function void build();
    rsvd_hi = uvm_reg_field::type_id::create("rsvd_hi");
    rsvd_hi.configure(this, 8, 24, "RO", 0, 0, 1, 1, 1);

    seed = uvm_reg_field::type_id::create("seed");
    seed.configure(this, 8, 16, "RW", 0, 0, 1, 1, 1);

    length = uvm_reg_field::type_id::create("length");
    length.configure(this, 8, 8, "RW", 0, 4, 1, 1, 1);

    rsvd_lo = uvm_reg_field::type_id::create("rsvd_lo");
    rsvd_lo.configure(this, 4, 4, "RO", 0, 0, 1, 1, 1);

    src_port = uvm_reg_field::type_id::create("src_port");
    src_port.configure(this, 2, 2, "RW", 0, 0, 1, 1, 1);

    dst_port = uvm_reg_field::type_id::create("dst_port");
    dst_port.configure(this, 2, 0, "RW", 0, 1, 1, 1, 1);
  endfunction

  virtual function void sample(uvm_reg_data_t data,
                               uvm_reg_data_t byte_en,
                               bit is_read,
                               uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);

    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      seed_cg.sample();
      length_cg.sample();
      src_port_cg.sample();
      dst_port_cg.sample();
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();

    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      seed_cg.sample();
      length_cg.sample();
      src_port_cg.sample();
      dst_port_cg.sample();
    end
  endfunction

endclass

  // 0x34 GEN_INTERVAL
class gen_interval_reg extends uvm_reg;
  `uvm_object_utils(gen_interval_reg)

  rand uvm_reg_field rsvd;
  rand uvm_reg_field interval;

  covergroup interval_cg;
    interval_cp: coverpoint interval.value[15:0] {
      bins zero = {16'h0000};
      bins small1 = {[16'h0001:16'h000A]};
      bins medium1 = {[16'h000B:16'h0064]};
      bins large1 = {[16'h0065:16'hFFFF]};
    }
  endgroup

  function new(string name = "gen_interval_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);

    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      interval_cg = new();
    end
  endfunction

  virtual function void build();
    rsvd = uvm_reg_field::type_id::create("rsvd");
    rsvd.configure(this, 16, 16, "RO", 0, 0, 1, 1, 1);

    interval = uvm_reg_field::type_id::create("interval");
    interval.configure(this, 16, 0, "RW", 0, 2, 1, 1, 1);
  endfunction

  virtual function void sample(uvm_reg_data_t data,
                               uvm_reg_data_t byte_en,
                               bit is_read,
                               uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);

    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      interval_cg.sample();
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();

    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      interval_cg.sample();
    end
  endfunction

endclass

  // 0x38 GEN_COUNT
 class gen_count_reg extends uvm_reg;
  `uvm_object_utils(gen_count_reg)

  rand uvm_reg_field rsvd;
  rand uvm_reg_field packet_count;

  covergroup packet_count_cg;
    packet_count_cp: coverpoint packet_count.value[15:0] {
      bins zero = {16'h0000};
      bins one_packet = {16'h0001};
      bins small_count = {[16'h0002:16'h0004]};
      bins medium_count = {[16'h0005:16'h0064]};
      bins large_count = {[16'h0065:16'hFFFF]};
    }
  endgroup

  function new(string name = "gen_count_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);

    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      packet_count_cg = new();
    end
  endfunction

  virtual function void build();
    rsvd = uvm_reg_field::type_id::create("rsvd");
    rsvd.configure(this, 16, 16, "RO", 0, 0, 1, 1, 1);

    packet_count = uvm_reg_field::type_id::create("packet_count");
    packet_count.configure(this, 16, 0, "RW", 0, 4, 1, 1, 1);
  endfunction

  virtual function void sample(uvm_reg_data_t data,
                               uvm_reg_data_t byte_en,
                               bit is_read,
                               uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);

    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      packet_count_cg.sample();
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();

    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      packet_count_cg.sample();
    end
  endfunction

endclass

  // 0x3C IRQ_STATUS
class irq_status_reg extends uvm_reg;
  `uvm_object_utils(irq_status_reg)

  rand uvm_reg_field rsvd;
  rand uvm_reg_field sw_event;
  rand uvm_reg_field start_ack;
  rand uvm_reg_field queue_almost_full;
  rand uvm_reg_field packet_forwarded;
  rand uvm_reg_field packet_dropped;
  rand uvm_reg_field queue_overflow;
  rand uvm_reg_field error;
  rand uvm_reg_field gen_done;

  covergroup sw_event_cg;
    sw_event_cp: coverpoint sw_event.value[0] {
      bins inactive = {0};
      bins active = {1};
    }
  endgroup

  covergroup start_ack_cg;
    start_ack_cp: coverpoint start_ack.value[0] {
      bins inactive = {0};
      bins active = {1};
    }
  endgroup

  covergroup queue_almost_full_cg;
    queue_almost_full_cp: coverpoint queue_almost_full.value[0] {
      bins inactive = {0};
      bins active = {1};
    }
  endgroup

  covergroup packet_forwarded_cg;
    packet_forwarded_cp: coverpoint packet_forwarded.value[0] {
      bins inactive = {0};
      bins active = {1};
    }
  endgroup

  covergroup packet_dropped_cg;
    packet_dropped_cp: coverpoint packet_dropped.value[0] {
      bins inactive = {0};
      bins active = {1};
    }
  endgroup

  covergroup queue_overflow_cg;
    queue_overflow_cp: coverpoint queue_overflow.value[0] {
      bins inactive = {0};
      bins active = {1};
    }
  endgroup

  covergroup error_cg;
    error_cp: coverpoint error.value[0] {
      bins inactive = {0};
      bins active = {1};
    }
  endgroup

  covergroup gen_done_cg;
    gen_done_cp: coverpoint gen_done.value[0] {
      bins inactive = {0};
      bins active = {1};
    }
  endgroup

  function new(string name = "irq_status_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);

    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      sw_event_cg = new();
      start_ack_cg = new();
      queue_almost_full_cg = new();
      packet_forwarded_cg = new();
      packet_dropped_cg = new();
      queue_overflow_cg = new();
      error_cg = new();
      gen_done_cg = new();
    end
  endfunction

  virtual function void build();
    rsvd = uvm_reg_field::type_id::create("rsvd");
    rsvd.configure(this, 24, 8, "RO", 0, 0, 1, 1, 1);

    sw_event = uvm_reg_field::type_id::create("sw_event");
    sw_event.configure(this, 1, 7, "W1C", 1, 0, 1, 1, 1);

    start_ack = uvm_reg_field::type_id::create("start_ack");
    start_ack.configure(this, 1, 6, "W1C", 1, 0, 1, 1, 1);

    queue_almost_full = uvm_reg_field::type_id::create("queue_almost_full");
    queue_almost_full.configure(this, 1, 5, "W1C", 1, 0, 1, 1, 1);

    packet_forwarded = uvm_reg_field::type_id::create("packet_forwarded");
    packet_forwarded.configure(this, 1, 4, "W1C", 1, 0, 1, 1, 1);

    packet_dropped = uvm_reg_field::type_id::create("packet_dropped");
    packet_dropped.configure(this, 1, 3, "W1C", 1, 0, 1, 1, 1);

    queue_overflow = uvm_reg_field::type_id::create("queue_overflow");
    queue_overflow.configure(this, 1, 2, "W1C", 1, 0, 1, 1, 1);

    error = uvm_reg_field::type_id::create("error");
    error.configure(this, 1, 1, "W1C", 1, 0, 1, 1, 1);

    gen_done = uvm_reg_field::type_id::create("gen_done");
    gen_done.configure(this, 1, 0, "W1C", 1, 0, 1, 1, 1);
  endfunction

  virtual function void sample(uvm_reg_data_t data,
                               uvm_reg_data_t byte_en,
                               bit is_read,
                               uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);

    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      sw_event_cg.sample();
      start_ack_cg.sample();
      queue_almost_full_cg.sample();
      packet_forwarded_cg.sample();
      packet_dropped_cg.sample();
      queue_overflow_cg.sample();
      error_cg.sample();
      gen_done_cg.sample();
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();

    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      sw_event_cg.sample();
      start_ack_cg.sample();
      queue_almost_full_cg.sample();
      packet_forwarded_cg.sample();
      packet_dropped_cg.sample();
      queue_overflow_cg.sample();
      error_cg.sample();
      gen_done_cg.sample();
    end
  endfunction

endclass 


  // 0x40 IRQ_ENABLE
 class irq_enable_reg extends uvm_reg;
  `uvm_object_utils(irq_enable_reg)

  rand uvm_reg_field rsvd;
  rand uvm_reg_field sw_event_en;
  rand uvm_reg_field start_ack_en;
  rand uvm_reg_field queue_af_en;
  rand uvm_reg_field packet_fwd_en;
  rand uvm_reg_field packet_drop_en;
  rand uvm_reg_field overflow_en;
  rand uvm_reg_field error_en;
  rand uvm_reg_field gen_done_en;

  covergroup sw_event_en_cg;
    sw_event_en_cp: coverpoint sw_event_en.value[0] {
      bins disabled = {0};
      bins enabled = {1};
    }
  endgroup

  covergroup start_ack_en_cg;
    start_ack_en_cp: coverpoint start_ack_en.value[0] {
      bins disabled = {0};
      bins enabled = {1};
    }
  endgroup

  covergroup queue_af_en_cg;
    queue_af_en_cp: coverpoint queue_af_en.value[0] {
      bins disabled = {0};
      bins enabled = {1};
    }
  endgroup

  covergroup packet_fwd_en_cg;
    packet_fwd_en_cp: coverpoint packet_fwd_en.value[0] {
      bins disabled = {0};
      bins enabled = {1};
    }
  endgroup

  covergroup packet_drop_en_cg;
    packet_drop_en_cp: coverpoint packet_drop_en.value[0] {
      bins disabled = {0};
      bins enabled = {1};
    }
  endgroup

  covergroup overflow_en_cg;
    overflow_en_cp: coverpoint overflow_en.value[0] {
      bins disabled = {0};
      bins enabled = {1};
    }
  endgroup

  covergroup error_en_cg;
    error_en_cp: coverpoint error_en.value[0] {
      bins disabled = {0};
      bins enabled = {1};
    }
  endgroup

  covergroup gen_done_en_cg;
    gen_done_en_cp: coverpoint gen_done_en.value[0] {
      bins disabled = {0};
      bins enabled = {1};
    }
  endgroup

  function new(string name = "irq_enable_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);

    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      sw_event_en_cg = new();
      start_ack_en_cg = new();
      queue_af_en_cg = new();
      packet_fwd_en_cg = new();
      packet_drop_en_cg = new();
      overflow_en_cg = new();
      error_en_cg = new();
      gen_done_en_cg = new();
    end
  endfunction

  virtual function void build();
    rsvd = uvm_reg_field::type_id::create("rsvd");
    rsvd.configure(this, 24, 8, "RO", 0, 0, 1, 1, 1);

    sw_event_en = uvm_reg_field::type_id::create("sw_event_en");
    sw_event_en.configure(this, 1, 7, "RW", 0, 0, 1, 1, 1);

    start_ack_en = uvm_reg_field::type_id::create("start_ack_en");
    start_ack_en.configure(this, 1, 6, "RW", 0, 0, 1, 1, 1);

    queue_af_en = uvm_reg_field::type_id::create("queue_af_en");
    queue_af_en.configure(this, 1, 5, "RW", 0, 0, 1, 1, 1);

    packet_fwd_en = uvm_reg_field::type_id::create("packet_fwd_en");
    packet_fwd_en.configure(this, 1, 4, "RW", 0, 0, 1, 1, 1);

    packet_drop_en = uvm_reg_field::type_id::create("packet_drop_en");
    packet_drop_en.configure(this, 1, 3, "RW", 0, 0, 1, 1, 1);

    overflow_en = uvm_reg_field::type_id::create("overflow_en");
    overflow_en.configure(this, 1, 2, "RW", 0, 0, 1, 1, 1);

    error_en = uvm_reg_field::type_id::create("error_en");
    error_en.configure(this, 1, 1, "RW", 0, 0, 1, 1, 1);

    gen_done_en = uvm_reg_field::type_id::create("gen_done_en");
    gen_done_en.configure(this, 1, 0, "RW", 0, 0, 1, 1, 1);
  endfunction

  virtual function void sample(uvm_reg_data_t data,
                               uvm_reg_data_t byte_en,
                               bit is_read,
                               uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);

    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      sw_event_en_cg.sample();
      start_ack_en_cg.sample();
      queue_af_en_cg.sample();
      packet_fwd_en_cg.sample();
      packet_drop_en_cg.sample();
      overflow_en_cg.sample();
      error_en_cg.sample();
      gen_done_en_cg.sample();
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();

    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      sw_event_en_cg.sample();
      start_ack_en_cg.sample();
      queue_af_en_cg.sample();
      packet_fwd_en_cg.sample();
      packet_drop_en_cg.sample();
      overflow_en_cg.sample();
      error_en_cg.sample();
      gen_done_en_cg.sample();
    end
  endfunction

endclass


  // 0x44 IRQ_FORCE
class irq_force_reg extends uvm_reg;
  `uvm_object_utils(irq_force_reg)

  rand uvm_reg_field rsvd;
  rand uvm_reg_field force_bits;

  covergroup force_bits_cg;
    force_bits_cp: coverpoint force_bits.value[7:0] {
      bins none = {8'h00};
      bins gen_done = {8'h01};
      bins error = {8'h02};
      bins overflow = {8'h04};
      bins queue_overflow = {8'h08};
      bins packet_drop = {8'h10};
      bins packet_forwarded = {8'h20};
      bins start_ack = {8'h40};
      bins sw_event = {8'h80};
      bins multiple_bits = {8'h03, 8'h05, 8'h06, 8'h07,
                            [8'h09:8'h7F], [8'h81:8'hFF]};
    }
  endgroup

  function new(string name = "irq_force_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);

    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      force_bits_cg = new();
    end
  endfunction

  virtual function void build();
    rsvd = uvm_reg_field::type_id::create("rsvd");
    rsvd.configure(this, 24, 8, "RO", 0, 0, 1, 1, 1);

    force_bits = uvm_reg_field::type_id::create("force_bits");
    force_bits.configure(this, 8, 0, "WO", 0, 0, 1, 1, 1);
  endfunction

  virtual function void sample(uvm_reg_data_t data,
                               uvm_reg_data_t byte_en,
                               bit is_read,
                               uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);

    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      force_bits_cg.sample();
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();

    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      force_bits_cg.sample();
    end
  endfunction

endclass



  // 0x48 ERR_STATUS
 class err_status_reg extends uvm_reg;
  `uvm_object_utils(err_status_reg)

  rand uvm_reg_field rsvd;
  rand uvm_reg_field injected;
  rand uvm_reg_field length_error;
  rand uvm_reg_field crc_error;
  rand uvm_reg_field protocol_error;
  rand uvm_reg_field undersize;
  rand uvm_reg_field queue_overflow;
  rand uvm_reg_field dest_error;
  rand uvm_reg_field bus_error;

  covergroup injected_cg;
    injected_cp: coverpoint injected.value[0] {
      bins inactive = {0};
      bins active = {1};
    }
  endgroup

  covergroup length_error_cg;
    length_error_cp: coverpoint length_error.value[0] {
      bins inactive = {0};
      bins active = {1};
    }
  endgroup

  covergroup crc_error_cg;
    crc_error_cp: coverpoint crc_error.value[0] {
      bins inactive = {0};
      bins active = {1};
    }
  endgroup

  covergroup protocol_error_cg;
    protocol_error_cp: coverpoint protocol_error.value[0] {
      bins inactive = {0};
      bins active = {1};
    }
  endgroup

  covergroup undersize_cg;
    undersize_cp: coverpoint undersize.value[0] {
      bins inactive = {0};
      bins active = {1};
    }
  endgroup

  covergroup queue_overflow_cg;
    queue_overflow_cp: coverpoint queue_overflow.value[0] {
      bins inactive = {0};
      bins active = {1};
    }
  endgroup

  covergroup dest_error_cg;
    dest_error_cp: coverpoint dest_error.value[0] {
      bins inactive = {0};
      bins active = {1};
    }
  endgroup

  covergroup bus_error_cg;
    bus_error_cp: coverpoint bus_error.value[0] {
      bins inactive = {0};
      bins active = {1};
    }
  endgroup

  function new(string name = "err_status_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);

    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      injected_cg = new();
      length_error_cg = new();
      crc_error_cg = new();
      protocol_error_cg = new();
      undersize_cg = new();
      queue_overflow_cg = new();
      dest_error_cg = new();
      bus_error_cg = new();
    end
  endfunction

  virtual function void build();
    rsvd = uvm_reg_field::type_id::create("rsvd");
    rsvd.configure(this, 24, 8, "RO", 0, 0, 1, 1, 1);

    injected = uvm_reg_field::type_id::create("injected");
    injected.configure(this, 1, 7, "W1C", 1, 0, 1, 1, 1);

    length_error = uvm_reg_field::type_id::create("length_error");
    length_error.configure(this, 1, 6, "W1C", 1, 0, 1, 1, 1);

    crc_error = uvm_reg_field::type_id::create("crc_error");
    crc_error.configure(this, 1, 5, "W1C", 1, 0, 1, 1, 1);

    protocol_error = uvm_reg_field::type_id::create("protocol_error");
    protocol_error.configure(this, 1, 4, "W1C", 1, 0, 1, 1, 1);

    undersize = uvm_reg_field::type_id::create("undersize");
    undersize.configure(this, 1, 3, "W1C", 1, 0, 1, 1, 1);

    queue_overflow = uvm_reg_field::type_id::create("queue_overflow");
    queue_overflow.configure(this, 1, 2, "W1C", 1, 0, 1, 1, 1);

    dest_error = uvm_reg_field::type_id::create("dest_error");
    dest_error.configure(this, 1, 1, "W1C", 1, 0, 1, 1, 1);

    bus_error = uvm_reg_field::type_id::create("bus_error");
    bus_error.configure(this, 1, 0, "W1C", 1, 0, 1, 1, 1);
  endfunction

  virtual function void sample(uvm_reg_data_t data,
                               uvm_reg_data_t byte_en,
                               bit is_read,
                               uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);

    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      injected_cg.sample();
      length_error_cg.sample();
      crc_error_cg.sample();
      protocol_error_cg.sample();
      undersize_cg.sample();
      queue_overflow_cg.sample();
      dest_error_cg.sample();
      bus_error_cg.sample();
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();

    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      injected_cg.sample();
      length_error_cg.sample();
      crc_error_cg.sample();
      protocol_error_cg.sample();
      undersize_cg.sample();
      queue_overflow_cg.sample();
      dest_error_cg.sample();
      bus_error_cg.sample();
    end
  endfunction

endclass

  // 0x4C ERR_ENABLE
class err_enable_reg extends uvm_reg;
  `uvm_object_utils(err_enable_reg)

  rand uvm_reg_field rsvd;
  rand uvm_reg_field injected_en;
  rand uvm_reg_field length_en;
  rand uvm_reg_field crc_en;
  rand uvm_reg_field protocol_en;
  rand uvm_reg_field undersize_en;
  rand uvm_reg_field overflow_en;
  rand uvm_reg_field dest_en;
  rand uvm_reg_field bus_en;

  covergroup injected_en_cg;
    injected_en_cp: coverpoint injected_en.value[0] {
      bins disabled = {0};
      bins enabled = {1};
    }
  endgroup

  covergroup length_en_cg;
    length_en_cp: coverpoint length_en.value[0] {
      bins disabled = {0};
      bins enabled = {1};
    }
  endgroup

  covergroup crc_en_cg;
    crc_en_cp: coverpoint crc_en.value[0] {
      bins disabled = {0};
      bins enabled = {1};
    }
  endgroup

  covergroup protocol_en_cg;
    protocol_en_cp: coverpoint protocol_en.value[0] {
      bins disabled = {0};
      bins enabled = {1};
    }
  endgroup

  covergroup undersize_en_cg;
    undersize_en_cp: coverpoint undersize_en.value[0] {
      bins disabled = {0};
      bins enabled = {1};
    }
  endgroup

  covergroup overflow_en_cg;
    overflow_en_cp: coverpoint overflow_en.value[0] {
      bins disabled = {0};
      bins enabled = {1};
    }
  endgroup

  covergroup dest_en_cg;
    dest_en_cp: coverpoint dest_en.value[0] {
      bins disabled = {0};
      bins enabled = {1};
    }
  endgroup

  covergroup bus_en_cg;
    bus_en_cp: coverpoint bus_en.value[0] {
      bins disabled = {0};
      bins enabled = {1};
    }
  endgroup

  function new(string name = "err_enable_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);

    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      injected_en_cg = new();
      length_en_cg = new();
      crc_en_cg = new();
      protocol_en_cg = new();
      undersize_en_cg = new();
      overflow_en_cg = new();
      dest_en_cg = new();
      bus_en_cg = new();
    end
  endfunction

  virtual function void build();
    rsvd = uvm_reg_field::type_id::create("rsvd");
    rsvd.configure(this, 24, 8, "RO", 0, 0, 1, 1, 1);

    injected_en = uvm_reg_field::type_id::create("injected_en");
    injected_en.configure(this, 1, 7, "RW", 0, 0, 1, 1, 1);

    length_en = uvm_reg_field::type_id::create("length_en");
    length_en.configure(this, 1, 6, "RW", 0, 0, 1, 1, 1);

    crc_en = uvm_reg_field::type_id::create("crc_en");
    crc_en.configure(this, 1, 5, "RW", 0, 0, 1, 1, 1);

    protocol_en = uvm_reg_field::type_id::create("protocol_en");
    protocol_en.configure(this, 1, 4, "RW", 0, 0, 1, 1, 1);

    undersize_en = uvm_reg_field::type_id::create("undersize_en");
    undersize_en.configure(this, 1, 3, "RW", 0, 0, 1, 1, 1);

    overflow_en = uvm_reg_field::type_id::create("overflow_en");
    overflow_en.configure(this, 1, 2, "RW", 0, 0, 1, 1, 1);

    dest_en = uvm_reg_field::type_id::create("dest_en");
    dest_en.configure(this, 1, 1, "RW", 0, 0, 1, 1, 1);

    bus_en = uvm_reg_field::type_id::create("bus_en");
    bus_en.configure(this, 1, 0, "RW", 0, 0, 1, 1, 1);
  endfunction

  virtual function void sample(uvm_reg_data_t data,
                               uvm_reg_data_t byte_en,
                               bit is_read,
                               uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);

    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      injected_en_cg.sample();
      length_en_cg.sample();
      crc_en_cg.sample();
      protocol_en_cg.sample();
      undersize_en_cg.sample();
      overflow_en_cg.sample();
      dest_en_cg.sample();
      bus_en_cg.sample();
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();

    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      injected_en_cg.sample();
      length_en_cg.sample();
      crc_en_cg.sample();
      protocol_en_cg.sample();
      undersize_en_cg.sample();
      overflow_en_cg.sample();
      dest_en_cg.sample();
      bus_en_cg.sample();
    end
  endfunction

endclass

  // 0x50 ERR_INJECT
class err_inject_reg extends uvm_reg;
  `uvm_object_utils(err_inject_reg)

  rand uvm_reg_field clear_count;
  rand uvm_reg_field rsvd;
  rand uvm_reg_field injected;
  rand uvm_reg_field length;
  rand uvm_reg_field crc;
  rand uvm_reg_field protocol;
  rand uvm_reg_field undersize;
  rand uvm_reg_field overflow;
  rand uvm_reg_field dest;
  rand uvm_reg_field bus;

  covergroup clear_count_cg;
    clear_count_cp: coverpoint clear_count.value[0] {
      bins not_cleared = {0};
      bins cleared = {1};
    }
  endgroup

  covergroup injected_cg;
    injected_cp: coverpoint injected.value[0] {
      bins inactive = {0};
      bins active = {1};
    }
  endgroup

  covergroup length_cg;
    length_cp: coverpoint length.value[0] {
      bins inactive = {0};
      bins active = {1};
    }
  endgroup

  covergroup crc_cg;
    crc_cp: coverpoint crc.value[0] {
      bins inactive = {0};
      bins active = {1};
    }
  endgroup

  covergroup protocol_cg;
    protocol_cp: coverpoint protocol.value[0] {
      bins inactive = {0};
      bins active = {1};
    }
  endgroup

  covergroup undersize_cg;
    undersize_cp: coverpoint undersize.value[0] {
      bins inactive = {0};
      bins active = {1};
    }
  endgroup

  covergroup overflow_cg;
    overflow_cp: coverpoint overflow.value[0] {
      bins inactive = {0};
      bins active = {1};
    }
  endgroup

  covergroup dest_cg;
    dest_cp: coverpoint dest.value[0] {
      bins inactive = {0};
      bins active = {1};
    }
  endgroup

  covergroup bus_cg;
    bus_cp: coverpoint bus.value[0] {
      bins inactive = {0};
      bins active = {1};
    }
  endgroup

  function new(string name = "err_inject_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);

    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      clear_count_cg = new();
      injected_cg = new();
      length_cg = new();
      crc_cg = new();
      protocol_cg = new();
      undersize_cg = new();
      overflow_cg = new();
      dest_cg = new();
      bus_cg = new();
    end
  endfunction

  virtual function void build();
    clear_count = uvm_reg_field::type_id::create("clear_count");
    clear_count.configure(this, 1, 31, "WO", 0, 0, 1, 1, 1);

    rsvd = uvm_reg_field::type_id::create("rsvd");
    rsvd.configure(this, 23, 8, "RO", 0, 0, 1, 1, 1);

    injected = uvm_reg_field::type_id::create("injected");
    injected.configure(this, 1, 7, "WO", 0, 0, 1, 1, 1);

    length = uvm_reg_field::type_id::create("length");
    length.configure(this, 1, 6, "WO", 0, 0, 1, 1, 1);

    crc = uvm_reg_field::type_id::create("crc");
    crc.configure(this, 1, 5, "WO", 0, 0, 1, 1, 1);

    protocol = uvm_reg_field::type_id::create("protocol");
    protocol.configure(this, 1, 4, "WO", 0, 0, 1, 1, 1);

    undersize = uvm_reg_field::type_id::create("undersize");
    undersize.configure(this, 1, 3, "WO", 0, 0, 1, 1, 1);

    overflow = uvm_reg_field::type_id::create("overflow");
    overflow.configure(this, 1, 2, "WO", 0, 0, 1, 1, 1);

    dest = uvm_reg_field::type_id::create("dest");
    dest.configure(this, 1, 1, "WO", 0, 0, 1, 1, 1);

    bus = uvm_reg_field::type_id::create("bus");
    bus.configure(this, 1, 0, "WO", 0, 0, 1, 1, 1);
  endfunction

  virtual function void sample(uvm_reg_data_t data,
                               uvm_reg_data_t byte_en,
                               bit is_read,
                               uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);

    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      clear_count_cg.sample();
      injected_cg.sample();
      length_cg.sample();
      crc_cg.sample();
      protocol_cg.sample();
      undersize_cg.sample();
      overflow_cg.sample();
      dest_cg.sample();
      bus_cg.sample();
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();

    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      clear_count_cg.sample();
      injected_cg.sample();
      length_cg.sample();
      crc_cg.sample();
      protocol_cg.sample();
      undersize_cg.sample();
      overflow_cg.sample();
      dest_cg.sample();
      bus_cg.sample();
    end
  endfunction

endclass

  // 0x54 ERR_COUNT
 class err_count_reg extends uvm_reg;
  `uvm_object_utils(err_count_reg)

  rand uvm_reg_field rsvd;
  rand uvm_reg_field error_count;

  covergroup error_count_cg;
    error_count_cp: coverpoint error_count.value[15:0] {
      bins zero = {16'h0000};
      bins other_count = {[16'h0001:16'hFFFF]};
    }
  endgroup

  function new(string name = "err_count_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);

    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      error_count_cg = new();
    end
  endfunction

  virtual function void build();
    rsvd = uvm_reg_field::type_id::create("rsvd");
    rsvd.configure(this, 16, 16, "RO", 0, 0, 1, 1, 1);

    error_count = uvm_reg_field::type_id::create("error_count");
    error_count.configure(this, 16, 0, "RO", 1, 0, 1, 1, 1);
  endfunction

  virtual function void sample(uvm_reg_data_t data,
                               uvm_reg_data_t byte_en,
                               bit is_read,
                               uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);

    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      error_count_cg.sample();
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();

    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      error_count_cg.sample();
    end
  endfunction

endclass

  // 0x58 ERR_INFO
 class err_info_reg extends uvm_reg;
  `uvm_object_utils(err_info_reg)

  rand uvm_reg_field tx_snapshot;
  rand uvm_reg_field rsvd;
  rand uvm_reg_field dest_port;
  rand uvm_reg_field source;
  rand uvm_reg_field last_code;


  covergroup tx_snapshot_cg;
    tx_snapshot_cp: coverpoint tx_snapshot.value[11:0] {
      bins zero = {12'h000};
      bins non_zero = {[12'h001:12'hFFF]};
    }
  endgroup

  covergroup dest_port_cg;
  dest_port_cp: coverpoint dest_port.value[1:0] {
      bins port0_1 = {2'd0, 2'd1};
      bins port2_3 = {2'd2, 2'd3};
    }
  endgroup
  
covergroup source_cg;
    source_cp: coverpoint source.value[7:0] {
      bins zero = {8'h00};
      bins low = {[8'h01:8'h3F]};
    }
  endgroup

  covergroup last_code_cg;
    last_code_cp: coverpoint last_code.value[7:0] {
      bins zero = {8'h00};
      bins low = {[8'h01:8'h3F]};
    }
  endgroup

  function new(string name = "err_info_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);

    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      tx_snapshot_cg = new();
      dest_port_cg = new();
      source_cg = new();
      last_code_cg = new();
    end
  endfunction

  virtual function void build();
    tx_snapshot = uvm_reg_field::type_id::create("tx_snapshot");
    tx_snapshot.configure(this, 12, 20, "RO", 1, 0, 1, 1, 1);

    rsvd = uvm_reg_field::type_id::create("rsvd");
    rsvd.configure(this, 2, 18, "RO", 0, 0, 1, 1, 1);

    dest_port = uvm_reg_field::type_id::create("dest_port");
    dest_port.configure(this, 2, 16, "RO", 1, 0, 1, 1, 1);

    source = uvm_reg_field::type_id::create("source");
    source.configure(this, 8, 8, "RO", 1, 0, 1, 1, 1);

    last_code = uvm_reg_field::type_id::create("last_code");
    last_code.configure(this, 8, 0, "RO", 1, 0, 1, 1, 1);
  endfunction

  virtual function void sample(uvm_reg_data_t data,
                               uvm_reg_data_t byte_en,
                               bit is_read,
                               uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);

    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
 tx_snapshot_cg.sample();
      dest_port_cg.sample();
      source_cg.sample();
      last_code_cg.sample();
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();

    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      tx_snapshot_cg.sample();
      dest_port_cg.sample();
      source_cg.sample();
      last_code_cg.sample();
    end
  endfunction

endclass


  // 0x5C LOCK
  // NOTE: writing the full 32-bit key 32'hA5A5C3C3 unlocks, any other value locks.
  // LOCKED is RO/volatile: check it with a read/peek, not the mirror.
 class lock_reg extends uvm_reg;
  `uvm_object_utils(lock_reg)

  rand uvm_reg_field key;
  rand uvm_reg_field locked;

  covergroup key_cg;
    key_cp: coverpoint key.value[30:0] {
      bins zero = {31'h00000000};
      bins unlock_key = {31'h52D2E1E1};
      bins other_value = default;
    }
  endgroup

  covergroup locked_cg;
    locked_cp: coverpoint locked.value[0] {
      bins locked = {1'b1};
      bins unlocked = {1'b0};
    }
  endgroup

  function new(string name = "lock_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      key_cg = new();
      locked_cg = new();
    end
  endfunction

  virtual function void build();
    key = uvm_reg_field::type_id::create("key");
    key.configure(this, 31, 1, "WO", 0, 0, 1, 1, 1);

    locked = uvm_reg_field::type_id::create("locked");
    locked.configure(this, 1, 0, "RO", 1, 1, 1, 1, 1);
  endfunction

  virtual function void sample(uvm_reg_data_t data,
                               uvm_reg_data_t byte_en,
                               bit is_read,
                               uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      key_cg.sample();
      locked_cg.sample();
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      key_cg.sample();
      locked_cg.sample();
    end
  endfunction
endclass

  // 0x60 SOFT_RESET
 class soft_reset_reg extends uvm_reg;
  `uvm_object_utils(soft_reset_reg)

  rand uvm_reg_field rsvd;
  rand uvm_reg_field pulse;

  covergroup pulse_cg;
    pulse_cp: coverpoint pulse.value[0] {
      bins inactive = {1'b0};
      bins active = {1'b1};
    }
  endgroup

  function new(string name = "soft_reset_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      pulse_cg = new();
    end
  endfunction

  virtual function void build();
    rsvd = uvm_reg_field::type_id::create("rsvd");
    rsvd.configure(this, 31, 1, "RO", 0, 0, 1, 1, 1);

    pulse = uvm_reg_field::type_id::create("pulse");
    pulse.configure(this, 1, 0, "WO", 0, 0, 1, 1, 1);
  endfunction

  virtual function void sample(uvm_reg_data_t data,
                               uvm_reg_data_t byte_en,
                               bit is_read,
                               uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      pulse_cg.sample();
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      pulse_cg.sample();
    end
  endfunction
endclass
