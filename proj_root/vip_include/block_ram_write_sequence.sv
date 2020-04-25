`ifndef BLOCK_RAM_WRITE_SEQUENCE
`define BLOCK_RAM_WRITE_SEQUENCE
class block_ram_write_sequence extends uvm_sequence#(block_ram_sequence_item);
	int ram_data[$];
	int ram_addr[$];
	`uvm_object_utils_begin(block_ram_write_sequence)
		`uvm_field_queue_int(ram_data,		UVM_ALL_ON)
		`uvm_field_queue_int(ram_addr,		UVM_ALL_ON)
	`uvm_object_utils_end

  function new(string name = "block_ram_write_sequence");
		super.new(name);
	endfunction: new

	virtual task body();
		int length;
		`uvm_info(this.get_name(), "BODY ENTER", UVM_LOW)
		if(this.ram_data.size() != this.ram_addr.size())
			begin
				`uvm_error("WRITE", "DATA size is different to ADDR size")
			end
		else
			begin
				length = this.ram_data.size();
				`uvm_create(req)
					req.trans_type 		= 	WRITE;
					req.trans_length	=		length;
					// delete content of queues
					req.trans_addr  = {};
					req.trans_datai = {};
					req.trans_datao = {};
					foreach(this.ram_addr[i])
						begin
							req.trans_addr.push_back(this.ram_addr[i]);
							req.trans_datai.push_back(this.ram_data[i]);
							req.trans_datao.push_back('h0);
						end
				`uvm_send(req)
			end
		`uvm_info(this.get_name(), "BODY EXIT", UVM_LOW)
	endtask: body

endclass: block_ram_write_sequence
`endif
