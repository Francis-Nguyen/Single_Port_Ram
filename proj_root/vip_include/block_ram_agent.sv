`ifndef BLOCK_RAM_AGENT
`define BLOCK_RAM_AGENT
	class block_ram_agent extends uvm_agent;
		block_ram_driver				blk_ram_driver;
		block_ram_sequencer			blk_ram_sequencer;
		block_ram_configuration m_config;
		
		`uvm_component_utils_begin(block_ram_agent)
			`uvm_field_object(blk_ram_sequencer, 	UVM_ALL_ON)
			`uvm_field_object(blk_ram_driver, 		UVM_ALL_ON)
			`uvm_field_object(m_config, 					UVM_ALL_ON)
		`uvm_component_utils_end

		function new(string name ="block_ram_agent", uvm_component parent);
			super.new(name, parent);
			//this.m_config = block_ram_configuration::type_id::create("m_config", this);
		endfunction: new

		virtual function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			`uvm_info(this.get_name(), "BUILD PHASE ENTER", UVM_LOW)
			`uvm_info(this.get_name(), "BUILD PHASE EXIT", UVM_LOW)
		endfunction: build_phase

		virtual function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
			`uvm_info(this.get_name(), "CONNECT PHASE ENTER", UVM_LOW)
			//this.m_config.print();
			// if(this.m_config.is_master == 1'b1)
			//	 begin
			// 			uvm_config_db#(block_ram_configuration)::set(this, "*", "ms_config", this.m_config);
			//	 end
			// else
			// if(this.m_config.is_slaver == 1'b1)
			//	 begin
			// 			uvm_config_db#(block_ram_configuration)::set(this, "*", "slv_config", this.m_config);
			//	 end
			//this.blk_ram_driver.m_config = this.m_config;
			`uvm_info(this.get_name(), "CONNECT PHASE EXIT", UVM_LOW)
		endfunction: connect_phase

	endclass: block_ram_agent
`endif
