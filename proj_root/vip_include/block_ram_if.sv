`ifndef BLOCK_RAM_IF
`define BLOCK_RAM_IF
interface block_ram_if (input clk, input reset);
	bit											bram_en;
	bit											bram_wen;
	bit [`ADDR_WIDTH-1:0] 	bram_addr;
	bit [`DATA_WIDTH-1:0] 	bram_datai;	
	bit [`DATA_WIDTH-1:0] 	bram_datao;	

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
