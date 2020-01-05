`ifndef BLOCK_RAM_SEQUENCER
`define BLOCK_RAM_SEQUENCER
  class block_ram_sequencer extends uvm_sequencer #(block_ram_sequence_item);
		`uvm_object_utils(block_ram_sequencer)

		function new(string name = "block_ram_sequencer", uvm_component parent=null);
		  super.new(name, parent);
		endfunction: new

		task run_phase(uvm_phase phase);
			super.run_phase(phase);
			`uvm_info(this.get_name(), "RUN PHASE ENTER", UVM_LOW)
			`uvm_info(this.get_name(), "RUN PHASE EXIT", UVM_LOW)
		endtask: run_phase

  endclass: block_ram_sequencer
`endif
