interface dut_if;
	logic					ms_read;
	logic					ms_write;
	logic [7:0] 	ms_addr;
	logic [15:0] 	ms_datai;	
	logic [15:0] 	ms_datao;	

	logic					slv_read;
	logic					slv_write;
	logic [7:0] 	slv_addr;
	logic [15:0] 	slv_datai;	
	logic [15:0] 	slv_datao;	
endinterface
