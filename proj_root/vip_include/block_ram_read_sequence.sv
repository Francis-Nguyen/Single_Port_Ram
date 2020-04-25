`ifndef BLOCK_RAM_READ_SEQUENCE
`define BLOCK_RAM_READ_SEQUENCE
	class block_ram_read_sequence extends uvm_sequence#(block_ram_sequence_item);
		int	ram_data[$];
		int	ram_addr[$];
		`uvm_object_utils_begin(block_ram_read_sequence)
			`uvm_field_queue_int(ram_data,		UVM_ALL_ON)
			`uvm_field_queue_int(ram_addr,		UVM_ALL_ON)
		`uvm_object_utils_end

	  function new(string name = "block_ram_read_sequence");
			super.new(name);
		endfunction: new

		virtual task body();
			int length;
			`uvm_info(this.get_name(), "BODY ENTER", UVM_LOW)
			length = this.ram_data.size();
			`uvm_create(req)
				req.trans_type		=		READ;
				req.trans_length	=		length;
				//delete queue content
				req.trans_addr = {};
				req.trans_datai = {};
				foreach(this.ram_addr[i])
					begin
						req.trans_addr.push_back(this.ram_addr[i]);
						req.trans_datai.push_back('h0);
					end
			`uvm_send(req)
			// get respond data
			this.get_response(rsp);
			//delete queue content
			this.ram_data = {};
			foreach(rsp.trans_datao[i])
				begin
					this.ram_data.push_back(rsp.trans_datao[i]);
				end
			`uvm_info(this.get_name(), "BODY EXIT", UVM_LOW)
		endtask: body

	endclass: block_ram_read_sequence
`endif
