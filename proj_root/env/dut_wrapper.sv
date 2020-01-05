`include "dut.v"
module dut_wrapper(interface blk_ram_ms_if, interface blk_ram_slv_if);
	dut dut(
		.blk_ram_ms_if(blk_ram_ms_if),
		.blk_ram_slv_if(blk_ram_slv_if)
	);
endmodule
