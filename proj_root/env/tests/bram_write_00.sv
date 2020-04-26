class bram_write_00 extends virt_sequence;
  `uvm_object_utils(bram_write_00)

  function new(string name = "bram_write_00");
		super.new(name);
	endfunction: new

	virtual task pre_body();
			`uvm_info("**RESET**", "**BEGIN**", UVM_LOW)
			this.rst_sequence.start(this.p_sequencer);
			`uvm_info("**RESET**", "**END**", UVM_LOW)
	endtask: pre_body

	virtual task body();
		int data[$];
		int	addr[$];
		begin
		`uvm_info(this.get_name(), "BODY ENTER", UVM_LOW)
		for(int i=0; i<10; i++)
			begin
				data.push_back($random());
				addr.push_back(i);
			end
				foreach(data[i])
					begin
						this.write_sequence.ram_data.push_back(data[i]);
						this.write_sequence.ram_addr.push_back(addr[i]);
						this.read_sequence.ram_addr.push_back(addr[i]);
						this.read_sequence.ram_data.push_back(data[i]);
					end
				this.write_sequence.start(this.p_sequencer);
				this.read_sequence.start(this.p_sequencer);
		`uvm_info(this.get_name(), "BODY EXIT", UVM_LOW)
		end
	endtask: body

endclass: bram_write_00
