`ifndef BLOCK_RAM_WRITE_CONTINUOUS_SEQUENCE
`define BLOCK_RAM_WRITE_CONTINUOUS_SEQUENCE
	class block_ram_write_continuous_sequence extends block_ram_base_sequence;
		int wr_data[$];
		int wr_addr[$];
		`uvm_object_utils_begin(block_ram_write_continuous_sequence)
			`uvm_field_queue_int(wr_data,		UVM_ALL_ON)
			`uvm_field_queue_int(wr_addr,		UVM_ALL_ON)
		`uvm_object_utils_end

	  function new(string name = "block_ram_write_continuous_sequence");
			super.new(name);
		endfunction: new

		virtual task body();
			int length;
			`uvm_info(this.get_name(), "BODY ENTER", UVM_LOW)
			if((wr_data.size() !=0) && (wr_addr.size() != 0))
				begin
					if(wr_data.size() < wr_addr.size())
						length = wr_data.size();
					else
						length = wr_addr.size();
				end
			for(int i=0; i<length; i++)
				begin
			 		`uvm_create(req)
						req.trans_type = WRITE;
						req.trans_addr		=		this.wr_addr[i];
						req.trans_datai		=		this.wr_data[i];
						req.trans_datao		=		0;
			 		`uvm_send(req)
					`uvm_info(this.get_name(), $psprintf("WRITE: addr=0x%x, data=0x%x", this.wr_addr[i], this.wr_data[i]), UVM_LOW)
				end
			`uvm_info(this.get_name(), "BODY EXIT", UVM_LOW)
		endtask: body

	endclass: block_ram_write_continuous_sequence
`endif
