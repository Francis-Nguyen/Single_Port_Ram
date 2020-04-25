`ifndef BLOCK_RAM_PKG
`define BLOCK_RAM_PKG
package block_ram_pkg;
	`ifndef DATA_WIDTH
	  `define DATA_WIDTH 16
	`endif
	`ifndef ADDR_WIDTH
	  `define ADDR_WIDTH 8
	`endif
	typedef enum {WRITE, READ} transaction_type;

	`include "block_ram_sequence_item.sv"
	`include "block_ram_configuration.sv"
	`include "block_ram_driver.sv"
	`include "block_ram_sequencer.sv"
	`include "block_ram_agent.sv"
	`include "block_ram_random_sequence.sv"
	`include "block_ram_write_sequence.sv"
	`include "block_ram_read_sequence.sv"

endpackage
`endif
