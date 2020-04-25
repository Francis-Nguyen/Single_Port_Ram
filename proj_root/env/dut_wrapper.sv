`include "dut.v"
module dut_wrapper(interface ram_if);
	blk_ram blk_ram(
		.clk		(ram_if.clk),
		.rst		(ram_if.rst),
		.en			(ram_if.en),
		.wen		(ram_if.wen),
		.addr		(ram_if.addr),
		.datai	(ram_if.datai),
		.datao	(ram_if.datao)
	);
endmodule
