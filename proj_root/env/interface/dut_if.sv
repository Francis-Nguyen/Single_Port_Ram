interface dut_if;
	logic									clk;
	logic									reset;
	logic									bram_en;
	logic									bram_wen;
	logic [`AWIDTH-1:0] 	bram_addr;
	logic [`DWIDTH-1:0] 	bram_datai;	
	logic [`DWIDTH-1:0] 	bram_datao;	
endinterface
