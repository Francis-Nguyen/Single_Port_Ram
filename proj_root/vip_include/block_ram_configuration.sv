`ifndef BLOCK_RAM_CONFIGURATION
`define BLOCK_RAM_CONFIGURATION
	class block_ram_configuration extends uvm_object;
		bit is_master;
		bit is_slaver;

		`uvm_object_utils_begin(block_ram_configuration)
			`uvm_field_int(is_master, UVM_ALL_ON)
			`uvm_field_int(is_slaver, UVM_ALL_ON)
		`uvm_object_utils_end

		function new (string name = "block_ram_configuration");
			super.new(name);
		endfunction: new


	endclass: block_ram_configuration
`endif
