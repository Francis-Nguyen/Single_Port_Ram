`ifndef ENV
`define ENV
typedef class env;
`include "sequencer.sv"
class env extends uvm_env;
	block_ram_agent 				master_agent;
	sequencer								master_sequencer;
  block_ram_driver 				master_driver;	
	block_ram_configuration	master_config;
	//block_ram_agent 				slaver_agent;
	//sequencer								slaver_sequencer;
  //block_ram_driver 				slaver_driver;	
	//block_ram_configuration	slaver_config;

	`uvm_component_utils_begin(env)
		`uvm_field_object(master_agent, 			UVM_ALL_ON)
		`uvm_field_object(master_sequencer, 	UVM_ALL_ON)
		`uvm_field_object(master_driver, 			UVM_ALL_ON)
		`uvm_field_object(master_config, 			UVM_ALL_ON)
		//`uvm_field_object(slaver_agent, 			UVM_ALL_ON)
		//`uvm_field_object(slaver_sequencer, 	UVM_ALL_ON)
		//`uvm_field_object(slaver_driver, 			UVM_ALL_ON)
		//`uvm_field_object(slaver_config, 			UVM_ALL_ON)
	`uvm_component_utils_end

	function new(string name, uvm_component parent=null);
		super.new(name, parent);
	endfunction: new
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("ENV", "build phase entering.............", UVM_LOW);
		this.master_agent 						= block_ram_agent::type_id::create("master_agent", this);
		this.master_sequencer 				= sequencer::type_id::create("master_sequencer", this);
		this.master_driver 						= block_ram_driver::type_id::create("master_driver", this);
		this.master_config						= block_ram_configuration::type_id::create("master_config", this);
		this.master_config.is_master 	= 1'b1;
		uvm_config_db#(block_ram_configuration)::set(uvm_root::get(), "*", "m_config", this.master_config);

		//this.slaver_agent 						= block_ram_agent::type_id::create("slaver_agent", this);
		//this.slaver_sequencer					= sequencer::type_id::create("slaver_sequencer", this);
		//this.slaver_driver						= block_ram_driver::type_id::create("slaver_driver", this);
		//this.slaver_config						= block_ram_configuration::type_id::create("slaver_config", this);
		//this.slaver_config.is_slaver	= 1'b1;
		`uvm_info("ENV", "build phase exiting..............", UVM_LOW);
	endfunction: build_phase
	
	function void connect_phase(uvm_phase phase);
		`uvm_info("ENV", "connect phase entering.............", UVM_LOW);
		 this.master_agent.blk_ram_sequencer = this.master_sequencer;
		 this.master_agent.blk_ram_driver    = this.master_driver;
		 this.master_agent.blk_ram_driver.seq_item_port.connect(this.master_agent.blk_ram_sequencer.seq_item_export);
		 //this.slaver_agent.blk_ram_sequencer = this.slaver_sequencer;
		 //this.slaver_agent.blk_ram_driver    = this.slaver_driver;
		 //this.slaver_agent.blk_ram_driver.seq_item_port.connect(this.slaver_agent.blk_ram_sequencer.seq_item_export);
		this.master_agent.blk_ram_driver.m_config		=	this.master_config;
		//this.slaver_agent.blk_ram_driver.m_config		=	this.slaver_config;
		`uvm_info("ENV", "connect phase exiting..............", UVM_LOW);
	endfunction: connect_phase

	virtual task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		`uvm_info("ENV", "run_phase phase entering.............", UVM_LOW);
	  #1ms;
		`uvm_info("ENV", "run_phase phase exiting.............", UVM_LOW);
		phase.drop_objection(this);
	endtask: run_phase
		
endclass: env
`endif
