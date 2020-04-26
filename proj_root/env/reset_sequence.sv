`ifndef RESET_SEQUENCE
`define RESET_SEQUENCE

class reset_sequence extends uvm_sequence#(block_ram_sequence_item);

	virtual block_ram_if 	ms_ram_if;
	block_ram_configuration m_config;
  `uvm_object_utils(reset_sequence)
	`uvm_declare_p_sequencer(sequencer)

  function new(string name = "reset_sequence");
		super.new(name);
	endfunction: new

	virtual task body();
		`uvm_info(this.get_name(), "BODY ENTER", UVM_LOW)
		 	if(!uvm_config_db#(block_ram_configuration)::get(uvm_root::get(), "*", "m_config", this.m_config))
		 	begin
		  	`uvm_error(this.get_name(), " Need configuration for m_config")
			end
			else
			if(this.m_config.is_master == 1'b1)
				begin
		 			if(!uvm_config_db#(virtual block_ram_if)::get(uvm_root::get(), "*", "master_ram_if", this.ms_ram_if))
		 			begin
		  			`uvm_error(this.get_name(), " Need configuration for master_ram_if")
					end
					else
					begin
						this.ms_ram_if.reset = 1'b0;
						repeat(100)	@(posedge this.ms_ram_if.clk);
						this.ms_ram_if.reset = 1'b1;
					end
				end
		`uvm_info(this.get_name(), "BODY EXIT", UVM_LOW)
	endtask: body

endclass: reset_sequence
`endif
