///////////////////////////////////////////////////UART_TOP/////////////////////////////////////////////////////////////////////////////////
module top;
       
   	import uvm_pkg::*;
	`include "uvm_macros.svh"
	`include "wr_xtn.sv"
`include "wr_agent_config.sv"
`include "env_config.sv"
`include "wr_driver.sv"
`include "wr_monitor.sv"
`include "wr_sequencer.sv"
`include "wr_agent.sv"
`include "wr_agent_top.sv"
`include "wr_seq.sv"

`include "virtual_sequencer.sv"
`include "virtual_seq.sv"
`include "scoreboard.sv"

`include "tb.sv"
`include "vtest_lib.sv"


/////////////////////////CLOCK_GENERATION////////////////////////////////
			bit clock;
                   bit clock1;    
  always
    
        #10 clock=~clock;
    
always
    
#20 clock1=~clock1;
    
wire a,b;
//////////////////////////////////////INSTANTIATE THE TOP OF THE UART//////////////////////////////////////////////////////////////////////////
 uart_top DUT1(.wb_clk_i(clock),.wb_rst_i(in1.wb_rst_i),.wb_adr_i(in1.wb_addr_i),.wb_dat_i(in1.wb_dat_i),.wb_dat_o(in1.wb_dat_o),.wb_we_i(in1.wb_we_i),.wb_stb_i(in1.wb_stb_i),.wb_cyc_i(in1.wb_cyc_i),.wb_ack_o(in1.wb_ack_o),.wb_sel_i(in1.wb_sel_i),.int_o(in1.int_o),.stx_pad_o(a),.srx_pad_i(b),.rts_pad_o(in1.rts_pad_o),.cts_pad_i(in1.cts_pad_i),.dtr_pad_o(in1.dtr_pad_o),.dsr_pad_i(in1.dsr_pad_i),.ri_pad_i(in1.ri_pad_i),.dcd_pad_i(in1.dcd_pad_i),.baud_o(in1.baud_o));


 uart_top DUT2(.wb_clk_i(clock1),.wb_rst_i(in2.wb_rst_i),.wb_adr_i(in2.wb_addr_i),.wb_dat_i(in2.wb_dat_i),.wb_dat_o(in2.wb_dat_o),.wb_we_i(in2.wb_we_i),.wb_stb_i(in2.wb_stb_i),.wb_cyc_i(in2.wb_cyc_i),.wb_ack_o(in2.wb_ack_o),.wb_sel_i(in2.wb_sel_i),.int_o(in2.int_o),.stx_pad_o(b),.srx_pad_i(a),.rts_pad_o(in2.rts_pad_o),.cts_pad_i(in2.cts_pad_i),.dtr_pad_o(in2.dtr_pad_o),.dsr_pad_i(in2.dsr_pad_i),.ri_pad_i(in2.ri_pad_i),.dcd_pad_i(in2.dcd_pad_i),.baud_o(in2.baud_o));

     
///////////////////CLOCK_FOR_INTERFACE/////////////////////////////////////////////

     uart_if in1(clock);
     uart_if in2(clock1);



///////////////////////////////////////////RUN_TEST//////////////////////////////////////////////////////////////////////////////////////////
initial
begin
	uvm_config_db #(virtual uart_if)::set(null,"*","vif_0",in1);
	uvm_config_db #(virtual uart_if)::set(null,"*","vif_1",in2);

	run_test();
     end
  
endmodule

