
class packet_subscriber extends uvm_component;
  `uvm_component_utils(packet_subscriber)

  uvm_analysis_imp #(packet_seq_item, packet_subscriber) subscrb_port;

  packet_seq_item cov_item;

  real item_cov;

  covergroup cg;
    option.per_instance = 1;

    pwrite_cp : coverpoint cov_item.pwrite {
      bins read  = {0};
      bins write = {1};
    }

    paddr_cp : coverpoint cov_item.paddr {
      bins device_id     = {16'h0000};
      bins version       = {16'h0004};
      bins switch_status = {16'h0008};
      bins port_status   = {16'h000C};
      bins gen_status    = {16'h0010};
      bins stat_rx       = {16'h0014};
      bins stat_tx       = {16'h0018};
      bins stat_drop     = {16'h001C};
      bins switch_ctrl   = {16'h0020};
      bins port_enable   = {16'h0024};
      bins fwd_enable    = {16'h0028};
      bins gen_ctrl      = {16'h002C};
      bins gen_pkt_cfg   = {16'h0030};
      bins gen_interval  = {16'h0034};
      bins gen_count     = {16'h0038};
      bins irq_status    = {16'h003C};
      bins irq_enable    = {16'h0040};
      bins irq_force     = {16'h0044};
      bins err_status    = {16'h0048};
      bins err_enable    = {16'h004C};
      bins err_inject    = {16'h0050};
      bins err_count     = {16'h0054};
      bins err_info      = {16'h0058};
      bins lock          = {16'h005C};
      bins soft_reset    = {16'h0060};
      bins invalid_addr  = default;
    }

    pwdata_cp : coverpoint cov_item.pwdata iff (cov_item.pwrite) {
      bins zero      = {32'h00000000};
      bins all_ones  = {32'hFFFFFFFF};
      bins other_data = default;
    }

    prdata_cp : coverpoint cov_item.prdata iff (!cov_item.pwrite) {
      bins zero       = {32'h00000000};
      bins other_data = default;
    }

    pslverr_cp : coverpoint cov_item.pslverr {
      bins no_error = {0};
      bins error    = {1};
    }

    access_cross : cross pwrite_cp, paddr_cp;
  endgroup

  function new(string name = "packet_subscriber",
               uvm_component parent);
    super.new(name, parent);
    cg = new();
    subscrb_port = new("subscrb_port", this);
  endfunction

  function void write(packet_seq_item t);
    cov_item = t;
    cg.sample();
  endfunction

  function void extract_phase(uvm_phase phase);
    super.extract_phase(phase);
    item_cov = cg.get_coverage();
  endfunction

  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(),
      $sformatf("APB Functional Coverage = %0.2f%%", item_cov),
      UVM_MEDIUM)
  endfunction

endclass

