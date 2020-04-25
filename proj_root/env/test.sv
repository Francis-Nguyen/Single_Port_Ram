typedef class test;
`include "env.sv"
`include "virt_sequence.sv"
`include "bram_write_00.sv"
class test extends uvm_test;
	env block_ram_env;
	bram_write_00	write_00;
	`uvm_component_utils(test)

	function new(string name, uvm_component parent=null);
		super.new(name, parent);
	endfunction: new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("TEST", "build phase entering.................", UVM_LOW);
			block_ram_env = env::type_id::create("block_ram_env", this);
		`uvm_info("TEST", "build phase exiting.................", UVM_LOW);
	endfunction: build_phase		

	task run_phase(uvm_phase phase);
		`uvm_info("TEST", "run phase entering.................", UVM_LOW);
			write_00	= bram_write_00::type_id::create("bram_write_00");
			write_00.start(this.block_ram_env.master_sequencer);
		`uvm_info("TEST", "run phase exiting.................", UVM_LOW);

	endtask: run_phase 

endclass: test
