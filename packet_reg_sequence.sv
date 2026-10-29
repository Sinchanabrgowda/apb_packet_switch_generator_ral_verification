class packet_base_reg_seq extends uvm_sequence;
  `uvm_object_utils(packet_base_reg_seq)

packet_reg_block pkt_regmodel;

  function new (string name = "packet_base_reg_seq"); 
    super.new(name);
  endfunction
  
  uvm_status_e status;
  uvm_reg_data_t    rdata, rdata_m, dout_t;

endclass

//unlock reg
class packet_unlock_reg_seq extends packet_base_reg_seq;
  `uvm_object_utils(packet_unlock_reg_seq)

  function new(string name = "packet_unlock_reg_seq");
    super.new(name);
  endfunction

  task body();
    uvm_reg_data_t rdata;

    pkt_regmodel.lock.read(status, rdata, UVM_FRONTDOOR);

    `uvm_info("UNLOCK_SEQ",  $sformatf("Initial LOCK value = 0x%08h", rdata),  UVM_LOW)

    if (rdata[0] != 1'b1)
      `uvm_error("UNLOCK_SEQ", "LOCK register should be locked after reset")

    pkt_regmodel.lock.write(status, 32'hA5A5_C3C3, UVM_FRONTDOOR);

    pkt_regmodel.lock.read(status, rdata, UVM_FRONTDOOR);

    `uvm_info("UNLOCK_SEQ", $sformatf("LOCK value after unlock key = 0x%08h", rdata), UVM_LOW)

    if (rdata[0] != 1'b0)
      `uvm_error("UNLOCK_SEQ", "LOCK register did not unlock")

    pkt_regmodel.lock.write(status, 32'h0000_0000, UVM_FRONTDOOR);

    pkt_regmodel.lock.read(status, rdata, UVM_FRONTDOOR);

    `uvm_info("UNLOCK_SEQ", $sformatf("LOCK value after locking again = 0x%08h", rdata),  UVM_LOW)

    if (rdata[0] != 1'b1)
      `uvm_error("UNLOCK_SEQ", "LOCK register did not lock again")

  endtask
endclass
      ////////////////////////////////////////////////////////////
//device_id reset
      class packet_device_id_reg_seq extends packet_base_reg_seq;
  `uvm_object_utils(packet_device_id_reg_seq)

  uvm_status_e status;
  uvm_reg_data_t rdata;
  uvm_reg_data_t expected_data = 32'h02A5_5357;

  function new(string name = "packet_device_id_reg_seq");
    super.new(name);
  endfunction

  task body();
    `uvm_info("DEVICE_ID_SEQ", "Starting DEVICE_ID register verification", UVM_MEDIUM)

    pkt_regmodel.device_id.read(status, rdata, UVM_FRONTDOOR);

    if (status != UVM_IS_OK) begin
`uvm_error("DEVICE_ID_SEQ", "DEVICE_ID register read failed")
    end
    else if (rdata !== expected_data) begin
      `uvm_error("DEVICE_ID_SEQ",$sformatf("DEVICE_ID mismatch: Expected=0x%08h Actual=0x%08h",  expected_data, rdata))
    end
    else begin
      `uvm_info("DEVICE_ID_SEQ", $sformatf("DEVICE_ID PASS: Read=0x%08h", rdata), UVM_MEDIUM)
    end
  endtask

endclass
    
 ///////////////////////////////////////////////////////////////////////////   
    //version id reset check
class packet_version_reg_seq extends packet_base_reg_seq;
  `uvm_object_utils(packet_version_reg_seq)

  uvm_status_e status;
  uvm_reg_data_t rdata;
  uvm_reg_data_t expected_data = 32'h0001_0200;

  function new(string name = "packet_version_reg_seq");
    super.new(name);
  endfunction

  task body();
    `uvm_info("VERSION_SEQ", "Starting VERSION register verification", UVM_MEDIUM)

    pkt_regmodel.version.read(status, rdata, UVM_FRONTDOOR);

    if (status != UVM_IS_OK) begin
      `uvm_error("VERSION_SEQ", "VERSION register read failed")
    end
    else if (rdata !== expected_data) begin
      `uvm_error("VERSION_SEQ",    $sformatf("VERSION mismatch: Expected=0x%08h Actual=0x%08h",  expected_data, rdata))
    end
    else begin
      `uvm_info("VERSION_SEQ",$sformatf("VERSION PASS: Read=0x%08h", rdata), UVM_MEDIUM)
    end
  endtask

endclass
    
    ///////////////////////////////////////////////////////////////////
    //switch_status reset

class packet_switch_status_reg_seq extends packet_base_reg_seq;
  `uvm_object_utils(packet_switch_status_reg_seq)

  uvm_status_e status;
  uvm_reg_data_t rdata;
  uvm_reg_data_t expected_data = 32'h0000_00F9;

  function new(string name = "packet_switch_status_reg_seq");
    super.new(name);
  endfunction

  task body();
    `uvm_info("SWITCH_STATUS_SEQ",  "Starting SWITCH_STATUS register verification", UVM_MEDIUM)

    pkt_regmodel.switch_status.read(status, rdata, UVM_FRONTDOOR);

    if (status != UVM_IS_OK) begin
      `uvm_error("SWITCH_STATUS_SEQ", "SWITCH_STATUS register read failed")
    end
    else if (rdata !== expected_data) begin
      `uvm_error("SWITCH_STATUS_SEQ",$sformatf("SWITCH_STATUS mismatch: Expected=0x%08h Actual=0x%08h", expected_data, rdata))
    end
    else begin
      `uvm_info("SWITCH_STATUS_SEQ", $sformatf("SWITCH_STATUS PASS: Read=0x%08h", rdata), UVM_MEDIUM)
    end
  endtask

endclass

    
    ///////////////////////////////////////////////////////////////////
    //port_status reset 
class packet_port_status_reg_seq extends packet_base_reg_seq;
  `uvm_object_utils(packet_port_status_reg_seq)

  uvm_status_e status;
  uvm_reg_data_t rdata;
  uvm_reg_data_t expected_data = 32'h0000_0000;

  function new(string name = "packet_port_status_reg_seq");
    super.new(name);
  endfunction

  task body();
    `uvm_info("PORT_STATUS_SEQ",  "Starting PORT_STATUS register verification", UVM_MEDIUM)

    pkt_regmodel.port_status.read(status, rdata, UVM_FRONTDOOR);

    if (status != UVM_IS_OK) begin
      `uvm_error("PORT_STATUS_SEQ", "PORT_STATUS register read failed")
    end
    else if (rdata !== expected_data) begin
      `uvm_error("PORT_STATUS_SEQ", $sformatf("PORT_STATUS mismatch: Expected=0x%08h Actual=0x%08h",expected_data, rdata))
    end
    else begin
      `uvm_info("PORT_STATUS_SEQ", $sformatf("PORT_STATUS PASS: Read=0x%08h", rdata), UVM_MEDIUM)
    end
  endtask

endclass

    
    ///////////////////////////////////////////////////////////////
    //gen_status
class packet_gen_status_reg_seq extends packet_base_reg_seq;
  `uvm_object_utils(packet_gen_status_reg_seq)

  uvm_status_e status;
  uvm_reg_data_t rdata;
  uvm_reg_data_t expected_data = 32'h0000_0000;

  function new(string name = "packet_gen_status_reg_seq");
    super.new(name);
  endfunction

  task body();
    `uvm_info("GEN_STATUS_SEQ",  "Starting GEN_STATUS register verification", UVM_MEDIUM)

    pkt_regmodel.gen_status.read(status, rdata, UVM_FRONTDOOR);

    if (status != UVM_IS_OK) begin
      `uvm_error("GEN_STATUS_SEQ", "GEN_STATUS register read failed")
    end
    else if (rdata !== expected_data) begin
      `uvm_error("GEN_STATUS_SEQ", $sformatf("GEN_STATUS mismatch: Expected=0x%08h Actual=0x%08h",  expected_data, rdata))
    end
    else begin
      `uvm_info("GEN_STATUS_SEQ", $sformatf("GEN_STATUS PASS: Read=0x%08h", rdata), UVM_MEDIUM)
    end
  endtask

endclass
    
    
    ////////////////////////////////////////////////////////////
    //stat_rx reset
class packet_stat_rx_reg_seq extends packet_base_reg_seq;
  `uvm_object_utils(packet_stat_rx_reg_seq)

  uvm_status_e status;
  uvm_reg_data_t rdata;
  uvm_reg_data_t expected_data = 32'h0000_0000;

  function new(string name = "packet_stat_rx_reg_seq");
    super.new(name);
  endfunction

  task body();
    `uvm_info("STAT_RX_SEQ","Starting STAT_RX register verification", UVM_MEDIUM)

    pkt_regmodel.stat_rx.read(status, rdata, UVM_FRONTDOOR);

    if (status != UVM_IS_OK) begin
      `uvm_error("STAT_RX_SEQ", "STAT_RX register read failed")
    end
    else if (rdata !== expected_data) begin
      `uvm_error("STAT_RX_SEQ",$sformatf("STAT_RX mismatch: Expected=0x%08h Actual=0x%08h",  expected_data, rdata))
    end
    else begin
      `uvm_info("STAT_RX_SEQ",$sformatf("STAT_RX PASS: Read=0x%08h", rdata), UVM_MEDIUM)
    end
  endtask

endclass
    
    
    /////////////////////////////////////////////////////
    //stat_tx reset

class packet_stat_tx_reg_seq extends packet_base_reg_seq;
  `uvm_object_utils(packet_stat_tx_reg_seq)

  uvm_status_e status;
  uvm_reg_data_t rdata;
  uvm_reg_data_t expected_data = 32'h0000_0000;

  function new(string name = "packet_stat_tx_reg_seq");
    super.new(name);
  endfunction

  task body();
    `uvm_info("STAT_TX_SEQ",  "Starting STAT_TX register verification", UVM_MEDIUM)

    pkt_regmodel.stat_tx.read(status, rdata, UVM_FRONTDOOR);

    if (status != UVM_IS_OK) begin
      `uvm_error("STAT_TX_SEQ", "STAT_TX register read failed")
    end
    else if (rdata !== expected_data) begin
      `uvm_error("STAT_TX_SEQ",$sformatf("STAT_TX mismatch: Expected=0x%08h Actual=0x%08h",expected_data, rdata))
    end
    else begin
      `uvm_info("STAT_TX_SEQ",$sformatf("STAT_TX PASS: Read=0x%08h", rdata), UVM_MEDIUM)
    end
  endtask

endclass

    
    ////////////////////////////////////////////////////
    //stat_drop reset
class packet_stat_drop_reg_seq extends packet_base_reg_seq;
  `uvm_object_utils(packet_stat_drop_reg_seq)

  uvm_status_e status;
  uvm_reg_data_t rdata;
  uvm_reg_data_t expected_data = 32'h0000_0000;

  function new(string name = "packet_stat_drop_reg_seq");
    super.new(name);
  endfunction

  task body();
    `uvm_info("STAT_DROP_SEQ","Starting STAT_DROP register verification", UVM_MEDIUM)

    pkt_regmodel.stat_drop.read(status, rdata, UVM_FRONTDOOR);

    if (status != UVM_IS_OK) begin
      `uvm_error("STAT_DROP_SEQ", "STAT_DROP register read failed")
    end
    else if (rdata !== expected_data) begin
      `uvm_error("STAT_DROP_SEQ",$sformatf("STAT_DROP mismatch: Expected=0x%08h Actual=0x%08h",  expected_data, rdata))
    end
    else begin
      `uvm_info("STAT_DROP_SEQ",$sformatf("STAT_DROP PASS: Read=0x%08h", rdata), UVM_MEDIUM)
    end
  endtask

endclass
    
    ///////////////////////////////////////////////////////
    //switch_control reset and rw check by unlockign and writing into it
class packet_switch_ctrl_reg_seq extends packet_base_reg_seq;
  `uvm_object_utils(packet_switch_ctrl_reg_seq)

  uvm_status_e status;
  uvm_reg_data_t rdata;
  uvm_reg_data_t expected_data;
  uvm_reg_data_t wdata;

  function new(string name = "packet_switch_ctrl_reg_seq");
    super.new(name);
  endfunction

  task body();
    `uvm_info("SWITCH_CTRL_SEQ", "Starting SWITCH_CTRL register verification", UVM_MEDIUM)

    pkt_regmodel.lock.write(status, 32'hA5A5_C3C3, UVM_FRONTDOOR);

    if (status != UVM_IS_OK) begin
      `uvm_error("SWITCH_CTRL_SEQ", "Failed to unlock DUT")
      return;
    end

    pkt_regmodel.switch_ctrl.read(status, rdata, UVM_FRONTDOOR);

    if (status != UVM_IS_OK) begin
      `uvm_error("SWITCH_CTRL_SEQ", "SWITCH_CTRL reset read failed")
    end
    else if (rdata !== 32'h0000_0000) begin
      `uvm_error("SWITCH_CTRL_SEQ",  $sformatf("Reset value mismatch: Expected=0x00000000 Actual=0x%08h", rdata))
    end
    else begin
      `uvm_info("SWITCH_CTRL_SEQ", "SWITCH_CTRL reset value PASS", UVM_MEDIUM)
    end

    wdata = 32'h0000_0009;
    pkt_regmodel.switch_ctrl.write(status, wdata, UVM_FRONTDOOR);

    if (status != UVM_IS_OK) begin
      `uvm_error("SWITCH_CTRL_SEQ", "SWITCH_CTRL write failed")
    end
    else begin
      pkt_regmodel.switch_ctrl.read(status, rdata, UVM_FRONTDOOR);
      expected_data = 32'h0000_0009;

      if (status != UVM_IS_OK) begin
        `uvm_error("SWITCH_CTRL_SEQ", "SWITCH_CTRL readback failed")
      end
      else if (rdata !== expected_data) begin
        `uvm_error("SWITCH_CTRL_SEQ",  $sformatf("Readback mismatch: Expected=0x%08h Actual=0x%08h", expected_data, rdata))
      end
      else begin
        `uvm_info("SWITCH_CTRL_SEQ",  $sformatf("SWITCH_CTRL PASS: Read=0x%08h", rdata), UVM_MEDIUM)
      end
    end
  endtask

endclass

    
    ///////////////////////////////////////////////////////////////
    //port enable rw check by unlocking and check reset then rw
class packet_port_enable_reg_seq extends packet_base_reg_seq;
  `uvm_object_utils(packet_port_enable_reg_seq)

  uvm_status_e status;
  uvm_reg_data_t rdata;
  uvm_reg_data_t expected_data;
  uvm_reg_data_t wdata;

  function new(string name = "packet_port_enable_reg_seq");
    super.new(name);
  endfunction

  task body();
    `uvm_info("PORT_ENABLE_SEQ","Starting PORT_ENABLE register verification", UVM_MEDIUM)

    pkt_regmodel.lock.write(status, 32'hA5A5_C3C3, UVM_FRONTDOOR);

    if (status != UVM_IS_OK) begin
      `uvm_error("PORT_ENABLE_SEQ", "Failed to unlock DUT")
      return;
    end

    pkt_regmodel.port_enable.read(status, rdata, UVM_FRONTDOOR);

    if (status != UVM_IS_OK) begin
      `uvm_error("PORT_ENABLE_SEQ", "PORT_ENABLE reset read failed")
    end
    else if (rdata !== 32'h0000_000F) begin
      `uvm_error("PORT_ENABLE_SEQ",$sformatf("Reset mismatch: Expected=0x0000000F Actual=0x%08h",  rdata))
    end
    else begin
      `uvm_info("PORT_ENABLE_SEQ",  "PORT_ENABLE reset value PASS", UVM_MEDIUM)
    end

    wdata = 32'h0000_0005;
    pkt_regmodel.port_enable.write(status, wdata, UVM_FRONTDOOR);

    if (status != UVM_IS_OK) begin
      `uvm_error("PORT_ENABLE_SEQ", "PORT_ENABLE write failed")
    end
    else begin
      pkt_regmodel.port_enable.read(status, rdata, UVM_FRONTDOOR);
      expected_data = 32'h0000_0005;

      if (status != UVM_IS_OK) begin
        `uvm_error("PORT_ENABLE_SEQ", "PORT_ENABLE readback failed")
      end
      else if (rdata !== expected_data) begin
        `uvm_error("PORT_ENABLE_SEQ",$sformatf("Readback mismatch: Expected=0x%08h Actual=0x%08h",expected_data, rdata))
      end
      else begin
        `uvm_info("PORT_ENABLE_SEQ",  $sformatf("PORT_ENABLE PASS: Read=0x%08h", rdata), UVM_MEDIUM)
      end
    end
  endtask

endclass

    
    ///////////////////////////////////////////////////////////////////
    //fwd_enable 
class packet_fwd_enable_reg_seq extends packet_base_reg_seq;
  `uvm_object_utils(packet_fwd_enable_reg_seq)

  uvm_status_e status;
  uvm_reg_data_t rdata;
  uvm_reg_data_t expected_data;
  uvm_reg_data_t wdata;

  function new(string name = "packet_fwd_enable_reg_seq");
    super.new(name);
  endfunction

  task body();
    `uvm_info("FWD_ENABLE_SEQ",  "Starting FWD_ENABLE register verification", UVM_MEDIUM)

    pkt_regmodel.lock.write(status, 32'hA5A5_C3C3, UVM_FRONTDOOR);

    if (status != UVM_IS_OK) begin
      `uvm_error("FWD_ENABLE_SEQ", "Failed to unlock DUT")
      return;
    end

    pkt_regmodel.fwd_enable.read(status, rdata, UVM_FRONTDOOR);

    if (status != UVM_IS_OK) begin
      `uvm_error("FWD_ENABLE_SEQ", "FWD_ENABLE reset read failed")
    end
    else if (rdata !== 32'h0000_000F) begin
      `uvm_error("FWD_ENABLE_SEQ", $sformatf("Reset mismatch: Expected=0x%08h Actual=0x%08h", 32'h0000_000F, rdata))
    end
    else begin
      `uvm_info("FWD_ENABLE_SEQ", "FWD_ENABLE reset value PASS", UVM_MEDIUM)
    end

    wdata = 32'h0000_0005;
    pkt_regmodel.fwd_enable.write(status, wdata, UVM_FRONTDOOR);

    if (status != UVM_IS_OK) begin
      `uvm_error("FWD_ENABLE_SEQ", "FWD_ENABLE write failed")
    end
    else begin
      pkt_regmodel.fwd_enable.read(status, rdata, UVM_FRONTDOOR);
      expected_data = 32'h0000_0005;

      if (status != UVM_IS_OK) begin
        `uvm_error("FWD_ENABLE_SEQ", "FWD_ENABLE readback failed")
      end
      else if (rdata !== expected_data) begin
        `uvm_error("FWD_ENABLE_SEQ",  $sformatf("Readback mismatch: Expected=0x%08h Actual=0x%08h", expected_data, rdata))
      end
      else begin
        `uvm_info("FWD_ENABLE_SEQ",  $sformatf("FWD_ENABLE PASS: Read=0x%08h", rdata), UVM_MEDIUM)
      end
    end
  endtask

endclass
   
    
    ////////////////////////////////////////////////////////////////////
    //gen_ctrl
class packet_gen_ctrl_reg_seq extends packet_base_reg_seq;
  `uvm_object_utils(packet_gen_ctrl_reg_seq)

  uvm_status_e status;
  uvm_reg_data_t rdata;
  uvm_reg_data_t expected_data;
  uvm_reg_data_t wdata;

  function new(string name = "packet_gen_ctrl_reg_seq");
    super.new(name);
  endfunction

  task body();
    `uvm_info("GEN_CTRL_SEQ", "Starting GEN_CTRL register verification", UVM_MEDIUM)

    pkt_regmodel.lock.write(status, 32'hA5A5_C3C3, UVM_FRONTDOOR);

    if (status != UVM_IS_OK) begin
      `uvm_error("GEN_CTRL_SEQ", "Failed to unlock DUT")
      return;
    end

    pkt_regmodel.gen_ctrl.read(status, rdata, UVM_FRONTDOOR);

    if (status != UVM_IS_OK) begin
      `uvm_error("GEN_CTRL_SEQ", "GEN_CTRL reset read failed")
    end
    else if (rdata !== 32'h0000_0000) begin
      `uvm_error("GEN_CTRL_SEQ",$sformatf("Reset mismatch: Expected=0x%08h Actual=0x%08h",   32'h0000_0000, rdata))
    end
    else begin
      `uvm_info("GEN_CTRL_SEQ","GEN_CTRL reset value PASS", UVM_MEDIUM)
    end

    wdata = 32'h0000_0009;
    pkt_regmodel.gen_ctrl.write(status, wdata, UVM_FRONTDOOR);

    if (status != UVM_IS_OK) begin
      `uvm_error("GEN_CTRL_SEQ", "GEN_CTRL write failed")
    end
    else begin
      pkt_regmodel.gen_ctrl.read(status, rdata, UVM_FRONTDOOR);
      expected_data = 32'h0000_0009;

      if (status != UVM_IS_OK) begin
        `uvm_error("GEN_CTRL_SEQ", "GEN_CTRL readback failed")
      end
      else if (rdata !== expected_data) begin
        `uvm_error("GEN_CTRL_SEQ",  $sformatf("Readback mismatch: Expected=0x%08h Actual=0x%08h",  expected_data, rdata))
      end
      else begin
        `uvm_info("GEN_CTRL_SEQ", $sformatf("GEN_CTRL PASS: Read=0x%08h", rdata), UVM_MEDIUM)
      end
    end
  endtask

endclass
    
    
    //////////////////////////////////////////////////
    //gen_pkt_cfg
class packet_gen_pkt_cfg_reg_seq extends packet_base_reg_seq;
  `uvm_object_utils(packet_gen_pkt_cfg_reg_seq)

  uvm_status_e status;
  uvm_reg_data_t rdata;
  uvm_reg_data_t expected_data;
  uvm_reg_data_t wdata;

  function new(string name = "packet_gen_pkt_cfg_reg_seq");
    super.new(name);
  endfunction

  task body();
    `uvm_info("GEN_PKT_CFG_SEQ",   "Starting GEN_PKT_CFG register verification", UVM_MEDIUM)

    pkt_regmodel.lock.write(status, 32'hA5A5_C3C3, UVM_FRONTDOOR);

    if (status != UVM_IS_OK) begin
      `uvm_error("GEN_PKT_CFG_SEQ", "Failed to unlock DUT")
      return;
    end

    pkt_regmodel.gen_pkt_cfg.read(status, rdata, UVM_FRONTDOOR);

    if (status != UVM_IS_OK) begin
      `uvm_error("GEN_PKT_CFG_SEQ", "GEN_PKT_CFG reset read failed")
    end
    else if (rdata !== 32'h0000_0401) begin
      `uvm_error("GEN_PKT_CFG_SEQ",  $sformatf("Reset mismatch: Expected=0x%08h Actual=0x%08h",32'h0000_0401, rdata))
    end
    else begin
      `uvm_info("GEN_PKT_CFG_SEQ","GEN_PKT_CFG reset value PASS", UVM_MEDIUM)
    end

    wdata = 32'h005A_0806;
    pkt_regmodel.gen_pkt_cfg.write(status, wdata, UVM_FRONTDOOR);

    if (status != UVM_IS_OK) begin
      `uvm_error("GEN_PKT_CFG_SEQ", "GEN_PKT_CFG write failed")
    end
    else begin
      pkt_regmodel.gen_pkt_cfg.read(status, rdata, UVM_FRONTDOOR);
      expected_data = 32'h005A_0806;

      if (status != UVM_IS_OK) begin
        `uvm_error("GEN_PKT_CFG_SEQ", "GEN_PKT_CFG readback failed")
      end
      else if (rdata !== expected_data) begin
        `uvm_error("GEN_PKT_CFG_SEQ", $sformatf("Readback mismatch: Expected=0x%08h Actual=0x%08h", expected_data, rdata))
      end
      else begin
        `uvm_info("GEN_PKT_CFG_SEQ",   $sformatf("GEN_PKT_CFG PASS: Read=0x%08h", rdata), UVM_MEDIUM)
      end
    end
  endtask

endclass
    
    
    //gen_interval
    
class packet_gen_interval_reg_seq extends packet_base_reg_seq;
  `uvm_object_utils(packet_gen_interval_reg_seq)

  uvm_status_e status;
  uvm_reg_data_t rdata;

  function new(string name = "packet_gen_interval_reg_seq");
    super.new(name);
  endfunction

  task body();
    pkt_regmodel.lock.write(status, 32'hA5A5_C3C3, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("GEN_INTERVAL", "Failed to unlock DUT")
      return;
    end

    pkt_regmodel.gen_interval.read(status, rdata, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("GEN_INTERVAL", "Failed to read reset value")
      return;
    end

    if (rdata != 32'h00000002)
      `uvm_error("GEN_INTERVAL", $sformatf("Reset value mismatch: Expected 0x00000002, Got 0x%08h", rdata))
    else
      `uvm_info("GEN_INTERVAL", "Reset value matched: 0x00000002", UVM_MEDIUM)

    pkt_regmodel.gen_interval.write(status, 32'h00000005, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("GEN_INTERVAL", "Write failed")
      return;
    end

    pkt_regmodel.gen_interval.read(status, rdata, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("GEN_INTERVAL", "Readback failed")
      return;
    end

    if (rdata != 32'h00000005)
      `uvm_error("GEN_INTERVAL", $sformatf("Readback mismatch: Expected 0x00000005, Got 0x%08h", rdata))
    else
      `uvm_info("GEN_INTERVAL", "Readback matched: 0x00000005", UVM_MEDIUM)
  endtask
endclass

      
      
      //gen_count
      
class packet_gen_count_reg_seq extends packet_base_reg_seq;
  `uvm_object_utils(packet_gen_count_reg_seq)

  uvm_status_e status;
  uvm_reg_data_t rdata;

  function new(string name = "packet_gen_count_reg_seq");
    super.new(name);
  endfunction

  task body();
    pkt_regmodel.lock.write(status, 32'hA5A5_C3C3, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("GEN_COUNT", "Failed to unlock DUT")
      return;
    end

    pkt_regmodel.gen_count.read(status, rdata, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("GEN_COUNT", "Failed to read reset value")
      return;
    end

    if (rdata != 32'h00000004)
      `uvm_error("GEN_COUNT", $sformatf("Reset value mismatch: Expected 0x00000004, Got 0x%08h", rdata))
    else
      `uvm_info("GEN_COUNT", "Reset value matched: 0x00000004", UVM_MEDIUM)

    pkt_regmodel.gen_count.write(status, 32'h00000008, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("GEN_COUNT", "Write failed")
      return;
    end

    pkt_regmodel.gen_count.read(status, rdata, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("GEN_COUNT", "Readback failed")
      return;
    end

    if (rdata != 32'h00000008)
      `uvm_error("GEN_COUNT", $sformatf("Readback mismatch: Expected 0x00000008, Got 0x%08h", rdata))
    else
      `uvm_info("GEN_COUNT", "Readback matched: 0x00000008", UVM_MEDIUM)
  endtask
endclass

      
      //irq_status
      
class packet_irq_status_reg_seq extends packet_base_reg_seq;
  `uvm_object_utils(packet_irq_status_reg_seq)

  uvm_status_e status;
  uvm_reg_data_t rdata;

  function new(string name = "packet_irq_status_reg_seq");
    super.new(name);
  endfunction

  task body();
    pkt_regmodel.irq_status.read(status, rdata, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("IRQ_STATUS", "Failed to read reset value")
      return;
    end

    if (rdata != 32'h00000000)
      `uvm_error("IRQ_STATUS", $sformatf("Reset value mismatch: Expected 0x00000000, Got 0x%08h", rdata))
    else
      `uvm_info("IRQ_STATUS", "Reset value matched: 0x00000000", UVM_MEDIUM)

    pkt_regmodel.irq_status.write(status, 32'hFFFFFFFF, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("IRQ_STATUS", "Write-one-to-clear operation failed")
      return;
    end

    pkt_regmodel.irq_status.read(status, rdata, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("IRQ_STATUS", "Readback failed")
      return;
    end

    if (rdata != 32'h00000000)
      `uvm_error("IRQ_STATUS", $sformatf("Expected status 0x00000000, Got 0x%08h", rdata))
    else
      `uvm_info("IRQ_STATUS", "Interrupt status is clear", UVM_MEDIUM)
  endtask
endclass

      
      //irq_enable
      
class packet_irq_enable_reg_seq extends packet_base_reg_seq;
  `uvm_object_utils(packet_irq_enable_reg_seq)

  uvm_status_e status;
  uvm_reg_data_t rdata;

  function new(string name = "packet_irq_enable_reg_seq");
    super.new(name);
  endfunction

  task body();
    pkt_regmodel.lock.write(status, 32'hA5A5_C3C3, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("IRQ_ENABLE", "Failed to unlock DUT")
      return;
    end

    pkt_regmodel.irq_enable.read(status, rdata, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("IRQ_ENABLE", "Failed to read reset value")
      return;
    end

    if (rdata != 32'h00000000)
      `uvm_error("IRQ_ENABLE", $sformatf("Reset value mismatch: Expected 0x00000000, Got 0x%08h", rdata))
    else
      `uvm_info("IRQ_ENABLE", "Reset value matched: 0x00000000", UVM_MEDIUM)

    pkt_regmodel.irq_enable.write(status, 32'h00000005, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("IRQ_ENABLE", "Write failed")
      return;
    end

    pkt_regmodel.irq_enable.read(status, rdata, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("IRQ_ENABLE", "Readback failed")
      return;
    end

    if (rdata != 32'h00000005)
      `uvm_error("IRQ_ENABLE", $sformatf("Readback mismatch: Expected 0x00000005, Got 0x%08h", rdata))
    else
      `uvm_info("IRQ_ENABLE", "Readback matched: 0x00000005", UVM_MEDIUM)
  endtask
endclass

      
      //irq_force
      
class packet_irq_force_reg_seq extends packet_base_reg_seq;
  `uvm_object_utils(packet_irq_force_reg_seq)

  uvm_status_e status;
  uvm_reg_data_t rdata;

  function new(string name = "packet_irq_force_reg_seq");
    super.new(name);
  endfunction

  task body();
    pkt_regmodel.irq_force.write(status, 32'h00000005, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("IRQ_FORCE", "Write to IRQ_FORCE failed")
      return;
    end

    `uvm_info("IRQ_FORCE", "Software interrupt force value written: 0x00000005", UVM_MEDIUM)
    
    pkt_regmodel.irq_force.read(status, rdata, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("IRQ_FORCE", "Read from IRQ_FORCE failed")
      return;
    end

    `uvm_info("IRQ_FORCE", $sformatf("IRQ_FORCE read data: 0x%08h", rdata), UVM_MEDIUM)

    pkt_regmodel.irq_status.read(status, rdata, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("IRQ_FORCE", "Failed to read IRQ_STATUS")
      return;
    end

    if ((rdata & 32'h00000005) == 32'h00000005)
      `uvm_info("IRQ_FORCE", "Forced interrupt status bits are set", UVM_MEDIUM)
    else
      `uvm_error("IRQ_FORCE", $sformatf("Expected IRQ_STATUS ; IRQ_STATUS=0x%08h", rdata))
  endtask
endclass

      
      //err_status
      
class packet_err_status_reg_seq extends packet_base_reg_seq;
  `uvm_object_utils(packet_err_status_reg_seq)

  uvm_status_e status;
  uvm_reg_data_t rdata;

  function new(string name = "packet_err_status_reg_seq");
    super.new(name);
  endfunction

  task body();
    pkt_regmodel.err_status.read(status, rdata, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("ERR_STATUS", "Failed to read reset value")
      return;
    end

    if (rdata != 32'h00000000)
      `uvm_error("ERR_STATUS", $sformatf("Reset value mismatch: Expected 0x00000000, Got 0x%08h", rdata))
    else
      `uvm_info("ERR_STATUS", "Reset value matched: 0x00000000", UVM_MEDIUM)

    pkt_regmodel.err_status.write(status, 32'hFFFFFFFF, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("ERR_STATUS", "W1c failed")
      return;
    end

    pkt_regmodel.err_status.read(status, rdata, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("ERR_STATUS", "Readback failed")
      return;
    end

    if (rdata != 32'h00000000)
      `uvm_error("ERR_STATUS", $sformatf("Expected cleared status 0x00000000, Got 0x%08h", rdata))
    else
      `uvm_info("ERR_STATUS", "Error status is clear", UVM_MEDIUM)
  endtask
endclass

      
      //err_enable
      
class packet_err_enable_reg_seq extends packet_base_reg_seq;
  `uvm_object_utils(packet_err_enable_reg_seq)

  uvm_status_e status;
  uvm_reg_data_t rdata;

  function new(string name = "packet_err_enable_reg_seq");
    super.new(name);
  endfunction

  task body();
    pkt_regmodel.lock.write(status, 32'hA5A5_C3C3, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("ERR_ENABLE", "Failed to unlock DUT")
      return;
    end

    pkt_regmodel.err_enable.read(status, rdata, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("ERR_ENABLE", "Failed to read reset value")
      return;
    end

    if (rdata != 32'h00000000)
      `uvm_error("ERR_ENABLE", $sformatf("Reset value mismatch: Expected 0x00000000, Got 0x%08h", rdata))
    else
      `uvm_info("ERR_ENABLE", "Reset value matched: 0x00000000", UVM_MEDIUM)

    pkt_regmodel.err_enable.write(status, 32'h00000005, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("ERR_ENABLE", "Write failed")
      return;
    end

    pkt_regmodel.err_enable.read(status, rdata, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("ERR_ENABLE", "Readback failed")
      return;
    end

    if (rdata != 32'h00000005)
      `uvm_error("ERR_ENABLE", $sformatf("Readback mismatch: Expected 0x00000005, Got 0x%08h", rdata))
    else
      `uvm_info("ERR_ENABLE", "Readback matched: 0x00000005", UVM_MEDIUM)
  endtask
endclass

      
      //err_inject
      
class packet_err_inject_reg_seq extends packet_base_reg_seq;
  `uvm_object_utils(packet_err_inject_reg_seq)

  uvm_status_e status;
  uvm_reg_data_t rdata;

  function new(string name = "packet_err_inject_reg_seq");
    super.new(name);
  endfunction

  task body();
    pkt_regmodel.err_inject.write(status, 32'h00000001, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("ERR_INJECT", "Write to ERR_INJECT failed")
      return;
    end

    `uvm_info("ERR_INJECT", "Error injection value written: 0x00000001", UVM_MEDIUM)

    pkt_regmodel.err_status.read(status, rdata, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("ERR_INJECT", "Failed to read ERR_STATUS")
      return;
    end

    if (rdata[0] == 1'b1)
      `uvm_info("ERR_INJECT", "Expected error status bit is set", UVM_MEDIUM)
    else
      `uvm_error("ERR_INJECT", $sformatf("Expected ERR_STATUS bit 0 to be set, Got 0x%08h", rdata))
  endtask
endclass

      //err_count
      
class packet_err_count_reg_seq extends packet_base_reg_seq;
  `uvm_object_utils(packet_err_count_reg_seq)

  uvm_status_e status;
  uvm_reg_data_t rdata;

  function new(string name = "packet_err_count_reg_seq");
    super.new(name);
  endfunction

  task body();
    pkt_regmodel.err_count.read(status, rdata, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("ERR_COUNT", "Failed to read ERR_COUNT")
      return;
    end

    if (rdata != 32'h00000000)
      `uvm_error("ERR_COUNT", $sformatf("Reset value mismatch: Expected 0x00000000, Got 0x%08h", rdata))
    else
      `uvm_info("ERR_COUNT", "Reset value matched: 0x00000000", UVM_MEDIUM)
  endtask
endclass

      
      //err_info
      
class packet_err_info_reg_seq extends packet_base_reg_seq;
  `uvm_object_utils(packet_err_info_reg_seq)

  uvm_status_e status;
  uvm_reg_data_t rdata;

  function new(string name = "packet_err_info_reg_seq");
    super.new(name);
  endfunction

  task body();
    pkt_regmodel.err_info.read(status, rdata, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("ERR_INFO", "Failed to read ERR_INFO")
      return;
    end

    if (rdata != 32'h00000000)
      `uvm_error("ERR_INFO", $sformatf("Reset value mismatch: Expected 0x00000000, Got 0x%08h", rdata))
    else
      `uvm_info("ERR_INFO", "Reset value matched: 0x00000000", UVM_MEDIUM)
  endtask
endclass

      //lock
      
class packet_lock_reg_seq extends packet_base_reg_seq;
  `uvm_object_utils(packet_lock_reg_seq)

  uvm_status_e status;
  uvm_reg_data_t rdata;

  function new(string name = "packet_lock_reg_seq");
    super.new(name);
  endfunction

  task body();
    pkt_regmodel.lock.read(status, rdata, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("LOCK", "Failed to read LOCK reset value")
      return;
    end

    if (rdata != 32'h00000001)
      `uvm_error("LOCK", $sformatf("Reset value mismatch: Expected 0x00000001, Got 0x%08h", rdata))
    else
      `uvm_info("LOCK", "Reset value matched: Locked", UVM_MEDIUM)

    pkt_regmodel.lock.write(status, 32'hA5A5_C3C3, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("LOCK", "Failed to write unlock key")
      return;
    end

    pkt_regmodel.lock.read(status, rdata, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("LOCK", "Failed to read LOCK after unlock")
      return;
    end

    if (rdata != 32'h00000000)
      `uvm_error("LOCK", $sformatf("Unlock failed: Expected 0x00000000, Got 0x%08h", rdata))
    else
      `uvm_info("LOCK", "Unlock successful", UVM_MEDIUM)
  endtask
endclass

      
      //soft_reset
      
class packet_soft_reset_reg_seq extends packet_base_reg_seq;
  `uvm_object_utils(packet_soft_reset_reg_seq)

  uvm_status_e status;
  uvm_reg_data_t rdata;

  function new(string name = "packet_soft_reset_reg_seq");
    super.new(name);
  endfunction

  task body();
    pkt_regmodel.soft_reset.write(status, 32'h00000001, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("SOFT_RESET", "Write to SOFT_RESET failed")
      return;
    end

    `uvm_info("SOFT_RESET", "Software reset  written", UVM_MEDIUM)

    #10;

    pkt_regmodel.lock.read(status, rdata, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("SOFT_RESET", "Failed to read LOCK after reset")
      return;
    end

    if (rdata != 32'h00000001)
      `uvm_error("SOFT_RESET", $sformatf("LOCK reset mismatch: Expected 0x00000001, Got 0x%08h", rdata))
    else
      `uvm_info("SOFT_RESET", "LOCK returned to reset state", UVM_MEDIUM)

    pkt_regmodel.port_enable.read(status, rdata, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("SOFT_RESET", "Failed to read PORT_ENABLE after reset")
      return;
    end

    if (rdata != 32'h0000000F)
      `uvm_error("SOFT_RESET", $sformatf("PORT_ENABLE reset mismatch: Expected 0x0000000F, Got 0x%08h", rdata))
    else
      `uvm_info("SOFT_RESET", "PORT_ENABLE returned to reset state", UVM_MEDIUM)
  endtask
endclass

      
      //6.1 and 6.2 generate 4 packets from source 0 to dest 1 and clear sticky bits
      
class packet_generate_four_packets_seq extends packet_base_reg_seq;
  `uvm_object_utils(packet_generate_four_packets_seq)

  uvm_status_e status;
  uvm_reg_data_t rdata;
  bit done;

  function new(string name = "packet_generate_four_packets_seq");
    super.new(name);
  endfunction

  task body();
    done = 0;

    pkt_regmodel.lock.write(status, 32'hA5A5_C3C3, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("GEN4", "Failed to unlock configuration")
      return;
    end

    pkt_regmodel.irq_status.write(status, 32'h000000FF, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("GEN4", "Failed to clear IRQ_STATUS")
      return;
    end

    pkt_regmodel.port_enable.write(status, 32'h0000000F, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("GEN4", "PORT_ENABLE write failed")
      return;
    end

    pkt_regmodel.fwd_enable.write(status, 32'h0000000F, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("GEN4", "FWD_ENABLE write failed")
      return;
    end

    pkt_regmodel.switch_ctrl.write(status, 32'h00000009, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("GEN4", "SWITCH_CTRL write failed")
      return;
    end

    pkt_regmodel.gen_pkt_cfg.write(status, 32'h00100401, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("GEN4", "GEN_PKT_CFG write failed")
      return;
    end

    pkt_regmodel.gen_interval.write(status, 32'h00000002, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("GEN4", "GEN_INTERVAL write failed")
      return;
    end

    pkt_regmodel.gen_count.write(status, 32'h00000004, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("GEN4", "GEN_COUNT write failed")
      return;
    end

    pkt_regmodel.irq_enable.write(status, 32'h00000041, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("GEN4", "IRQ_ENABLE write failed")
      return;
    end

    pkt_regmodel.gen_ctrl.write(status, 32'h00000003, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("GEN4", "Failed to start packet generator")
      return;
    end

    `uvm_info("GEN4", "Packet generator started for four packets", UVM_MEDIUM)

    for (int i = 0; i < 100; i++) begin
      pkt_regmodel.irq_status.read(status, rdata, UVM_FRONTDOOR);
      if (status != UVM_IS_OK) begin
        `uvm_error("GEN4", "Failed to poll IRQ_STATUS")
        return;
      end

      if (rdata[0]) begin
        done = 1;
        break;
      end
    end

  
    if (!done) begin
      `uvm_error("GEN4", "Timeout waiting for IRQ_STATUS.GEN_DONE")
      return;
    end

    pkt_regmodel.stat_rx.read(status, rdata, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("GEN4", "Failed to read STAT_RX")
      return;
    end
    if (rdata != 32'h00000004)
      `uvm_error("GEN4", $sformatf("STAT_RX mismatch: Expected 4, Got %0d", rdata))
    else
      `uvm_info("GEN4", "STAT_RX matched: 4", UVM_MEDIUM)

    pkt_regmodel.stat_tx.read(status, rdata, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("GEN4", "Failed to read STAT_TX")
      return;
    end
    if (rdata != 32'h00000004)
      `uvm_error("GEN4", $sformatf("STAT_TX mismatch: Expected 4, Got %0d", rdata))
    else
      `uvm_info("GEN4", "STAT_TX matched: 4", UVM_MEDIUM)

    pkt_regmodel.stat_drop.read(status, rdata, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("GEN4", "Failed to read STAT_DROP")
      return;
    end
    if (rdata != 32'h00000000)
      `uvm_error("GEN4", $sformatf("STAT_DROP mismatch: Expected 0, Got %0d", rdata))
    else
      `uvm_info("GEN4", "STAT_DROP matched: 0", UVM_MEDIUM)

    pkt_regmodel.gen_status.read(status, rdata, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("GEN4", "Failed to read GEN_STATUS")
      return;
    end

    if (rdata[1])
  `uvm_info("GEN4", "Generator completed successfully", UVM_MEDIUM)
else
  `uvm_error("GEN4", "Generator has not completed")
  

    pkt_regmodel.irq_status.read(status, rdata, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("GEN4", "Failed to read final IRQ_STATUS")
      return;
    end

    if (!rdata[0])
      `uvm_error("GEN4", "IRQ_STATUS.GEN_DONE is not set")
    else
      `uvm_info("GEN4", "IRQ_STATUS.GEN_DONE is set", UVM_MEDIUM)

    if (!rdata[6])
      `uvm_error("GEN4", "IRQ_STATUS.START_ACK is not set")
    else
      `uvm_info("GEN4", "IRQ_STATUS.START_ACK is set", UVM_MEDIUM)
      
          pkt_regmodel.irq_status.write(status, 32'h00000041, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("GEN4", "Failed to clear GEN_DONE and START_ACK")
      return;
    end

    pkt_regmodel.irq_status.write(status, 32'h000000FF, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("GEN4", "Failed to clear all implemented IRQ bits")
      return;
    end

    `uvm_info("GEN4", "Sticky IRQ status bits cleared successfully", UVM_MEDIUM)
    
  endtask
endclass

      
 //6.3
class packet_destination_drop_seq extends packet_base_reg_seq;
  `uvm_object_utils(packet_destination_drop_seq)

  uvm_status_e status;
  uvm_reg_data_t rdata;
  uvm_reg_data_t initial_drop;
  bit done;

  function new(string name = "packet_destination_drop_seq");
    super.new(name);
  endfunction

  task body();
    done = 0;

    pkt_regmodel.lock.write(status, 32'hA5A5_C3C3, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("DEST_DROP", "Failed to unlock configuration")
      return;
    end

    pkt_regmodel.irq_status.write(status, 32'h000000FF, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("DEST_DROP", "Failed to clear IRQ_STATUS")
      return;
    end

    pkt_regmodel.err_status.write(status, 32'h00000002, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("DEST_DROP", "Failed to clear ERR_STATUS.DEST_ERROR")
      return;
    end

    pkt_regmodel.stat_drop.read(status, initial_drop, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("DEST_DROP", "Failed to read initial STAT_DROP")
      return;
    end

    pkt_regmodel.port_enable.write(status, 32'h0000000F, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("DEST_DROP", "PORT_ENABLE write failed")
      return;
    end

    pkt_regmodel.fwd_enable.write(status, 32'h00000001, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("DEST_DROP", "FWD_ENABLE write failed")
      return;
    end

    pkt_regmodel.switch_ctrl.write(status, 32'h00000009, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("DEST_DROP", "SWITCH_CTRL write failed")
      return;
    end

    pkt_regmodel.gen_pkt_cfg.write(status, 32'h00100401, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("DEST_DROP", "GEN_PKT_CFG write failed")
      return;
    end

    pkt_regmodel.gen_interval.write(status, 32'h00000002, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("DEST_DROP", "GEN_INTERVAL write failed")
      return;
    end

    pkt_regmodel.gen_count.write(status, 32'h00000001, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("DEST_DROP", "GEN_COUNT write failed")
      return;
    end

    pkt_regmodel.irq_enable.write(status, 32'h00000008, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("DEST_DROP", "IRQ_ENABLE write failed")
      return;
    end

    pkt_regmodel.gen_ctrl.write(status, 32'h00000003, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("DEST_DROP", "Failed to start packet generator")
      return;
    end

    `uvm_info("DEST_DROP", "Started one packet targeting disabled destination 1", UVM_MEDIUM)

    for (int i = 0; i < 100; i++) begin
      pkt_regmodel.irq_status.read(status, rdata, UVM_FRONTDOOR);
      if (status != UVM_IS_OK) begin
        `uvm_error("DEST_DROP", "Failed to poll IRQ_STATUS")
        return;
      end

      if (rdata[3]) begin
        done = 1;
        break;
      end
    end

    if (!done) begin
      `uvm_error("DEST_DROP", "Timeout waiting for IRQ_STATUS.PACKET_DROPPED")
      return;
    end

    pkt_regmodel.err_status.read(status, rdata, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("DEST_DROP", "Failed to read ERR_STATUS")
      return;
    end

    if (rdata[1])
      `uvm_info("DEST_DROP", "ERR_STATUS.DEST_ERROR is set", UVM_MEDIUM)
    else
      `uvm_error("DEST_DROP", "ERR_STATUS.DEST_ERROR is not set")

    pkt_regmodel.stat_drop.read(status, rdata, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("DEST_DROP", "Failed to read STAT_DROP")
      return;
    end

    if (rdata == initial_drop + 1)
      `uvm_info("DEST_DROP", "STAT_DROP incremented by one", UVM_MEDIUM)
    else
      `uvm_error("DEST_DROP", $sformatf("STAT_DROP mismatch: Initial=%0d Expected=%0d Got=%0d", initial_drop, initial_drop + 1, rdata))

    pkt_regmodel.irq_status.read(status, rdata, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("DEST_DROP", "Failed to read final IRQ_STATUS")
      return;
    end

    if (rdata[3])
      `uvm_info("DEST_DROP", "IRQ_STATUS.PACKET_DROPPED is set", UVM_MEDIUM)
    else
      `uvm_error("DEST_DROP", "IRQ_STATUS.PACKET_DROPPED is not set")
  endtask
endclass

      
      //unalligned access addr - 02
      class packet_unaligned_access_seq extends uvm_sequence #(packet_seq_item);
  `uvm_object_utils(packet_unaligned_access_seq)

  packet_seq_item req;

  function new(string name = "packet_unaligned_access_seq");
    super.new(name);
  endfunction

  task body();
    req = packet_seq_item::type_id::create("req");

    start_item(req);
    req.paddr = 32'h02;
    req.pwrite = 1;
    req.pwdata = 32'hA5A5A5A5;
    finish_item(req);

    if (req.pslverr !== 1'b1)
      `uvm_error("UNALIGNED", "PSLVERR was not asserted for unaligned write")

    req = packet_seq_item::type_id::create("req");
    start_item(req);
    req.paddr = 32'h02;
    req.pwrite = 0;
    req.pwdata = 0;
    finish_item(req);

    if (req.pslverr !== 1'b1)
      `uvm_error("UNALIGNED", "PSLVERR was not asserted for unaligned read")

    if (req.prdata !== 32'h00000000)
      `uvm_error("UNALIGNED", $sformatf("Expected PRDATA=0, got %0h", req.prdata))

    `uvm_info("UNALIGNED", "Unaligned access test completed", UVM_MEDIUM)
  endtask
endclass
      
      
      //error case -unmapped addr addr greater than 60
      class packet_unmapped_access_seq extends uvm_sequence #(packet_seq_item);
  `uvm_object_utils(packet_unmapped_access_seq)

  packet_seq_item req;

  function new(string name = "packet_unmapped_access_seq");
    super.new(name);
  endfunction

  task body();
    req = packet_seq_item::type_id::create("req");

    start_item(req);
    req.paddr = 32'h64;
    req.pwrite = 1;
    req.pwdata = 32'h12345678;
    finish_item(req);

    if (req.pslverr !== 1'b1)
      `uvm_error("UNMAPPED", "PSLVERR was not asserted for unmapped write")

    req = packet_seq_item::type_id::create("req");
    start_item(req);
    req.paddr = 32'h64;
    req.pwrite = 0;
    req.pwdata = 0;
    finish_item(req);

    if (req.pslverr !== 1'b1)
      `uvm_error("UNMAPPED", "PSLVERR was not asserted for unmapped read")

    if (req.prdata !== 32'h00000000)
      `uvm_error("UNMAPPED", $sformatf("Expected PRDATA=0, got %0h", req.prdata))

    `uvm_info("UNMAPPED", "Unmapped access test completed", UVM_MEDIUM)
  endtask
endclass
      
      
 //ro reg - read- write - read checking
      class packet_ro_write_seq extends uvm_sequence #(packet_seq_item);
  `uvm_object_utils(packet_ro_write_seq)

  packet_reg_block pkt_regmodel;
  uvm_status_e status;
  uvm_reg_data_t rdata;

  function new(string name = "packet_ro_write_seq");
    super.new(name);
  endfunction

  task body();

    pkt_regmodel.device_id.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("RO_TEST", $sformatf("DEVICE_ID before write = %08h", rdata), UVM_MEDIUM)
    pkt_regmodel.device_id.write(status, 32'hFFFFFFFF, UVM_FRONTDOOR);
    pkt_regmodel.device_id.read(status, rdata, UVM_FRONTDOOR);
    if (rdata != 32'h02A55357)
      `uvm_error("RO_TEST", $sformatf("DEVICE_ID changed: %08h", rdata))

    pkt_regmodel.version.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("RO_TEST", $sformatf("VERSION before write = %08h", rdata), UVM_MEDIUM)
    pkt_regmodel.version.write(status, 32'hFFFFFFFF, UVM_FRONTDOOR);
    pkt_regmodel.version.read(status, rdata, UVM_FRONTDOOR);
    if (rdata != 32'h00010200)
      `uvm_error("RO_TEST", $sformatf("VERSION changed: %08h", rdata))

    pkt_regmodel.switch_status.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("RO_TEST", $sformatf("SWITCH_STATUS before write = %08h", rdata), UVM_MEDIUM)
    pkt_regmodel.switch_status.write(status, 32'hFFFFFFFF, UVM_FRONTDOOR);
    pkt_regmodel.switch_status.read(status, rdata, UVM_FRONTDOOR);
    if (rdata != 32'h000000F9)
      `uvm_error("RO_TEST", $sformatf("SWITCH_STATUS changed: %08h", rdata))

    pkt_regmodel.port_status.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("RO_TEST", $sformatf("PORT_STATUS before write = %08h", rdata), UVM_MEDIUM)
    pkt_regmodel.port_status.write(status, 32'hFFFFFFFF, UVM_FRONTDOOR);
    pkt_regmodel.port_status.read(status, rdata, UVM_FRONTDOOR);
    if (rdata != 32'h00000000)
      `uvm_error("RO_TEST", $sformatf("PORT_STATUS changed: %08h", rdata))

    pkt_regmodel.gen_status.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("RO_TEST", $sformatf("GEN_STATUS before write = %08h", rdata), UVM_MEDIUM)
    pkt_regmodel.gen_status.write(status, 32'hFFFFFFFF, UVM_FRONTDOOR);
    pkt_regmodel.gen_status.read(status, rdata, UVM_FRONTDOOR);
    if (rdata != 32'h00000000)
      `uvm_error("RO_TEST", $sformatf("GEN_STATUS changed: %08h", rdata))

    pkt_regmodel.stat_rx.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("RO_TEST", $sformatf("STAT_RX before write = %08h", rdata), UVM_MEDIUM)
    pkt_regmodel.stat_rx.write(status, 32'hFFFFFFFF, UVM_FRONTDOOR);
    pkt_regmodel.stat_rx.read(status, rdata, UVM_FRONTDOOR);
    if (rdata != 32'h00000000)
      `uvm_error("RO_TEST", $sformatf("STAT_RX changed: %08h", rdata))

    pkt_regmodel.stat_tx.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("RO_TEST", $sformatf("STAT_TX before write = %08h", rdata), UVM_MEDIUM)
    pkt_regmodel.stat_tx.write(status, 32'hFFFFFFFF, UVM_FRONTDOOR);
    pkt_regmodel.stat_tx.read(status, rdata, UVM_FRONTDOOR);
    if (rdata != 32'h00000000)
      `uvm_error("RO_TEST", $sformatf("STAT_TX changed: %08h", rdata))

    pkt_regmodel.stat_drop.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("RO_TEST", $sformatf("STAT_DROP before write = %08h", rdata), UVM_MEDIUM)
    pkt_regmodel.stat_drop.write(status, 32'hFFFFFFFF, UVM_FRONTDOOR);
    pkt_regmodel.stat_drop.read(status, rdata, UVM_FRONTDOOR);
    if (rdata != 32'h00000000)
      `uvm_error("RO_TEST", $sformatf("STAT_DROP changed: %08h", rdata))

    pkt_regmodel.err_count.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("RO_TEST", $sformatf("ERR_COUNT before write = %08h", rdata), UVM_MEDIUM)
    pkt_regmodel.err_count.write(status, 32'hFFFFFFFF, UVM_FRONTDOOR);
    pkt_regmodel.err_count.read(status, rdata, UVM_FRONTDOOR);
    if (rdata != 32'h00000000)
      `uvm_error("RO_TEST", $sformatf("ERR_COUNT changed: %08h", rdata))

    pkt_regmodel.err_info.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("RO_TEST", $sformatf("ERR_INFO before write = %08h", rdata), UVM_MEDIUM)
    pkt_regmodel.err_info.write(status, 32'hFFFFFFFF, UVM_FRONTDOOR);
    pkt_regmodel.err_info.read(status, rdata, UVM_FRONTDOOR);
    if (rdata != 32'h00000000)
      `uvm_error("RO_TEST", $sformatf("ERR_INFO changed: %08h", rdata))

  endtask
endclass
      
      
      //wo reg check read shld have only defualt value
      class packet_wo_read_seq extends uvm_sequence #(packet_seq_item);
  `uvm_object_utils(packet_wo_read_seq)

  packet_reg_block pkt_regmodel;
  uvm_status_e status;
  uvm_reg_data_t rdata;

  function new(string name = "packet_wo_read_seq");
    super.new(name);
  endfunction

  task body();

    pkt_regmodel.switch_ctrl.read(status, rdata, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_error("WO_TEST", "SWITCH_CTRL read failed")
    else if (rdata != 32'h00000000)
      `uvm_error("WO_TEST", $sformatf("SWITCH_CTRL read expected 0, got %08h", rdata))
    else
      `uvm_info("WO_TEST", "SWITCH_CTRL read returned 0", UVM_MEDIUM)

    pkt_regmodel.gen_ctrl.read(status, rdata, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_error("WO_TEST", "GEN_CTRL read failed")
    else if (rdata != 32'h00000000)
      `uvm_error("WO_TEST", $sformatf("GEN_CTRL read expected 0, got %08h", rdata))
    else
      `uvm_info("WO_TEST", "GEN_CTRL read returned 0", UVM_MEDIUM)

    pkt_regmodel.err_inject.read(status, rdata, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_error("WO_TEST", "ERR_INJECT read failed")
    else if (rdata != 32'h00000000)
      `uvm_error("WO_TEST", $sformatf("ERR_INJECT read expected 0, got %08h", rdata))
    else
      `uvm_info("WO_TEST", "ERR_INJECT read returned 0", UVM_MEDIUM)

    pkt_regmodel.soft_reset.read(status, rdata, UVM_FRONTDOOR);
    if (status != UVM_IS_OK)
      `uvm_error("WO_TEST", "SOFT_RESET read failed")
    else if (rdata != 32'h00000000)
      `uvm_error("WO_TEST", $sformatf("SOFT_RESET read expected 0, got %08h", rdata))
    else
      `uvm_info("WO_TEST", "SOFT_RESET read returned 0", UVM_MEDIUM)

  endtask
endclass
      
      
      //error check - writing to reg when locked shld ignore the write
      class packet_locked_write_seq extends uvm_sequence #(packet_seq_item);
  `uvm_object_utils(packet_locked_write_seq)

  packet_reg_block pkt_regmodel;
  uvm_status_e status;
  uvm_reg_data_t rdata;

  function new(string name = "packet_locked_write_seq");
    super.new(name);
  endfunction

  task body();

    pkt_regmodel.lock.write(status, 32'hA5A5C3C3, UVM_FRONTDOOR);

    pkt_regmodel.switch_ctrl.write(status, 32'h00000000, UVM_FRONTDOOR);
    pkt_regmodel.port_enable.write(status, 32'h0000000F, UVM_FRONTDOOR);
    pkt_regmodel.fwd_enable.write(status, 32'h0000000F, UVM_FRONTDOOR);
    pkt_regmodel.gen_ctrl.write(status, 32'h00000000, UVM_FRONTDOOR);
    pkt_regmodel.gen_pkt_cfg.write(status, 32'h00000401, UVM_FRONTDOOR);
    pkt_regmodel.gen_interval.write(status, 32'h00000002, UVM_FRONTDOOR);
    pkt_regmodel.gen_count.write(status, 32'h00000004, UVM_FRONTDOOR);
    pkt_regmodel.irq_enable.write(status, 32'h00000000, UVM_FRONTDOOR);
    pkt_regmodel.err_enable.write(status, 32'h00000000, UVM_FRONTDOOR);

    pkt_regmodel.switch_ctrl.read(status, rdata, UVM_FRONTDOOR);
    if (rdata != 32'h00000000)
      `uvm_error("LOCK_TEST", $sformatf("SWITCH_CTRL initial value incorrect: %08h", rdata))

    pkt_regmodel.port_enable.read(status, rdata, UVM_FRONTDOOR);
    if (rdata != 32'h0000000F)
      `uvm_error("LOCK_TEST", $sformatf("PORT_ENABLE initial value incorrect: %08h", rdata))

    pkt_regmodel.fwd_enable.read(status, rdata, UVM_FRONTDOOR);
    if (rdata != 32'h0000000F)
      `uvm_error("LOCK_TEST", $sformatf("FWD_ENABLE initial value incorrect: %08h", rdata))

    pkt_regmodel.gen_ctrl.read(status, rdata, UVM_FRONTDOOR);
    if (rdata != 32'h00000000)
      `uvm_error("LOCK_TEST", $sformatf("GEN_CTRL initial value incorrect: %08h", rdata))

    pkt_regmodel.gen_pkt_cfg.read(status, rdata, UVM_FRONTDOOR);
    if (rdata != 32'h00000401)
      `uvm_error("LOCK_TEST", $sformatf("GEN_PKT_CFG initial value incorrect: %08h", rdata))

    pkt_regmodel.gen_interval.read(status, rdata, UVM_FRONTDOOR);
    if (rdata != 32'h00000002)
      `uvm_error("LOCK_TEST", $sformatf("GEN_INTERVAL initial value incorrect: %08h", rdata))

    pkt_regmodel.gen_count.read(status, rdata, UVM_FRONTDOOR);
    if (rdata != 32'h00000004)
      `uvm_error("LOCK_TEST", $sformatf("GEN_COUNT initial value incorrect: %08h", rdata))

    pkt_regmodel.irq_enable.read(status, rdata, UVM_FRONTDOOR);
    if (rdata != 32'h00000000)
      `uvm_error("LOCK_TEST", $sformatf("IRQ_ENABLE initial value incorrect: %08h", rdata))

    pkt_regmodel.err_enable.read(status, rdata, UVM_FRONTDOOR);
    if (rdata != 32'h00000000)
      `uvm_error("LOCK_TEST", $sformatf("ERR_ENABLE initial value incorrect: %08h", rdata))

    pkt_regmodel.lock.write(status, 32'h00000000, UVM_FRONTDOOR);

    pkt_regmodel.switch_ctrl.write(status, 32'hFFFFFFFF, UVM_FRONTDOOR);
    pkt_regmodel.port_enable.write(status, 32'h00000000, UVM_FRONTDOOR);
    pkt_regmodel.fwd_enable.write(status, 32'h00000000, UVM_FRONTDOOR);
    pkt_regmodel.gen_ctrl.write(status, 32'hFFFFFFFF, UVM_FRONTDOOR);
    pkt_regmodel.gen_pkt_cfg.write(status, 32'hFFFFFFFF, UVM_FRONTDOOR);
    pkt_regmodel.gen_interval.write(status, 32'hFFFFFFFF, UVM_FRONTDOOR);
    pkt_regmodel.gen_count.write(status, 32'hFFFFFFFF, UVM_FRONTDOOR);
    pkt_regmodel.irq_enable.write(status, 32'hFFFFFFFF, UVM_FRONTDOOR);
    pkt_regmodel.err_enable.write(status, 32'hFFFFFFFF, UVM_FRONTDOOR);

    pkt_regmodel.switch_ctrl.read(status, rdata, UVM_FRONTDOOR);
    if (rdata != 32'h00000000)
      `uvm_error("LOCK_TEST", $sformatf("SWITCH_CTRL changed while locked: %08h", rdata))
    else
      `uvm_info("LOCK_TEST", "SWITCH_CTRL write ignored while locked", UVM_MEDIUM)

    pkt_regmodel.port_enable.read(status, rdata, UVM_FRONTDOOR);
    if (rdata != 32'h0000000F)
      `uvm_error("LOCK_TEST", $sformatf("PORT_ENABLE changed while locked: %08h", rdata))
    else
      `uvm_info("LOCK_TEST", "PORT_ENABLE write ignored while locked", UVM_MEDIUM)

    pkt_regmodel.fwd_enable.read(status, rdata, UVM_FRONTDOOR);
    if (rdata != 32'h0000000F)
      `uvm_error("LOCK_TEST", $sformatf("FWD_ENABLE changed while locked: %08h", rdata))
    else
      `uvm_info("LOCK_TEST", "FWD_ENABLE write ignored while locked", UVM_MEDIUM)

    pkt_regmodel.gen_ctrl.read(status, rdata, UVM_FRONTDOOR);
    if (rdata != 32'h00000000)
      `uvm_error("LOCK_TEST", $sformatf("GEN_CTRL changed while locked: %08h", rdata))
    else
      `uvm_info("LOCK_TEST", "GEN_CTRL write ignored while locked", UVM_MEDIUM)

    pkt_regmodel.gen_pkt_cfg.read(status, rdata, UVM_FRONTDOOR);
    if (rdata != 32'h00000401)
      `uvm_error("LOCK_TEST", $sformatf("GEN_PKT_CFG changed while locked: %08h", rdata))
    else
      `uvm_info("LOCK_TEST", "GEN_PKT_CFG write ignored while locked", UVM_MEDIUM)

    pkt_regmodel.gen_interval.read(status, rdata, UVM_FRONTDOOR);
    if (rdata != 32'h00000002)
      `uvm_error("LOCK_TEST", $sformatf("GEN_INTERVAL changed while locked: %08h", rdata))
    else
      `uvm_info("LOCK_TEST", "GEN_INTERVAL write ignored while locked", UVM_MEDIUM)

    pkt_regmodel.gen_count.read(status, rdata, UVM_FRONTDOOR);
    if (rdata != 32'h00000004)
      `uvm_error("LOCK_TEST", $sformatf("GEN_COUNT changed while locked: %08h", rdata))
    else
      `uvm_info("LOCK_TEST", "GEN_COUNT write ignored while locked", UVM_MEDIUM)

    pkt_regmodel.irq_enable.read(status, rdata, UVM_FRONTDOOR);
    if (rdata != 32'h00000000)
      `uvm_error("LOCK_TEST", $sformatf("IRQ_ENABLE changed while locked: %08h", rdata))
    else
      `uvm_info("LOCK_TEST", "IRQ_ENABLE write ignored while locked", UVM_MEDIUM)

    pkt_regmodel.err_enable.read(status, rdata, UVM_FRONTDOOR);
    if (rdata != 32'h00000000)
      `uvm_error("LOCK_TEST", $sformatf("ERR_ENABLE changed while locked: %08h", rdata))
    else
      `uvm_info("LOCK_TEST", "ERR_ENABLE write ignored while locked", UVM_MEDIUM)

  endtask
endclass
      
  
        //after running coverage
    //src_port2 missing sequence
    class packet_gen_pkt_cfg_src_port2_seq extends packet_base_reg_seq;
  `uvm_object_utils(packet_gen_pkt_cfg_src_port2_seq)

  uvm_status_e status;
  uvm_reg_data_t rdata;
  uvm_reg_data_t wdata;

  function new(string name = "packet_gen_pkt_cfg_src_port2_seq");
    super.new(name);
  endfunction

  task body();

    pkt_regmodel.lock.write(status, 32'hA5A5_C3C3, UVM_FRONTDOOR);

    pkt_regmodel.gen_pkt_cfg.read(status, rdata, UVM_FRONTDOOR);

    wdata = (rdata & 32'hFFFFFFF3) | 32'h00000008;

    pkt_regmodel.gen_pkt_cfg.write(status, wdata, UVM_FRONTDOOR);

    pkt_regmodel.gen_pkt_cfg.read(status, rdata, UVM_FRONTDOOR);

    if (((rdata >> 2) & 2'b11) != 2'b10)
      `uvm_error("SRC_PORT", $sformatf("Expected SRC_PORT=2, got %0d", ((rdata >> 2) & 2'b11)))
    else
      `uvm_info("SRC_PORT", "SRC_PORT=2 verified successfully", UVM_MEDIUM)

  endtask
endclass
      
      
       //interval med bin
class packet_generate_four_packets_seq1 extends packet_base_reg_seq;
  `uvm_object_utils(packet_generate_four_packets_seq1)

  uvm_status_e status;
  uvm_reg_data_t rdata;
  bit done;
  int no_of_transactions = 100;

  function new(string name = "packet_generate_four_packets_seq1");
    super.new(name);
  endfunction

  task body();
      done = 0;

      pkt_regmodel.lock.write(status, 32'hA5A5_C3C3, UVM_FRONTDOOR);
      if (status != UVM_IS_OK) begin
        `uvm_error("GEN4", "Failed to unlock configuration")
        return;
      end

      pkt_regmodel.irq_status.write(status, 32'h000000FF, UVM_FRONTDOOR);
      if (status != UVM_IS_OK) begin
        `uvm_error("GEN4", "Failed to clear IRQ_STATUS")
        return;
      end

      pkt_regmodel.port_enable.write(status, 32'h0000000F, UVM_FRONTDOOR);
      if (status != UVM_IS_OK) begin
        `uvm_error("GEN4", "PORT_ENABLE write failed")
        return;
      end

      pkt_regmodel.fwd_enable.write(status, 32'h0000000F, UVM_FRONTDOOR);
      if (status != UVM_IS_OK) begin
        `uvm_error("GEN4", "FWD_ENABLE write failed")
        return;
      end

      pkt_regmodel.switch_ctrl.write(status, 32'h00000009, UVM_FRONTDOOR);
      if (status != UVM_IS_OK) begin
        `uvm_error("GEN4", "SWITCH_CTRL write failed")
        return;
      end

      pkt_regmodel.gen_pkt_cfg.write(status, 32'h00100401, UVM_FRONTDOOR);
      if (status != UVM_IS_OK) begin
        `uvm_error("GEN4", "GEN_PKT_CFG write failed")
        return;
      end

      pkt_regmodel.gen_interval.write(status, $urandom_range(11, 100), UVM_FRONTDOOR);
      if (status != UVM_IS_OK) begin
        `uvm_error("GEN4", "GEN_INTERVAL write failed")
        return;
      end

      pkt_regmodel.gen_count.write(status, 32'h00000004, UVM_FRONTDOOR);
      if (status != UVM_IS_OK) begin
        `uvm_error("GEN4", "GEN_COUNT write failed")
        return;
      end

      pkt_regmodel.irq_enable.write(status, 32'h00000041, UVM_FRONTDOOR);
      if (status != UVM_IS_OK) begin
        `uvm_error("GEN4", "IRQ_ENABLE write failed")
        return;
      end

      pkt_regmodel.gen_ctrl.write(status, 32'h00000003, UVM_FRONTDOOR);
      if (status != UVM_IS_OK) begin
        `uvm_error("GEN4", "Failed to start packet generator")
        return;
      end

      `uvm_info("GEN4", $sformatf("Transaction %0d started", no_of_transactions), UVM_MEDIUM)

      for (int i = 0; i < 100; i++) begin
        pkt_regmodel.irq_status.read(status, rdata, UVM_FRONTDOOR);
        if (status != UVM_IS_OK) begin
          `uvm_error("GEN4", "Failed to poll IRQ_STATUS")
          return;
        end

        if (rdata[0]) begin
          done = 1;
          break;
        end
      end

      if (!done) begin
        `uvm_error("GEN4", "Timeout waiting for IRQ_STATUS.GEN_DONE")
        return;
      end

      pkt_regmodel.stat_rx.read(status, rdata, UVM_FRONTDOOR);
      if (status != UVM_IS_OK) begin
        `uvm_error("GEN4", "Failed to read STAT_RX")
        return;
      end
      if (rdata != 32'h00000004)
        `uvm_error("GEN4", $sformatf("STAT_RX mismatch: Expected 4, Got %0d", rdata))
      else
        `uvm_info("GEN4", "STAT_RX matched: 4", UVM_MEDIUM)

      pkt_regmodel.stat_tx.read(status, rdata, UVM_FRONTDOOR);
      if (status != UVM_IS_OK) begin
        `uvm_error("GEN4", "Failed to read STAT_TX")
        return;
      end
      if (rdata != 32'h00000004)
        `uvm_error("GEN4", $sformatf("STAT_TX mismatch: Expected 4, Got %0d", rdata))
      else
        `uvm_info("GEN4", "STAT_TX matched: 4", UVM_MEDIUM)

      pkt_regmodel.stat_drop.read(status, rdata, UVM_FRONTDOOR);
      if (status != UVM_IS_OK) begin
        `uvm_error("GEN4", "Failed to read STAT_DROP")
        return;
      end
      if (rdata != 32'h00000000)
        `uvm_error("GEN4", $sformatf("STAT_DROP mismatch: Expected 0, Got %0d", rdata))
      else
        `uvm_info("GEN4", "STAT_DROP matched: 0", UVM_MEDIUM)

      pkt_regmodel.gen_status.read(status, rdata, UVM_FRONTDOOR);
      if (status != UVM_IS_OK) begin
        `uvm_error("GEN4", "Failed to read GEN_STATUS")
        return;
      end

      if (rdata[1])
        `uvm_info("GEN4", "Generator completed successfully", UVM_MEDIUM)
      else
        `uvm_error("GEN4", "Generator has not completed")

      pkt_regmodel.irq_status.read(status, rdata, UVM_FRONTDOOR);
      if (status != UVM_IS_OK) begin
        `uvm_error("GEN4", "Failed to read final IRQ_STATUS")
        return;
      end

      if (!rdata[0])
        `uvm_error("GEN4", "IRQ_STATUS.GEN_DONE is not set")
      else
        `uvm_info("GEN4", "IRQ_STATUS.GEN_DONE is set", UVM_MEDIUM)

      if (!rdata[6])
        `uvm_error("GEN4", "IRQ_STATUS.START_ACK is not set")
      else
        `uvm_info("GEN4", "IRQ_STATUS.START_ACK is set", UVM_MEDIUM)

      pkt_regmodel.irq_status.write(status, 32'h00000041, UVM_FRONTDOOR);
      if (status != UVM_IS_OK) begin
        `uvm_error("GEN4", "Failed to clear GEN_DONE and START_ACK")
        return;
      end

      pkt_regmodel.irq_status.write(status, 32'h000000FF, UVM_FRONTDOOR);
      if (status != UVM_IS_OK) begin
        `uvm_error("GEN4", "Failed to clear all implemented IRQ bits")
        return;
      end

      `uvm_info("GEN4", "Sticky IRQ status bits cleared successfully", UVM_MEDIUM)

  endtask
endclass

// stat_tx and rx count = 1

class packet_generate_four_packets_seq2 extends packet_base_reg_seq;
  `uvm_object_utils(packet_generate_four_packets_seq2)

  uvm_status_e status;
  uvm_reg_data_t rdata;
  bit done;
  int no_of_transactions = 100;

  function new(string name = "packet_generate_four_packets_seq2");
    super.new(name);
  endfunction

  task body();
      done = 0;

      pkt_regmodel.lock.write(status, 32'hA5A5_C3C3, UVM_FRONTDOOR);
      if (status != UVM_IS_OK) begin
        `uvm_error("GEN4", "Failed to unlock configuration")
        return;
      end

      pkt_regmodel.irq_status.write(status, 32'h000000FF, UVM_FRONTDOOR);
      if (status != UVM_IS_OK) begin
        `uvm_error("GEN4", "Failed to clear IRQ_STATUS")
        return;
      end

      pkt_regmodel.port_enable.write(status, 32'h0000000F, UVM_FRONTDOOR);
      if (status != UVM_IS_OK) begin
        `uvm_error("GEN4", "PORT_ENABLE write failed")
        return;
      end

      pkt_regmodel.fwd_enable.write(status, 32'h0000000F, UVM_FRONTDOOR);
      if (status != UVM_IS_OK) begin
        `uvm_error("GEN4", "FWD_ENABLE write failed")
        return;
      end

      pkt_regmodel.switch_ctrl.write(status, 32'h00000009, UVM_FRONTDOOR);
      if (status != UVM_IS_OK) begin
        `uvm_error("GEN4", "SWITCH_CTRL write failed")
        return;
      end

      pkt_regmodel.gen_pkt_cfg.write(status, 32'h00100401, UVM_FRONTDOOR);
      if (status != UVM_IS_OK) begin
        `uvm_error("GEN4", "GEN_PKT_CFG write failed")
        return;
      end

      pkt_regmodel.gen_interval.write(status, $urandom_range(11, 100), UVM_FRONTDOOR);
      if (status != UVM_IS_OK) begin
        `uvm_error("GEN4", "GEN_INTERVAL write failed")
        return;
      end

      pkt_regmodel.gen_count.write(status, 32'h00000001, UVM_FRONTDOOR);
      if (status != UVM_IS_OK) begin
        `uvm_error("GEN4", "GEN_COUNT write failed")
        return;
      end

      pkt_regmodel.irq_enable.write(status, 32'h00000041, UVM_FRONTDOOR);
      if (status != UVM_IS_OK) begin
        `uvm_error("GEN4", "IRQ_ENABLE write failed")
        return;
      end

      pkt_regmodel.gen_ctrl.write(status, 32'h00000003, UVM_FRONTDOOR);
      if (status != UVM_IS_OK) begin
        `uvm_error("GEN4", "Failed to start packet generator")
        return;
      end

      `uvm_info("GEN4", "Packet generator started for one packet", UVM_MEDIUM)

      for (int i = 0; i < 100; i++) begin
        pkt_regmodel.irq_status.read(status, rdata, UVM_FRONTDOOR);
        if (status != UVM_IS_OK) begin
          `uvm_error("GEN4", "Failed to poll IRQ_STATUS")
          return;
        end

        if (rdata[0]) begin
          done = 1;
          break;
        end
      end

      if (!done) begin
        `uvm_error("GEN4", "Timeout waiting for IRQ_STATUS.GEN_DONE")
        return;
      end

      pkt_regmodel.stat_rx.read(status, rdata, UVM_FRONTDOOR);
      if (status != UVM_IS_OK) begin
        `uvm_error("GEN4", "Failed to read STAT_RX")
        return;
      end
      if (rdata != 32'h00000001)
        `uvm_error("GEN4", $sformatf("STAT_RX mismatch: Expected 1, Got %0d", rdata))
      else
        `uvm_info("GEN4", "STAT_RX matched: 1", UVM_MEDIUM)

      pkt_regmodel.stat_tx.read(status, rdata, UVM_FRONTDOOR);
      if (status != UVM_IS_OK) begin
        `uvm_error("GEN4", "Failed to read STAT_TX")
        return;
      end
      if (rdata != 32'h00000001)
        `uvm_error("GEN4", $sformatf("STAT_TX mismatch: Expected 1, Got %0d", rdata))
      else
        `uvm_info("GEN4", "STAT_TX matched: 1", UVM_MEDIUM)

      pkt_regmodel.stat_drop.read(status, rdata, UVM_FRONTDOOR);
      if (status != UVM_IS_OK) begin
        `uvm_error("GEN4", "Failed to read STAT_DROP")
        return;
      end
      if (rdata != 32'h00000000)
        `uvm_error("GEN4", $sformatf("STAT_DROP mismatch: Expected 0, Got %0d", rdata))
      else
        `uvm_info("GEN4", "STAT_DROP matched: 0", UVM_MEDIUM)

      pkt_regmodel.gen_status.read(status, rdata, UVM_FRONTDOOR);
      if (status != UVM_IS_OK) begin
        `uvm_error("GEN4", "Failed to read GEN_STATUS")
        return;
      end

      if (rdata[1])
        `uvm_info("GEN4", "Generator completed successfully", UVM_MEDIUM)
      else
        `uvm_error("GEN4", "Generator has not completed")

      pkt_regmodel.irq_status.read(status, rdata, UVM_FRONTDOOR);
      if (status != UVM_IS_OK) begin
        `uvm_error("GEN4", "Failed to read final IRQ_STATUS")
        return;
      end

      if (!rdata[0])
        `uvm_error("GEN4", "IRQ_STATUS.GEN_DONE is not set")
      else
        `uvm_info("GEN4", "IRQ_STATUS.GEN_DONE is set", UVM_MEDIUM)

      if (!rdata[6])
        `uvm_error("GEN4", "IRQ_STATUS.START_ACK is not set")
      else
        `uvm_info("GEN4", "IRQ_STATUS.START_ACK is set", UVM_MEDIUM)

      pkt_regmodel.irq_status.write(status, 32'h00000041, UVM_FRONTDOOR);
      if (status != UVM_IS_OK) begin
        `uvm_error("GEN4", "Failed to clear GEN_DONE and START_ACK")
        return;
      end

      pkt_regmodel.irq_status.write(status, 32'h000000FF, UVM_FRONTDOOR);
      if (status != UVM_IS_OK) begin
        `uvm_error("GEN4", "Failed to clear all implemented IRQ bits")
        return;
      end

      `uvm_info("GEN4", "Sticky IRQ status bits cleared successfully", UVM_MEDIUM)

  endtask
endclass

//err_inject
class packet_err_inject_reg_seq1 extends packet_base_reg_seq;
  `uvm_object_utils(packet_err_inject_reg_seq1)

  uvm_status_e status;
  uvm_reg_data_t rdata;

  function new(string name = "packet_err_inject_reg_seq1");
    super.new(name);
  endfunction

  task body();

    pkt_regmodel.err_status.write(status, 32'h000000FF, UVM_FRONTDOOR);

    pkt_regmodel.err_inject.write(status, 32'h00000040, UVM_FRONTDOOR);
    pkt_regmodel.err_status.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("ERR_INJECT", $sformatf("LENGTH_ERROR status = 0x%08h", rdata), UVM_MEDIUM)
    pkt_regmodel.err_count.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("ERR_COUNT", $sformatf("ERR_COUNT after LENGTH_ERROR = %0d", rdata[15:0]), UVM_MEDIUM)

    pkt_regmodel.err_inject.write(status, 32'h00000020, UVM_FRONTDOOR);
    pkt_regmodel.err_status.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("ERR_INJECT", $sformatf("CRC_ERROR status = 0x%08h", rdata), UVM_MEDIUM)
    pkt_regmodel.err_count.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("ERR_COUNT", $sformatf("ERR_COUNT after CRC_ERROR = %0d", rdata[15:0]), UVM_MEDIUM)

    pkt_regmodel.err_inject.write(status, 32'h00000010, UVM_FRONTDOOR);
    pkt_regmodel.err_status.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("ERR_INJECT", $sformatf("PROTOCOL_ERROR status = 0x%08h", rdata), UVM_MEDIUM)
    pkt_regmodel.err_count.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("ERR_COUNT", $sformatf("ERR_COUNT after PROTOCOL_ERROR = %0d", rdata[15:0]), UVM_MEDIUM)

    pkt_regmodel.err_inject.write(status, 32'h00000008, UVM_FRONTDOOR);
    pkt_regmodel.err_status.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("ERR_INJECT", $sformatf("UNDERSIZE status = 0x%08h", rdata), UVM_MEDIUM)
    pkt_regmodel.err_count.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("ERR_COUNT", $sformatf("ERR_COUNT after UNDERSIZE = %0d", rdata[15:0]), UVM_MEDIUM)

    pkt_regmodel.err_inject.write(status, 32'h00000004, UVM_FRONTDOOR);
    pkt_regmodel.err_status.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("ERR_INJECT", $sformatf("QUEUE_OVERFLOW status = 0x%08h", rdata), UVM_MEDIUM)
    pkt_regmodel.err_count.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("ERR_COUNT", $sformatf("ERR_COUNT after QUEUE_OVERFLOW = %0d", rdata[15:0]), UVM_MEDIUM)

    pkt_regmodel.err_inject.write(status, 32'h00000002, UVM_FRONTDOOR);
    pkt_regmodel.err_status.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("ERR_INJECT", $sformatf("DEST_ERROR status = 0x%08h", rdata), UVM_MEDIUM)

    pkt_regmodel.err_info.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("ERR_INFO",
      $sformatf("ERR_INFO = 0x%08h, DEST_PORT = %0d, SOURCE = 0x%02h, LAST_CODE = 0x%02h",
      rdata, rdata[17:16], rdata[15:8], rdata[7:0]), UVM_MEDIUM)

    pkt_regmodel.err_count.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("ERR_COUNT", $sformatf("ERR_COUNT after DEST_ERROR = %0d", rdata[15:0]), UVM_MEDIUM)

    pkt_regmodel.err_inject.write(status, 32'h00000001, UVM_FRONTDOOR);
    pkt_regmodel.err_status.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("ERR_INJECT", $sformatf("BUS_ERROR status = 0x%08h", rdata), UVM_MEDIUM)
    pkt_regmodel.err_count.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("ERR_COUNT", $sformatf("ERR_COUNT after BUS_ERROR = %0d", rdata[15:0]), UVM_MEDIUM)

    pkt_regmodel.err_inject.write(status, 32'h00000080, UVM_FRONTDOOR);
    pkt_regmodel.err_status.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("ERR_INJECT",  $sformatf("ERR_STATUS after INJECTED command = 0x%08h", rdata),UVM_MEDIUM)
    pkt_regmodel.err_count.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("ERR_COUNT", $sformatf("ERR_COUNT after INJECTED command = %0d", rdata[15:0]), UVM_MEDIUM)

    pkt_regmodel.err_inject.write(status, 32'h80000000, UVM_FRONTDOOR);
    pkt_regmodel.err_count.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("ERR_INJECT", $sformatf("ERR_COUNT after CLEAR_COUNT = 0x%08h", rdata), UVM_MEDIUM)

    pkt_regmodel.err_info.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("ERR_INJECT", $sformatf("ERR_INFO after CLEAR_COUNT = 0x%08h", rdata), UVM_MEDIUM)

    pkt_regmodel.err_status.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("ERR_INJECT", $sformatf("Final ERR_STATUS = 0x%08h", rdata), UVM_MEDIUM)

  endtask
endclass

//err_info testing seq
class packet_err_info_port2_seq extends packet_base_reg_seq;
  `uvm_object_utils(packet_err_info_port2_seq)

  uvm_status_e status;
  uvm_reg_data_t rdata;

  function new(string name = "packet_err_info_port2_seq");
    super.new(name);
  endfunction

  task body();
    pkt_regmodel.lock.write(status, 32'hA5A5C3C3, UVM_FRONTDOOR);
    pkt_regmodel.gen_pkt_cfg.write(status, 32'h00000402, UVM_FRONTDOOR);
    pkt_regmodel.gen_count.write(status, 32'd4, UVM_FRONTDOOR);
    
   pkt_regmodel.switch_ctrl.write(status, 32'h00000001, UVM_FRONTDOOR);

pkt_regmodel.switch_ctrl.read(status, rdata, UVM_FRONTDOOR);
`uvm_info("REG_CHECK",$sformatf("SWITCH_CTRL = 0x%08h", rdata), UVM_MEDIUM)

pkt_regmodel.port_enable.read(status, rdata, UVM_FRONTDOOR);
`uvm_info("REG_CHECK",$sformatf("PORT_ENABLE = 0x%08h", rdata), UVM_MEDIUM)

pkt_regmodel.fwd_enable.read(status, rdata, UVM_FRONTDOOR);
`uvm_info("REG_CHECK",$sformatf("FWD_ENABLE = 0x%08h", rdata), UVM_MEDIUM)
    
    pkt_regmodel.gen_ctrl.write(status, 32'h00000003, UVM_FRONTDOOR);

    do begin
      pkt_regmodel.gen_status.read(status, rdata, UVM_FRONTDOOR);
    end while (rdata[1] == 0);

    pkt_regmodel.stat_tx.read(status, rdata, UVM_FRONTDOOR);
`uvm_info("TX_CHECK", $sformatf("STAT_TX = 0x%08h", rdata), UVM_MEDIUM)

pkt_regmodel.stat_rx.read(status, rdata, UVM_FRONTDOOR);
`uvm_info("RX_CHECK", $sformatf("STAT_RX = 0x%08h", rdata), UVM_MEDIUM)
    
    pkt_regmodel.stat_tx.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("TX_SNAPSHOT", $sformatf("STAT_TX = 0x%08h", rdata),  UVM_MEDIUM)

    pkt_regmodel.err_inject.write(status, 32'h00000002, UVM_FRONTDOOR);

    pkt_regmodel.err_info.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("ERR_INFO",$sformatf("ERR_INFO = 0x%08h, TX_SNAPSHOT = 0x%03h, DEST_PORT = %0d, SOURCE = 0x%02h, LAST_CODE = 0x%02h",rdata, rdata[31:20], rdata[17:16], rdata[15:8], rdata[7:0]), UVM_MEDIUM)
  endtask
endclass

    
    //port3 err info check
    class packet_err_info_port3_seq extends packet_base_reg_seq;
  `uvm_object_utils(packet_err_info_port3_seq)

  uvm_status_e status;
  uvm_reg_data_t rdata;

  function new(string name = "packet_err_info_port3_seq");
    super.new(name);
  endfunction

  task body();
    pkt_regmodel.lock.write(status, 32'hA5A5C3C3, UVM_FRONTDOOR);
    pkt_regmodel.gen_pkt_cfg.write(status, 32'h00000403, UVM_FRONTDOOR);
    pkt_regmodel.gen_count.write(status, 32'd4, UVM_FRONTDOOR);

    pkt_regmodel.switch_ctrl.write(status, 32'h00000001, UVM_FRONTDOOR);

    pkt_regmodel.switch_ctrl.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("REG_CHECK",$sformatf("SWITCH_CTRL = 0x%08h", rdata), UVM_MEDIUM)

    pkt_regmodel.port_enable.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("REG_CHECK", $sformatf("PORT_ENABLE = 0x%08h", rdata), UVM_MEDIUM)

    pkt_regmodel.fwd_enable.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("REG_CHECK",$sformatf("FWD_ENABLE = 0x%08h", rdata), UVM_MEDIUM)

    pkt_regmodel.gen_ctrl.write(status, 32'h00000003, UVM_FRONTDOOR);

    do begin
      pkt_regmodel.gen_status.read(status, rdata, UVM_FRONTDOOR);
    end while (rdata[1] == 0);

    pkt_regmodel.stat_tx.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("TX_CHECK",   $sformatf("STAT_TX = 0x%08h", rdata), UVM_MEDIUM)

    pkt_regmodel.stat_rx.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("RX_CHECK",  $sformatf("STAT_RX= 0x%08h", rdata), UVM_MEDIUM)

    pkt_regmodel.stat_tx.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("TX_SNAPSHOT",  $sformatf("STAT_TX = 0x%08h", rdata), UVM_MEDIUM)

    pkt_regmodel.err_inject.write(status, 32'h00000002, UVM_FRONTDOOR);

    pkt_regmodel.err_info.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("ERR_INFO",     $sformatf("ERR_INFO = 0x%08h, TX_SNAPSHOT = 0x%03h, DEST_PORT = %0d, SOURCE = 0x%02h, LAST_CODE = 0x%02h",rdata, rdata[31:20], rdata[17:16], rdata[15:8], rdata[7:0]), UVM_MEDIUM)
  endtask
endclass


class packet_irq_sw_event_error_seq extends packet_base_reg_seq;
  `uvm_object_utils(packet_irq_sw_event_error_seq)

  uvm_status_e status;
  uvm_reg_data_t rdata;

  function new(string name = "packet_irq_sw_event_error_seq");
    super.new(name);
  endfunction

  task body();

    pkt_regmodel.lock.write(status, 32'hA5A5C3C3, UVM_FRONTDOOR);
    pkt_regmodel.irq_enable.write(status, 32'h00000086, UVM_FRONTDOOR);
pkt_regmodel.irq_enable.read(status, rdata, UVM_FRONTDOOR);
`uvm_info("IRQ_CHECK", $sformatf("IRQ_ENABLE = 0x%08h", rdata), UVM_MEDIUM)
    
     pkt_regmodel.irq_force.write(status, 32'h00000080, UVM_FRONTDOOR);
    pkt_regmodel.irq_status.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("IRQ_CHECK", $sformatf("SW_EVENT: IRQ_STATUS = 0x%08h, SW_EVENT = %0b", rdata, rdata[7]), UVM_MEDIUM)

    pkt_regmodel.err_status.write(status, 32'h000000FF, UVM_FRONTDOOR);
    pkt_regmodel.err_enable.write(status, 32'h00000002, UVM_FRONTDOOR);

    pkt_regmodel.err_enable.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("IRQ_CHECK", $sformatf("ERR_ENABLE = 0x%08h", rdata), UVM_MEDIUM)

    pkt_regmodel.err_inject.write(status, 32'h00000002, UVM_FRONTDOOR);
    pkt_regmodel.switch_status.read(status, rdata, UVM_FRONTDOOR);
`uvm_info("SWITCH_STATUS", $sformatf("ERR_PENDING = %0b", rdata[9]), UVM_MEDIUM)

    pkt_regmodel.err_status.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("IRQ_CHECK", $sformatf("ERR_STATUS = 0x%08h", rdata), UVM_MEDIUM)

    pkt_regmodel.irq_status.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("IRQ_CHECK", $sformatf("ERROR: IRQ_STATUS = 0x%08h, ERROR = %0b", rdata, rdata[1]), UVM_MEDIUM)

    pkt_regmodel.gen_pkt_cfg.write(status, 32'h00001001, UVM_FRONTDOOR);
    pkt_regmodel.gen_interval.write(status, 32'h00000000, UVM_FRONTDOOR);
    pkt_regmodel.gen_count.write(status, 32'd4, UVM_FRONTDOOR);
    pkt_regmodel.switch_ctrl.write(status, 32'h00000001, UVM_FRONTDOOR);
    pkt_regmodel.switch_status.read(status, rdata, UVM_FRONTDOOR);
`uvm_info("SWITCH_STATUS",$sformatf("SWITCH_ENABLED = %0b", rdata[2]), UVM_MEDIUM)
`uvm_info("SWITCH_STATUS",$sformatf("PORT_ENABLED = 0x%0h", rdata[7:4]), UVM_MEDIUM)
    

    pkt_regmodel.gen_ctrl.write(status, 32'h00000003, UVM_FRONTDOOR);
    pkt_regmodel.switch_status.read(status, rdata, UVM_FRONTDOOR);
`uvm_info("SWITCH_STATUS",  $sformatf("BUSY = %0b", rdata[1]), UVM_MEDIUM)
`uvm_info("SWITCH_STATUS",$sformatf("PORT_ENABLED = 0x%0h", rdata[7:4]), UVM_MEDIUM)
    

    do begin
      pkt_regmodel.gen_status.read(status, rdata, UVM_FRONTDOOR);
    end while (rdata[1] == 0);
    
    pkt_regmodel.switch_status.read(status, rdata, UVM_FRONTDOOR);
`uvm_info("SWITCH_STATUS",
  $sformatf("GEN_RUNNING = %0b", rdata[8]), UVM_MEDIUM)

    pkt_regmodel.irq_status.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("IRQ_CHECK", $sformatf("QUEUE_OVERFLOW: IRQ_STATUS = 0x%08h, QUEUE_OVERFLOW = %0b", rdata, rdata[2]), UVM_MEDIUM)
    `uvm_info("IRQ_COV_DEBUG", $sformatf("IRQ_STATUS read data = 0x%08h, QUEUE_OVERFLOW bit = %0b, RAL field = %0b",rdata, rdata[2], pkt_regmodel.irq_status.queue_overflow.value[0]),UVM_LOW)

  endtask
endclass    

 //gap and fsm sequnce
   class packet_gen_fsm_gap_seq extends packet_base_reg_seq;
  `uvm_object_utils(packet_gen_fsm_gap_seq)

  uvm_status_e status;
  uvm_reg_data_t rdata;

  function new(string name = "packet_gen_fsm_gap_seq");
    super.new(name);
  endfunction

  task body();
    pkt_regmodel.lock.write(status, 32'hA5A5C3C3, UVM_FRONTDOOR);
    pkt_regmodel.gen_pkt_cfg.write(status, 32'h00000401, UVM_FRONTDOOR);
    pkt_regmodel.gen_interval.write(status, 32'h00000100, UVM_FRONTDOOR);
    pkt_regmodel.gen_count.write(status, 32'd10, UVM_FRONTDOOR);
    pkt_regmodel.switch_ctrl.write(status, 32'h00000001, UVM_FRONTDOOR);

    pkt_regmodel.gen_ctrl.write(status, 32'h00000003, UVM_FRONTDOOR);

    repeat (100) begin
      pkt_regmodel.switch_status.read(status, rdata, UVM_FRONTDOOR);
      `uvm_info("FSM_CHECK",  $sformatf("GEN_FSM = %0d", rdata[17:16]), UVM_MEDIUM)
    end

    do begin
      pkt_regmodel.gen_status.read(status, rdata, UVM_FRONTDOOR);
    end while (rdata[1] == 0);

    pkt_regmodel.switch_status.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("FSM_CHECK", $sformatf("Final GEN_FSM = %0d", rdata[17:16]), UVM_MEDIUM)
  endtask
endclass
    
    //port_enables
    class packet_port_enabled_cov_seq extends packet_base_reg_seq;
  `uvm_object_utils(packet_port_enabled_cov_seq)

  uvm_status_e status;
  uvm_reg_data_t rdata;

  function new(string name = "packet_port_enabled_cov_seq");
    super.new(name);
  endfunction

  task body();
    pkt_regmodel.lock.write(status, 32'hA5A5C3C3, UVM_FRONTDOOR);

    pkt_regmodel.port_enable.write(status, 32'h00000001, UVM_FRONTDOOR);
    pkt_regmodel.switch_status.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("PORT_CHECK",$sformatf("PORT_ENABLE = 0x1, PORT_ENABLED = 0x%0h",rdata[7:4]), UVM_MEDIUM)

    pkt_regmodel.port_enable.write(status, 32'h00000003, UVM_FRONTDOOR);
    pkt_regmodel.switch_status.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("PORT_CHECK",$sformatf("PORT_ENABLE = 0x3, PORT_ENABLED = 0x%0h",    rdata[7:4]), UVM_MEDIUM)

    pkt_regmodel.port_enable.write(status, 32'h0000000F, UVM_FRONTDOOR);
    pkt_regmodel.switch_status.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("PORT_CHECK",  $sformatf("PORT_ENABLE = 0xF, PORT_ENABLED = 0x%0h",  rdata[7:4]), UVM_MEDIUM)
  endtask
endclass

    
    //stat_drop
    
class packet_drop_count_cov_seq extends packet_base_reg_seq;
  `uvm_object_utils(packet_drop_count_cov_seq)

  uvm_status_e status;
  uvm_reg_data_t rdata;
  uvm_reg_data_t drop_before;
  uvm_reg_data_t drop_after;
  bit done;

  function new(string name = "packet_drop_count_cov_seq");
    super.new(name);
  endfunction

  task body();

    pkt_regmodel.lock.write(status, 32'hA5A5C3C3, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("STAT_DROP", "Failed to unlock registers")
      return;
    end

    pkt_regmodel.switch_ctrl.write(status, 32'h00000002, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("STAT_DROP", "Failed to clear")
      return;
    end

    pkt_regmodel.stat_drop.read(status, rdata, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("STAT_DROP", "Failed to read STAT_DROP")
      return;
    end

    if (rdata[15:0] == 0)
      `uvm_info("STAT_DROP","zero drop", UVM_MEDIUM)
    else
      `uvm_error("STAT_DROP", $sformatf("Expected zero drop, got %0d", rdata[15:0]))

    pkt_regmodel.port_enable.write(status, 32'h0000000F, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("STAT_DROP", "PORT_ENABLE write failed")
      return;
    end

    pkt_regmodel.fwd_enable.write(status, 32'h0000000D, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("STAT_DROP", "FWD_ENABLE write failed")
      return;
    end

    pkt_regmodel.gen_pkt_cfg.write(status, 32'h00000401, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("STAT_DROP", "GEN_PKT_CFG write failed")
      return;
    end

    pkt_regmodel.gen_interval.write(status, 32'd2, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("STAT_DROP", "GEN_INTERVAL write failed")
      return;
    end

    pkt_regmodel.switch_ctrl.write(status, 32'h00000001, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("STAT_DROP", "Failed to enable switch")
      return;
    end

    pkt_regmodel.gen_count.write(status, 32'd1, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("STAT_DROP", "GEN_COUNT write failed")
      return;
    end

    pkt_regmodel.gen_ctrl.write(status, 32'h00000003, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("STAT_DROP", "Failed to start first run")
      return;
    end

    done = 0;
    for (int i = 0; i < 200; i++) begin
      pkt_regmodel.gen_status.read(status, rdata, UVM_FRONTDOOR);
      if (status != UVM_IS_OK) begin
        `uvm_error("STAT_DROP", "GEN_STATUS read failed")
        return;
      end

      if (rdata[1]) begin
        done = 1;
        break;
      end
    end

    if (!done) begin
      `uvm_error("STAT_DROP", "Timeout waiting for first generator run")
      return;
    end

    pkt_regmodel.stat_drop.read(status, drop_after, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("STAT_DROP", "STAT_DROP read failed after first run")
      return;
    end

    if (drop_after[15:0] == 1)
      `uvm_info("STAT_DROP", "One drop", UVM_MEDIUM)
    else
      `uvm_error("STAT_DROP", $sformatf("Expected 1 drop, got %0d", drop_after[15:0]))

    drop_before = drop_after;

    pkt_regmodel.gen_count.write(status, 32'd3, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("STAT_DROP", "GEN_COUNT write failed for second run")
      return;
    end

    pkt_regmodel.gen_ctrl.write(status, 32'h00000003, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("STAT_DROP", "Failed to start second run")
      return;
    end

    done = 0;
    for (int i = 0; i < 400; i++) begin
      pkt_regmodel.gen_status.read(status, rdata, UVM_FRONTDOOR);
      if (status != UVM_IS_OK) begin
        `uvm_error("STAT_DROP", "GEN_STATUS read failed")
        return;
      end

      if (rdata[1]) begin
        done = 1;
        break;
      end
    end

    if (!done) begin
      `uvm_error("STAT_DROP", "Timeout waiting for second generator run")
      return;
    end

    pkt_regmodel.stat_drop.read(status, drop_after, UVM_FRONTDOOR);
    if (status != UVM_IS_OK) begin
      `uvm_error("STAT_DROP", "STAT_DROP read failed after second run")
      return;
    end

    if (drop_after[15:0] == drop_before[15:0] + 3)
      `uvm_info("STAT_DROP",  $sformatf("before=%0d after=%0d",  drop_before[15:0], drop_after[15:0]), UVM_MEDIUM)
    else
      `uvm_error("STAT_DROP",  $sformatf("before=%0d after=%0d",   drop_before[15:0], drop_after[15:0]))

  endtask
endclass

      //irq_force covergae
      
class packet_irq_force_cov_seq extends packet_base_reg_seq;
  `uvm_object_utils(packet_irq_force_cov_seq)

  uvm_status_e status;
  uvm_reg_data_t rdata;

  function new(string name = "packet_irq_force_cov_seq");
    super.new(name);
  endfunction

  task body();

    pkt_regmodel.irq_status.write(status, 32'h000000FF, UVM_FRONTDOOR);
    pkt_regmodel.irq_force.write(status, 32'h00000040, UVM_FRONTDOOR);
    pkt_regmodel.irq_status.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("IRQ_FORCE", $sformatf("START_ACK: IRQ_STATUS = 0x%08h", rdata), UVM_MEDIUM)

    pkt_regmodel.irq_status.write(status, 32'h000000FF, UVM_FRONTDOOR);
    pkt_regmodel.irq_force.write(status, 32'h00000010, UVM_FRONTDOOR);
    pkt_regmodel.irq_status.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("IRQ_FORCE", $sformatf("PACKET_FORWARDED: IRQ_STATUS = 0x%08h", rdata), UVM_MEDIUM)

    pkt_regmodel.irq_status.write(status, 32'h000000FF, UVM_FRONTDOOR);
    pkt_regmodel.irq_force.write(status, 32'h00000008, UVM_FRONTDOOR);
    pkt_regmodel.irq_status.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("IRQ_FORCE", $sformatf("PACKET_DROPPED: IRQ_STATUS = 0x%08h", rdata), UVM_MEDIUM)

    pkt_regmodel.irq_status.write(status, 32'h000000FF, UVM_FRONTDOOR);
 pkt_regmodel.switch_ctrl.write(status, 32'h00000008, UVM_FRONTDOOR);
pkt_regmodel.irq_enable.write(status, 32'h00000004, UVM_FRONTDOOR);
    pkt_regmodel.irq_force.write(status, 32'h00000004, UVM_FRONTDOOR);
    pkt_regmodel.irq_status.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("IRQ_FORCE", $sformatf("QUEUE_OVERFLOW: IRQ_STATUS = 0x%08h", rdata), UVM_MEDIUM)

//    pkt_regmodel.irq_status.write(status, 32'h000000FF, UVM_FRONTDOOR);
    pkt_regmodel.irq_force.write(status, 32'h00000020, UVM_FRONTDOOR);
    pkt_regmodel.irq_status.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("IRQ_FORCE", $sformatf("QUEUE_ALMOST_FULL: IRQ_STATUS = 0x%08h", rdata), UVM_MEDIUM)

  //  pkt_regmodel.irq_status.write(status, 32'h000000FF, UVM_FRONTDOOR);
    pkt_regmodel.irq_force.write(status, 32'h00000002, UVM_FRONTDOOR);
    pkt_regmodel.irq_status.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("IRQ_FORCE", $sformatf("ERROR: IRQ_STATUS = 0x%08h", rdata), UVM_MEDIUM)

   // pkt_regmodel.irq_status.write(status, 32'h000000FF, UVM_FRONTDOOR);
    pkt_regmodel.irq_force.write(status, 32'h00000001, UVM_FRONTDOOR);
    pkt_regmodel.irq_status.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("IRQ_FORCE", $sformatf("GEN_DONE: IRQ_STATUS = 0x%08h", rdata), UVM_MEDIUM)

   // pkt_regmodel.irq_status.write(status, 32'h000000FF, UVM_FRONTDOOR);
    pkt_regmodel.irq_force.write(status, 32'h00000000, UVM_FRONTDOOR);
    pkt_regmodel.irq_status.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("IRQ_FORCE", $sformatf("NONE: IRQ_STATUS = 0x%08h", rdata), UVM_MEDIUM)

  endtask
endclass
/*
//backdoor switch_ctrl
 class switch_ctrl_backdoor_test_seq extends packet_base_reg_seq;
  `uvm_object_utils(switch_ctrl_backdoor_test_seq)

  function new(string name = "switch_ctrl_backdoor_test_seq");
    super.new(name);
  endfunction

  task body();
    pkt_regmodel.lock.write(status, 32'hA5A5C3C3, UVM_FRONTDOOR);
    
    pkt_regmodel.switch_ctrl.write(status, 32'h00000009, UVM_FRONTDOOR);

    pkt_regmodel.switch_ctrl.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("SW_CTRL", $sformatf("Frontdoor read = 0x%08h", rdata), UVM_MEDIUM)

    pkt_regmodel.switch_ctrl.read(status, rdata, UVM_BACKDOOR);
    `uvm_info("SW_CTRL", $sformatf("Backdoor read = 0x%08h", rdata), UVM_MEDIUM)
  endtask
endclass
*/
//backdoor
class switch_ctrl_backdoor_test_seq extends packet_base_reg_seq;
  `uvm_object_utils(switch_ctrl_backdoor_test_seq)

  function new(string name = "switch_ctrl_backdoor_test_seq");
    super.new(name);
  endfunction

  task body();
    pkt_regmodel.lock.write(status, 32'hA5A5C3C3, UVM_FRONTDOOR);

    pkt_regmodel.switch_ctrl.write(status, 32'h00000009, UVM_FRONTDOOR);
    pkt_regmodel.switch_ctrl.read(status, rdata, UVM_FRONTDOOR);
    `uvm_info("SW_CTRL", $sformatf("Frontdoor read = 0x%08h", rdata), UVM_MEDIUM)
    pkt_regmodel.switch_ctrl.read(status, rdata, UVM_BACKDOOR);
    `uvm_info("SW_CTRL", $sformatf("Backdoor read = 0x%08h", rdata), UVM_MEDIUM)

    pkt_regmodel.port_enable.read(status, rdata, UVM_BACKDOOR);
    `uvm_info("PORT_ENABLE", $sformatf("Backdoor read = 0x%08h", rdata), UVM_MEDIUM)

    pkt_regmodel.fwd_enable.read(status, rdata, UVM_BACKDOOR);
    `uvm_info("FWD_ENABLE", $sformatf("Backdoor read = 0x%08h", rdata), UVM_MEDIUM)

    pkt_regmodel.gen_ctrl.read(status, rdata, UVM_BACKDOOR);
    `uvm_info("GEN_CTRL", $sformatf("Backdoor read = 0x%08h", rdata), UVM_MEDIUM)

    pkt_regmodel.gen_pkt_cfg.read(status, rdata, UVM_BACKDOOR);
    `uvm_info("GEN_PKT_CFG", $sformatf("Backdoor read = 0x%08h", rdata), UVM_MEDIUM)

    pkt_regmodel.gen_interval.read(status, rdata, UVM_BACKDOOR);
    `uvm_info("GEN_INTERVAL", $sformatf("Backdoor read = 0x%08h", rdata), UVM_MEDIUM)

    pkt_regmodel.gen_count.read(status, rdata, UVM_BACKDOOR);
    `uvm_info("GEN_COUNT", $sformatf("Backdoor read = 0x%08h", rdata), UVM_MEDIUM)

    pkt_regmodel.irq_status.read(status, rdata, UVM_BACKDOOR);
    `uvm_info("IRQ_STATUS", $sformatf("Backdoor read = 0x%08h", rdata), UVM_MEDIUM)

    pkt_regmodel.irq_enable.read(status, rdata, UVM_BACKDOOR);
    `uvm_info("IRQ_ENABLE", $sformatf("Backdoor read = 0x%08h", rdata), UVM_MEDIUM)

    pkt_regmodel.err_status.read(status, rdata, UVM_BACKDOOR);
    `uvm_info("ERR_STATUS", $sformatf("Backdoor read = 0x%08h", rdata), UVM_MEDIUM)

    pkt_regmodel.err_enable.read(status, rdata, UVM_BACKDOOR);
    `uvm_info("ERR_ENABLE", $sformatf("Backdoor read = 0x%08h", rdata), UVM_MEDIUM)

    pkt_regmodel.err_count.read(status, rdata, UVM_BACKDOOR);
    `uvm_info("ERR_COUNT", $sformatf("Backdoor read = 0x%08h", rdata), UVM_MEDIUM)

    pkt_regmodel.err_info.read(status, rdata, UVM_BACKDOOR);
    `uvm_info("ERR_INFO", $sformatf("Backdoor read = 0x%08h", rdata), UVM_MEDIUM)

    pkt_regmodel.lock.read(status, rdata, UVM_BACKDOOR);
    `uvm_info("LOCK", $sformatf("Backdoor read = 0x%08h", rdata), UVM_MEDIUM)

    pkt_regmodel.switch_status.read(status, rdata, UVM_BACKDOOR);
    `uvm_info("SWITCH_STATUS", $sformatf("Backdoor read = 0x%08h", rdata), UVM_MEDIUM)

    pkt_regmodel.port_status.read(status, rdata, UVM_BACKDOOR);
    `uvm_info("PORT_STATUS", $sformatf("Backdoor read = 0x%08h", rdata), UVM_MEDIUM)

    pkt_regmodel.gen_status.read(status, rdata, UVM_BACKDOOR);
    `uvm_info("GEN_STATUS", $sformatf("Backdoor read = 0x%08h", rdata), UVM_MEDIUM)

    pkt_regmodel.stat_rx.read(status, rdata, UVM_BACKDOOR);
    `uvm_info("STAT_RX", $sformatf("Backdoor read = 0x%08h", rdata), UVM_MEDIUM)

    pkt_regmodel.stat_tx.read(status, rdata, UVM_BACKDOOR);
    `uvm_info("STAT_TX", $sformatf("Backdoor read = 0x%08h", rdata), UVM_MEDIUM)

    pkt_regmodel.stat_drop.read(status, rdata, UVM_BACKDOOR);
    `uvm_info("STAT_DROP", $sformatf("Backdoor read = 0x%08h", rdata), UVM_MEDIUM)
  endtask
endclass

      //regression
      class packet_regression_seq extends packet_base_reg_seq;
  `uvm_object_utils(packet_regression_seq)

  packet_unlock_reg_seq unlock_seq;
  packet_device_id_reg_seq device_id_seq;
  packet_version_reg_seq version_seq;
  packet_switch_status_reg_seq switch_status_seq;
  packet_port_status_reg_seq port_status_seq;
  packet_gen_status_reg_seq gen_status_seq;
  packet_stat_rx_reg_seq stat_rx_seq;
  packet_stat_tx_reg_seq stat_tx_seq;
  packet_stat_drop_reg_seq stat_drop_seq;
  packet_switch_ctrl_reg_seq switch_ctrl_seq;
  packet_port_enable_reg_seq port_enable_seq;
  packet_fwd_enable_reg_seq fwd_enable_seq;
  packet_gen_ctrl_reg_seq gen_ctrl_seq;
  packet_gen_pkt_cfg_reg_seq gen_pkt_cfg_seq;
  packet_gen_interval_reg_seq gen_interval_seq;
  packet_gen_count_reg_seq gen_count_seq;
  packet_irq_status_reg_seq irq_status_seq;
  packet_irq_enable_reg_seq irq_enable_seq;
  packet_irq_force_reg_seq irq_force_seq;
  packet_err_status_reg_seq err_status_seq;
  packet_err_enable_reg_seq err_enable_seq;
  packet_err_inject_reg_seq err_inject_seq;
  packet_err_count_reg_seq err_count_seq;
  packet_err_info_reg_seq err_info_seq;
  packet_lock_reg_seq lock_seq;
  packet_soft_reset_reg_seq soft_reset_seq;
  packet_generate_four_packets_seq generate_four_packets_seq;
  packet_destination_drop_seq destination_drop_seq;
  packet_unaligned_access_seq unaligned_access_seq;
  packet_unmapped_access_seq unmapped_access_seq;
  packet_ro_write_seq ro_write_seq;
  packet_wo_read_seq wo_read_seq;
  packet_locked_write_seq locked_write_seq;
   packet_gen_pkt_cfg_src_port2_seq seq;
 packet_generate_four_packets_seq1 seq1;
packet_generate_four_packets_seq2 seq2;
packet_err_inject_reg_seq1 err_seq1;
            packet_err_info_port2_seq seq3;
         packet_err_info_port3_seq seq4;
  packet_irq_sw_event_error_seq seq5;
 packet_gen_fsm_gap_seq seq6;
        packet_port_enabled_cov_seq seq7;
 packet_drop_count_cov_seq seq8;
packet_irq_force_cov_seq seq_irq;

  function new(string name = "packet_regression_seq");
    super.new(name);
  endfunction

  virtual task body();

     `uvm_create(ro_write_seq)
    ro_write_seq.pkt_regmodel = this.pkt_regmodel;
    `uvm_send(ro_write_seq)

    `uvm_create(wo_read_seq)
    wo_read_seq.pkt_regmodel = this.pkt_regmodel;
    `uvm_send(wo_read_seq)
    
    `uvm_create(unlock_seq)
    unlock_seq.pkt_regmodel = this.pkt_regmodel;
    `uvm_send(unlock_seq)

    repeat(`no_of_transactions) begin

      `uvm_create(device_id_seq)
      device_id_seq.pkt_regmodel = this.pkt_regmodel;
      `uvm_send(device_id_seq)

      `uvm_create(version_seq)
      version_seq.pkt_regmodel = this.pkt_regmodel;
      `uvm_send(version_seq)

      `uvm_create(switch_status_seq)
      switch_status_seq.pkt_regmodel = this.pkt_regmodel;
      `uvm_send(switch_status_seq)

      `uvm_create(port_status_seq)
      port_status_seq.pkt_regmodel = this.pkt_regmodel;
      `uvm_send(port_status_seq)

      `uvm_create(gen_status_seq)
      gen_status_seq.pkt_regmodel = this.pkt_regmodel;
      `uvm_send(gen_status_seq)

      `uvm_create(stat_rx_seq)
      stat_rx_seq.pkt_regmodel = this.pkt_regmodel;
      `uvm_send(stat_rx_seq)

      `uvm_create(stat_tx_seq)
      stat_tx_seq.pkt_regmodel = this.pkt_regmodel;
      `uvm_send(stat_tx_seq)

      `uvm_create(stat_drop_seq)
      stat_drop_seq.pkt_regmodel = this.pkt_regmodel;
      `uvm_send(stat_drop_seq)

      `uvm_create(switch_ctrl_seq)
      switch_ctrl_seq.pkt_regmodel = this.pkt_regmodel;
      `uvm_send(switch_ctrl_seq)

      `uvm_create(port_enable_seq)
      port_enable_seq.pkt_regmodel = this.pkt_regmodel;
      `uvm_send(port_enable_seq)

      `uvm_create(fwd_enable_seq)
      fwd_enable_seq.pkt_regmodel = this.pkt_regmodel;
      `uvm_send(fwd_enable_seq)

      `uvm_create(gen_ctrl_seq)
      gen_ctrl_seq.pkt_regmodel = this.pkt_regmodel;
      `uvm_send(gen_ctrl_seq)

      `uvm_create(gen_pkt_cfg_seq)
      gen_pkt_cfg_seq.pkt_regmodel = this.pkt_regmodel;
      `uvm_send(gen_pkt_cfg_seq)
      

      `uvm_create(gen_interval_seq)
      gen_interval_seq.pkt_regmodel = this.pkt_regmodel;
      `uvm_send(gen_interval_seq)

      `uvm_create(gen_count_seq)
      gen_count_seq.pkt_regmodel = this.pkt_regmodel;
      `uvm_send(gen_count_seq)

      `uvm_create(irq_status_seq)
      irq_status_seq.pkt_regmodel = this.pkt_regmodel;
      `uvm_send(irq_status_seq)

      `uvm_create(irq_enable_seq)
      irq_enable_seq.pkt_regmodel = this.pkt_regmodel;
      `uvm_send(irq_enable_seq)

      `uvm_create(irq_force_seq)
      irq_force_seq.pkt_regmodel = this.pkt_regmodel;
      `uvm_send(irq_force_seq)

      `uvm_create(err_status_seq)
      err_status_seq.pkt_regmodel = this.pkt_regmodel;
      `uvm_send(err_status_seq)
      
       `uvm_create(err_count_seq)
      err_count_seq.pkt_regmodel = this.pkt_regmodel;
      `uvm_send(err_count_seq)

       `uvm_create(err_info_seq)
      err_info_seq.pkt_regmodel = this.pkt_regmodel;
      `uvm_send(err_info_seq)

      `uvm_create(err_enable_seq)
      err_enable_seq.pkt_regmodel = this.pkt_regmodel;
      `uvm_send(err_enable_seq)

      `uvm_create(err_inject_seq)
      err_inject_seq.pkt_regmodel = this.pkt_regmodel;
      `uvm_send(err_inject_seq)

     
     

    end

   

    `uvm_create(locked_write_seq)
    locked_write_seq.pkt_regmodel = this.pkt_regmodel;
    `uvm_send(locked_write_seq)

    `uvm_create(unmapped_access_seq)
//     unmapped_access_seq.pkt_regmodel = this.pkt_regmodel;
    `uvm_send(unmapped_access_seq)

    `uvm_create(unaligned_access_seq)
//     unaligned_access_seq.pkt_regmodel = this.pkt_regmodel;
    `uvm_send(unaligned_access_seq)
    
     `uvm_create(seq)
    seq.pkt_regmodel = this.pkt_regmodel;
    `uvm_send(seq)

    `uvm_create(generate_four_packets_seq)
    generate_four_packets_seq.pkt_regmodel = this.pkt_regmodel;
    `uvm_send(generate_four_packets_seq)

    pkt_regmodel.switch_ctrl.write(status, 32'h0000000B, UVM_FRONTDOOR);
    
    `uvm_create(seq1)
    seq1.pkt_regmodel = this.pkt_regmodel;
    `uvm_send(seq1)

     pkt_regmodel.switch_ctrl.write(status, 32'h0000000B, UVM_FRONTDOOR);
    
    `uvm_create(seq2)
    seq2.pkt_regmodel = this.pkt_regmodel;
    `uvm_send(seq2)
    
    pkt_regmodel.switch_ctrl.write(status, 32'h0000000B, UVM_FRONTDOOR);
    
    `uvm_create(err_seq1)
    err_seq1.pkt_regmodel = this.pkt_regmodel;
    `uvm_send(err_seq1)
    
    pkt_regmodel.switch_ctrl.write(status, 32'h0000000B, UVM_FRONTDOOR);

 `uvm_create(seq3)
    seq3.pkt_regmodel = this.pkt_regmodel;
    `uvm_send(seq3)
    
    pkt_regmodel.switch_ctrl.write(status, 32'h0000000B, UVM_FRONTDOOR);
    
    `uvm_create(seq4)
    seq4.pkt_regmodel = this.pkt_regmodel;
    `uvm_send(seq4)
   pkt_regmodel.switch_ctrl.write(status, 32'h0000000B, UVM_FRONTDOOR);

 `uvm_create(seq5)
    seq5.pkt_regmodel = this.pkt_regmodel;
    `uvm_send(seq5)
    
    pkt_regmodel.switch_ctrl.write(status, 32'h0000000B, UVM_FRONTDOOR);


 `uvm_create(seq6)
    seq6.pkt_regmodel = this.pkt_regmodel;
    `uvm_send(seq6)
    
    pkt_regmodel.switch_ctrl.write(status, 32'h0000000B, UVM_FRONTDOOR);
    
    `uvm_create(seq7)
    seq7.pkt_regmodel = this.pkt_regmodel;
    `uvm_send(seq7)
    
    pkt_regmodel.switch_ctrl.write(status, 32'h0000000B, UVM_FRONTDOOR);
    
      `uvm_create(seq8)
    seq8.pkt_regmodel = this.pkt_regmodel;
    `uvm_send(seq8)
    
    pkt_regmodel.switch_ctrl.write(status, 32'h0000000B, UVM_FRONTDOOR);

 `uvm_create(seq_irq)
    seq_irq.pkt_regmodel = this.pkt_regmodel;
    `uvm_send(seq_irq)
    
    pkt_regmodel.switch_ctrl.write(status, 32'h0000000B, UVM_FRONTDOOR);
    
    `uvm_create(destination_drop_seq)
    destination_drop_seq.pkt_regmodel = this.pkt_regmodel;
    `uvm_send(destination_drop_seq)

    
     `uvm_create(soft_reset_seq)
    soft_reset_seq.pkt_regmodel = this.pkt_regmodel;
    `uvm_send(soft_reset_seq)
  endtask
endclass
    
   
 

