interface dut_if (input clk, input reset);
	bit									clk;
	bit									reset;
	bit									bram_en;
	bit									bram_wen;
	bit [`AWIDTH-1:0] 	bram_addr;
	bit [`DWIDTH-1:0] 	bram_datai;	
	bit [`DWIDTH-1:0] 	bram_datao;	
endinterface
