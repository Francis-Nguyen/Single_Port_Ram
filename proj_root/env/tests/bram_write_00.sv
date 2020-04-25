class bram_write_00 extends virt_sequence;
  `uvm_object_utils(bram_write_00)

  function new(string name = "bram_write_00");
		super.new(name);
	endfunction: new

	virtual task body();
		int data[$];
		int	addr[$];

		`uvm_info(this.get_name(), "BODY ENTER", UVM_LOW)
		for(int i=0; i<10; i++)
			begin
				data.push_back($random());
				addr.push_back(i);
			end
		`uvm_do_on_with(write_sequence, sequencer, {write_sequence.ram_data = data; write_sequence.ram_addr=addr;})	
		`uvm_info(this.get_name(), "BODY EXIT", UVM_LOW)
	endtask: body

endclass: bram_write_00
