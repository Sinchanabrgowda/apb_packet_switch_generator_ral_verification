class packet_test extends uvm_test;
  `uvm_component_utils(packet_test)
  
  packet_env pkt_e;
  packet_base_reg_seq pkt_reg_seq;
  
  function new(string name = "packet_test", uvm_component parent);
    super.new(name, parent);
  endfunction

function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.set_timeout(100000, 0);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    pkt_e = packet_env::type_id::create("pkt_e", this);
  endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    pkt_reg_seq = packet_base_reg_seq::type_id::create("pkt_reg_seq");
    pkt_reg_seq.pkt_regmodel = pkt_e.pkt_regmodel;
    pkt_reg_seq.start(pkt_e.pkt_agt.seqr);
    phase.drop_objection(this);
  endtask
  
endclass


//unlock test
class packet_unlock_test extends packet_test;
  `uvm_component_utils(packet_unlock_test)


  packet_unlock_reg_seq pkt_reg_seq;

  function new(string name = "packet_unlock_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction


  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    pkt_reg_seq = packet_unlock_reg_seq::type_id::create("pkt_reg_seq");
    pkt_reg_seq.pkt_regmodel = pkt_e.pkt_regmodel;
    pkt_reg_seq.start(pkt_e.pkt_agt.seqr);

    phase.drop_objection(this);
  endtask

endclass


//device_id  reset test
class packet_device_id_reg_test extends packet_test;
  `uvm_component_utils(packet_device_id_reg_test)

  packet_device_id_reg_seq device_id_seq;

  function new(string name = "packet_device_id_reg_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    device_id_seq = packet_device_id_reg_seq::type_id::create("device_id_seq");
    device_id_seq.pkt_regmodel = pkt_e.pkt_regmodel;
    device_id_seq.start(pkt_e.pkt_agt.seqr);

    phase.drop_objection(this);
  endtask

endclass


///////////////////////////////////////////////////////////////////
//version_id test

class packet_version_reg_test extends packet_test;
  `uvm_component_utils(packet_version_reg_test)

  packet_version_reg_seq version_seq;

  function new(string name = "packet_version_reg_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    version_seq = packet_version_reg_seq::type_id::create("version_seq");
    version_seq.pkt_regmodel = pkt_e.pkt_regmodel;
    version_seq.start(pkt_e.pkt_agt.seqr);

    phase.drop_objection(this);
  endtask

endclass


//////////////////////////////////////////////////////////////////
//switch_status test

class packet_switch_status_reg_test extends packet_test;
  `uvm_component_utils(packet_switch_status_reg_test)

  packet_switch_status_reg_seq switch_status_seq;

  function new(string name = "packet_switch_status_reg_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    switch_status_seq =
      packet_switch_status_reg_seq::type_id::create("switch_status_seq");

    switch_status_seq.pkt_regmodel = pkt_e.pkt_regmodel;
    switch_status_seq.start(pkt_e.pkt_agt.seqr);

    phase.drop_objection(this);
  endtask

endclass

///////////////////////////////////////////////////////////
//port_status 
class packet_port_status_reg_test extends packet_test;
  `uvm_component_utils(packet_port_status_reg_test)

  packet_port_status_reg_seq port_status_seq;

  function new(string name = "packet_port_status_reg_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    port_status_seq =
      packet_port_status_reg_seq::type_id::create("port_status_seq");

    port_status_seq.pkt_regmodel = pkt_e.pkt_regmodel;
    port_status_seq.start(pkt_e.pkt_agt.seqr);

    phase.drop_objection(this);
  endtask

endclass


///////////////////////////////////////////////////////////////
//gen_status

class packet_gen_status_reg_test extends packet_test;
  `uvm_component_utils(packet_gen_status_reg_test)

  packet_gen_status_reg_seq gen_status_seq;

  function new(string name = "packet_gen_status_reg_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    gen_status_seq =
      packet_gen_status_reg_seq::type_id::create("gen_status_seq");

    gen_status_seq.pkt_regmodel = pkt_e.pkt_regmodel;
    gen_status_seq.start(pkt_e.pkt_agt.seqr);

    phase.drop_objection(this);
  endtask

endclass


////////////////////////////////////////////////////////////
//stat_rx

class packet_stat_rx_reg_test extends packet_test;
  `uvm_component_utils(packet_stat_rx_reg_test)

  packet_stat_rx_reg_seq stat_rx_seq;

  function new(string name = "packet_stat_rx_reg_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    stat_rx_seq = packet_stat_rx_reg_seq::type_id::create("stat_rx_seq");
    stat_rx_seq.pkt_regmodel = pkt_e.pkt_regmodel;
    stat_rx_seq.start(pkt_e.pkt_agt.seqr);

    phase.drop_objection(this);
  endtask

endclass


/////////////////////////////////////////////////////
//stat_tx

class packet_stat_tx_reg_test extends packet_test;
  `uvm_component_utils(packet_stat_tx_reg_test)

  packet_stat_tx_reg_seq stat_tx_seq;

  function new(string name = "packet_stat_tx_reg_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    stat_tx_seq = packet_stat_tx_reg_seq::type_id::create("stat_tx_seq");
    stat_tx_seq.pkt_regmodel = pkt_e.pkt_regmodel;
    stat_tx_seq.start(pkt_e.pkt_agt.seqr);

    phase.drop_objection(this);
  endtask

endclass

/////////////////////////////////////////////////////////////
//stat_drop

class packet_stat_drop_reg_test extends packet_test;
  `uvm_component_utils(packet_stat_drop_reg_test)

  packet_stat_drop_reg_seq stat_drop_seq;

  function new(string name = "packet_stat_drop_reg_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    stat_drop_seq =
      packet_stat_drop_reg_seq::type_id::create("stat_drop_seq");

    stat_drop_seq.pkt_regmodel = pkt_e.pkt_regmodel;
    stat_drop_seq.start(pkt_e.pkt_agt.seqr);

    phase.drop_objection(this);
  endtask

endclass


////////////////////////////////////////////////////////////////////
//switch_control
class packet_switch_ctrl_reg_test extends packet_test;
  `uvm_component_utils(packet_switch_ctrl_reg_test)

  packet_switch_ctrl_reg_seq switch_ctrl_seq;

  function new(string name = "packet_switch_ctrl_reg_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    switch_ctrl_seq =
      packet_switch_ctrl_reg_seq::type_id::create("switch_ctrl_seq");

    switch_ctrl_seq.pkt_regmodel = pkt_e.pkt_regmodel;
    switch_ctrl_seq.start(pkt_e.pkt_agt.seqr);

    phase.drop_objection(this);
  endtask

endclass


////////////////////////////////////////////////////////////////////////////
//port_enable

class packet_port_enable_reg_test extends packet_test;
  `uvm_component_utils(packet_port_enable_reg_test)

  packet_port_enable_reg_seq port_enable_seq;

  function new(string name = "packet_port_enable_reg_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    port_enable_seq =
      packet_port_enable_reg_seq::type_id::create("port_enable_seq");

    port_enable_seq.pkt_regmodel = pkt_e.pkt_regmodel;
    port_enable_seq.start(pkt_e.pkt_agt.seqr);

    phase.drop_objection(this);
  endtask

endclass


////////////////////////////////////////////////////////////////////////
//fwd_enable

class packet_fwd_enable_reg_test extends packet_test;
  `uvm_component_utils(packet_fwd_enable_reg_test)

  packet_fwd_enable_reg_seq fwd_enable_seq;

  function new(string name = "packet_fwd_enable_reg_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    fwd_enable_seq =
      packet_fwd_enable_reg_seq::type_id::create("fwd_enable_seq");

    fwd_enable_seq.pkt_regmodel = pkt_e.pkt_regmodel;
    fwd_enable_seq.start(pkt_e.pkt_agt.seqr);

    phase.drop_objection(this);
  endtask

endclass


/////////////////////////////////////////////////////////////////////////
//gen_ctrl
class packet_gen_ctrl_reg_test extends packet_test;
  `uvm_component_utils(packet_gen_ctrl_reg_test)

  packet_gen_ctrl_reg_seq gen_ctrl_seq;

  function new(string name = "packet_gen_ctrl_reg_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    gen_ctrl_seq =
      packet_gen_ctrl_reg_seq::type_id::create("gen_ctrl_seq");

    gen_ctrl_seq.pkt_regmodel = pkt_e.pkt_regmodel;
    gen_ctrl_seq.start(pkt_e.pkt_agt.seqr);

    phase.drop_objection(this);
  endtask

endclass


/////////////////////////////////////////////////////////////
//gen_pkt_cfg
class packet_gen_pkt_cfg_reg_test extends packet_test;
  `uvm_component_utils(packet_gen_pkt_cfg_reg_test)

  packet_gen_pkt_cfg_reg_seq gen_pkt_cfg_seq;

  function new(string name = "packet_gen_pkt_cfg_reg_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    gen_pkt_cfg_seq =
      packet_gen_pkt_cfg_reg_seq::type_id::create("gen_pkt_cfg_seq");

    gen_pkt_cfg_seq.pkt_regmodel = pkt_e.pkt_regmodel;
    gen_pkt_cfg_seq.start(pkt_e.pkt_agt.seqr);

    phase.drop_objection(this);
  endtask

endclass


//gen_interval
class packet_gen_interval_reg_test extends packet_test;
  `uvm_component_utils(packet_gen_interval_reg_test)

  packet_gen_interval_reg_seq gen_interval_seq;

function new(string name = "packet_gen_interval_reg_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

task run_phase(uvm_phase phase);
    phase.raise_objection(this);

gen_interval_seq = packet_gen_interval_reg_seq::type_id::create("gen_interval_seq");
    gen_interval_seq.pkt_regmodel = pkt_e.pkt_regmodel;
    gen_interval_seq.start(pkt_e.pkt_agt.seqr);

phase.drop_objection(this);
endtask
endclass


//gen_count
class packet_gen_count_reg_test extends packet_test;
  `uvm_component_utils(packet_gen_count_reg_test)

  packet_gen_count_reg_seq gen_count_seq;

function new(string name = "packet_gen_count_reg_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

task run_phase(uvm_phase phase);
    phase.raise_objection(this);

gen_count_seq = packet_gen_count_reg_seq::type_id::create("gen_count_seq");
    gen_count_seq.pkt_regmodel = pkt_e.pkt_regmodel;
    gen_count_seq.start(pkt_e.pkt_agt.seqr);

phase.drop_objection(this);
endtask
endclass


//irq_status

class packet_irq_status_reg_test extends packet_test;
  `uvm_component_utils(packet_irq_status_reg_test)

  packet_irq_status_reg_seq irq_status_seq;

  function new(string name = "packet_irq_status_reg_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    irq_status_seq = packet_irq_status_reg_seq::type_id::create("irq_status_seq");
    irq_status_seq.pkt_regmodel = pkt_e.pkt_regmodel;
    irq_status_seq.start(pkt_e.pkt_agt.seqr);

    phase.drop_objection(this);
  endtask
endclass


//irq_enable
class packet_irq_enable_reg_test extends packet_test;
  `uvm_component_utils(packet_irq_enable_reg_test)

  packet_irq_enable_reg_seq irq_enable_seq;

function new(string name = "packet_irq_enable_reg_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

task run_phase(uvm_phase phase);
    phase.raise_objection(this);

irq_enable_seq = packet_irq_enable_reg_seq::type_id::create("irq_enable_seq");
    irq_enable_seq.pkt_regmodel = pkt_e.pkt_regmodel;
    irq_enable_seq.start(pkt_e.pkt_agt.seqr);

phase.drop_objection(this);
endtask
endclass

//irq_force

class packet_irq_force_reg_test extends packet_test;
  `uvm_component_utils(packet_irq_force_reg_test)

  packet_irq_force_reg_seq irq_force_seq;

  function new(string name = "packet_irq_force_reg_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    irq_force_seq = packet_irq_force_reg_seq::type_id::create("irq_force_seq");
    irq_force_seq.pkt_regmodel = pkt_e.pkt_regmodel;
    irq_force_seq.start(pkt_e.pkt_agt.seqr);

    phase.drop_objection(this);
  endtask
endclass


//err_status

class packet_err_status_reg_test extends packet_test;
  `uvm_component_utils(packet_err_status_reg_test)

  packet_err_status_reg_seq err_status_seq;

  function new(string name = "packet_err_status_reg_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    err_status_seq = packet_err_status_reg_seq::type_id::create("err_status_seq");
    err_status_seq.pkt_regmodel = pkt_e.pkt_regmodel;
    err_status_seq.start(pkt_e.pkt_agt.seqr);

    phase.drop_objection(this);
  endtask
endclass


//err_enable
class packet_err_enable_reg_test extends packet_test;
  `uvm_component_utils(packet_err_enable_reg_test)

  packet_err_enable_reg_seq err_enable_seq;

function new(string name = "packet_err_enable_reg_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

task run_phase(uvm_phase phase);
    phase.raise_objection(this);

err_enable_seq = packet_err_enable_reg_seq::type_id::create("err_enable_seq");
    err_enable_seq.pkt_regmodel = pkt_e.pkt_regmodel;
    err_enable_seq.start(pkt_e.pkt_agt.seqr);

phase.drop_objection(this);
endtask
endclass

//err_inject

class packet_err_inject_reg_test extends packet_test;
  `uvm_component_utils(packet_err_inject_reg_test)

  packet_err_inject_reg_seq err_inject_seq;

  function new(string name = "packet_err_inject_reg_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    err_inject_seq = packet_err_inject_reg_seq::type_id::create("err_inject_seq");
    err_inject_seq.pkt_regmodel = pkt_e.pkt_regmodel;
    err_inject_seq.start(pkt_e.pkt_agt.seqr);

    phase.drop_objection(this);
  endtask
endclass


//err_count

class packet_err_count_reg_test extends packet_test;
  `uvm_component_utils(packet_err_count_reg_test)

  packet_err_count_reg_seq err_count_seq;

  function new(string name = "packet_err_count_reg_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    err_count_seq = packet_err_count_reg_seq::type_id::create("err_count_seq");
    err_count_seq.pkt_regmodel = pkt_e.pkt_regmodel;
    err_count_seq.start(pkt_e.pkt_agt.seqr);

    phase.drop_objection(this);
  endtask
endclass


//err_info

class packet_err_info_reg_test extends packet_test;
  `uvm_component_utils(packet_err_info_reg_test)

  packet_err_info_reg_seq err_info_seq;

  function new(string name = "packet_err_info_reg_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    err_info_seq = packet_err_info_reg_seq::type_id::create("err_info_seq");
    err_info_seq.pkt_regmodel = pkt_e.pkt_regmodel;
    err_info_seq.start(pkt_e.pkt_agt.seqr);

    phase.drop_objection(this);
  endtask
endclass


//lock

class packet_lock_reg_test extends packet_test;
  `uvm_component_utils(packet_lock_reg_test)

  packet_lock_reg_seq lock_seq;

  function new(string name = "packet_lock_reg_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    lock_seq = packet_lock_reg_seq::type_id::create("lock_seq");
    lock_seq.pkt_regmodel = pkt_e.pkt_regmodel;
    lock_seq.start(pkt_e.pkt_agt.seqr);

    phase.drop_objection(this);
  endtask
endclass


//soft_reset
class packet_soft_reset_reg_test extends packet_test;
  `uvm_component_utils(packet_soft_reset_reg_test)

  packet_soft_reset_reg_seq soft_reset_seq;

function new(string name = "packet_soft_reset_reg_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

task run_phase(uvm_phase phase);
    phase.raise_objection(this);

soft_reset_seq = packet_soft_reset_reg_seq::type_id::create("soft_reset_seq");
    soft_reset_seq.pkt_regmodel = pkt_e.pkt_regmodel;
    soft_reset_seq.start(pkt_e.pkt_agt.seqr);

phase.drop_objection(this);
endtask
endclass

//6.1 and 6.2 genreate 4 packets from soruce 0 to dest 1 and clear sticky bits

class packet_generate_four_packets_test extends packet_test;
  `uvm_component_utils(packet_generate_four_packets_test)

  packet_generate_four_packets_seq gen_four_seq;

  function new(string name = "packet_generate_four_packets_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    gen_four_seq = packet_generate_four_packets_seq::type_id::create("gen_four_seq");
    gen_four_seq.pkt_regmodel = pkt_e.pkt_regmodel;
    gen_four_seq.start(pkt_e.pkt_agt.seqr);

    phase.drop_objection(this);
  endtask
endclass


//6.3 
class packet_destination_drop_test extends packet_test;
  `uvm_component_utils(packet_destination_drop_test)

  packet_destination_drop_seq seq;

  function new(string name = "packet_destination_drop_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    seq = packet_destination_drop_seq::type_id::create("seq");
    seq.pkt_regmodel = pkt_e.pkt_regmodel;
    seq.start(pkt_e.pkt_agt.seqr);

    phase.drop_objection(this);
  endtask
endclass

//unalligned access
class packet_unaligned_access_test extends packet_test;
  `uvm_component_utils(packet_unaligned_access_test)

  packet_unaligned_access_seq seq;

  function new(string name = "packet_unaligned_access_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq = packet_unaligned_access_seq::type_id::create("seq");
    seq.start(pkt_e.pkt_agt.seqr);
    phase.drop_objection(this);
  endtask
endclass

//unmapped addr 
class packet_unmapped_access_test extends packet_test;
  `uvm_component_utils(packet_unmapped_access_test)

  packet_unmapped_access_seq seq;

  function new(string name = "packet_unmapped_access_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq = packet_unmapped_access_seq::type_id::create("seq");
    seq.start(pkt_e.pkt_agt.seqr);
    phase.drop_objection(this);
  endtask
endclass


//ro reg - writing test
class packet_ro_write_test extends packet_test;
  `uvm_component_utils(packet_ro_write_test)

  packet_ro_write_seq seq;

  function new(string name = "packet_ro_write_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    seq = packet_ro_write_seq::type_id::create("seq");
    seq.pkt_regmodel = pkt_e.pkt_regmodel;
    seq.start(pkt_e.pkt_agt.seqr);

    phase.drop_objection(this);
  endtask
endclass


//wo reg check
class packet_wo_read_test extends packet_test;
  `uvm_component_utils(packet_wo_read_test)

  packet_wo_read_seq seq;

  function new(string name = "packet_wo_read_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    seq = packet_wo_read_seq::type_id::create("seq");
    seq.pkt_regmodel = pkt_e.pkt_regmodel;
    seq.start(pkt_e.pkt_agt.seqr);

    phase.drop_objection(this);
  endtask
endclass


//error test - write to reg whn locked shld ignore write
class packet_locked_write_test extends packet_test;
  `uvm_component_utils(packet_locked_write_test)

  packet_locked_write_seq seq;

  function new(string name = "packet_locked_write_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    seq = packet_locked_write_seq::type_id::create("seq");
    seq.pkt_regmodel = pkt_e.pkt_regmodel;
    seq.start(pkt_e.pkt_agt.seqr);

    phase.drop_objection(this);
  endtask
endclass


//after covergae test
//src port2 missing
class packet_gen_pkt_cfg_src_port2_test extends packet_test;
  `uvm_component_utils(packet_gen_pkt_cfg_src_port2_test)

  packet_gen_pkt_cfg_src_port2_seq seq;

function new(string name = "packet_gen_pkt_cfg_src_port2_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

task run_phase(uvm_phase phase);
    phase.raise_objection(this);

seq = packet_gen_pkt_cfg_src_port2_seq::type_id::create("seq");
    seq.pkt_regmodel = pkt_e.pkt_regmodel;
    seq.start(pkt_e.pkt_agt.seqr);

phase.drop_objection(this);
  endtask
endclass

//gen interval med bin
class packet_generate_four_packets_test1 extends packet_test;
  `uvm_component_utils(packet_generate_four_packets_test1)

  packet_generate_four_packets_seq1 seq1;

  function new(string name = "packet_generate_four_packets_test1", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    seq1 = packet_generate_four_packets_seq1::type_id::create("seq1");
    seq1.pkt_regmodel = pkt_e.pkt_regmodel;
    seq1.start(pkt_e.pkt_agt.seqr);

    phase.drop_objection(this);
  endtask
endclass

//stat_tx and rx count1
class packet_generate_four_packets_test2 extends packet_test;
  `uvm_component_utils(packet_generate_four_packets_test2)

  packet_generate_four_packets_seq2 seq2;

  function new(string name = "packet_generate_four_packets_test2", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    seq2 = packet_generate_four_packets_seq2::type_id::create("seq2");
    seq2.pkt_regmodel = pkt_e.pkt_regmodel;
    seq2.start(pkt_e.pkt_agt.seqr);

    phase.drop_objection(this);
  endtask
endclass

//error inject
class packet_err_inject_test1 extends packet_test;
  `uvm_component_utils(packet_err_inject_test1)

  packet_err_inject_reg_seq1 err_seq1;

  function new(string name = "packet_err_inject_test1", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    err_seq1 = packet_err_inject_reg_seq1::type_id::create("err_seq1");
    err_seq1.pkt_regmodel = pkt_e.pkt_regmodel;
    err_seq1.start(pkt_e.pkt_agt.seqr);

    phase.drop_objection(this);
  endtask
endclass

//err_info test

class packet_err_info_port2_test extends packet_test;
  `uvm_component_utils(packet_err_info_port2_test)

  packet_err_info_port2_seq seq3;

  function new(string name = "packet_err_info_port2_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    seq3 = packet_err_info_port2_seq::type_id::create("seq3");
    seq3.pkt_regmodel = pkt_e.pkt_regmodel;
    seq3.start(pkt_e.pkt_agt.seqr);

    phase.drop_objection(this);
  endtask
endclass


//port3
class packet_err_info_port3_test extends packet_test;
  `uvm_component_utils(packet_err_info_port3_test)

  packet_err_info_port3_seq seq4;

  function new(string name = "packet_err_info_port3_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    seq4 = packet_err_info_port3_seq::type_id::create("seq4");
    seq4.pkt_regmodel = pkt_e.pkt_regmodel;
    seq4.start(pkt_e.pkt_agt.seqr);

    phase.drop_objection(this);
  endtask
endclass

//err status swevent and error
class packet_irq_sw_event_error_test extends packet_test;
  `uvm_component_utils(packet_irq_sw_event_error_test)

  packet_irq_sw_event_error_seq seq5;

  function new(string name = "packet_irq_sw_event_error_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    seq5 = packet_irq_sw_event_error_seq::type_id::create("seq5");
    seq5.pkt_regmodel = pkt_e.pkt_regmodel;
    seq5.start(pkt_e.pkt_agt.seqr);

    phase.drop_objection(this);
  endtask
endclass

//gen_fsm
class packet_gen_fsm_gap_test extends packet_test;
  `uvm_component_utils(packet_gen_fsm_gap_test)

  packet_gen_fsm_gap_seq seq6;

  function new(string name = "packet_gen_fsm_gap_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq6 = packet_gen_fsm_gap_seq::type_id::create("seq6");
    seq6.pkt_regmodel = pkt_e.pkt_regmodel;
    seq6.start(pkt_e.pkt_agt.seqr);
    phase.drop_objection(this);
  endtask
endclass

//port_enabled
class packet_port_enabled_cov_test extends packet_test;
  `uvm_component_utils(packet_port_enabled_cov_test)

  packet_port_enabled_cov_seq seq7;

  function new(string name = "packet_port_enabled_cov_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq7 = packet_port_enabled_cov_seq::type_id::create("seq7");
    seq7.pkt_regmodel = pkt_e.pkt_regmodel;
    seq7.start(pkt_e.pkt_agt.seqr);
    phase.drop_objection(this);
  endtask
endclass

//irq_force cov

class packet_irq_force_cov_test extends packet_test;
  `uvm_component_utils(packet_irq_force_cov_test)

  packet_irq_force_cov_seq seq_irq;

  function new(string name = "packet_irq_force_cov_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    seq_irq = packet_irq_force_cov_seq::type_id::create("seq_irq");
    seq_irq.pkt_regmodel = pkt_e.pkt_regmodel;
    seq_irq.start(pkt_e.pkt_agt.seqr);

    phase.drop_objection(this);
  endtask
endclass

//regression test
class packet_regression_test extends packet_test;
  `uvm_component_utils(packet_regression_test)

  packet_regression_seq regression_seq;

  function new(string name = "packet_regression_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    regression_seq = packet_regression_seq::type_id::create("regression_seq");
    regression_seq.pkt_regmodel = pkt_e.pkt_regmodel;
    regression_seq.start(pkt_e.pkt_agt.seqr);

    phase.drop_objection(this);
  endtask

endclass


//backdoor test
class switch_ctrl_backdoor_test extends packet_test;
  `uvm_component_utils(switch_ctrl_backdoor_test)

  switch_ctrl_backdoor_test_seq seq;

  function new(string name = "switch_ctrl_backdoor_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);

    seq = switch_ctrl_backdoor_test_seq::type_id::create("seq");
    seq.pkt_regmodel = pkt_e.pkt_regmodel;
    seq.start(pkt_e.pkt_agt.seqr);

    phase.drop_objection(this);
  endtask
endclass


