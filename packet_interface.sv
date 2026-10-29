interface packet_interface(input logic pclk);
  
  logic preset_n;
  logic psel;
  logic penable;
  logic pwrite;
  logic pready;
  logic [`data_width-1:0] pwdata;
  logic [`data_width-1:0] prdata;
  logic [`addr_width-1:0] paddr;
  logic pslverr;
  logic irq;
  
  clocking driver_cb@(posedge pclk);
    default input #0 output #0;
    output pwdata, paddr, psel, penable,pwrite, preset_n;
    input prdata, pready, pslverr, irq;
  endclocking
  
  clocking monitor_cb@(posedge pclk);
    default input #0 output #0;
    input pwdata, paddr, psel, penable,pwrite, preset_n, prdata, pready, pslverr, irq;
  endclocking
  
  modport driver_mod(clocking driver_cb);
  modport monitor_mod(clocking monitor_cb);
      
      endinterface
      
