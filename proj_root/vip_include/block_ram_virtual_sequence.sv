`ifndef BLOCK_RAM_VIRTUAL_SEQUENCE
`define BLOCK_RAM_VIRTUAL_SEQUENCE
	class block_ram_virtual_sequence extends block_ram_base_sequence;

				block_ram_base_sequence base_sequence;
		`uvm_declare_p_sequencer(block_ram_sequencer)

	  function new(string name = "block_ram_virtual_sequence");
			super.new(name);
		endfunction: new

		virtual task body();
			`uvm_info(this.get_name(), "BODY ENTER", UVM_LOW)
				base_sequence	= block_ram_base_sequence::type_id::create("base_sequence");
				base_sequence.start(p_sequencer, this);
			`uvm_info(this.get_name(), "BODY EXIT", UVM_LOW)
		endtask: body

		`uvm_object_utils_begin(block_ram_virtual_sequence)
      `uvm_field_object(base_sequence, UVM_ALL_ON)
   `uvm_object_utils_end
	endclass: block_ram_virtual_sequence
`endif
