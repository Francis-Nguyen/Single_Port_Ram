`ifndef BLOCK_RAM_RANDOM_SEQUENCE
`define BLOCK_RAM_RANDOM_SEQUENCE
class block_ram_random_sequence extends uvm_sequence#(block_ram_sequence_item);
		rand int length;	
		`uvm_object_utils_begin(block_ram_random_sequence)
			`uvm_field_int(length,		UVM_ALL_ON)
		`uvm_object_utils_end

  function new(string name = "block_ram_random_sequence");
		super.new(name);
	endfunction: new

	virtual task body();
		`uvm_info(this.get_name(), "BODY ENTER", UVM_LOW)
		 for(int i=0; i<this.length; i=i+1)
		  begin
		    `uvm_create(req)
		     	assert(req.randomize());
		    `uvm_send(req)
		     this.get_response(rsp);
		     this.rsp.print();
			end
		 `uvm_info(this.get_name(), "BODY EXIT", UVM_LOW)
	endtask: body

endclass: block_ram_random_sequence
`endif
