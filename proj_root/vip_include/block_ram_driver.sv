`ifndef BLOCK_RAM_DRIVER
`define BLOCK_RAM_DRIVER

  class block_ram_driver extends uvm_driver #(block_ram_sequence_item);
	  				block_ram_sequence_item 		req_item;
	  				block_ram_sequence_item 		rsp_item;
		virtual block_ram_if 								blk_ram_if;
		virtual block_ram_if 								slv_ram_if;
		bit [`DATA_WIDTH-1:0] mem [2**`ADDR_WIDTH:0];
		block_ram_configuration m_config;
		`uvm_component_utils(block_ram_driver)

		function new (string name = "block_ram_driver", uvm_component parent);
		  super.new(name, parent);
		endfunction: new

		function void build_phase(uvm_phase phase);
		  super.build_phase(phase);
			`uvm_info(this.get_name(), "BUILD PHASE ENTER", UVM_LOW)
			 this.req_item = block_ram_sequence_item::type_id::create("req_item", this);
			 this.rsp_item = block_ram_sequence_item::type_id::create("rsp_item", this);
			`uvm_info(this.get_name(), "BUILD PHASE EXIT", UVM_LOW)
		endfunction: build_phase

		task run_phase(uvm_phase phase);
			super.run_phase(phase);
			`uvm_info(this.get_name(), "RUN PHASE ENTER", UVM_LOW)
		   this.m_config.print();
			 fork
			  begin
			    if(this.m_config.is_master == 1'b1)
			   	 begin
			        if(!uvm_config_db#(virtual block_ram_if)::get(this, "", "master_ram_if", this.blk_ram_if))
			        begin
			     		 `uvm_error(this.get_name(), " Need configuration for master_ram_if")
			     	 end
			        fork
			          while(1) 
			         	 begin
			            this.seq_item_port.get_next_item(this.req_item);
		              this.req_item.print();
			          	 this.send_to_if(this.req_item, this.rsp_item);
			            this.seq_item_port.item_done();	
			          	 this.rsp_item.set_id_info(this.req_item);
			          	 this.seq_item_port.put_response(this.rsp_item);
			          end
			        join_none
			   	 end
				 end
				 begin
			     if(this.m_config.is_slaver == 1'b1)
			    	 begin
			         if(!uvm_config_db#(virtual block_ram_if)::get(this, "", "slaver_ram_if", this.slv_ram_if))
			         begin
			      		 `uvm_error(this.get_name(), " Need configuration for slaver_ram_if")
			      	 end
			    	   
			    	   fork
			    		   while(1)
			    				 begin
			    				   receive_from_if();
			    				 end
			    		 join_none
			    	 end
					end
				join
			`uvm_info(this.get_name(), "RUN PHASE EXIT", UVM_LOW)
		endtask: run_phase

		task send_to_if(block_ram_sequence_item in_item, ref block_ram_sequence_item out_item);
			begin
			  if(in_item.trans_type.name() == "READ")
			  	begin
			  	  @(posedge this.blk_ram_if.CLK);
			  	  this.blk_ram_if.READ 		= 1'b1;
			  	  this.blk_ram_if.WRITE		= 1'b0;
			  	  this.blk_ram_if.ADDR		= in_item.trans_addr;
			  	  this.blk_ram_if.DATAI		=	in_item.trans_datai;
			  	  @(posedge this.blk_ram_if.CLK);
			  	  in_item.trans_datao			=	this.blk_ram_if.DATAO;
			  	  this.blk_ram_if.READ 		= 1'b0;
			  	end
			  else
			  if(in_item.trans_type.name() == "WRITE")
			  	begin
					  @(posedge this.blk_ram_if.CLK);
			  	  this.blk_ram_if.READ 		= 1'b0;
			  	  this.blk_ram_if.WRITE		= 1'b1;
			  	  this.blk_ram_if.ADDR		= in_item.trans_addr;
			  	  this.blk_ram_if.DATAI		=	in_item.trans_datai;
			  	  in_item.trans_datao			=	0;
						@(posedge this.blk_ram_if.CLK);
			  	  this.blk_ram_if.WRITE		= 1'b0;

			  	end

			  	out_item.trans_type			= in_item.trans_type;
			  	out_item.trans_addr			= in_item.trans_addr;
			  	out_item.trans_datai		=	in_item.trans_datai;
			  	out_item.trans_datao		= in_item.trans_datao;
			end

		endtask: send_to_if

		task receive_from_if();
			begin
					fork
					  begin
				      wait(this.slv_ram_if.READ == 1'b1);
				    	  this.slv_ram_if.DATAO = this.mem[this.slv_ram_if.ADDR];
				    	  @(posedge this.slv_ram_if.CLK);
						end
						begin
						  wait(this.slv_ram_if.WRITE == 1'b1);
							this.mem[this.slv_ram_if.ADDR] = this.slv_ram_if.DATAI; 
							@(posedge this.slv_ram_if.CLK);
						end
					join_any
					disable fork;
			end
		endtask: receive_from_if
	endclass: block_ram_driver
`endif
