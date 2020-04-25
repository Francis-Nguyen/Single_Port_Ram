typedef class test;
`include "env.sv"
`include "virt_sequence.sv"
`include "bram_write_00.sv"
class test extends uvm_test;
	env block_ram_env;
	bram_write_00	write_00;
	`uvm_component_utils_begin(test)
			`uvm_field_object(block_ram_env, UVM_ALL_ON)
			`uvm_field_object(write_00, UVM_ALL_ON)
	`uvm_component_utils_end

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
		string test_name;
		`uvm_info("TEST", "run phase entering.................", UVM_LOW);
		void'(uvm_cmdline_proc.get_arg_value("TEST_NAME=", test_name));
		$display("test_name = %s", test_name);
		if(test_name == "bram_write_00")
			begin
				write_00	= bram_write_00::type_id::create("bram_write_00", this);
				write_00.start(this.block_ram_env.master_sequencer);
			end
		`uvm_info("TEST", "run phase exiting.................", UVM_LOW);

	endtask: run_phase 

endclass: test
