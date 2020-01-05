`ifndef BLOCK_RAM_RANDOM_SEQUENCE
`define BLOCK_RAM_RANDOM_SEQUENCE
	class block_ram_random_sequence extends block_ram_base_sequence;

		`uvm_object_utils(block_ram_random_sequence)

	  function new(string name = "block_ram_random_sequence");
			super.new(name);
		endfunction: new

		virtual task body();
			`uvm_info(this.get_name(), "BODY ENTER", UVM_LOW)
			 for(int i=0; i<10; i++)
			  begin
			    `uvm_create(req)
			     //assert(req.randomize());
			     req.trans_type = WRITE;
			     req.trans_addr = i;
			     req.trans_datai = $random();
			    `uvm_send(req)
			     this.get_response(rsp);
			     this.rsp.print();
				end
				for(int i=0; i<10; i++)
				begin
			    `uvm_create(req)
			     //assert(req.randomize());
			     req.trans_type = READ;
			     req.trans_addr = i;
			    `uvm_send(req)
			     this.get_response(rsp);
			     this.rsp.print();
			  end
			 `uvm_info(this.get_name(), "BODY EXIT", UVM_LOW)
		endtask: body

	endclass: block_ram_random_sequence
`endif
