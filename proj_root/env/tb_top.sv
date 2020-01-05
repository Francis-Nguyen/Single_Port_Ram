import uvm_pkg::*;
import block_ram_pkg::*;
`include "uvm_macros.svh"
`include "test.sv"
`include "dut_wrapper.sv"
module tb_top();
	parameter P_250MHZ = 20;

	bit clk 		= 0;
	bit reset 	= 0;

	initial forever begin
		#P_250MHZ clk =~ clk;
	end

	initial begin
		reset = 0;
		#1us;
		reset = 1;
		#10us;
		reset = 0;
	end

	block_ram_if 				ms_ram_if(.CLK(clk), .RESET(reset));
	block_ram_if 				slv_ram_if(.CLK(clk), .RESET(reset));
	dut_wrapper dut_wrapper(.blk_ram_ms_if(ms_ram_if.ms_if), .blk_ram_slv_if(slv_ram_if.slv_if));
	initial begin
		uvm_config_db #(virtual block_ram_if)::set(null, "*", "master_ram_if", ms_ram_if);
		uvm_config_db #(virtual block_ram_if)::set(null, "*", "slaver_ram_if", slv_ram_if);
	end

	initial begin
		run_test("test");
	end

endmodule
