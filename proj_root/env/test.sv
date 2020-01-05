typedef class test;
`include "env.sv"
`include "write_sequence.sv"
class test extends uvm_test;
	`uvm_component_utils(test)
	env block_ram_env;
	write_sequence wr_seq;
	block_ram_random_sequence  rand_sequence;

	function new(string name, uvm_component parent);
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
		//wr_seq = write_sequence::type_id::create("wr_seq", this);
		rand_sequence = block_ram_random_sequence::type_id::create("rand_sequence", this);
		rand_sequence.start(this.block_ram_env.master_sequencer);
		`uvm_info("TEST", "run phase exiting.................", UVM_LOW);

	endtask: run_phase 

endclass: test
