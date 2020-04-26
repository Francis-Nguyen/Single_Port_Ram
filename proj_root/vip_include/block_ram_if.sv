`ifndef BLOCK_RAM_IF
`define BLOCK_RAM_IF
interface block_ram_if;
	logic											clk;
	logic											reset;
	logic											bram_en;
	logic											bram_wen;
	logic [`ADDR_WIDTH-1:0] 	bram_addr;
	logic [`DATA_WIDTH-1:0] 	bram_datai;	
	logic [`DATA_WIDTH-1:0] 	bram_datao;	

	modport ms_if(
	  output 											bram_en,
		output 											bram_wen,
		output 											bram_addr,
		output 											bram_datai,	
		input 											bram_datao	
	);
	modport slv_if(
	  input 											bram_en,
		input 											bram_wen,
		input 											bram_addr,
		input 											bram_datai,
		output 											bram_datao	
	);
endinterface: block_ram_if
`endif
