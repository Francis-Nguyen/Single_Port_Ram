import uvm_pkg::*;
import block_ram_pkg::*;
`include "uvm_macros.svh"
`include "test.sv"
`include "dut_wrapper.sv"
module tb_top();
	parameter P_250MHZ = 20;

	bit clk 		= 0;

	initial forever begin
		#P_250MHZ clk =~ clk;
	end

	block_ram_if	ms_ram_if();

	assign ms_ram_if.clk = clk;

	dut_wrapper dut_wrapper(
		.dut_if(ms_ram_if)
	);

	initial begin
		uvm_config_db #(virtual block_ram_if)::set(null, "*", "master_ram_if", ms_ram_if);
	end

	initial begin
		run_test("test");
	end

endmodule
