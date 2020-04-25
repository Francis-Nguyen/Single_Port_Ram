`ifndef BLOCK_RAM_BASE_SEQUENCE
`define BLOCK_RAM_BASE_SEQUENCE
	class block_ram_base_sequence extends uvm_sequence #(block_ram_sequence_item);

					transaction_type					trans_type;
  	rand 	bit [`ADDR_WIDTH-1:0] 		trans_addr;
  	rand 	bit [`DATA_WIDTH-1:0] 		trans_datai;	
  				bit [`DATA_WIDTH-1:0] 		trans_datao;	
		block_ram_sequence_item	sequence_item;

	  `uvm_object_utils_begin(block_ram_base_sequence)
			`uvm_field_enum(transaction_type, trans_type, UVM_ALL_ON)
			`uvm_field_int(trans_addr, UVM_ALL_ON)
			`uvm_field_int(trans_datai, UVM_ALL_ON)
			`uvm_field_int(trans_datao, UVM_ALL_ON)
			`uvm_field_object(sequence_item, UVM_ALL_ON)
		`uvm_object_utils_end

	  function new(string name = "block_ram_base_sequence");
			super.new(name);
		endfunction: new

		virtual task body();
			`uvm_info(this.get_name(), "BODY ENTER", UVM_LOW)
			 `uvm_create(sequence_item)
				this.sequence_item.trans_type 	= this.trans_type;
				this.sequence_item.trans_addr		= this.trans_addr;				
				this.sequence_item.trans_datai	= this.trans_datai;
				this.sequence_item.trans_datao	= this.trans_datao;			
			 `uvm_send(sequence_item)
			`uvm_info(this.get_name(), "BODY EXIT", UVM_LOW)
		endtask: body

	endclass: block_ram_base_sequence
`endif
