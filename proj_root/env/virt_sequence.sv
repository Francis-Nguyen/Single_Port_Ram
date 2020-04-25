`ifndef VIRT_SEQUENCE
`define VIRT_SEQUENCE
class virt_sequence extends uvm_sequence;
	block_ram_random_sequence	rand_sequence;	
	block_ram_read_sequence		read_sequence;
	block_ram_write_sequence	write_sequence;

  `uvm_object_utils(virt_sequence)
	`uvm_declare_p_sequencer(sequencer)

  function new(string name = "virt_sequence");
		super.new(name);
		rand_sequence		= block_ram_random_sequence::type_id::create("rand_sequence", this);
		read_sequence		= block_ram_read_sequence::type_id::create("read_sequence", this);
		write_sequence	= block_ram_read_sequence::type_id::create("write_sequence", this);
	endfunction: new

	virtual task body();
		`uvm_info(this.get_name(), "BODY ENTER", UVM_LOW)
		`uvm_info(this.get_name(), "BODY EXIT", UVM_LOW)
	endtask: body

endclass: virt_sequence
`endif
