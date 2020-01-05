`ifndef BLOCK_RAM_READ_CONTINUOUS_SEQUENCE
`define BLOCK_RAM_READ_CONTINUOUS_SEQUENCE
	class block_ram_read_continuous_sequence extends block_ram_base_sequence;
		int rd_data[$];
		int rd_addr[$];
		`uvm_object_utils_begin(block_ram_read_continuous_sequence)
			`uvm_field_queue_int(rd_data,		UVM_ALL_ON)
			`uvm_field_queue_int(rd_addr,		UVM_ALL_ON)
		`uvm_object_utils_end

	  function new(string name = "block_ram_read_continuous_sequence");
			super.new(name);
		endfunction: new

		virtual task body();
			int length;
			`uvm_info(this.get_name(), "BODY ENTER", UVM_LOW)
			if((rd_data.size() !=0) && (rd_addr.size() != 0))
				begin
					if(rd_data.size() < rd_addr.size())
						length = rd_data.size();
					else
						length = rd_addr.size();
				end
			for(int i=0; i<length; i++)
				begin
			 		`uvm_create(req)
						req.trans_type		=		READ;
						req.trans_addr		=		this.rd_addr[i];
						req.trans_datai		=		0;
			 		`uvm_send(req)
					this.get_response(rsp);
					this.rd_data.push_back(rsp.trans_datao);
					`uvm_info(this.get_name(), $psprintf("READ: addr=0x%x, data=0x%x", this.rd_addr[i], this.rd_data[i]), UVM_LOW)
				end
			`uvm_info(this.get_name(), "BODY EXIT", UVM_LOW)
		endtask: body

	endclass: block_ram_read_continuous_sequence
`endif
