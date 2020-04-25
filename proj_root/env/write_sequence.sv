`ifndef WRITE_SEQUENCE
`define WRITE_SEQUENCE
class write_sequence extends block_ram_base_sequence;
  `uvm_object_utils(write_sequence)
	`uvm_declare_p_sequencer(sequencer)

	block_ram_sequence_item item;
  function new(string name = "write_sequence");
		super.new(name);
	endfunction: new

	virtual task body();
		`uvm_info(this.get_name(), "BODY ENTER", UVM_LOW)
		 `uvm_create(item)
		 item.randomize();
		 `uvm_send(item)
		`uvm_info(this.get_name(), "BODY EXIT", UVM_LOW)
	endtask: body
endclass: write_sequence
`endif
