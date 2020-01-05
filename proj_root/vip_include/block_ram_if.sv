`ifndef BLOCK_RAM_IF
`define BLOCK_RAM_IF
  	interface block_ram_if (input CLK, input RESET);
  		bit											READ;
  		bit											WRITE;
  		bit [`ADDR_WIDTH-1:0] 	ADDR;
  		bit [`DATA_WIDTH-1:0] 	DATAI;	
  		bit [`DATA_WIDTH-1:0] 	DATAO;	

			modport ms_if(
			  output 											READ,
				output 											WRITE,
  			output 											ADDR,
  			output 											DATAI,	
  			input 											DATAO	
			);
			modport slv_if(
			  input 											READ,
				input 											WRITE,
  			input 											ADDR,
  			input 											DATAI,
  			output 											DATAO	
			);
  	endinterface: block_ram_if
`endif
